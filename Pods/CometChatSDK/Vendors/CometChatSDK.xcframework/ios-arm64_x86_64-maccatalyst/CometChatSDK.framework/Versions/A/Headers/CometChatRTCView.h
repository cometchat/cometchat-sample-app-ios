//
//  NSObject+CometChatRTCView.h
//  CometChatRTC
//
//  Created by Jitvar on 1/30/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RTCEventDelegate <NSObject>
@required
- (void)onCallEndedFromRTC;
- (void)onCallEndButtonPressedFromRTC;
@end

@interface CometChatRTCViewBuilder : NSObject

@property (nonatomic,copy) NSString *sessionID;
@property (nonatomic,copy) NSString *mode;
@property (nonatomic,copy) NSString *region;
@property (nonatomic,copy) NSString *domain;
@property (nonatomic,copy) NSString *sdk;
@property (nonatomic,copy) NSString *appID;
@property (nonatomic,copy) NSString *defaultAudioMode;
@property (nonatomic) BOOL defaultLayout;
@property (nonatomic) BOOL isAudioOnly;
@property (nonatomic) BOOL isInitiator;
@property (nonatomic) BOOL muteAudioButtonDisable;
@property (nonatomic) BOOL endCallButtonDisable;
@property (nonatomic) BOOL enableVideoTileClick;
@property (nonatomic) BOOL enableDraggableVideoTile;
@property (nonatomic) BOOL pauseVideoButtonDisable;
@property (nonatomic) BOOL switchCameraButtonDisable;
@property (nonatomic) BOOL audioModeButtonDisable;
@property (nonatomic) BOOL showSwitchToVideoCallButton;
@property (nonatomic) BOOL startAudioMuted;
@property (nonatomic) BOOL startVideoMuted;
@property (nonatomic) BOOL isConference;
@property (nonatomic) BOOL isSingleMode;
@property (nonatomic) BOOL showRecordingButton;
@property (nonatomic) BOOL startRecordingOnCallStart;
@property (nonatomic) NSMutableDictionary *rtcUser;
@property (nonatomic) NSMutableDictionary *analyticsSettings;
@property (nonatomic) NSMutableDictionary *rtcReveiver;
@property (nonatomic) NSMutableDictionary *rtcInitiator;
@property (nonatomic,copy) NSString *setAvatarMode;
@property (weak, nonatomic) UIView *view;
@property (nonatomic) NSMutableDictionary *setmainVideoContainerSetting;
@end


@interface CometChatRTCView : NSObject

@property (nonatomic,copy,readonly) NSString *sessionID;
@property (nonatomic,copy) NSString *mode;
@property (nonatomic,readonly) BOOL defaultLayout;
@property (nonatomic,copy) NSString *region;
@property (nonatomic,copy) NSString *domain;
@property (nonatomic,copy) NSString *sdk;
@property (nonatomic,copy) NSString *appID;
@property (nonatomic,copy) NSString *defaultAudioMode;
@property (weak, nonatomic) UIView *view;
@property (nonatomic) BOOL isAudioOnly;
@property (nonatomic) BOOL isInitiator;
@property (nonatomic) BOOL muteAudioButtonDisable;
@property (nonatomic) BOOL endCallButtonDisable;
@property (nonatomic) BOOL enableVideoTileClick;
@property (nonatomic) BOOL enableDraggableVideoTile;
@property (nonatomic) BOOL pauseVideoButtonDisable;
@property (nonatomic) BOOL switchCameraButtonDisable;
@property (nonatomic) BOOL audioModeButtonDisable;
@property (nonatomic) BOOL showSwitchToVideoCallButton;
@property (nonatomic) BOOL startAudioMuted;
@property (nonatomic) BOOL startVideoMuted;
@property (nonatomic) BOOL isConference;
@property (nonatomic) BOOL isSingleMode;
@property (nonatomic) BOOL showRecordingButton;
@property (nonatomic) BOOL startRecordingOnCallStart;
@property (nonatomic) NSMutableDictionary *rtcUser;
@property (nonatomic) NSMutableDictionary *analyticsSettings;
@property (nonatomic) NSMutableDictionary *rtcReveiver;
@property (nonatomic) NSMutableDictionary *rtcInitiator;
@property (nonatomic,copy) NSString *setAvatarMode;
@property (nonatomic) NSMutableDictionary *setmainVideoContainerSetting;
//ab try kariye maalik
@property (nonatomic,weak)NSObject<RTCEventDelegate>* delegate;
//@property (nonatomic, weak) id <RTCEventDelegate> delegate;

-(instancetype)initWithBuilder:(CometChatRTCViewBuilder *)builder;
//-(NSMutableDictionary*)createUserDictionary:(NSString *)uid avatar: (NSString *)avatar name: (NSString *)name;

-(void)startSession;
-(void)endCallSession;
-(void)switchCameraSource;
-(void)muteAudio;
-(void)unMuteAudio;
-(void)pauseVideo;
-(void)unPauseVideo;
-(void)setAudioModeToSpeaker;
-(void)setAudioModeToEarPiece;
-(void)setAudioMode:(NSMutableString*)mode;
-(void)getAudioModes:(void(^)(NSArray * list))callback;
-(void)getAudioOutputModes:(void(^)(NSArray * list))callback;
-(void)enterPIPMode;
-(void)exitPIPMode;
-(void)switchToVideoCall;
-(void)startRecording;
-(void)stopRecording;

//-(void)methodForTriggeringProtocol;

//-(void)RTCEvents:(void (^) (NSDictionary *response))onCallEnded
//onCallEndButtonPressed:(void (^) (NSDictionary *response))onCallEndButtonPressed;

@end

NS_ASSUME_NONNULL_END
