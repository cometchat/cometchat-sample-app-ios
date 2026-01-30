//
//  CallingEvents.h
//  RTCCometChat
//
//  Created by Nishant Tiwari on 15/04/20.
//  Copyright © 2020 Nishant Tiwari. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CallingEventsCalls : NSObject

//-(void)callingEventOfonCallEndButtonPressed;
//
//-(void)RTCEventEndButtonPressed:(void (^) (void))onCallEndButtonPressed;

-(void)callingEventOfCallEndButtonPressed;
-(void)callingEventOfConnectionInterrupted;
-(void)callingEventOfConnectionRestored;
-(void)callingEventOfConnectionFailed;
-(void)callingEventOfConnectionDisconnected;
-(void)RTCEventOnButtonPressed:(void (^) (void))onCallEndButtonPressed;
-(void)RTCEventOnConnectionInterrupted:(void (^) (void))onConnectionInterrupted;
-(void)RTCEventOnConnectionRestored:(void (^) (void))onConnectionRestored;
-(void)RTCEventOnConnectionFailed:(void (^) (void))onConnectionFailed;
-(void)RTCEventOnConnectionDisconnected:(void (^) (void))onConnectionDisconnected;
//-(void)RTCEvents:(void (^) (NSDictionary *response))onCallEnded
//onCallEndButtonPressed:(void (^) (NSDictionary *response))onCallEndButtonPressed;

//-(void)RTCEvents:(void (^) (void))onCallEndButtonPressed;
////onCallEndButtonPressed:(void (^) (void))onCallEndButtonPressed;
//
//-(void)newRTCEvents:(NSString* (^) (NSString*))onCallEndButtonPressed;

-(void)callingEventOnEndCall;

-(void)callingEventOnSessionTimeoutCall;

-(void)RTCEventOnCallEnded:(void (^) (void))onCallEnded;

-(void)RTCEventOnSessionTimeout:(void (^) (void))onSessionTimeout;

//-(void)callingEventOnUserJoinned;
-(void)callingEventOnUserJoinned:(NSDictionary *)UID;

- (void)RTCEventOnUserJoinned:(void (^)(NSDictionary *))onUserJoinned;

//-(void)RTCEventOnUserJoinned:(void (^) (void))onUserJoinned;

//-(void)RTCEventOnUserJoinned:(void (^)(NSString *))response;

//-(void)newRTCEvents:(NSString* (^) (NSString*))onCallEndButtonPressed;

-(void)callingEventOfonUserLeft:(NSDictionary *)UID;

-(void)RTCEventOnLeft:(void (^)(NSDictionary *))onUserLeft;

-(void)callingEventOnUserUserListChanged:(NSArray *)users;

-(void)RTCEventOnUserListChanged:(void (^)(NSArray *))onUserListChanged;

-(void)callingEventOnAudioDeviceListChanged:(NSArray *)devices;

-(void)RTCEventOnAudioDeviceListChanged:(void (^)(NSArray *))onAudioDeviceListChanged;

-(void)callingEventGetAudioModesOnSuccess:(NSArray *)devices;

-(void)RTCEventGetAudioModesOnSuccess:(void (^)(NSArray *))onAudioModeSuccess;

-(void)CallingEventOnSwitchedToVideoCall:(NSDictionary *)CallSwitchRequestInfo;
-(void)RTCEventOnSwitchedToVideoCall:(void (^)(NSDictionary *))onSwitchToVideoCall;

-(void)callingEventOnRecordingToggled:(NSDictionary *)info;
-(void)RTCEventOnRecordingToggled:(void (^)(NSDictionary *))info;

-(void)callingEventOnUserMuted:(NSDictionary *)info;
-(void)RTCEventOnUserMuted:(void (^)(NSDictionary *))info;
@end

NS_ASSUME_NONNULL_END
