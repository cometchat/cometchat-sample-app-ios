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
          },
          {
            "heading": "Contacts",
            "description": "CometChatContacts is a versatile UI component specifically designed to streamlines the process of showcasing all app users and available chat groups in a user-friendly interface, making it easier for users to connect and communicate effectively.",
            "avatar": "contacts"
          }
        ]
      ],
      "calls": [
        [
        {
                "heading": "Call Button",
                "description": "CometChatCallButton is an independent component that will allows you to make a call.",
                "avatar": "person.text.rectangle"
        },
        {
                "heading": "Call Logs",
                "description": "CometChatCallLogs is an independent component shows all your recent call Logs.",
                "avatar": "call"
        },
        {
                "heading": "CallLogsWithDetails",
                "description": "CallLogsWithDetails is an component that uses & CallLogsWithDetails to shows all your recent call Logs with its details.",
                "avatar": "call-log"
        },
        {
                "heading": "CallLogDetails",
                "description": "CallLogDetails is an component that shows detailed information about a particular call. This uses CallLogHistory, CallLogRecording & CallLogParticipant as child component",
                "avatar": "call-log"
        },
        {
                "heading": "CallLogHistory",
                "description": "CallLogHistory is an component shows Call History with some user or group. It will only show that call between the Logged In user and the chosen user.",
                "avatar": "call-history"
        },
        {
                "heading": "CallLogRecording",
                "description": "CallLogRecording is an component that displays all the recordings from a particular call. This component also allows to directly download the recording into your phone",
                "avatar": "call-recording"
        },
        {
                "heading": "CallLogParticipant",
                "description": "CallLogParticipant is an component that shows the list of participant in a particular call.",
                "avatar": "call-participant"
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
          },
          {
            "heading": "MessageInformation",
            "description": "The CometChatMessageInformation component is custom UI view designed to dispaly message-related information, such as delivery and read receipts. It serves as an integral part of the CometChat UI UIkit",
            "avatar": "messages-info"
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
            "heading": "Form Bubble",
            "description": "CometChatFormBubble component is used to render a form within a chat bubble. To learn more about this component tap here.",
            "avatar": "form"
          },
    
          {
            "heading": "Card Bubble",
            "description": "The CometChatCardMessage component is used to create a card message within a chat bubble. To learn more about this component tap here.",
            "avatar": "card"
          },
    
          {
            "heading": "Media Recorder",
            "description": "The CometChatMediRecorder is a custom iOS component that provides a user interface for recording audio and playing back the recorded audio. It is designed to be easily integrated into chat applications or other projects where audio messaging is required. To learn more about this component tap here.",
            "avatar": "microphone"
          },
              {
                "heading": "List Item",
                "description": "CometChatListItem is a reusable component which is used across multiple components in different variations such as Users, Groups, Conversations and many more as a List Item. To learn more about this component tap here.",
                "avatar": "menu"
              }
        ]
      ]
    }
    """
    
}
