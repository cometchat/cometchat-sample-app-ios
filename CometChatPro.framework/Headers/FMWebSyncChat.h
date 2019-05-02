//
// Title: WebSync Client Chat Extension for Cocoa
// Version: 4.9.32
// Copyright Frozen Mountain Software 2011+
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#if TARGET_OS_IPHONE
  #import <UIKit/UIKit.h>
#else
  #import <AppKit/AppKit.h>
#endif

@class FMWebSyncChatUserClientJoinArgs;
@class FMWebSyncChatUserClientLeaveArgs;
@class FMWebSyncChatChatClient;
@class FMWebSyncChatChatUser;
@class FMWebSyncClientExtensions;
@class FMWebSyncChatLeaveState;
@class FMWebSyncChatJoinArgs;
@class FMWebSyncChatJoinState;
@class FMWebSyncChatUserJoinArgs;
@class FMWebSyncChatUserLeaveArgs;
@class FMWebSyncChatLeaveArgs;
@class FMWebSyncChatJoinCompleteArgs;
@class FMWebSyncChatJoinFailureArgs;
@class FMWebSyncChatJoinSuccessArgs;
@class FMWebSyncChatLeaveCompleteArgs;
@class FMWebSyncChatLeaveFailureArgs;
@class FMWebSyncChatLeaveSuccessArgs;
@class FMWebSyncChatJoinReceiveArgs;

@class FMWebSyncChatChatUser;
@class NSStringFMExtensions;
@class FMWebSyncSubscribedClient;

/// <summary>
/// Arguments for <see cref="FMWebSyncChatJoinArgs#onUserClientJoin" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatUserClientJoinArgs : FMWebSyncSubscribersClientSubscribeArgs 

/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatUserClientJoinArgs" /> class.
/// </summary>
/// <param name="channel">The channel.</param>
/// <param name="subscribedClient">The subscribed client.</param>
- (id) initWithChannel:(NSString*)channel subscribedClient:(FMWebSyncSubscribedClient*)subscribedClient;
/// <summary>
/// Gets the user associated with the client that joined.
/// </summary>
- (FMWebSyncChatChatUser*) joinedUser;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatUserClientJoinArgs" /> class.
/// </summary>
/// <param name="channel">The channel.</param>
/// <param name="subscribedClient">The subscribed client.</param>
+ (FMWebSyncChatUserClientJoinArgs*) userClientJoinArgsWithChannel:(NSString*)channel subscribedClient:(FMWebSyncSubscribedClient*)subscribedClient;
/// <summary>
/// Gets the ID of the current user.
/// </summary>
- (NSString*) userId;
/// <summary>
/// Gets the nickname of the current user.
/// </summary>
- (NSString*) userNickname;

@end


@class FMWebSyncChatChatUser;
@class NSStringFMExtensions;
@class FMWebSyncSubscribedClient;

/// <summary>
/// Arguments for <see cref="FMWebSyncChatJoinArgs#onUserClientLeave" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatUserClientLeaveArgs : FMWebSyncSubscribersClientUnsubscribeArgs 

/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatUserClientLeaveArgs" /> class.
/// </summary>
/// <param name="channel">The channel.</param>
/// <param name="unsubscribedClient">The unsubscribed client.</param>
- (id) initWithChannel:(NSString*)channel unsubscribedClient:(FMWebSyncSubscribedClient*)unsubscribedClient;
/// <summary>
/// Gets the user associated with the client that left.
/// </summary>
- (FMWebSyncChatChatUser*) leftUser;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatUserClientLeaveArgs" /> class.
/// </summary>
/// <param name="channel">The channel.</param>
/// <param name="unsubscribedClient">The unsubscribed client.</param>
+ (FMWebSyncChatUserClientLeaveArgs*) userClientLeaveArgsWithChannel:(NSString*)channel unsubscribedClient:(FMWebSyncSubscribedClient*)unsubscribedClient;
/// <summary>
/// Gets the ID of the current user.
/// </summary>
- (NSString*) userId;
/// <summary>
/// Gets the nickname of the current user.
/// </summary>
- (NSString*) userNickname;

@end


@class NSMutableDictionaryFMExtensions;
@class FMGuid;

/// <summary>
/// A chat client associated with a given chat user.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatChatClient : FMSerializable 

/// <summary>
/// Gets the bound records of the chat client.
/// </summary>
- (NSMutableDictionary*) boundRecords;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatChatClient" /> class.
/// </summary>
/// <param name="clientId">The ID of the chat client.</param>
/// <param name="boundRecords">The bound records of the chat client.</param>
+ (FMWebSyncChatChatClient*) chatClientWithClientId:(FMGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatChatClient" /> class.
/// </summary>
/// <param name="clientId">The ID of the chat client.</param>
/// <param name="boundRecords">The bound records of the chat client.</param>
+ (FMWebSyncChatChatClient*) chatClientWithId:(FMGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Gets the ID of the chat client.
/// </summary>
- (FMGuid*) clientId;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatChatClient" /> class.
/// </summary>
/// <param name="clientId">The ID of the chat client.</param>
/// <param name="boundRecords">The bound records of the chat client.</param>
- (id) initWithClientId:(FMGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Sets the bound records of the chat client.
/// </summary>
- (void) setBoundRecords:(NSMutableDictionary*)value;
/// <summary>
/// Sets the ID of the chat client.
/// </summary>
- (void) setClientId:(FMGuid*)value;

@end


@class NSMutableDictionaryFMExtensions;
@class FMNullableGuid;
@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// An instance of a chat participant.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatChatUser : FMSerializable 

/// <summary>
/// Gets the bound records of the chat client triggering this event.
/// </summary>
- (NSMutableDictionary*) boundRecords;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatChatUser" /> class.
/// </summary>
/// <param name="userId">The user ID of the chat participant.</param>
/// <param name="userNickname">The user nickname of the chat participant.</param>
/// <param name="clientId">The ID of the chat client triggering this event.</param>
/// <param name="boundRecords">The bound records of the chat client triggering this event.</param>
+ (FMWebSyncChatChatUser*) chatUserWithUserId:(NSString*)userId userNickname:(NSString*)userNickname clientId:(FMNullableGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatChatUser" /> class.
/// </summary>
/// <param name="userId">The user ID of the chat participant.</param>
/// <param name="userNickname">The user nickname of the chat participant.</param>
/// <param name="clientId">The ID of the chat client triggering this event.</param>
/// <param name="boundRecords">The bound records of the chat client triggering this event.</param>
+ (FMWebSyncChatChatUser*) chatUserWithId:(NSString*)userId userNickname:(NSString*)userNickname clientId:(FMNullableGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Gets the ID of the chat client triggering this event.
/// </summary>
- (FMNullableGuid*) clientId;
/// <summary>
/// Gets the chat clients associated with the chat user.
/// </summary>
- (NSMutableArray*) clients;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatChatUser" /> class.
/// </summary>
/// <param name="userId">The user ID of the chat participant.</param>
/// <param name="userNickname">The user nickname of the chat participant.</param>
/// <param name="clientId">The ID of the chat client triggering this event.</param>
/// <param name="boundRecords">The bound records of the chat client triggering this event.</param>
- (id) initWithUserId:(NSString*)userId userNickname:(NSString*)userNickname clientId:(FMNullableGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
- (void) loadClientSetWithClientSet:(NSMutableDictionary*)clientSet;
- (void) loadClientSet:(NSMutableDictionary*)clientSet;
/// <summary>
/// Sets the bound records of the chat client triggering this event.
/// </summary>
- (void) setBoundRecords:(NSMutableDictionary*)value;
/// <summary>
/// Sets the ID of the chat client triggering this event.
/// </summary>
- (void) setClientId:(FMNullableGuid*)value;
/// <summary>
/// Sets the chat clients associated with the chat user.
/// </summary>
- (void) setClients:(NSMutableArray*)value;
/// <summary>
/// Sets the user ID of the chat participant.
/// </summary>
- (void) setUserId:(NSString*)value;
/// <summary>
/// Sets the user nickname of the chat participant.
/// </summary>
- (void) setUserNickname:(NSString*)value;
/// <summary>
/// Gets the user ID of the chat participant.
/// </summary>
- (NSString*) userId;
/// <summary>
/// Gets the user nickname of the chat participant.
/// </summary>
- (NSString*) userNickname;

@end


@class NSStringFMExtensions;
@class FMWebSyncClient;
@class FMWebSyncChatJoinArgs;
@class FMWebSyncChatLeaveArgs;

/// <summary>
/// Extensions for the <see cref="FMWebSyncClient" /> class.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClient (FMWebSyncChatExtensions)

/// <summary>
/// Gets the binding key for a user ID.
/// </summary>
/// <param name="channel">The subscribed channel.</param>
/// <returns></returns>
+ (NSString*) getUserIdKeyWithChannel:(NSString*)channel;
/// <summary>
/// Gets the binding key for a user nickname.
/// </summary>
/// <param name="channel">The subscribed channel.</param>
/// <returns></returns>
+ (NSString*) getUserNicknameKeyWithChannel:(NSString*)channel;
/// <summary>
/// Binds/subscribes the client to the channel with the specified
/// user ID and nickname.
/// </summary>
/// <remarks>
/// When the join completes successfully, the OnSuccess callback
/// will be invoked, passing in the joined channel, user ID, and
/// user nickname, <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="client">The client.</param>
/// <param name="joinArgs">The join arguments.
/// See <see cref="FMWebSyncChatJoinArgs" /> for details.</param>
/// <returns>The client.</returns>
+ (FMWebSyncClient*) joinWithClient:(FMWebSyncClient*)client joinArgs:(FMWebSyncChatJoinArgs*)joinArgs;
/// <summary>
/// Binds/subscribes the client to the channel with the specified
/// user ID and nickname.
/// </summary>
/// <remarks>
/// When the join completes successfully, the OnSuccess callback
/// will be invoked, passing in the joined channel, user ID, and
/// user nickname, <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="client">The client.</param>
/// <param name="joinArgs">The join arguments.
/// See <see cref="FMWebSyncChatJoinArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) joinWithJoinArgs:(FMWebSyncChatJoinArgs*)joinArgs;
/// <summary>
/// Binds/subscribes the client to the channel with the specified
/// user ID and nickname.
/// </summary>
/// <remarks>
/// When the join completes successfully, the OnSuccess callback
/// will be invoked, passing in the joined channel, user ID, and
/// user nickname, <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="client">The client.</param>
/// <param name="joinArgs">The join arguments.
/// See <see cref="FMWebSyncChatJoinArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) joinWithArgs:(FMWebSyncChatJoinArgs*)joinArgs;
/// <summary>
/// Unsubscribes/unbinds the client from the channel.
/// </summary>
/// <remarks>
/// When the leave completes successfully, the OnSuccess callback
/// will be invoked, passing in the left
/// channel, <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="client">The client.</param>
/// <param name="leaveArgs">The leave arguments.
/// See <see cref="FMWebSyncChatLeaveArgs" /> for details.</param>
/// <returns>The client.</returns>
+ (FMWebSyncClient*) leaveWithClient:(FMWebSyncClient*)client leaveArgs:(FMWebSyncChatLeaveArgs*)leaveArgs;
/// <summary>
/// Unsubscribes/unbinds the client from the channel.
/// </summary>
/// <remarks>
/// When the leave completes successfully, the OnSuccess callback
/// will be invoked, passing in the left
/// channel, <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="client">The client.</param>
/// <param name="leaveArgs">The leave arguments.
/// See <see cref="FMWebSyncChatLeaveArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) leaveWithLeaveArgs:(FMWebSyncChatLeaveArgs*)leaveArgs;
/// <summary>
/// Unsubscribes/unbinds the client from the channel.
/// </summary>
/// <remarks>
/// When the leave completes successfully, the OnSuccess callback
/// will be invoked, passing in the left
/// channel, <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="client">The client.</param>
/// <param name="leaveArgs">The leave arguments.
/// See <see cref="FMWebSyncChatLeaveArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) leaveWithArgs:(FMWebSyncChatLeaveArgs*)leaveArgs;

@end


@class FMWebSyncUnbindFailureArgs;
@class FMWebSyncUnbindSuccessArgs;
@class FMWebSyncUnsubscribeFailureArgs;
@class FMWebSyncUnsubscribeSuccessArgs;

#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatLeaveState : NSObject 

- (id) init;
+ (FMWebSyncChatLeaveState*) leaveState;
- (FMWebSyncUnbindFailureArgs*) unbindFailureArgs;
- (bool) unbindSuccess;
- (FMWebSyncUnbindSuccessArgs*) unbindSuccessArgs;
- (FMWebSyncUnsubscribeFailureArgs*) unsubscribeFailureArgs;
- (bool) unsubscribeSuccess;
- (FMWebSyncUnsubscribeSuccessArgs*) unsubscribeSuccessArgs;
- (void) updateUnbindFailureWithUnbindFailureArgs:(FMWebSyncUnbindFailureArgs*)unbindFailureArgs;
- (void) updateUnbindFailureWithArgs:(FMWebSyncUnbindFailureArgs*)unbindFailureArgs;
- (void) updateUnbindSuccessWithUnbindSuccessArgs:(FMWebSyncUnbindSuccessArgs*)unbindSuccessArgs;
- (void) updateUnbindSuccessWithArgs:(FMWebSyncUnbindSuccessArgs*)unbindSuccessArgs;
- (void) updateUnsubscribeFailureWithUnsubscribeFailureArgs:(FMWebSyncUnsubscribeFailureArgs*)unsubscribeFailureArgs;
- (void) updateUnsubscribeFailureWithArgs:(FMWebSyncUnsubscribeFailureArgs*)unsubscribeFailureArgs;
- (void) updateUnsubscribeSuccessWithUnsubscribeSuccessArgs:(FMWebSyncUnsubscribeSuccessArgs*)unsubscribeSuccessArgs;
- (void) updateUnsubscribeSuccessWithArgs:(FMWebSyncUnsubscribeSuccessArgs*)unsubscribeSuccessArgs;

@end


@class FMWebSyncChatJoinCompleteArgs;
@class FMWebSyncChatJoinFailureArgs;
@class FMWebSyncChatJoinSuccessArgs;
@class FMWebSyncChatUserJoinArgs;
@class FMWebSyncChatUserLeaveArgs;
@class FMWebSyncChatUserClientJoinArgs;
@class FMWebSyncChatUserClientLeaveArgs;
@class FMWebSyncChatJoinReceiveArgs;
@class NSMutableArrayFMExtensions;
@class FMCallback;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for a client joining a chat channel.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatJoinArgs : FMWebSyncBaseInputArgs 

/// <summary>
/// Gets the channel to which the client should be subscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatJoinArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels to which the client should be subscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatJoinArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatJoinArgs" /> class.
/// </summary>
/// <param name="channel">The channel to join.</param>
- (id) initWithChannel:(NSString*)channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatJoinArgs" /> class.
/// </summary>
/// <param name="channel">The channel to join.</param>
/// <param name="tag">The tag identifying the subscription.</param>
- (id) initWithChannel:(NSString*)channel tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatJoinArgs" /> class.
/// </summary>
/// <param name="channels">The channels to join.</param>
- (id) initWithChannels:(NSMutableArray*)channels;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatJoinArgs" /> class.
/// </summary>
/// <param name="channels">The channels to join.</param>
/// <param name="tag">The tag identifying the subscription.</param>
- (id) initWithChannels:(NSMutableArray*)channels tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatJoinArgs" /> class.
/// </summary>
/// <param name="channel">The channel to join.</param>
+ (FMWebSyncChatJoinArgs*) joinArgsWithChannel:(NSString*)channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatJoinArgs" /> class.
/// </summary>
/// <param name="channel">The channel to join.</param>
/// <param name="tag">The tag identifying the subscription.</param>
+ (FMWebSyncChatJoinArgs*) joinArgsWithChannel:(NSString*)channel tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatJoinArgs" /> class.
/// </summary>
/// <param name="channels">The channels to join.</param>
+ (FMWebSyncChatJoinArgs*) joinArgsWithChannels:(NSMutableArray*)channels;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatJoinArgs" /> class.
/// </summary>
/// <param name="channels">The channels to join.</param>
/// <param name="tag">The tag identifying the subscription.</param>
+ (FMWebSyncChatJoinArgs*) joinArgsWithChannels:(NSMutableArray*)channels tag:(NSString*)tag;
/// <summary>
/// Gets the callback to invoke after <see cref="FMWebSyncChatJoinArgs#onSuccess" /> or <see cref="FMWebSyncChatJoinArgs#onFailure" />.
/// </summary>
- (FMCallback*) onComplete;
/// <summary>
/// Gets the callback to invoke if the request fails.
/// </summary>
- (FMCallback*) onFailure;
/// <summary>
/// Gets the callback to invoke when data is received on the channel.
/// See <see cref="FMWebSyncChatJoinReceiveArgs" /> for callback argument details.
/// </summary>
- (FMCallback*) onReceive;
/// <summary>
/// Gets the callback to invoke if the request succeeds.
/// </summary>
- (FMCallback*) onSuccess;
/// <summary>
/// Gets the callback to invoke when any client associated with
/// a given user ID joins the channel.
/// See <see cref="FMWebSyncChatUserClientJoinArgs" /> for callback argument details.
/// This callback is invoked when the client count for a given user ID
/// increases.
/// </summary>
- (FMCallback*) onUserClientJoin;
/// <summary>
/// Gets the callback to invoke when any client associated with
/// a given user ID leaves the channel.
/// See <see cref="FMWebSyncChatUserClientLeaveArgs" /> for callback argument details.
/// This callback is invoked when the client count for a given user ID
/// decreases.
/// </summary>
- (FMCallback*) onUserClientLeave;
/// <summary>
/// Gets the callback to invoke when the first client associated
/// with a given user ID joins the channel.
/// See <see cref="FMWebSyncChatUserJoinArgs" /> for callback argument details.
/// This callback is invoked when the client count for a given user ID
/// moves from 0 to 1.
/// </summary>
- (FMCallback*) onUserJoin;
/// <summary>
/// Gets the callback to invoke when the last client associated
/// with a given user ID leaves the channel.
/// See <see cref="FMWebSyncChatUserLeaveArgs" /> for callback argument details.
/// This callback is invoked when the client count for a given user ID
/// moves from 1 to 0.
/// </summary>
- (FMCallback*) onUserLeave;
- (bool) rejoin;
/// <summary>
/// Sets the channel to which the client should be subscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatJoinArgs#channels" />.
/// </summary>
- (void) setChannel:(NSString*)value;
/// <summary>
/// Sets the channels to which the client should be subscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatJoinArgs#channel" />.
/// </summary>
- (void) setChannels:(NSMutableArray*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncChatJoinArgs#onSuccess" /> or <see cref="FMWebSyncChatJoinArgs#onFailure" />.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncChatJoinArgs#onSuccess" /> or <see cref="FMWebSyncChatJoinArgs#onFailure" />.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMWebSyncChatJoinCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMWebSyncChatJoinFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke when data is received on the channel.
/// See <see cref="FMWebSyncChatJoinReceiveArgs" /> for callback argument details.
/// </summary>
- (void) setOnReceive:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke when data is received on the channel.
/// See <see cref="FMWebSyncChatJoinReceiveArgs" /> for callback argument details.
/// </summary>
- (void) setOnReceiveBlock:(void (^) (FMWebSyncChatJoinReceiveArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMWebSyncChatJoinSuccessArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke when any client associated with
/// a given user ID joins the channel.
/// See <see cref="FMWebSyncChatUserClientJoinArgs" /> for callback argument details.
/// This callback is invoked when the client count for a given user ID
/// increases.
/// </summary>
- (void) setOnUserClientJoin:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke when any client associated with
/// a given user ID joins the channel.
/// See <see cref="FMWebSyncChatUserClientJoinArgs" /> for callback argument details.
/// This callback is invoked when the client count for a given user ID
/// increases.
/// </summary>
- (void) setOnUserClientJoinBlock:(void (^) (FMWebSyncChatUserClientJoinArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke when any client associated with
/// a given user ID leaves the channel.
/// See <see cref="FMWebSyncChatUserClientLeaveArgs" /> for callback argument details.
/// This callback is invoked when the client count for a given user ID
/// decreases.
/// </summary>
- (void) setOnUserClientLeave:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke when any client associated with
/// a given user ID leaves the channel.
/// See <see cref="FMWebSyncChatUserClientLeaveArgs" /> for callback argument details.
/// This callback is invoked when the client count for a given user ID
/// decreases.
/// </summary>
- (void) setOnUserClientLeaveBlock:(void (^) (FMWebSyncChatUserClientLeaveArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke when the first client associated
/// with a given user ID joins the channel.
/// See <see cref="FMWebSyncChatUserJoinArgs" /> for callback argument details.
/// This callback is invoked when the client count for a given user ID
/// moves from 0 to 1.
/// </summary>
- (void) setOnUserJoin:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke when the first client associated
/// with a given user ID joins the channel.
/// See <see cref="FMWebSyncChatUserJoinArgs" /> for callback argument details.
/// This callback is invoked when the client count for a given user ID
/// moves from 0 to 1.
/// </summary>
- (void) setOnUserJoinBlock:(void (^) (FMWebSyncChatUserJoinArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke when the last client associated
/// with a given user ID leaves the channel.
/// See <see cref="FMWebSyncChatUserLeaveArgs" /> for callback argument details.
/// This callback is invoked when the client count for a given user ID
/// moves from 1 to 0.
/// </summary>
- (void) setOnUserLeave:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke when the last client associated
/// with a given user ID leaves the channel.
/// See <see cref="FMWebSyncChatUserLeaveArgs" /> for callback argument details.
/// This callback is invoked when the client count for a given user ID
/// moves from 1 to 0.
/// </summary>
- (void) setOnUserLeaveBlock:(void (^) (FMWebSyncChatUserLeaveArgs*))valueBlock;
- (void) setRejoin:(bool)value;
/// <summary>
/// Sets a tag that will uniquely identify this subscription so it
/// can be unsubscribed later without affecting other subscriptions with the same channel.
/// </summary>
- (void) setTag:(NSString*)value;
/// <summary>
/// Sets the current user ID.
/// </summary>
- (void) setUserId:(NSString*)value;
/// <summary>
/// Sets the current user nickname.
/// </summary>
- (void) setUserNickname:(NSString*)value;
/// <summary>
/// Gets a tag that will uniquely identify this subscription so it
/// can be unsubscribed later without affecting other subscriptions with the same channel.
/// </summary>
- (NSString*) tag;
/// <summary>
/// Gets the current user ID.
/// </summary>
- (NSString*) userId;
/// <summary>
/// Gets the current user nickname.
/// </summary>
- (NSString*) userNickname;

@end


@class FMWebSyncBindFailureArgs;
@class FMWebSyncBindSuccessArgs;
@class FMWebSyncSubscribeFailureArgs;
@class FMWebSyncSubscribeSuccessArgs;

#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatJoinState : NSObject 

- (FMWebSyncBindFailureArgs*) bindFailureArgs;
- (bool) bindSuccess;
- (FMWebSyncBindSuccessArgs*) bindSuccessArgs;
- (id) init;
+ (FMWebSyncChatJoinState*) joinState;
- (FMWebSyncSubscribeFailureArgs*) subscribeFailureArgs;
- (bool) subscribeSuccess;
- (FMWebSyncSubscribeSuccessArgs*) subscribeSuccessArgs;
- (void) updateBindFailureWithBindFailureArgs:(FMWebSyncBindFailureArgs*)bindFailureArgs;
- (void) updateBindFailureWithArgs:(FMWebSyncBindFailureArgs*)bindFailureArgs;
- (void) updateBindSuccessWithBindSuccessArgs:(FMWebSyncBindSuccessArgs*)bindSuccessArgs;
- (void) updateBindSuccessWithArgs:(FMWebSyncBindSuccessArgs*)bindSuccessArgs;
- (void) updateSubscribeFailureWithSubscribeFailureArgs:(FMWebSyncSubscribeFailureArgs*)subscribeFailureArgs;
- (void) updateSubscribeFailureWithArgs:(FMWebSyncSubscribeFailureArgs*)subscribeFailureArgs;
- (void) updateSubscribeSuccessWithSubscribeSuccessArgs:(FMWebSyncSubscribeSuccessArgs*)subscribeSuccessArgs;
- (void) updateSubscribeSuccessWithArgs:(FMWebSyncSubscribeSuccessArgs*)subscribeSuccessArgs;

@end


@class FMWebSyncChatChatUser;
@class NSStringFMExtensions;
@class FMWebSyncSubscribedClient;

/// <summary>
/// Arguments for <see cref="FMWebSyncChatJoinArgs#onUserJoin" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatUserJoinArgs : FMWebSyncSubscribersClientSubscribeArgs 

/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatUserJoinArgs" /> class.
/// </summary>
/// <param name="channel">The channel.</param>
/// <param name="subscribedClient">The subscribed client.</param>
- (id) initWithChannel:(NSString*)channel subscribedClient:(FMWebSyncSubscribedClient*)subscribedClient;
/// <summary>
/// Gets the user that joined.
/// </summary>
- (FMWebSyncChatChatUser*) joinedUser;
/// <summary>
/// Gets the ID of the current user.
/// </summary>
- (NSString*) userId;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatUserJoinArgs" /> class.
/// </summary>
/// <param name="channel">The channel.</param>
/// <param name="subscribedClient">The subscribed client.</param>
+ (FMWebSyncChatUserJoinArgs*) userJoinArgsWithChannel:(NSString*)channel subscribedClient:(FMWebSyncSubscribedClient*)subscribedClient;
/// <summary>
/// Gets the nickname of the current user.
/// </summary>
- (NSString*) userNickname;

@end


@class FMWebSyncChatChatUser;
@class NSStringFMExtensions;
@class FMWebSyncSubscribedClient;

/// <summary>
/// Arguments for <see cref="FMWebSyncChatJoinArgs#onUserLeave" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatUserLeaveArgs : FMWebSyncSubscribersClientUnsubscribeArgs 

/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatUserLeaveArgs" /> class.
/// </summary>
/// <param name="channel">The channel.</param>
/// <param name="unsubscribedClient">The unsubscribed client.</param>
- (id) initWithChannel:(NSString*)channel unsubscribedClient:(FMWebSyncSubscribedClient*)unsubscribedClient;
/// <summary>
/// Gets the user that left.
/// </summary>
- (FMWebSyncChatChatUser*) leftUser;
/// <summary>
/// Gets the ID of the current user.
/// </summary>
- (NSString*) userId;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatUserLeaveArgs" /> class.
/// </summary>
/// <param name="channel">The channel.</param>
/// <param name="unsubscribedClient">The unsubscribed client.</param>
+ (FMWebSyncChatUserLeaveArgs*) userLeaveArgsWithChannel:(NSString*)channel unsubscribedClient:(FMWebSyncSubscribedClient*)unsubscribedClient;
/// <summary>
/// Gets the nickname of the current user.
/// </summary>
- (NSString*) userNickname;

@end


@class FMWebSyncChatLeaveCompleteArgs;
@class FMWebSyncChatLeaveFailureArgs;
@class FMWebSyncChatLeaveSuccessArgs;
@class NSMutableArrayFMExtensions;
@class FMCallback;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for a client leaving a chat channel.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatLeaveArgs : FMWebSyncBaseInputArgs 

/// <summary>
/// Gets the channel from which the client should be unsubscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatLeaveArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels from which the client should be unsubscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatLeaveArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatLeaveArgs" /> class.
/// </summary>
/// <param name="channel">The channel to leave.</param>
- (id) initWithChannel:(NSString*)channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatLeaveArgs" /> class.
/// </summary>
/// <param name="channel">The channel to leave.</param>
/// <param name="tag">The tag identifying the subscription.</param>
- (id) initWithChannel:(NSString*)channel tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatLeaveArgs" /> class.
/// </summary>
/// <param name="channels">The channels to join.</param>
- (id) initWithChannels:(NSMutableArray*)channels;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatLeaveArgs" /> class.
/// </summary>
/// <param name="channels">The channels to leave.</param>
/// <param name="tag">The tag identifying the subscription.</param>
- (id) initWithChannels:(NSMutableArray*)channels tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatLeaveArgs" /> class.
/// </summary>
/// <param name="channel">The channel to leave.</param>
+ (FMWebSyncChatLeaveArgs*) leaveArgsWithChannel:(NSString*)channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatLeaveArgs" /> class.
/// </summary>
/// <param name="channel">The channel to leave.</param>
/// <param name="tag">The tag identifying the subscription.</param>
+ (FMWebSyncChatLeaveArgs*) leaveArgsWithChannel:(NSString*)channel tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatLeaveArgs" /> class.
/// </summary>
/// <param name="channels">The channels to join.</param>
+ (FMWebSyncChatLeaveArgs*) leaveArgsWithChannels:(NSMutableArray*)channels;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatLeaveArgs" /> class.
/// </summary>
/// <param name="channels">The channels to leave.</param>
/// <param name="tag">The tag identifying the subscription.</param>
+ (FMWebSyncChatLeaveArgs*) leaveArgsWithChannels:(NSMutableArray*)channels tag:(NSString*)tag;
/// <summary>
/// Gets the callback to invoke after <see cref="FMWebSyncChatLeaveArgs#onSuccess" /> or <see cref="FMWebSyncChatLeaveArgs#onFailure" />.
/// </summary>
- (FMCallback*) onComplete;
/// <summary>
/// Gets the callback to invoke if the request fails.
/// </summary>
- (FMCallback*) onFailure;
/// <summary>
/// Gets the callback to invoke if the request succeeds.
/// </summary>
- (FMCallback*) onSuccess;
/// <summary>
/// Sets the channel from which the client should be unsubscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatLeaveArgs#channels" />.
/// </summary>
- (void) setChannel:(NSString*)value;
/// <summary>
/// Sets the channels from which the client should be unsubscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatLeaveArgs#channel" />.
/// </summary>
- (void) setChannels:(NSMutableArray*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncChatLeaveArgs#onSuccess" /> or <see cref="FMWebSyncChatLeaveArgs#onFailure" />.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncChatLeaveArgs#onSuccess" /> or <see cref="FMWebSyncChatLeaveArgs#onFailure" />.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMWebSyncChatLeaveCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMWebSyncChatLeaveFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMWebSyncChatLeaveSuccessArgs*))valueBlock;
/// <summary>
/// Sets a tag that uniquely identifies a subscription so
/// other subscriptions with the same channel are not affected.
/// </summary>
- (void) setTag:(NSString*)value;
/// <summary>
/// Gets a tag that uniquely identifies a subscription so
/// other subscriptions with the same channel are not affected.
/// </summary>
- (NSString*) tag;

@end



/// <summary>
/// Arguments for join complete callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatJoinCompleteArgs : FMWebSyncBaseCompleteArgs 

- (id) init;
/// <summary>
/// Gets whether the join call was automatically
/// invoked following a stream failure.
/// </summary>
- (bool) isRejoin;
+ (FMWebSyncChatJoinCompleteArgs*) joinCompleteArgs;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for join failure callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatJoinFailureArgs : FMWebSyncBaseFailureArgs 

/// <summary>
/// Gets the channel to which the client failed to be subscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatJoinFailureArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels to which the client failed to be subscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatJoinFailureArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
- (id) init;
/// <summary>
/// Gets whether the join call was automatically
/// invoked following a stream failure.
/// </summary>
- (bool) isRejoin;
+ (FMWebSyncChatJoinFailureArgs*) joinFailureArgs;
/// <summary>
/// Gets the tag associated with the subscribe request.
/// </summary>
- (NSString*) tag;
/// <summary>
/// Gets the ID of the current user.
/// </summary>
- (NSString*) userId;
/// <summary>
/// Gets the nickname of the current user.
/// </summary>
- (NSString*) userNickname;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for join success callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatJoinSuccessArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets the channel to which the client was subscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatJoinSuccessArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels to which the client was subscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatJoinSuccessArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
- (id) init;
/// <summary>
/// Gets whether the join call was automatically
/// invoked following a stream failure.
/// </summary>
- (bool) isRejoin;
+ (FMWebSyncChatJoinSuccessArgs*) joinSuccessArgs;
/// <summary>
/// Gets the tag associated with the subscribe request.
/// </summary>
- (NSString*) tag;
/// <summary>
/// Gets the ID of the current user.
/// </summary>
- (NSString*) userId;
/// <summary>
/// Gets the nickname of the current user.
/// </summary>
- (NSString*) userNickname;
/// <summary>
/// Gets the array of users in the channel.
/// </summary>
- (NSMutableArray*) users;

@end



/// <summary>
/// Arguments for leave complete callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatLeaveCompleteArgs : FMWebSyncBaseCompleteArgs 

- (id) init;
+ (FMWebSyncChatLeaveCompleteArgs*) leaveCompleteArgs;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for leave failure callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatLeaveFailureArgs : FMWebSyncBaseFailureArgs 

/// <summary>
/// Gets the channel from which the client failed to be unsubscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatLeaveFailureArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels from which the client failed to be unsubscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatLeaveFailureArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
- (id) init;
+ (FMWebSyncChatLeaveFailureArgs*) leaveFailureArgs;
/// <summary>
/// Gets the tag associated with the subscribe request.
/// </summary>
- (NSString*) tag;
/// <summary>
/// Gets the ID of the current user.
/// </summary>
- (NSString*) userId;
/// <summary>
/// Gets the nickname of the current user.
/// </summary>
- (NSString*) userNickname;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for leave success callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatLeaveSuccessArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets the channel from which the client was unsubscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatLeaveSuccessArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels from which the client was unsubscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncChatLeaveSuccessArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
- (id) init;
+ (FMWebSyncChatLeaveSuccessArgs*) leaveSuccessArgs;
/// <summary>
/// Gets the tag associated with the subscribe request.
/// </summary>
- (NSString*) tag;
/// <summary>
/// Gets the ID of the current user.
/// </summary>
- (NSString*) userId;
/// <summary>
/// Gets the nickname of the current user.
/// </summary>
- (NSString*) userNickname;

@end


@class FMWebSyncChatChatUser;
@class NSStringFMExtensions;
@class NSMutableDataFMExtensions;

/// <summary>
/// Arguments for join receive callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncChatJoinReceiveArgs : FMWebSyncSubscribeReceiveArgs 

/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatJoinReceiveArgs" /> class.
/// </summary>
/// <param name="channel">The channel over which data was received.</param>
/// <param name="dataJson">The data in JSON format.</param>
/// <param name="dataBytes">The data in binary format.</param>
/// <param name="connectionType">The current connection type.</param>
/// <param name="reconnectAfter">The amount of time in milliseconds to pause before reconnecting to the server.</param>
- (id) initWithChannel:(NSString*)channel dataJson:(NSString*)dataJson dataBytes:(NSMutableData*)dataBytes connectionType:(FMWebSyncConnectionType)connectionType reconnectAfter:(int)reconnectAfter;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncChatJoinReceiveArgs" /> class.
/// </summary>
/// <param name="channel">The channel over which data was received.</param>
/// <param name="dataJson">The data in JSON format.</param>
/// <param name="dataBytes">The data in binary format.</param>
/// <param name="connectionType">The current connection type.</param>
/// <param name="reconnectAfter">The amount of time in milliseconds to pause before reconnecting to the server.</param>
+ (FMWebSyncChatJoinReceiveArgs*) joinReceiveArgsWithChannel:(NSString*)channel dataJson:(NSString*)dataJson dataBytes:(NSMutableData*)dataBytes connectionType:(FMWebSyncConnectionType)connectionType reconnectAfter:(int)reconnectAfter;
/// <summary>
/// Gets the user that published the message.
/// </summary>
- (FMWebSyncChatChatUser*) publishingUser;
/// <summary>
/// Gets the ID of the current user.
/// </summary>
- (NSString*) userId;
/// <summary>
/// Gets the nickname of the current user.
/// </summary>
- (NSString*) userNickname;

@end

