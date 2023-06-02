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
            "avatar": "conversations-with-messages"
          },
          {
            "heading": "Conversations",
            "description": "CometChatConversations is an independent component used to set up a screen that shows the recent conversations alone",
            "avatar": "conversations"
          },
          {
            "heading": "List Item",
            "description": "CometListItem is a reusable component which is used to display the conversation list item in the conversation list.",
            "avatar": "menu"
          }
        ]
      ],
      "calls": [
        [
        {
                "heading": "Call Button",
                "description": "CometChatCallButton is an independent component that will allows you to make a call.",
                "avatar": "person.text.rectangle"
        }
        ]
      ],
      "message": [
        [
          {
            "heading": "Messages",
            "description": "The CometChatMessages component is an independent component that is used to handle messages for users and groups.",
            "avatar": "message-text-icon"
          },
          {
            "heading": "Message Header",
            "description": "CometChatMessageHeader is an independent component that  displays the User or Group information using SDK's User or Group object.",
            "avatar": "menubar.rectangle"
          },
          {
            "heading": "Message List",
            "description": "CometChatMessageList displays a list of messages and handles real-time operations.",
            "avatar": "message-list"
          },
          {
            "heading": "MessageComposer",
            "description": "CometChatComposer is an independent and a critical component that allows users to compose and send various types of messages such as text, image, video and custom messages.",
            "avatar": "compose"
          }
        ]
      ],
      "users": [
        [
          {
            "heading": "Users With Messages",
            "description": "CometChatUsersWithMessages is an independent component used to set up a screen that shows the list of users available in your app and gives you the ability to search for a specific user and to start conversation.",
            "avatar": "users-chat"
          },
          {
            "heading": "Users",
            "description": "CometChatUsers is an independent component used to set up a screen that displays a scrollable list of users available in your app and gives you the ability to search for a specific user.",
            "avatar": "user-solid"
          },
          {
            "heading": "List Item",
            "description": "CometChatListItem is used to display the user list item in a user list. It houses the Avatar, Status indicator and Title",
            "avatar": "menu"
          },
        {
                "heading": "CometChatDetails (User)",
                "description": "This component is used to display the detailed information of an user. To learn more about this component tap here.",
                "avatar": "account"
        }
        ]
      ],
      "groups": [
        [
          {
            "heading": "Groups With Messages",
            "description": "CometChatGroupsWithMessages is an independent component used to set up a screen that shows the list of groups available in your app and gives you the ability to search for a specific group and to start a conversation.",
            "avatar": "chat-group"
          },
          {
            "heading": "Groups",
            "description": "CometChatGroups is an independent component used to set up a screen that displays the list of groups available in your app and gives you the ability to search for a specific group",
            "avatar": "group-chat"
          },
          {
            "heading": "List Item",
            "description": "CometChatListItem is used to display the group list item in the group list. It houses the Avatar, Status indicator, Title and Subtitle.",
            "avatar": "menu"
          },
          {
            "heading": "Create Group",
            "description": "This component is used to create a new group. Groups can of three types public , private or password protected. To learn more about this component tap here.",
            "avatar": "create-group-button"
          },
          {
            "heading": "Join Protected Group",
            "description": "This component is used to join password protected group. To learn more about this component tap here.",
            "avatar": "shield-with-lock"
          },
          {
            "heading": "Group Members",
            "description": "This component is used to view members in a group. To learn more about this component tap here.",
            "avatar": "group-chat"
          },
          {
            "heading": "Add Members",
            "description": "This component is used to add members in a group. To learn more about this component tap here.",
            "avatar": "user-plus"
          },
          {
            "heading": "Banned Members",
            "description": "This component is used to display Banned members of a group. To learn more about this component tap here.",
            "avatar": "ban-user"
          },
          {
            "heading": "Transfer Ownership",
            "description": "This component is used to transer ownership of group from one user to another. To learn more about this component tap here.",
            "avatar": "transfer-ownership"
          },
              {
                "heading": "CometChatDetails (Group)",
                "description": "This component is used to display the detailed information of a group. To learn more about this component tap here.",
                "avatar": "account"
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
            "avatar": "theme"
          },
          {
            "heading": "Localize",
            "description": "CometChatLocalize allows you to detect the language of your users based on their browser or device settings and set the language accordingly.",
            "avatar": "textformat.alt"
          }
        ],
        [
          {
            "heading": "Avatar",
            "description": "CometChatAvatar component displays an image or user/group avatar with fallback to the first two letters of the user name/group name",
            "avatar": "person"
          },
          {
            "heading": "Badge Count",
            "description": "CometChatBadge is a custom component which is used to display the unread message count. It can be used in places like ConversationListItem, etc.",
            "avatar": "rectangle.dashed.badge.record"
          },
          {
            "heading": "Status Indicator",
            "description": "StatusIndicator component indicates whether a user is online or offline.",
            "avatar": "person.crop.circle.badge.questionmark.fill"
          },
          {
            "heading": "Message Receipt",
            "description": "CometChatReceipt component renders the receipts such as sending, sent, delivered, read and error state indicator of a message.",
            "avatar": "sidebar.left"
          },
    
          {
            "heading": "Text Bubble",
            "description": "CometChatTextBubble displays a text message. To learn more about this component tap here.",
            "avatar": "message-text-icon"
          },

          {
            "heading": "Image Bubble",
            "description": "CometChatImageBubble displays a media message containing an image. To learn more about this component tap here.",
            "avatar": "image"
          },
    
          {
            "heading": "Video Bubble",
            "description": "CometChatVideoBubble displays a media message containing a video. To learn more about this component tap here.",
            "avatar": "video-icon"
          },
    
          {
            "heading": "Audio Bubble",
            "description": "CometChatAudioBubble displays a media message containing an audio. To learn more about this component tap here.",
            "avatar": "volume-icon"
          },
    
          {
            "heading": "File Bubble",
            "description": "CometChatFileBubble displays a media message containing a file. To learn more about this component tap here.",
            "avatar": "folder-icon"
          },
              {
                "heading": "List Item",
                "description": "CometChatListItem is a reusable component which is used across multiple components in different variations such as Users, Groups, Conversations and many more as a List Item.",
                "avatar": "menu"
              }

        ]
      ]
    }
    """
    
}
