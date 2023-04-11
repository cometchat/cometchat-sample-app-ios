//
//  ModulesJson.swift
//  CometChatSwift
//
//  Created by admin on 11/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import Foundation

public class ModulesJson {
    public static let jsonString = """
    {
      "chat": [
        [
          {
            "heading": "Conversations With Messages",
            "description": "CometChatConversationsWithMessages is an independent component used to set up a screen that shows the recent conversations and allows you to send a message to the user or group from the list",
            "avatar": "sidebar.leading"
          },
          {
            "heading": "Conversations",
            "description": "CometChatConversations is an independent component used to set up a screen that shows the recent conversations alone",
            "avatar": "menubar.rectangle"
          },
          {
            "heading": "List Item",
            "description": "CometListItem is a reusable component which is used to display the conversation list item in the conversation list.",
            "avatar": "person.text.rectangle"
          }
        ]
      ],
      "calls": [
        [
          {
            "heading": "CallHistoryWithDetails",
            "description": "CometChatCallsHistory is an independent component used to set up a screen that shows the recent conversations and allows you to send a message to the user or group from the list",
            "avatar": "sidebar.leading"
          },
          {
            "heading": "Calls History",
            "description": "CometChatCallsHistory is an independent component used to set up a screen that shows the recent conversations and allows you to send a message to the user or group from the list",
            "avatar": "list.bullet.rectangle.portrait"
          },
          {
            "heading": "Call Details",
            "description": "CallDetails is an independent component used to set up a screen that shows the recent conversations and allows you to check the details of a particular call message.",
            "avatar": "person.text.rectangle"
          },
          {
            "heading": "Outgoing Call",
            "description": "CometChatOutgoingCall is an independent component used to set up a screen that shows the recent conversations and allows you to send a message to the user or group from the list",
            "avatar": "phone.arrow.up.right"
          },
          {
            "heading": "Incoming Call",
            "description": "CometChatIncomingCall is an independent component used to set up a screen that shows the recent conversations and allows you to send a message to the user or group from the list",
            "avatar": "phone.arrow.down.left"
          },
          {
            "heading": "Ongoing Call",
            "description": "CometChatOningCall is an independent component used to set up a screen that shows the recent conversations and allows you to send a message to the user or group from the list",
            "avatar": "phone.and.waveform"
          }
        ]
      ],
      "message": [
        [
          {
            "heading": "Messages",
            "description": "The CometChatMessages component is an independent component that is used to handle messages for users and groups.",
            "avatar": "sidebar.leading"
          },
          {
            "heading": "Message Header",
            "description": "CometChatMessageHeader is an independent component that  displays the User or Group information using SDK's User or Group object.",
            "avatar": "menubar.rectangle"
          },
          {
            "heading": "Message List",
            "description": "CometChatMessageList displays a list of messages and handles real-time operations.",
            "avatar": "list.bullet.below.rectangle"
          },
          {
            "heading": "MessageComposer",
            "description": "CometChatComposer is an independent and a critical component that allows users to compose and send various types of messages such as text, image, video and custom messages.",
            "avatar": "person.text.rectangle"
          }
        ]
      ],
      "users": [
        [
          {
            "heading": "Users With Messages",
            "description": "CometChatUsersWithMessages is an independent component used to set up a screen that shows the list of users available in your app and gives you the ability to search for a specific user and to start conversation.",
            "avatar": "sidebar.leading"
          },
          {
            "heading": "Users",
            "description": "CometChatUsers is an independent component used to set up a screen that displays a scrollable list of users available in your app and gives you the ability to search for a specific user.",
            "avatar": "menubar.rectangle"
          },
          {
            "heading": "List Item",
            "description": "CometChatListItem is used to display the user list item in a user list. It houses the Avatar, Status indicator and Title",
            "avatar": "person.text.rectangle"
          }
        ]
      ],
      "groups": [
        [
          {
            "heading": "Groups With Messages",
            "description": "CometChatGroupsWithMessages is an independent component used to set up a screen that shows the list of groups available in your app and gives you the ability to search for a specific group and to start a conversation.",
            "avatar": "sidebar.leading"
          },
          {
            "heading": "Groups",
            "description": "CometChatGroups is an independent component used to set up a screen that displays the list of groups available in your app and gives you the ability to search for a specific group",
            "avatar": "menubar.rectangle"
          },
          {
            "heading": "List Item",
            "description": "CometChatDataItem is used to display the group list item in the group list. It houses the Avatar, Status indicator, Title and Subtitle.",
            "avatar": "person.text.rectangle"
          },
          {
            "heading": "Create Group",
            "description": "CometChatDataItem is used to display the group list item in the group list. It houses the Avatar, Status indicator, Title and Subtitle.",
            "avatar": "plus.square"
          },
          {
            "heading": "Join Protected Group",
            "description": "CometChatDataItem is used to display the group list item in the group list. It houses the Avatar, Status indicator, Title and Subtitle.",
            "avatar": "lock.shield"
          },
          {
            "heading": "View Members",
            "description": "CometChatDataItem is used to display the group list item in the group list. It houses the Avatar, Status indicator, Title and Subtitle.",
            "avatar": "person.fill.viewfinder"
          },
          {
            "heading": "Add Members",
            "description": "CometChatDataItem is used to display the group list item in the group list. It houses the Avatar, Status indicator, Title and Subtitle.",
            "avatar": "person.badge.plus"
          },
          {
            "heading": "Banned Members",
            "description": "CometChatDataItem is used to display the group list item in the group list. It houses the Avatar, Status indicator, Title and Subtitle.",
            "avatar": "person.badge.key"
          },
          {
            "heading": "Transfer Ownership",
            "description": "CometChatDataItem is used to display the group list item in the group list. It houses the Avatar, Status indicator, Title and Subtitle.",
            "avatar": "person.and.arrow.left.and.arrow.right"
          }
        ]
      ],
      "shared": [
        [
          {
            "heading": "Sound Manager",
            "description": "CometChatSoundManager allows you to play different types of audio which is required for incoming and outgoing events in UI Kit. for example, events like incoming and outgoing messages.",
            "avatar": "speaker.wave.3"
          },
          {
            "heading": "Theme",
            "description": "CometChatTheme is a style applied to every component and every view in the activity or component in the UI Kit",
            "avatar": "paintpalette"
          },
          {
            "heading": "Localize",
            "description": "CometChatLocalize allows you to detect the language of your users based on their browser or device settings and set the language accordingly.",
            "avatar": "textformat.alt"
          }
        ],
        [
          {
            "heading": "List Item",
            "description": "CometChatListItem is a reusable component which is used across multiple components in different variations such as Users, Groups, Conversations and many more as a List Item.",
            "avatar": "person.text.rectangle"
          }
        ],
        [
          {
            "heading": "Avatar",
            "description": "CometChatAvatar component displays an image or user/group avatar with fallback to the first two letters of the user name/group name",
            "avatar": "photo"
          },
          {
            "heading": "Badge Count",
            "description": "CometChatBadge is a custom component which is used to display the unread message count. It can be used in places like ConversationListItem, etc.",
            "avatar": "app.badge"
          },
          {
            "heading": "Status Indicator",
            "description": "StatusIndicator component indicates whether a user is online or offline.",
            "avatar": "record.circle"
          },
          {
            "heading": "Message Receipt",
            "description": "CometChatReceipt component renders the receipts such as sending, sent, delivered, read and error state indicator of a message.",
            "avatar": "checkmark.bubble"
          }
        ],
        [
          {
            "heading": "CometChatDetails (User)",
            "description": "CometChatConversationListItem is a reusable component which is used to display the conversation list item in the conversation list.",
            "avatar": "person.circle"
          },
          {
            "heading": "CometChatDetails (Group)",
            "description": "CometChatDataItem is a reusable component which is used across multiple components in different variations such as User List, Group List as a List Item.",
            "avatar": "person.2.circle"
          }
        ]
      ]
    }
    """
    
}
