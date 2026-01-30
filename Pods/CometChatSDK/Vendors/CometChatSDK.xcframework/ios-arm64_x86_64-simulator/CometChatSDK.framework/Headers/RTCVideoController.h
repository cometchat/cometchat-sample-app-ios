//
//  RTCVideoController.h
//  CometChatPro
//
//  Created by Admin on 10/08/21.
//  Copyright © 2021 Inscripts.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include("CallingEvents.h")
#import "CallingEvents.h"
#import "CometChatRTCView.h"
#define __HAS_SOME_MODULE_FRAMEWORK__
#endif

NS_ASSUME_NONNULL_BEGIN

@interface RTCVideoController : NSObject
#ifdef __HAS_SOME_MODULE_FRAMEWORK__
@property (strong,nonatomic) CallingEvents *callingEvents;
@property (strong,nullable) CometChatRTCView *cometChatRTCView;
@property (strong,nonatomic) CometChatRTCViewBuilder *cometChatRTCViewBuilder;
#endif

+ (RTCVideoController *)sharedInstance;
-(void)callingEventsObject;
-(void)cometChatRTCViewBuilderObject;
-(void)cometChatRTCViewObject;
-(void)removeAllObjects;
-(void)startSession;
-(void)endCallSession;
-(void)switchCameraSource;
-(void)muteAudio;
-(void)unMuteAudio;
-(void)pauseVideo;
-(void)unPauseVideo;
-(void)setAudioMode:(NSMutableString *)audio;
@end

NS_ASSUME_NONNULL_END
