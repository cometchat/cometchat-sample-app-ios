//
//  CometChatSDK.h
//  CometChatSDK
//
//  Created by Budhabhooshan Patil on 25/09/18.
//  Copyright © 2018 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for CometChatSDK.
FOUNDATION_EXPORT double CometChatSDKVersionNumber;

//! Project version string for CometChatSDK.
FOUNDATION_EXPORT const unsigned char CometChatSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <CometChatSDK/PublicHeader.h>

//#import <CometChatPro/XMPPFramework.h>
//#import <CometChatPro/FMDB.h>
#if __has_include("CallingEvents.h")
#import "RTCVideoController.h"
#import "CallingEvents.h"
#import "CometChatRTCView.h"
#endif
