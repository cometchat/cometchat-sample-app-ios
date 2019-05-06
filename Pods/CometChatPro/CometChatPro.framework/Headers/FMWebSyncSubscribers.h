//
// Title: WebSync Client Subscribers Extension for Cocoa
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

@class FMWebSyncSubscribersBase;
@class FMWebSyncSubscribersClientUnsubscribeArgs;
@class FMWebSyncSubscribersSerializer;
@class FMWebSyncSubscribeArgsExtensions;
@class FMWebSyncSubscribersSubscriberChange;
@class FMWebSyncSubscribersClientSubscribeArgs;
@class FMWebSyncSubscribeSuccessArgsExtensions;


/// <summary>
/// The subscribers change type.
/// </summary>
/// <remarks>
/// The type of change to the subscribers of a channel, subscribe or unsubscribe.
/// </remarks>
typedef enum {
	/// <summary>
	/// Indicates that new clients are subscribing to the channel.
	/// </summary>
	FMWebSyncSubscribersSubscriberChangeTypeSubscribe = 1,
	/// <summary>
	/// Indicates that existing clients are unsubscribing from the channel.
	/// </summary>
	FMWebSyncSubscribersSubscriberChangeTypeUnsubscribe = 2
} FMWebSyncSubscribersSubscriberChangeType;


@class NSMutableDictionaryFMExtensions;
@class FMWebSyncExtensible;

/// <summary>
/// Base methods supporting the Subscribers extension.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribersBase : NSObject 

/// <summary>
/// Gets the subscribed clients.
/// </summary>
/// <param name="extensible">The extensible base.</param>
/// <returns>The subscribed clients.</returns>
+ (NSMutableDictionary*) getSubscribedClientsWithExtensible:(FMWebSyncExtensible*)extensible;
/// <summary>
/// Sets the subscribed clients.
/// </summary>
/// <param name="extensible">The extensible base.</param>
/// <param name="subscribedClients">The subscribed clients.</param>
+ (void) setSubscribedClientsWithExtensible:(FMWebSyncExtensible*)extensible subscribedClients:(NSMutableDictionary*)subscribedClients;

@end


@class NSStringFMExtensions;
@class FMWebSyncSubscribedClient;

/// <summary>
/// Arguments for the subscriber change callback.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribersClientUnsubscribeArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets the channel on which the change occurred.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribersClientUnsubscribeArgs" /> class.
/// </summary>
/// <param name="channel">The channel.</param>
/// <param name="unsubscribedClient">The unsubscribed client.</param>
+ (FMWebSyncSubscribersClientUnsubscribeArgs*) clientUnsubscribeArgsWithChannel:(NSString*)channel unsubscribedClient:(FMWebSyncSubscribedClient*)unsubscribedClient;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribersClientUnsubscribeArgs" /> class.
/// </summary>
/// <param name="channel">The channel.</param>
/// <param name="unsubscribedClient">The unsubscribed client.</param>
- (id) initWithChannel:(NSString*)channel unsubscribedClient:(FMWebSyncSubscribedClient*)unsubscribedClient;
/// <summary>
/// Gets the client who unsubscribed from the channel.
/// </summary>
- (FMWebSyncSubscribedClient*) unsubscribedClient;

@end


@class NSMutableDictionaryFMExtensions;
@class FMWebSyncSubscribersSubscriberChange;
@class NSStringFMExtensions;

#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribersSerializer : NSObject 

+ (NSMutableDictionary*) createSubscribedClients;
+ (FMWebSyncSubscribersSubscriberChange*) createSubscriberChange;
+ (void) deserializeSubscribedClientsCallbackWithSubscribedClients:(NSMutableDictionary*)subscribedClients name:(NSString*)name valueJson:(NSString*)valueJson;
+ (NSMutableDictionary*) deserializeSubscribedClientsWithSubscribedClientsJson:(NSString*)subscribedClientsJson;
+ (NSMutableDictionary*) deserializeSubscribedClientsWithJson:(NSString*)subscribedClientsJson;
+ (void) deserializeSubscriberChangeCallbackWithSubscriberChange:(FMWebSyncSubscribersSubscriberChange*)subscriberChange name:(NSString*)name valueJson:(NSString*)valueJson;
+ (FMWebSyncSubscribersSubscriberChangeType) deserializeSubscriberChangeTypeWithSubscriberChangeTypeJson:(NSString*)subscriberChangeTypeJson;
+ (FMWebSyncSubscribersSubscriberChangeType) deserializeSubscriberChangeTypeWithJson:(NSString*)subscriberChangeTypeJson;
+ (FMWebSyncSubscribersSubscriberChange*) deserializeSubscriberChangeWithSubscriberChangeJson:(NSString*)subscriberChangeJson;
+ (FMWebSyncSubscribersSubscriberChange*) deserializeSubscriberChangeWithJson:(NSString*)subscriberChangeJson;
- (id) init;
+ (FMWebSyncSubscribersSerializer*) serializer;
+ (void) serializeSubscribedClientsCallbackWithSubscribedClients:(NSMutableDictionary*)subscribedClients jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializeSubscribedClientsWithSubscribedClients:(NSMutableDictionary*)subscribedClients;
+ (NSString*) serializeSubscribedClients:(NSMutableDictionary*)subscribedClients;
+ (void) serializeSubscriberChangeCallbackWithSubscriberChange:(FMWebSyncSubscribersSubscriberChange*)subscriberChange jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializeSubscriberChangeTypeWithSubscriberChangeType:(FMWebSyncSubscribersSubscriberChangeType)subscriberChangeType;
+ (NSString*) serializeSubscriberChangeType:(FMWebSyncSubscribersSubscriberChangeType)subscriberChangeType;
+ (NSString*) serializeSubscriberChangeWithSubscriberChange:(FMWebSyncSubscribersSubscriberChange*)subscriberChange;
+ (NSString*) serializeSubscriberChange:(FMWebSyncSubscribersSubscriberChange*)subscriberChange;

@end


@class FMWebSyncSubscribersClientSubscribeArgs;
@class FMWebSyncSubscribersClientUnsubscribeArgs;
@class FMCallback;
@class FMWebSyncSubscribeArgs;

/// <summary>
/// <see cref="FMWebSyncSubscribeArgs" /> extension methods for the Subscribers extension.
/// </summary>
/// <remarks>
/// <para>
/// The subscribers extension provides support for initial state load and differential
/// updates on the clients actively subscribed to the channel(s).
/// </para>
/// <para>
/// The extension is activated by adding a reference to your project.
/// </para>
/// </remarks>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribeArgs (FMWebSyncSubscribersExtensions)

/// <summary>
/// Gets the callback invoked when a client subscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <returns>The callback invoked when a client subscribes.</returns>
- (FMCallback*) getOnClientSubscribe;
/// <summary>
/// Gets the callback invoked when a client subscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <returns>The callback invoked when a client subscribes.</returns>
+ (FMCallback*) getOnClientSubscribeWithArgs:(FMWebSyncSubscribeArgs*)args;
/// <summary>
/// Gets the callback invoked when a client unsubscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <returns>The callback invoked when a client unsubscribes.</returns>
- (FMCallback*) getOnClientUnsubscribe;
/// <summary>
/// Gets the callback invoked when a client unsubscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <returns>The callback invoked when a client unsubscribes.</returns>
+ (FMCallback*) getOnClientUnsubscribeWithArgs:(FMWebSyncSubscribeArgs*)args;
/// <summary>
/// Sets a callback to invoke when a client subscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <param name="onClientSubscribe">The callback to invoke when a client subscribes to
/// the channel(s)).</param>
/// <returns>The <see cref="FMWebSyncSubscribeArgs" />.</returns>
+ (FMWebSyncSubscribeArgs*) setOnClientSubscribeWithArgs:(FMWebSyncSubscribeArgs*)args onClientSubscribe:(FMCallback*)onClientSubscribe;
/// <summary>
/// Sets a callback to invoke when a client subscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <param name="onClientSubscribe">The callback to invoke when a client subscribes to
/// the channel(s)).</param>
/// <returns>The <see cref="FMWebSyncSubscribeArgs" />.</returns>
+ (FMWebSyncSubscribeArgs*) setOnClientSubscribeWithArgs:(FMWebSyncSubscribeArgs*)args onClientSubscribeBlock:(void (^) (FMWebSyncSubscribersClientSubscribeArgs*))onClientSubscribeBlock;
/// <summary>
/// Sets a callback to invoke when a client subscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <param name="onClientSubscribe">The callback to invoke when a client subscribes to
/// the channel(s)).</param>
/// <returns>The <see cref="FMWebSyncSubscribeArgs" />.</returns>
- (FMWebSyncSubscribeArgs*) setOnClientSubscribeWithOnClientSubscribe:(FMCallback*)onClientSubscribe;
/// <summary>
/// Sets a callback to invoke when a client subscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <param name="onClientSubscribe">The callback to invoke when a client subscribes to
/// the channel(s)).</param>
/// <returns>The <see cref="FMWebSyncSubscribeArgs" />.</returns>
- (FMWebSyncSubscribeArgs*) setOnClientSubscribe:(FMCallback*)onClientSubscribe;
/// <summary>
/// Sets a callback to invoke when a client subscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <param name="onClientSubscribe">The callback to invoke when a client subscribes to
/// the channel(s)).</param>
/// <returns>The <see cref="FMWebSyncSubscribeArgs" />.</returns>
- (FMWebSyncSubscribeArgs*) setOnClientSubscribeWithOnClientSubscribeBlock:(void (^) (FMWebSyncSubscribersClientSubscribeArgs*))onClientSubscribeBlock;
/// <summary>
/// Sets a callback to invoke when a client subscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <param name="onClientSubscribe">The callback to invoke when a client subscribes to
/// the channel(s)).</param>
/// <returns>The <see cref="FMWebSyncSubscribeArgs" />.</returns>
- (FMWebSyncSubscribeArgs*) setOnClientSubscribeBlock:(void (^) (FMWebSyncSubscribersClientSubscribeArgs*))onClientSubscribeBlock;
/// <summary>
/// Sets a callback to invoke when a client unsubscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <param name="onClientUnsubscribe">The callback to invoke when a client unsubscribes from
/// the channel(s)).</param>
/// <returns>The <see cref="FMWebSyncSubscribeArgs" />.</returns>
+ (FMWebSyncSubscribeArgs*) setOnClientUnsubscribeWithArgs:(FMWebSyncSubscribeArgs*)args onClientUnsubscribe:(FMCallback*)onClientUnsubscribe;
/// <summary>
/// Sets a callback to invoke when a client unsubscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <param name="onClientUnsubscribe">The callback to invoke when a client unsubscribes from
/// the channel(s)).</param>
/// <returns>The <see cref="FMWebSyncSubscribeArgs" />.</returns>
+ (FMWebSyncSubscribeArgs*) setOnClientUnsubscribeWithArgs:(FMWebSyncSubscribeArgs*)args onClientUnsubscribeBlock:(void (^) (FMWebSyncSubscribersClientUnsubscribeArgs*))onClientUnsubscribeBlock;
/// <summary>
/// Sets a callback to invoke when a client unsubscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <param name="onClientUnsubscribe">The callback to invoke when a client unsubscribes from
/// the channel(s)).</param>
/// <returns>The <see cref="FMWebSyncSubscribeArgs" />.</returns>
- (FMWebSyncSubscribeArgs*) setOnClientUnsubscribeWithOnClientUnsubscribe:(FMCallback*)onClientUnsubscribe;
/// <summary>
/// Sets a callback to invoke when a client unsubscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <param name="onClientUnsubscribe">The callback to invoke when a client unsubscribes from
/// the channel(s)).</param>
/// <returns>The <see cref="FMWebSyncSubscribeArgs" />.</returns>
- (FMWebSyncSubscribeArgs*) setOnClientUnsubscribe:(FMCallback*)onClientUnsubscribe;
/// <summary>
/// Sets a callback to invoke when a client unsubscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <param name="onClientUnsubscribe">The callback to invoke when a client unsubscribes from
/// the channel(s)).</param>
/// <returns>The <see cref="FMWebSyncSubscribeArgs" />.</returns>
- (FMWebSyncSubscribeArgs*) setOnClientUnsubscribeWithOnClientUnsubscribeBlock:(void (^) (FMWebSyncSubscribersClientUnsubscribeArgs*))onClientUnsubscribeBlock;
/// <summary>
/// Sets a callback to invoke when a client unsubscribes.
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeArgs" /> to extend.</param>
/// <param name="onClientUnsubscribe">The callback to invoke when a client unsubscribes from
/// the channel(s)).</param>
/// <returns>The <see cref="FMWebSyncSubscribeArgs" />.</returns>
- (FMWebSyncSubscribeArgs*) setOnClientUnsubscribeBlock:(void (^) (FMWebSyncSubscribersClientUnsubscribeArgs*))onClientUnsubscribeBlock;

@end


@class FMWebSyncSubscribedClient;
@class NSStringFMExtensions;

/// <summary>
/// A description of a subscriber change on a channel, either a new
/// subscriber entering or an existing subscriber leaving.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribersSubscriberChange : FMSerializable 

/// <summary>
/// Gets the client who subscribed to or unsubscribed from the channel.
/// </summary>
- (FMWebSyncSubscribedClient*) client;
/// <summary>
/// Deserializes a subscriber change object from JSON.
/// </summary>
/// <param name="subscriberChangeJson">A JSON string to deserialize.</param>
/// <returns>The deserialized subscriber change object.</returns>
+ (FMWebSyncSubscribersSubscriberChange*) fromJsonWithSubscriberChangeJson:(NSString*)subscriberChangeJson;
- (id) init;
/// <summary>
/// Sets the client who subscribed to or unsubscribed from the channel.
/// </summary>
- (void) setClient:(FMWebSyncSubscribedClient*)value;
/// <summary>
/// Sets the type of the subscriber change, either subscribe or unsubscribe.
/// </summary>
- (void) setType:(FMWebSyncSubscribersSubscriberChangeType)value;
+ (FMWebSyncSubscribersSubscriberChange*) subscriberChange;
/// <summary>
/// Serializes the subscriber change object to JSON.
/// </summary>
/// <returns>The serialized subscriber change object.</returns>
- (NSString*) toJson;
/// <summary>
/// Serializes a subscriber change object to JSON.
/// </summary>
/// <param name="subscriberChange">A subscriber change object to serialize.</param>
/// <returns>The serialized subscriber change object.</returns>
+ (NSString*) toJsonWithSubscriberChange:(FMWebSyncSubscribersSubscriberChange*)subscriberChange;
/// <summary>
/// Gets the type of the subscriber change, either subscribe or unsubscribe.
/// </summary>
- (FMWebSyncSubscribersSubscriberChangeType) type;

@end


@class NSStringFMExtensions;
@class FMWebSyncSubscribedClient;

/// <summary>
/// Arguments for the subscriber change callback.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribersClientSubscribeArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets the channel on which the change occurred.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribersClientSubscribeArgs" /> class.
/// </summary>
/// <param name="channel">The channel.</param>
/// <param name="subscribedClient">The subscribed client.</param>
+ (FMWebSyncSubscribersClientSubscribeArgs*) clientSubscribeArgsWithChannel:(NSString*)channel subscribedClient:(FMWebSyncSubscribedClient*)subscribedClient;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribersClientSubscribeArgs" /> class.
/// </summary>
/// <param name="channel">The channel.</param>
/// <param name="subscribedClient">The subscribed client.</param>
- (id) initWithChannel:(NSString*)channel subscribedClient:(FMWebSyncSubscribedClient*)subscribedClient;
/// <summary>
/// Gets the client who subscribed to the channel.
/// </summary>
- (FMWebSyncSubscribedClient*) subscribedClient;

@end


@class NSMutableDictionaryFMExtensions;
@class FMWebSyncSubscribeSuccessArgs;

/// <summary>
/// <see cref="FMWebSyncSubscribeSuccessArgs" /> extension methods for the Subscribers extension.
/// </summary>
/// <remarks>
/// <para>
/// The subscribers extension provides support for initial state load and differential
/// updates on the clients actively subscribed to the channel(s).
/// </para>
/// <para>
/// The extension is activated by adding a reference to your project.
/// </para>
/// </remarks>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribeSuccessArgs (FMWebSyncSubscribersExtensions)

/// <summary>
/// Gets the active subscribed clients on the just-subscribed channel(s).
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeSuccessArgs" /> to extend.</param>
/// <returns>The subscribed clients, partitioned by channel.</returns>
- (NSMutableDictionary*) getSubscribedClients;
/// <summary>
/// Gets the active subscribed clients on the just-subscribed channel(s).
/// </summary>
/// <param name="args">The <see cref="FMWebSyncSubscribeSuccessArgs" /> to extend.</param>
/// <returns>The subscribed clients, partitioned by channel.</returns>
+ (NSMutableDictionary*) getSubscribedClientsWithArgs:(FMWebSyncSubscribeSuccessArgs*)args;

@end

