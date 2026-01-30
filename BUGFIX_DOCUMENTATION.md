# CometChat iOS App Bug Fixes Documentation

## Overview

This document details the critical bug fixes applied to resolve two major issues in the CometChat KitchenSink iOS app:

1. **App Freeze + Low Memory Kill** - Caused by infinite AutoLayout loops
2. **Message Send Failure + UI Stuck State** - Send button disabled after error

---

## Issue 1: App Freeze and Low Memory Kill

### Problem Description

When opening the MessageList/Chat screen, the app would:
- Freeze and become unresponsive
- Get killed by the OS after 10-20 seconds due to high memory usage
- Show repeated AutoLayout constraint warnings in console

### Console Warnings Observed

```
Unable to simultaneously satisfy constraints.
(
    "<NSLayoutConstraint:... CometChatMessageComposer.height == 40>",
    "<NSLayoutConstraint:... AudioVisualizationView.height == 40>",
    "<NSLayoutConstraint:... V:[AudioVisualizationView]-(5)-|>",
    "<NSLayoutConstraint:... V:|-(5)-[AudioVisualizationView]>",
    ...
)
Will attempt to recover by breaking constraint <AudioVisualizationView.height == 40>
```

### Root Cause Analysis

The issue was an **infinite layout loop** in the `GrowingTextView` component:

1. `layoutSubviews()` was called
2. It called `updateHeight()`
3. `updateHeight()` triggered the `willChangeHeight` delegate callback
4. The delegate set `inputBarHeight.constant = height`
5. This triggered a new layout pass on the parent view
6. Which triggered `layoutSubviews()` again on GrowingTextView
7. This loop continued infinitely, consuming memory until the OS killed the app

### Solution

#### Fix 1: GrowingTextView.swift - Re-entrancy Guard

**Added private properties to prevent infinite loops:**

```swift
// MARK: - Private properties
fileprivate var textView: GrowingInternalTextView = {
    let textView = GrowingInternalTextView(frame: .zero)
    textView.textContainerInset = .zero
    textView.textContainer.lineFragmentPadding = 1 // 1 pixel for caret
    textView.showsHorizontalScrollIndicator = false
    textView.contentInset = .zero
    textView.contentMode = .redraw
    return textView
}()

/// Guard to prevent infinite layout loops when height changes trigger layout passes
fileprivate var isUpdatingHeight = false
/// Track the last calculated height to avoid redundant updates
fileprivate var lastCalculatedHeight: CGFloat = 0
```

**Modified `layoutSubviews()` to skip updates when already updating:**

```swift
open override func layoutSubviews() {
    super.layoutSubviews()
    updateTextViewFrame()
    updateMaxHeight()
    updateMinHeight()
    
    // Only update height if not already in an update cycle
    // This prevents infinite layout loops when height changes trigger parent layout
    if !isUpdatingHeight {
        updateHeight()
    }
}
```

**Modified `updateHeight()` with guard flag and threshold check:**

```swift
public func updateHeight() {
    // Prevent re-entrant calls that cause infinite layout loops
    guard !isUpdatingHeight else { return }
    
    let updatedHeightInfo = updatedHeight()
    let newHeight = updatedHeightInfo.newHeight
    let difference = updatedHeightInfo.difference

    // Skip if no actual change or if height is the same as last calculated
    if difference == 0 || abs(newHeight - lastCalculatedHeight) < 0.5 {
        updateScrollPosition(animated: false)
        textView.shouldDisplayPlaceholder = textView.text.isEmpty && isPlaceholderEnabled
        return
    }
    
    // Set guard flag before making changes that could trigger layout
    isUpdatingHeight = true
    lastCalculatedHeight = newHeight
    
    defer {
        // Always reset the flag when done
        isUpdatingHeight = false
    }
    
    if newHeight == maxHeight {
        if !textView.isScrollEnabled {
            textView.isScrollEnabled = true
            textView.flashScrollIndicators()
        }
    } else {
        textView.isScrollEnabled = isScrollEnabled
    }

    if isGrowingAnimationEnabled {
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            self.updateGrowingTextView(newHeight: newHeight, difference: difference)
            }, completion: { (_) in
                if let delegate = self.delegate, delegate.responds(to: DelegateSelectors.didChangeHeight) {
                    delegate.growingTextView!(self, didChangeHeight: newHeight, difference: difference)
                }
        })
    } else {
        updateGrowingTextView(newHeight: newHeight, difference: difference)

        if let delegate = delegate, delegate.responds(to: DelegateSelectors.didChangeHeight) {
            delegate.growingTextView!(self, didChangeHeight: newHeight, difference: difference)
        }
    }

    updateScrollPosition(animated: false)
    textView.shouldDisplayPlaceholder = textView.text.isEmpty && isPlaceholderEnabled
}
```

#### Fix 2: CometChatMessageList.swift - Threshold Check in Delegate

**Modified `willChangeHeight` delegate to prevent triggering layout for tiny changes:**

```swift
extension CometChatMessageList: GrowingTextViewDelegate {
    public func growingTextView(_ growingTextView: GrowingTextView, willChangeHeight height: CGFloat, difference: CGFloat) {
        // Only update if there's an actual meaningful change to prevent layout loops
        guard abs(inputBarHeight.constant - height) > 0.5 else { return }
        inputBarHeight.constant = height
    }
```

#### Fix 3: CometChatThreadedMessageList.swift - Same Delegate Fix

**Applied the same threshold check:**

```swift
extension CometChatThreadedMessageList: GrowingTextViewDelegate {
    public func growingTextView(_ growingTextView: GrowingTextView, willChangeHeight height: CGFloat, difference: CGFloat) {
        // Only update if there's an actual meaningful change to prevent layout loops
        guard abs(inputBarHeight.constant - height) > 0.5 else { return }
        inputBarHeight.constant = height
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
```

---

## Issue 2: Message Send Failure + UI Stuck State

### Problem Description

When sending a message failed:
- A toast/snackbar appeared: "Something went wrong"
- The Send button became disabled
- Users could not retry sending
- The UI got stuck in a disabled state

### Root Cause Analysis

1. `send.isEnabled = false` was set before sending the message (optimistic UI)
2. On success, `send.isEnabled = true` was set
3. **On error, `send.isEnabled` was never re-enabled**, leaving the button disabled
4. The text was cleared before the message was actually sent, so users lost their message on failure

### Solution

#### Fix 1: CometChatMessageList.swift - Normal Send Mode Error Handler

**Before (broken):**
```swift
}) { (error) in
    DispatchQueue.main.async {
        if let error = error {
            CometChatSnackBoard.showErrorMessage(for: error)
        }
    }
}
```

**After (fixed):**
```swift
}) { (error) in
    DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return }
        if let error = error {
            CometChatSnackBoard.showErrorMessage(for: error)
        }
        // Re-enable send button on error so user can retry
        strongSelf.send.isEnabled = true
        // Remove the failed message from UI
        if let indexpath = strongSelf.chatMessages.indexPath(where: {$0.muid == message.muid}) {
            strongSelf.chatMessages[indexpath.section].remove(at: indexpath.row)
            strongSelf.tableView?.reloadData()
            // Restore the text so user can retry
            strongSelf.textView.text = message.text
        }
    }
}
```

#### Fix 2: CometChatMessageList.swift - Reply Mode Error Handler

**Fixed error handler:**
```swift
}) { [weak self] (error) in
    guard let strongSelf = self else { return }
    let failedMessageText = textMessage?.text ?? ""
    DispatchQueue.main.async {
        if let error = error {
            CometChatSnackBoard.showErrorMessage(for: error)
        }
        // Re-enable send button on error so user can retry
        strongSelf.send.isEnabled = true
        // Remove the failed message from UI
        if let muid = textMessage?.muid, let indexpath = strongSelf.chatMessages.indexPath(where: {$0.muid == muid}) {
            strongSelf.chatMessages[indexpath.section].remove(at: indexpath.row)
            strongSelf.tableView?.reloadData()
            // Restore the text so user can retry
            strongSelf.textView.text = failedMessageText
        }
    }
}
```

#### Fix 3: CometChatMessageList.swift - Edit Mode Error Handler

**Before (broken):**
```swift
}) { (error) in
    DispatchQueue.main.async{ [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.hide(view: .editMessageView, true)
        strongSelf.hide(view: .smartRepliesView, true)
        strongSelf.didPreformCancel()
        strongSelf.messageMode = .send
        strongSelf.textView.text = ""
        if let error = error as? CometChatException{
            CometChatSnackBoard.showErrorMessage(for: error)
        }
    }
}
```

**After (fixed):**
```swift
}) { (error) in
    DispatchQueue.main.async{ [weak self] in
        guard let strongSelf = self else { return }
        // Restore original text on the message object
        textMessage.text = originalText
        // Keep the edit view visible and text in input so user can retry
        strongSelf.send.isEnabled = true
        if let error = error as? CometChatException{
            CometChatSnackBoard.showErrorMessage(for: error)
        }
    }
}
```

#### Fix 4: CometChatMessageList.swift - Smart Replies Error Handler

**Fixed error handler:**
```swift
}) { [weak self] (error) in
    guard let strongSelf = self else { return }
    DispatchQueue.main.async {
        if let error = error {
            CometChatSnackBoard.showErrorMessage(for: error)
        }
        // Re-enable send button and remove failed message
        strongSelf.send.isEnabled = true
        if let muid = textMessage?.muid, let row = strongSelf.chatMessages[lastSection].firstIndex(where: {$0.muid == muid}) {
            strongSelf.chatMessages[lastSection].remove(at: row)
            strongSelf.tableView?.reloadData()
        }
    }
}
```

#### Fix 5: CometChatThreadedMessageList.swift - All Error Handlers

**Same fixes applied to ThreadedMessageList for:**
- Normal send mode (group and user)
- Reply mode (group and user)
- Smart replies (group and user)

**Example fixed error handler:**
```swift
}) { [weak self] (error) in
    guard let strongSelf = self else { return }
    let failedMessageText = textMessage?.text ?? ""
    DispatchQueue.main.async {
        if let error = error {
            CometChatSnackBoard.showErrorMessage(for: error)
        }
        // Re-enable send button and remove failed message
        strongSelf.send.isEnabled = true
        if let muid = textMessage?.muid, let row = strongSelf.chatMessages[lastSection].firstIndex(where: {$0.muid == muid}) {
            strongSelf.chatMessages[lastSection].remove(at: row)
            strongSelf.tableView?.reloadData()
            strongSelf.textView.text = failedMessageText
        }
    }
}
```

---

## Issue 3: Messages Not Sending (Early Return Bug)

### Problem Description

Messages were not being sent at all - the `CometChat.sendTextMessage()` call was never reached.

### Root Cause Analysis

Multiple `guard let indicator = typingIndicator else { return }` statements were causing early returns from the `didSendButtonPressed()` methods BEFORE the `CometChat.sendTextMessage()` call was reached.

When `typingIndicator` was nil:
- The function would return early
- The message sending code was never executed
- Users saw "Something went wrong" because no message was actually sent

### Solution

**Changed all early returns to optional checks:**

**Before (broken):**
```swift
guard let indicator = typingIndicator else {
    return
}
CometChat.endTyping(indicator: indicator)
```

**After (fixed):**
```swift
// Don't return early - just skip endTyping if indicator is nil
if let indicator = typingIndicator {
    CometChat.endTyping(indicator: indicator)
}
```

This fix was applied to all occurrences in:
- `CometChatMessageList.swift` - `didSendButtonPressed()` (normal, reply modes) and `didSendButtonPressed(title:)`
- `CometChatThreadedMessageList.swift` - Same methods

---

## Files Modified

1. **GrowingTextView.swift**
   - Path: `CometChatSwift/Library/UIKit Resources/Helper Extensions/GrowingTextView/GrowingTextView.swift`

2. **CometChatMessageList.swift**
   - Path: `CometChatSwift/Library/UI Components/Messages/Message List/CometChatMessageList.swift`

3. **CometChatThreadedMessageList.swift**
   - Path: `CometChatSwift/Library/UI Components/Messages/Threaded Message List/CometChatThreadedMessageList.swift`

---

## Summary of Changes

| Issue | Root Cause | Fix |
|-------|------------|-----|
| App Freeze | Infinite layout loop in GrowingTextView | Added re-entrancy guard and height threshold |
| Send Button Disabled | Error handler didn't re-enable button | Added `send.isEnabled = true` in all error handlers |
| Message Lost on Error | Text cleared before send confirmed | Restore text from failed message on error |
| Messages Not Sending | Early return when typingIndicator is nil | Changed `guard` to `if let` to avoid early return |

---

## Testing Recommendations

1. **Layout Loop Fix**: Open a chat, type messages, and verify no freeze occurs
2. **Send Error Recovery**: Simulate network failure and verify:
   - Send button remains enabled
   - Text is restored for retry
   - Failed message is removed from UI
3. **Message Sending**: Verify messages send successfully in all modes (normal, reply, edit, smart replies)
