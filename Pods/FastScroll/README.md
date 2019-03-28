[![Twitter](https://img.shields.io/badge/Twitter-@FrichtiTech-blue.svg?style|flat)](http://twitter.com/FrichtiTech) [![License](http://img.shields.io/badge/license-MIT-green.svg?style|flat)](https://github.com/Frichti/FastScroll/blob/master/LICENSE) ![Swift 4](https://img.shields.io/badge/Swift-4.0-orange.svg) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style|flat)](https://github.com/Carthage/Carthage)

![header](./images/frichtitech.png)
<img src="https://github.com/frichti/FastScroll/blob/master/images/gif1.gif" width="1024" height="578" />
<br><br/>

# FastScroll
FastScroll is lib to allow you to add easily a scrollBar to your `collectionView or your tableView`.<br>
The particularity of this scrollBar is that you can `drag the bar to scroll faster`.<br>
There is also a `bubble to display the information you want` about where you are in your scroll.<br>
`You can almost customize all what you want` to have the design you want

## Examples

| Default | Custom Design | Custom Image | No bubble |
|-----|-----|-----|-----|
|![alt text](https://github.com/Frichti/FastScroll/blob/master/images/gif2.gif "Default") | ![alt text](https://github.com/Frichti/FastScroll/blob/master/images/gif3.gif "Custom Design") |![alt text](https://github.com/Frichti/FastScroll/blob/master/images/gif4.gif "Custom Image") |![alt text](https://github.com/Frichti/FastScroll/blob/master/images/gif5.gif "No Bubble") |

## Requirements

- iOS 9.0+
- Xcode 9.0+

## Installation

Use [CocoaPods](https://cocoapods.org) with Podfile:
``` ruby
pod 'FastScroll'
```

## Usage

##### 1) Import FastScroll
```swift
import FastScroll
```

##### 2) Make UICollectionView inherit from `FastScrollCollectionView` (in your StoryBoard or Xib)
(or UITableView inherit from `FastScrollTableView`)<br/>

![cell](https://raw.githubusercontent.com/Frichti/FastScroll/master/images/storyboard_class.png)

##### 3) Adding your colletionView outlet
  `@IBOutlet weak var collectionView | FastScrollCollectionView!`  

##### 4) Implement UIScrollViewDelegate to dispatch the scroll behavior to your FastScrollCollectionView

``` swift
extension DemoFastScrollCollectionViewController | UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView | UIScrollView) {
        collectionView.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView | UIScrollView) {
        collectionView.scrollViewWillBeginDragging(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView | UIScrollView) {
        collectionView.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView | UIScrollView, willDecelerate decelerate | Bool) {
        collectionView.scrollViewDidEndDragging(scrollView, willDecelerate | decelerate)
    }
}
```

##### 5) Implement bubbleNameForIndexPath callback
  
``` swift
fileprivate func configFastScroll() {
    collectionView.delegate | self
    collectionView.dataSource | self

    //callback action to display bubble name
    collectionView.bubbleNameForIndexPath | { indexPath in
        let visibleSection | Section | self.data[indexPath.section]
        return visibleSection.sectionTitle
    }
}
```

## Customize
You can easily customize what you want.
You should make the config in `viewDidLoad` otherwise you'll need to call `collectionView.setup()` to refresh fast scroll views
``` swift
fileprivate func configFastScroll() {
    collectionView.delegate | self
    collectionView.dataSource | self
    
    //bubble
    collectionView.bubbleTextSize | 14.0
    collectionView.bubbleMarginRight | 80.0
    collectionView.bubbleColor | UIColor(red | 38.0 / 255.0, green | 48.0 / 255.0, blue | 60.0 / 255.0, alpha | 1.0)
    
    //handle
    collectionView.handleImage | UIImage.init(named | "cursor")
    collectionView.handleHeight | 40.0
    collectionView.handleWidth | 44.0
    collectionView.handleRadius | 0.0
    collectionView.handleMarginRight | 0
    collectionView.handleColor | UIColor.clear
    
    //scrollbar
    collectionView.scrollbarWidth | 0.0
    collectionView.scrollbarMarginTop | 20.0
    collectionView.scrollbarMarginBottom | 0.0
    collectionView.scrollbarMarginRight | 10.0

    //callback action to display bubble name
    collectionView.bubbleNameForIndexPath | { indexPath in
        let visibleSection | Section | self.data[indexPath.section]
        return visibleSection.sectionTitle
    }
}
```

## Properties
##### Bubble
| Property | Type | Default | Description |
|----------------|---------------|-----------|--------------------------------------|
| bubbleNameForIndexPath | Function | {} | The callback to display what you want in the bubble |
| deactivateBubble | Bool | false | Allow to activate or deactivate bubble functionnality |
| bubbleFocus | BubbleFocus | .first | Set the logic for returning the right indexPath conditionning to the scroll offset. The value can be `first`, `last`, `dynamic` (dynamic calculate the percentage of the scroll to take the visible cell index corresponding to the percentage)|
| bubble | UITextView | UITextView() | TextView to display bubble information |
| bubbleFont | UIFont | UIFont.systemFont(ofSize | 12.0) | Font in the bubble |
| bubbleTextSize | CGFloat | 12.0 | Size of the text in the bubble |
| bubbleTextColor | UIColor | White | Color of the text in the bubble |
| bubbleRadius | CGFloat | 20.0 | Manage bubble radius |
| bubblePadding | CGFloat | 12.0 | Padding around text of the bubble |
| bubbleMarginRight | CGFloat | 30.0 | Manage the margin between the bubble and the scrollbar |
| bubbleColor | UIColor | DarkGray | Change the background color |
| bubbleShadowColor | UIColor | DarkGray | Change the shadow color |
| bubbleShadowOpacity | Float | 0.7 | Shadow opacity |
| bubbleShadowRadius | CGFloat | 3.0 | Shadow radius |
| bubbleShadowOffset | CGSize | (0.0, 5.0) | Shadow offset |

##### Handle
| Property | Type | Default | Description |
|----------------|---------------|-----------|--------------------------------------|
| handle | UIView | UIView() | View for the handle allowing to scroll on touch (appear on scroll)  |
| handleImage | UIImage | nil | Allow to add an image in the handle |
| handleWidth | CGFloat | 30.0 | Handle width |
| handleHeight | CGFloat | 30.0 | Handle height |
| handleRadius | CGFloat | 15.0 | handle radius |
| handleMarginRight | CGFloat | 6.0 | Margin between the right border and the handle |
| handleShadowColor | UIColor | DdarkGray | Shadow color |
| handleShadowOpacity | Float | 0.7 | Shadow opacity |
| handleShadowOffset | CGSize | (0.0, 5.0) | Shadow offset |
| handleShadowRadius | CGFloat | 3.0 | Shadow Radius |
| handleColor | UIColor | DarkGray | Manage handle background color |
| handleTimeToDisappear | CGFloat | 1.5 | The handle is displayed when a scoll is detected. After `handleTimeToDisappear` seconds of inactivity, the handle disappear |
| handleDisappearAnimationDuration | CGFloat | 0.2 | Time of the alpha animation to hide handle after inactivity |

##### Scrollbar
| Property | Type | Default | Description |
|----------------|---------------|-----------|--------------------------------------|
| scrollbar | UIView | UIView() | View of the vertical scrollbar (appear on scroll) |
| scrollbarWidth | CGFloat | 2.0 | Scrollbar width, you can set 0.0 to hide the vetical bar |
| scrollbarColor | UIColor | Gray | Scrollbar color |
| scrollbarRadius | CGFloat | 1.0 | Scrollbar radius |
| scrollbarMarginTop | CGFloat | 40.0 | Manage margin top, it will be used to position nicely the bubble and the handle |
| scrollbarMarginBottom | CGFloat | 20.0 | Manage margin bottom, it will be used to position nicely the bubble and the handle |
| scrollbarMarginRight | CGFloat | 20.0 | Manage margin between right border and scrollbar |

##### Gesture view for handler touch
| Property | Type | Default | Description |
|----------------|---------------|-----------|--------------------------------------|
| gestureHandleView | UIView | UIView() | View to handle gesture allowing to scroll following the touch |
| gestureWidth | CGFloat | 50.0 | Width of the touch zone |
| gestureHeight | CGFloat | 50.0 | Height of the touch zone |
    
##### Others
| Property | Type | Description |
|----------------|---------------|--------------------------------------|
| setup | Function | You can use this of you need to update the views (bubble, handle, scrollbar) |

### About
This project is maintained by Frichti, Inc.<br>
We are making awesome fresh food.<br>

## License

FastScroll is released under the MIT license.
See [LICENSE](./LICENSE) for details.
