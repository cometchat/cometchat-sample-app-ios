//
// Title: WebSync Client for Cocoa
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

@class FMWebSyncNullableConnectionType;
@class FMWebSyncNullableReconnect;
@class FMWebSyncBackoffArgs;
@class FMWebSyncExtensible;
@class FMWebSyncBaseInputArgs;
@class FMWebSyncBaseOutputArgs;
@class FMWebSyncBasePublisherEventArgs;
@class FMWebSyncBasePublisherResponseEventArgs;
@class FMWebSyncBasePublisherResponseEventArgsGeneric;
@class FMWebSyncBasePublisherRequestEventArgs;
@class FMWebSyncBasePublisherRequestEventArgsGeneric;
@class FMWebSyncBaseClientEventArgs;
@class FMWebSyncBaseClientEndEventArgs;
@class FMWebSyncBaseClientEndEventArgsGeneric;
@class FMWebSyncBaseClientResponseEventArgs;
@class FMWebSyncBaseClientResponseEventArgsGeneric;
@class FMWebSyncClientNotifyResponseArgs;
@class FMWebSyncBaseServerArgs;
@class FMWebSyncBaseSuccessArgs;
@class FMWebSyncBaseReceiveArgs;
@class FMWebSyncBaseClientRequestEventArgs;
@class FMWebSyncBaseClientRequestEventArgsGeneric;
@class FMWebSyncClientNotifyRequestArgs;
@class FMWebSyncClientSubscribeEndArgs;
@class FMWebSyncClientBindEndArgs;
@class FMWebSyncClientConnectEndArgs;
@class FMWebSyncClientDisconnectEndArgs;
@class FMWebSyncClientNotifyEndArgs;
@class FMWebSyncClientPublishEndArgs;
@class FMWebSyncClientServiceEndArgs;
@class FMWebSyncClientUnbindEndArgs;
@class FMWebSyncClientUnsubscribeEndArgs;
@class FMWebSyncPublisherServiceRequestArgs;
@class FMWebSyncPublisherServiceResponseArgs;
@class FMWebSyncStateRestoredArgs;
@class FMWebSyncNotifyReceiveArgs;
@class FMWebSyncServerSubscribeArgs;
@class FMWebSyncServerUnsubscribeArgs;
@class FMWebSyncServerUnbindArgs;
@class FMWebSyncServerBindArgs;
@class FMWebSyncMessageRequestCreatedArgs;
@class FMWebSyncMessageResponseReceivedArgs;
@class FMWebSyncMessageRequestArgs;
@class FMWebSyncMessageResponseArgs;
@class FMWebSyncNotifyArgs;
@class FMWebSyncBaseCompleteArgs;
@class FMWebSyncNotifyCompleteArgs;
@class FMWebSyncBaseFailureArgs;
@class FMWebSyncNotifyFailureArgs;
@class FMWebSyncNotifySuccessArgs;
@class FMWebSyncPublisherNotifyResponseArgs;
@class FMWebSyncPublisherNotifyRequestArgs;
@class FMWebSyncUnhandledExceptionArgs;
@class FMWebSyncClientResponseArgs;
@class FMWebSyncConnectArgs;
@class FMWebSyncBindArgs;
@class FMWebSyncServiceArgs;
@class FMWebSyncUnbindArgs;
@class FMWebSyncDisconnectArgs;
@class FMWebSyncPublishArgs;
@class FMWebSyncSubscribeArgs;
@class FMWebSyncUnsubscribeArgs;
@class FMWebSyncConnectCompleteArgs;
@class FMWebSyncBindCompleteArgs;
@class FMWebSyncServiceCompleteArgs;
@class FMWebSyncUnbindCompleteArgs;
@class FMWebSyncDisconnectCompleteArgs;
@class FMWebSyncPublishCompleteArgs;
@class FMWebSyncSubscribeCompleteArgs;
@class FMWebSyncUnsubscribeCompleteArgs;
@class FMWebSyncClientConnectResponseArgs;
@class FMWebSyncClientDisconnectResponseArgs;
@class FMWebSyncClientPublishResponseArgs;
@class FMWebSyncClientSubscribeResponseArgs;
@class FMWebSyncClientUnsubscribeResponseArgs;
@class FMWebSyncClientBindResponseArgs;
@class FMWebSyncClientUnbindResponseArgs;
@class FMWebSyncClientServiceResponseArgs;
@class FMWebSyncClientConnectRequestArgs;
@class FMWebSyncClientDisconnectRequestArgs;
@class FMWebSyncClientPublishRequestArgs;
@class FMWebSyncClientSubscribeRequestArgs;
@class FMWebSyncClientUnsubscribeRequestArgs;
@class FMWebSyncClientBindRequestArgs;
@class FMWebSyncClientUnbindRequestArgs;
@class FMWebSyncClientServiceRequestArgs;
@class FMWebSyncConnectFailureArgs;
@class FMWebSyncBindFailureArgs;
@class FMWebSyncServiceFailureArgs;
@class FMWebSyncUnbindFailureArgs;
@class FMWebSyncStreamFailureArgs;
@class FMWebSyncPublishFailureArgs;
@class FMWebSyncSubscribeFailureArgs;
@class FMWebSyncUnsubscribeFailureArgs;
@class FMWebSyncConnectSuccessArgs;
@class FMWebSyncBindSuccessArgs;
@class FMWebSyncServiceSuccessArgs;
@class FMWebSyncUnbindSuccessArgs;
@class FMWebSyncPublishSuccessArgs;
@class FMWebSyncSubscribeReceiveArgs;
@class FMWebSyncSubscribeSuccessArgs;
@class FMWebSyncUnsubscribeSuccessArgs;
@class FMWebSyncPublisherPublishResponseArgs;
@class FMWebSyncPublisherPublishRequestArgs;
@class FMWebSyncDeferredRetryConnectState;
@class FMWebSyncDeferredStreamState;
@class FMWebSyncPublisherQueue;
@class FMWebSyncMessageTransferFactory;
@class FMWebSyncMessageTransfer;
@class FMWebSyncHttpMessageTransfer;
@class FMWebSyncNotifyingClient;
@class FMWebSyncBaseMessage;
@class FMWebSyncNotification;
@class FMWebSyncPublisherResponseArgs;
@class FMWebSyncBaseClient;
@class FMWebSyncBaseAdvice;
@class FMWebSyncAdvice;
@class FMWebSyncMetaChannels;
@class FMWebSyncClient;
@class FMWebSyncClientSendState;
@class FMWebSyncClientRequest;
@class FMWebSyncDefaults;
@class FMWebSyncPublishingClient;
@class FMWebSyncExtensions;
@class FMWebSyncMessage;
@class FMWebSyncPublication;
@class FMWebSyncPublisher;
@class FMWebSyncRecord;
@class FMWebSyncSerializer;
@class FMWebSyncWebSocketMessageTransfer;
@class FMWebSyncSubscription;
@class FMWebSyncSubscribedClient;


/// <summary>
/// Various behaviour modes for handling connect retries.
/// </summary>
typedef enum {
	/// <summary>
	/// Indicates that the client should automatically
	/// retry after a connect failure, even if the failure
	/// originates from a custom server-side event.
	/// </summary>
	FMWebSyncConnectRetryModeAggressive = 1,
	/// <summary>
	/// Indicates that the client should automatically
	/// retry after a connect failure, unless the failure
	/// originates from a custom server-side event.
	/// </summary>
	FMWebSyncConnectRetryModeIntelligent = 2,
	/// <summary>
	/// Indicates that the client should not automatically
	/// retry after a connect failure.
	/// </summary>
	FMWebSyncConnectRetryModeNone = 3,
	/// <summary>
	/// Same as <see cref="FMWebSyncConnectRetryModeIntelligent" />.
	/// </summary>
	FMWebSyncConnectRetryModeDefault = 2
} FMWebSyncConnectRetryMode;



/// <summary>
/// Various behaviour modes for the streaming connection.
/// </summary>
typedef enum {
	/// <summary>
	/// Indicates that the client will not be competing with
	/// many other clients within the same process.
	/// </summary>
	FMWebSyncConcurrencyModeLow = 1,
	/// <summary>
	/// Indicates that the client will have to compete with
	/// hundreds or thousands of other clients within the same
	/// process for processor time.
	/// </summary>
	FMWebSyncConcurrencyModeHigh = 2,
	/// <summary>
	/// Same as <see cref="FMWebSyncConcurrencyModeLow" />.
	/// </summary>
	FMWebSyncConcurrencyModeDefault = 1
} FMWebSyncConcurrencyMode;



/// <summary>
/// Allowed reconnect advice values for <see cref="FMWebSyncMessage"> Messages</see>.
/// </summary>
typedef enum {
	/// <summary>
	/// Indicates that the client should retry its last request.
	/// </summary>
	FMWebSyncReconnectRetry = 1,
	/// <summary>
	/// Indicates that the client should attempt to handshake.
	/// </summary>
	FMWebSyncReconnectHandshake = 2,
	/// <summary>
	/// Indicates that the client should not attempt to reconnect.
	/// </summary>
	FMWebSyncReconnectNone = 3
} FMWebSyncReconnect;



/// <summary>
/// Allowed connection type values for <see cref="FMWebSyncMessage">Messages</see>.
/// </summary>
typedef enum {
	/// <summary>
	/// Indicates that the WebSocket connection type is supported.
	/// </summary>
	FMWebSyncConnectionTypeWebSocket = 1,
	/// <summary>
	/// Indicates that the long-polling connection type is supported.
	/// </summary>
	FMWebSyncConnectionTypeLongPolling = 2,
	/// <summary>
	/// Indicates that the callback-polling connection type is supported.
	/// </summary>
	FMWebSyncConnectionTypeCallbackPolling = 3,
	/// <summary>
	/// (Unsupported) Indicates that the iframe connection type is supported.
	/// </summary>
	FMWebSyncConnectionTypeIFrame = 4,
	/// <summary>
	/// (Unsupported) Indicates that the flash connection type is supported.
	/// </summary>
	FMWebSyncConnectionTypeFlash = 5,
	/// <summary>
	/// Indicates that the connection type was not recognized.
	/// </summary>
	FMWebSyncConnectionTypeUnknown = 99
} FMWebSyncConnectionType;



/// <summary>
/// Possible message types for <see cref="FMWebSyncMessage">Messages</see>.
/// </summary>
typedef enum {
	/// <summary>
	/// Message is a connect request/response.
	/// </summary>
	FMWebSyncMessageTypeConnect = 1,
	/// <summary>
	/// Message is a disconnect request/response.
	/// </summary>
	FMWebSyncMessageTypeDisconnect = 2,
	/// <summary>
	/// Messages is a bind request/response.
	/// </summary>
	FMWebSyncMessageTypeBind = 3,
	/// <summary>
	/// Messages is an unbind request/response.
	/// </summary>
	FMWebSyncMessageTypeUnbind = 4,
	/// <summary>
	/// Message is a subscribe request/response.
	/// </summary>
	FMWebSyncMessageTypeSubscribe = 5,
	/// <summary>
	/// Message is an unsubscribe request/response.
	/// </summary>
	FMWebSyncMessageTypeUnsubscribe = 6,
	/// <summary>
	/// Message is a publish request/response.
	/// </summary>
	FMWebSyncMessageTypePublish = 7,
	/// <summary>
	/// Message is a notify request/response.
	/// </summary>
	FMWebSyncMessageTypeNotify = 8,
	/// <summary>
	/// Message is a service request/response.
	/// </summary>
	FMWebSyncMessageTypeService = 9,
	/// <summary>
	/// Message is a stream request/response.
	/// </summary>
	FMWebSyncMessageTypeStream = 10,
	/// <summary>
	/// Message is an unknown request/response.
	/// </summary>
	FMWebSyncMessageTypeUnknown = 11
} FMWebSyncMessageType;



/// <summary>
/// Arguments used for <see cref="FMWebSyncConnectArgs#retryBackoff" />
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBackoffArgs : NSObject 

+ (FMWebSyncBackoffArgs*) backoffArgs;
/// <summary>
/// Gets the current backoff index. Starts at <c>0</c> and
/// increments by <c>1</c> for each backoff attempt.
/// </summary>
- (int) index;
- (id) init;
/// <summary>
/// Gets last timeout value used.
/// </summary>
- (int) lastTimeout;
- (void) setIndex:(int)value;
- (void) setLastTimeout:(int)value;

@end


@class FMWebSyncExtensions;
@class FMWebSyncRecord;
@class NSStringFMExtensions;
@class NSMutableArrayFMExtensions;

/// <summary>
/// <para>
/// Base class that defines the properties and methods shared by any class that
/// is considered extensible by the Bayeux specification.
/// </para>
/// <para>
/// The Bayeux specification defines the Ext field, which allows custom data to be
/// stored with a message using a namespaced key to access the information. This class
/// provides methods that store and retrieve JSON data stored in this manner. For example,
/// the <see cref="FMWebSyncExtensible#metaJson" /> property uses the Ext field to store its value
/// using "fm.meta" as a key.
/// </para>
/// <para>
/// In addition, classes which inherit from <see cref="FMWebSyncExtensible" /> can store
/// dynamic property values for local read/write access without the need to serialize
/// to JSON. This can aid greatly in the
/// development of third-party extensions to WebSync. Custom information can be stored
/// with method arguments in the "before" event and read out again for further
/// processing in the "after" event.
/// </para>
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncExtensible : FMDynamic 

+ (FMWebSyncRecord*) convertKeyToRecordWithKey:(NSString*)key;
+ (NSString*) convertRecordToKeyWithRecord:(FMWebSyncRecord*)record;
/// <summary>
/// Copies extension values from one instance into this instance.
/// </summary>
/// <param name="extensible">The object with the extensions to copy.</param>
/// <returns>This instance.</returns>
- (void) copyExtensionsWithExtensible:(FMWebSyncExtensible*)extensible;
+ (FMWebSyncExtensible*) extensible;
/// <summary>
/// Gets the number of extensions stored with this instance.
/// </summary>
- (int) extensionCount;
/// <summary>
/// Gets the names of the extensions stored with this instance.
/// </summary>
- (NSMutableArray*) extensionNames;
/// <summary>
/// Gets the internal extensions collection.
/// </summary>
- (FMWebSyncExtensions*) extensions;
/// <summary>
/// Gets a serialized value stored in the extensions.
/// </summary>
/// <param name="name">Fully-qualified extension name.</param>
/// <returns>The extension value in JSON format.</returns>
- (NSString*) getExtensionValueJsonWithName:(NSString*)name;
- (id) init;
/// <summary>
/// Gets meta-data associated with the message/publication.  Must be valid JSON.
/// </summary>
/// <remarks>
/// Use this property to define meta-data about the request itself, such as
/// authentication details, etc.
/// </remarks>
- (NSString*) metaJson;
/// <summary>
/// Sets the internal extensions collection.
/// </summary>
- (void) setExtensions:(FMWebSyncExtensions*)value;
/// <summary>
/// Stores a serialized value in the extensions.  Must be valid JSON.
/// </summary>
/// <param name="name">Fully-qualified extension name.</param>
/// <param name="valueJson">The extension value in valid JSON format.</param>
- (void) setExtensionValueJsonWithName:(NSString*)name valueJson:(NSString*)valueJson;
/// <summary>
/// Stores a serialized value in the extensions.  Must be valid JSON.
/// </summary>
/// <param name="name">Fully-qualified extension name.</param>
/// <param name="valueJson">The extension value in valid JSON format.</param>
/// <param name="validate">Whether or not to validate the JSON value.</param>
- (void) setExtensionValueJsonWithName:(NSString*)name valueJson:(NSString*)valueJson validate:(bool)validate;
/// <summary>
/// Sets meta-data associated with the message/publication.  Must be valid JSON.
/// </summary>
/// <remarks>
/// Use this property to define meta-data about the request itself, such as
/// authentication details, etc.
/// </remarks>
- (void) setMetaJson:(NSString*)value;
/// <summary>
/// Converts an array of channels to itself.
/// </summary>
/// <param name="channels">The array of channels.</param>
/// <returns>The array of channels.</returns>
+ (NSMutableArray*) sharedGetChannelsWithChannels:(NSMutableArray*)channels;
/// <summary>
/// Converts an array of channels to itself.
/// </summary>
/// <param name="channels">The array of channels.</param>
/// <returns>The array of channels.</returns>
+ (NSMutableArray*) sharedGetChannels:(NSMutableArray*)channels;
/// <summary>
/// Gets the first channel from an array of channels.
/// </summary>
/// <param name="channels">The channels to scan.</param>
/// <returns>The first channel.</returns>
+ (NSString*) sharedGetChannelWithChannels:(NSMutableArray*)channels;
/// <summary>
/// Converts an array of records to an array of keys.
/// </summary>
/// <param name="records">The array of records.</param>
/// <returns>The array of keys.</returns>
+ (NSMutableArray*) sharedGetKeysWithRecords:(NSMutableArray*)records;
/// <summary>
/// Gets the first key from an array of records.
/// </summary>
/// <param name="records">The records to scan.</param>
/// <returns>The first key.</returns>
+ (NSString*) sharedGetKeyWithRecords:(NSMutableArray*)records;
/// <summary>
/// Converts an array of records to itself.
/// </summary>
/// <param name="records">The array of records.</param>
/// <returns>The array of records.</returns>
+ (NSMutableArray*) sharedGetRecordsWithRecords:(NSMutableArray*)records;
/// <summary>
/// Converts an array of records to itself.
/// </summary>
/// <param name="records">The array of records.</param>
/// <returns>The array of records.</returns>
+ (NSMutableArray*) sharedGetRecords:(NSMutableArray*)records;
/// <summary>
/// Gets the first record from an array of records.
/// </summary>
/// <param name="records">The records to scan.</param>
/// <returns>The first record.</returns>
+ (FMWebSyncRecord*) sharedGetRecordWithRecords:(NSMutableArray*)records;
/// <summary>
/// Converts an array of channels to an array of validated channels.
/// </summary>
/// <param name="channels">The array of channels.</param>
/// <returns>The array of validated channels.</returns>
+ (NSMutableArray*) sharedSetChannelsWithChannels:(NSMutableArray*)channels;
/// <summary>
/// Converts an array of channels to an array of validated channels.
/// </summary>
/// <param name="channels">The array of channels.</param>
/// <returns>The array of validated channels.</returns>
+ (NSMutableArray*) sharedSetChannels:(NSMutableArray*)channels;
/// <summary>
/// Converts an array of channels to an array of validated channels.
/// </summary>
/// <param name="channels">The array of channels.</param>
/// <param name="validate">Whether or not to validate the channels.</param>
/// <returns>The array of validated channels.</returns>
+ (NSMutableArray*) sharedSetChannelsWithChannels:(NSMutableArray*)channels validate:(bool)validate;
/// <summary>
/// Converts an array of channels to an array of validated channels.
/// </summary>
/// <param name="channels">The array of channels.</param>
/// <param name="validate">Whether or not to validate the channels.</param>
/// <returns>The array of validated channels.</returns>
+ (NSMutableArray*) sharedSetChannels:(NSMutableArray*)channels validate:(bool)validate;
/// <summary>
/// Converts a channel to a validated channel array.
/// </summary>
/// <param name="channel">The channel to convert.</param>
/// <returns>The validated channel array.</returns>
+ (NSMutableArray*) sharedSetChannelWithChannel:(NSString*)channel;
/// <summary>
/// Converts a channel to a validated channel array.
/// </summary>
/// <param name="channel">The channel to convert.</param>
/// <returns>The validated channel array.</returns>
+ (NSMutableArray*) sharedSetChannel:(NSString*)channel;
/// <summary>
/// Converts a channel to a validated channel array.
/// </summary>
/// <param name="channel">The channel to convert.</param>
/// <param name="validate">Whether or not to validate the channel.</param>
/// <returns>The validated channel array.</returns>
+ (NSMutableArray*) sharedSetChannelWithChannel:(NSString*)channel validate:(bool)validate;
/// <summary>
/// Converts a channel to a validated channel array.
/// </summary>
/// <param name="channel">The channel to convert.</param>
/// <param name="validate">Whether or not to validate the channel.</param>
/// <returns>The validated channel array.</returns>
+ (NSMutableArray*) sharedSetChannel:(NSString*)channel validate:(bool)validate;
/// <summary>
/// Converts an array of keys to an array of validated records.
/// </summary>
/// <param name="keys">The array of keys.</param>
/// <returns>The array of records.</returns>
+ (NSMutableArray*) sharedSetKeysWithKeys:(NSMutableArray*)keys;
/// <summary>
/// Converts an array of keys to an array of validated records.
/// </summary>
/// <param name="keys">The array of keys.</param>
/// <returns>The array of records.</returns>
+ (NSMutableArray*) sharedSetKeys:(NSMutableArray*)keys;
/// <summary>
/// Converts an array of keys to an array of validated records.
/// </summary>
/// <param name="keys">The array of keys.</param>
/// <param name="validate">Whether or not to validate the records.</param>
/// <returns>The array of records.</returns>
+ (NSMutableArray*) sharedSetKeysWithKeys:(NSMutableArray*)keys validate:(bool)validate;
/// <summary>
/// Converts an array of keys to an array of validated records.
/// </summary>
/// <param name="keys">The array of keys.</param>
/// <param name="validate">Whether or not to validate the records.</param>
/// <returns>The array of records.</returns>
+ (NSMutableArray*) sharedSetKeys:(NSMutableArray*)keys validate:(bool)validate;
/// <summary>
/// Converts a key to a validated record array.
/// </summary>
/// <param name="key">The key to convert.</param>
/// <returns>The validated record array.</returns>
+ (NSMutableArray*) sharedSetKeyWithKey:(NSString*)key;
/// <summary>
/// Converts a key to a validated record array.
/// </summary>
/// <param name="key">The key to convert.</param>
/// <returns>The validated record array.</returns>
+ (NSMutableArray*) sharedSetKey:(NSString*)key;
/// <summary>
/// Converts a key to a validated record array.
/// </summary>
/// <param name="key">The key to convert.</param>
/// <param name="validate">Whether or not to validate the record.</param>
/// <returns>The validated record array.</returns>
+ (NSMutableArray*) sharedSetKeyWithKey:(NSString*)key validate:(bool)validate;
/// <summary>
/// Converts a key to a validated record array.
/// </summary>
/// <param name="key">The key to convert.</param>
/// <param name="validate">Whether or not to validate the record.</param>
/// <returns>The validated record array.</returns>
+ (NSMutableArray*) sharedSetKey:(NSString*)key validate:(bool)validate;
/// <summary>
/// Converts an array of records to an array of validated records.
/// </summary>
/// <param name="records">The array of records.</param>
/// <returns>The array of validated records.</returns>
+ (NSMutableArray*) sharedSetRecordsWithRecords:(NSMutableArray*)records;
/// <summary>
/// Converts an array of records to an array of validated records.
/// </summary>
/// <param name="records">The array of records.</param>
/// <returns>The array of validated records.</returns>
+ (NSMutableArray*) sharedSetRecords:(NSMutableArray*)records;
/// <summary>
/// Converts an array of records to an array of validated records.
/// </summary>
/// <param name="records">The array of records.</param>
/// <param name="validate">Whether or not to validate the records.</param>
/// <returns>The array of validated records.</returns>
+ (NSMutableArray*) sharedSetRecordsWithRecords:(NSMutableArray*)records validate:(bool)validate;
/// <summary>
/// Converts an array of records to an array of validated records.
/// </summary>
/// <param name="records">The array of records.</param>
/// <param name="validate">Whether or not to validate the records.</param>
/// <returns>The array of validated records.</returns>
+ (NSMutableArray*) sharedSetRecords:(NSMutableArray*)records validate:(bool)validate;
/// <summary>
/// Converts a record to a validated record array.
/// </summary>
/// <param name="record">The record to convert.</param>
/// <returns>The validated record array.</returns>
+ (NSMutableArray*) sharedSetRecordWithRecord:(FMWebSyncRecord*)record;
/// <summary>
/// Converts a record to a validated record array.
/// </summary>
/// <param name="record">The record to convert.</param>
/// <returns>The validated record array.</returns>
+ (NSMutableArray*) sharedSetRecord:(FMWebSyncRecord*)record;
/// <summary>
/// Converts a record to a validated record array.
/// </summary>
/// <param name="record">The record to convert.</param>
/// <param name="validate">Whether or not to validate the record.</param>
/// <returns>The validated record array.</returns>
+ (NSMutableArray*) sharedSetRecordWithRecord:(FMWebSyncRecord*)record validate:(bool)validate;
/// <summary>
/// Converts a record to a validated record array.
/// </summary>
/// <param name="record">The record to convert.</param>
/// <param name="validate">Whether or not to validate the record.</param>
/// <returns>The validated record array.</returns>
+ (NSMutableArray*) sharedSetRecord:(FMWebSyncRecord*)record validate:(bool)validate;
/// <summary>
/// Validates a channel.
/// </summary>
/// <param name="channel">The channel to validate.</param>
/// <param name="error">The error, if validation failed.</param>
/// <returns><c>true</c> if validation succeeded; otherwise <c>false</c>.</returns>
+ (bool) validateChannelWithChannel:(NSString*)channel error:(NSString**)error;
/// <summary>
/// Validates a channel.
/// </summary>
/// <param name="channel">The channel to validate.</param>
/// <param name="error">The error, if validation failed.</param>
/// <returns><c>true</c> if validation succeeded; otherwise <c>false</c>.</returns>
+ (bool) validateChannel:(NSString*)channel error:(NSString**)error;
/// <summary>
/// Validates a record.
/// </summary>
/// <param name="record">The record to validate.</param>
/// <param name="error">The error, if validation failed.</param>
/// <returns><c>true</c> if validation succeeded; otherwise <c>false</c>.</returns>
+ (bool) validateRecordWithRecord:(FMWebSyncRecord*)record error:(NSString**)error;
/// <summary>
/// Validates a record.
/// </summary>
/// <param name="record">The record to validate.</param>
/// <param name="error">The error, if validation failed.</param>
/// <returns><c>true</c> if validation succeeded; otherwise <c>false</c>.</returns>
+ (bool) validateRecord:(FMWebSyncRecord*)record error:(NSString**)error;

@end


@class FMNullableInt;
@class NSStringFMExtensions;
@class FMNullableBool;

/// <summary>
/// Base input arguments for WebSync <see cref="FMWebSyncClient" /> methods.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseInputArgs : FMWebSyncExtensible 

+ (FMWebSyncBaseInputArgs*) baseInputArgs;
- (id) init;
/// <summary>
/// Gets whether this method call is a retry following a failure.
/// </summary>
- (bool) isRetry;
/// <summary>
/// Gets the number of milliseconds for the request timeout to use
/// for this request. This will override any client-level request timeout
/// settings.
/// </summary>
- (FMNullableInt*) requestTimeout;
/// <summary>
/// Gets the absolute URL of the WebSync request handler, typically
/// ending with websync.ashx, to use for this request. Overrides the
/// client-level setting. This request will be sent using the
/// <see cref="FMWebSyncClientStreamRequestTransfer" /> class (especially relevant if
/// WebSockets are in use).
/// </summary>
- (NSString*) requestUrl;
/// <summary>
/// Sets whether this method call is a retry following a failure.
/// </summary>
- (void) setIsRetry:(bool)value;
/// <summary>
/// Sets the number of milliseconds for the request timeout to use
/// for this request. This will override any client-level request timeout
/// settings.
/// </summary>
- (void) setRequestTimeout:(FMNullableInt*)value;
/// <summary>
/// Sets the absolute URL of the WebSync request handler, typically
/// ending with websync.ashx, to use for this request. Overrides the
/// client-level setting. This request will be sent using the
/// <see cref="FMWebSyncClientStreamRequestTransfer" /> class (especially relevant if
/// WebSockets are in use).
/// </summary>
- (void) setRequestUrl:(NSString*)value;
/// <summary>
/// Sets whether the request should be executed asynchronously.
/// If <c>true</c>, the request will be executed synchronously.
/// If <c>false</c>, the request will be executed asynchronously.
/// If <c>null</c>, the request will be executed synchronously or asynchronously,
/// depending on the value of <see cref="FMWebSyncClient#synchronous" />.
/// Defaults to <c>null</c>.
/// </summary>
- (void) setSynchronous:(FMNullableBool*)value;
/// <summary>
/// Gets whether the request should be executed asynchronously.
/// If <c>true</c>, the request will be executed synchronously.
/// If <c>false</c>, the request will be executed asynchronously.
/// If <c>null</c>, the request will be executed synchronously or asynchronously,
/// depending on the value of <see cref="FMWebSyncClient#synchronous" />.
/// Defaults to <c>null</c>.
/// </summary>
- (FMNullableBool*) synchronous;

@end


@class FMNullableDate;
@class FMWebSyncClient;

/// <summary>
/// Base output arguments for WebSync <see cref="FMWebSyncBaseOutputArgs#client" /> methods.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseOutputArgs : FMWebSyncExtensible 

+ (FMWebSyncBaseOutputArgs*) baseOutputArgs;
/// <summary>
/// Gets the active WebSync <see cref="FMWebSyncBaseOutputArgs#client" /> who made the request.
/// </summary>
- (FMWebSyncClient*) client;
- (id) init;
/// <summary>
/// Sets the active WebSync <see cref="FMWebSyncBaseOutputArgs#client" /> who made the request.
/// </summary>
- (void) setClient:(FMWebSyncClient*)value;
/// <summary>
/// Sets the date/time the message was processed on the server (in UTC/GMT).
/// </summary>
- (void) setTimestamp:(FMNullableDate*)value;
/// <summary>
/// Gets the date/time the message was processed on the server (in UTC/GMT).
/// </summary>
- (FMNullableDate*) timestamp;

@end


@class FMWebSyncPublisher;

/// <summary>
/// Base arguments for <see cref="FMWebSyncBasePublisherEventArgs#publisher" />-triggered events.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBasePublisherEventArgs : NSObject 

+ (FMWebSyncBasePublisherEventArgs*) basePublisherEventArgs;
- (id) init;
/// <summary>
/// Gets the <see cref="FMWebSyncBasePublisherEventArgs#publisher" /> triggering the event.
/// </summary>
- (FMWebSyncPublisher*) publisher;
/// <summary>
/// Sets the <see cref="FMWebSyncBasePublisherEventArgs#publisher" /> triggering the event.
/// </summary>
- (void) setPublisher:(FMWebSyncPublisher*)value;

@end


@class NSExceptionFMExtensions;

/// <summary>
/// Base arguments for <see cref="FMWebSyncPublisher" /> events that occur
/// after a response is received.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBasePublisherResponseEventArgs : FMWebSyncBasePublisherEventArgs 

+ (FMWebSyncBasePublisherResponseEventArgs*) basePublisherResponseEventArgs;
/// <summary>
/// Gets the exception generated while completing the request, if any.
/// Will be <c>null</c> if no exception was generated.
/// </summary>
- (NSException*) exception;
- (id) init;
/// <summary>
/// Sets the exception generated while completing the request, if any.
/// Will be <c>null</c> if no exception was generated.
/// </summary>
- (void) setException:(NSException*)value;

@end


@class NSMutableArrayFMExtensions;

/// <summary>
/// Generic base arguments for <see cref="FMWebSyncPublisher" /> events that occur
/// after a response is received.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBasePublisherResponseEventArgsGeneric : FMWebSyncBasePublisherResponseEventArgs 

+ (FMWebSyncBasePublisherResponseEventArgsGeneric*) basePublisherResponseEventArgsGeneric;
- (id) init;
/// <summary>
/// Gets the requests sent to the server.
/// </summary>
- (NSMutableArray*) requests;
/// <summary>
/// Gets the responses received from the server.
/// </summary>
- (NSMutableArray*) responses;
/// <summary>
/// Sets the requests sent to the server.
/// </summary>
- (void) setRequests:(NSMutableArray*)value;
/// <summary>
/// Sets the responses received from the server.
/// </summary>
- (void) setResponses:(NSMutableArray*)value;

@end



/// <summary>
/// Base arguments for <see cref="FMWebSyncPublisher" /> events that occur
/// before a request is sent.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBasePublisherRequestEventArgs : FMWebSyncBasePublisherEventArgs 

+ (FMWebSyncBasePublisherRequestEventArgs*) basePublisherRequestEventArgs;
/// <summary>
/// Gets whether or not to cancel the request.
/// If set to <c>true</c>, the request will not be processed.
/// Defaults to <c>false</c>.
/// </summary>
- (bool) cancel;
- (id) init;
/// <summary>
/// Sets whether or not to cancel the request.
/// If set to <c>true</c>, the request will not be processed.
/// Defaults to <c>false</c>.
/// </summary>
- (void) setCancel:(bool)value;

@end


@class NSMutableArrayFMExtensions;

/// <summary>
/// Generic base arguments for <see cref="FMWebSyncPublisher" /> events that occur
/// before a request is sent.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBasePublisherRequestEventArgsGeneric : FMWebSyncBasePublisherRequestEventArgs 

+ (FMWebSyncBasePublisherRequestEventArgsGeneric*) basePublisherRequestEventArgsGeneric;
- (id) init;
/// <summary>
/// Gets the requests being sent to the server.
/// </summary>
- (NSMutableArray*) requests;
/// <summary>
/// Sets the requests being sent to the server.
/// </summary>
- (void) setRequests:(NSMutableArray*)value;

@end


@class FMWebSyncClient;

/// <summary>
/// Base arguments for <see cref="FMWebSyncBaseClientEventArgs#client" />-triggered events.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseClientEventArgs : NSObject 

+ (FMWebSyncBaseClientEventArgs*) baseClientEventArgs;
/// <summary>
/// Gets the <see cref="FMWebSyncBaseClientEventArgs#client" /> triggering the event.
/// </summary>
- (FMWebSyncClient*) client;
- (id) init;
/// <summary>
/// Sets the <see cref="FMWebSyncBaseClientEventArgs#client" /> triggering the event.
/// </summary>
- (void) setClient:(FMWebSyncClient*)value;

@end


@class NSExceptionFMExtensions;
@class FMWebSyncMessage;

/// <summary>
/// Base arguments for <see cref="FMWebSyncClient" /> events that occur
/// after a response has been processed.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseClientEndEventArgs : FMWebSyncBaseClientEventArgs 

+ (FMWebSyncBaseClientEndEventArgs*) baseClientEndEventArgs;
/// <summary>
/// Gets the exception generated while completing the request, if any.
/// Will be <c>null</c> if no exception was generated.
/// </summary>
- (NSException*) exception;
- (id) init;
/// <summary>
/// Gets the response received from the server.
/// </summary>
- (FMWebSyncMessage*) response;
/// <summary>
/// Sets the exception generated while completing the request, if any.
/// Will be <c>null</c> if no exception was generated.
/// </summary>
- (void) setException:(NSException*)value;
/// <summary>
/// Sets the response received from the server.
/// </summary>
- (void) setResponse:(FMWebSyncMessage*)value;

@end



/// <summary>
/// Generic base arguments for <see cref="FMWebSyncClient" /> events that occur
/// after a response has been processed.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseClientEndEventArgsGeneric : FMWebSyncBaseClientEndEventArgs 

+ (FMWebSyncBaseClientEndEventArgsGeneric*) baseClientEndEventArgsGeneric;
- (id) init;
/// <summary>
/// Gets the original arguments passed into the client method.
/// </summary>
- (NSObject*) methodArgs;
/// <summary>
/// Sets the original arguments passed into the client method.
/// </summary>
- (void) setMethodArgs:(NSObject*)value;

@end


@class NSExceptionFMExtensions;
@class FMWebSyncMessage;

/// <summary>
/// Base arguments for <see cref="FMWebSyncClient" /> events that occur
/// after a response is received.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseClientResponseEventArgs : FMWebSyncBaseClientEventArgs 

+ (FMWebSyncBaseClientResponseEventArgs*) baseClientResponseEventArgs;
/// <summary>
/// Gets the exception generated while completing the request, if any.
/// Will be <c>null</c> if no exception was generated.
/// </summary>
- (NSException*) exception;
- (id) init;
/// <summary>
/// Gets the response received from the server.
/// </summary>
- (FMWebSyncMessage*) response;
/// <summary>
/// Sets the exception generated while completing the request, if any.
/// Will be <c>null</c> if no exception was generated.
/// </summary>
- (void) setException:(NSException*)value;
/// <summary>
/// Sets the response received from the server.
/// </summary>
- (void) setResponse:(FMWebSyncMessage*)value;

@end



/// <summary>
/// Generic base arguments for <see cref="FMWebSyncClient" /> events that occur
/// after a response is received.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseClientResponseEventArgsGeneric : FMWebSyncBaseClientResponseEventArgs 

+ (FMWebSyncBaseClientResponseEventArgsGeneric*) baseClientResponseEventArgsGeneric;
- (id) init;
/// <summary>
/// Gets the original arguments passed into the client method.
/// </summary>
- (NSObject*) methodArgs;
/// <summary>
/// Sets the original arguments passed into the client method.
/// </summary>
- (void) setMethodArgs:(NSObject*)value;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnNotifyResponse:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientNotifyResponseArgs : FMWebSyncBaseClientResponseEventArgsGeneric 

+ (FMWebSyncClientNotifyResponseArgs*) clientNotifyResponseArgs;
- (id) init;

@end



/// <summary>
/// Base arguments for <see cref="FMWebSyncConnectArgs" /> "OnServer" callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseServerArgs : FMWebSyncBaseOutputArgs 

+ (FMWebSyncBaseServerArgs*) baseServerArgs;
- (id) init;

@end



/// <summary>
/// Base arguments for <see cref="FMWebSyncClient" /> "OnSuccess" callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseSuccessArgs : FMWebSyncBaseOutputArgs 

+ (FMWebSyncBaseSuccessArgs*) baseSuccessArgs;
- (id) init;

@end


@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for <see cref="FMWebSyncSubscribeArgs#onReceive" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseReceiveArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBaseReceiveArgs" /> class.
/// </summary>
/// <param name="dataJson">The data in JSON format.</param>
/// <param name="dataBytes">The data in binary format.</param>
/// <param name="connectionType">The current connection type.</param>
/// <param name="reconnectAfter">The amount of time in milliseconds to pause before reconnecting to the server.</param>
+ (FMWebSyncBaseReceiveArgs*) baseReceiveArgsWithDataJson:(NSString*)dataJson dataBytes:(NSMutableData*)dataBytes connectionType:(FMWebSyncConnectionType)connectionType reconnectAfter:(int)reconnectAfter;
/// <summary>
/// Gets the current connection type.
/// </summary>
- (FMWebSyncConnectionType) connectionType;
/// <summary>
/// Gets the data that was sent in binary format.
/// </summary>
- (NSMutableData*) dataBytes;
/// <summary>
/// Gets the data that was sent in JSON format.
/// </summary>
- (NSString*) dataJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBaseReceiveArgs" /> class.
/// </summary>
/// <param name="dataJson">The data in JSON format.</param>
/// <param name="dataBytes">The data in binary format.</param>
/// <param name="connectionType">The current connection type.</param>
/// <param name="reconnectAfter">The amount of time in milliseconds to pause before reconnecting to the server.</param>
- (id) initWithDataJson:(NSString*)dataJson dataBytes:(NSMutableData*)dataBytes connectionType:(FMWebSyncConnectionType)connectionType reconnectAfter:(int)reconnectAfter;
/// <summary>
/// Gets whether or not the data is binary.
/// </summary>
- (bool) isBinary;
/// <summary>
/// Gets the amount of time in milliseconds to pause
/// before reconnecting to the server.
/// </summary>
- (int) reconnectAfter;
/// <summary>
/// Sets the amount of time in milliseconds to pause
/// before reconnecting to the server.
/// </summary>
- (void) setReconnectAfter:(int)value;
/// <summary>
/// Gets the tag that identifies the contents of the payload.
/// </summary>
- (NSString*) tag;

@end



/// <summary>
/// Base arguments for <see cref="FMWebSyncClient" /> events that occur
/// before a request is sent.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseClientRequestEventArgs : FMWebSyncBaseClientEventArgs 

+ (FMWebSyncBaseClientRequestEventArgs*) baseClientRequestEventArgs;
/// <summary>
/// Gets whether or not to cancel the request.
/// If set to <c>true</c>, the request will not be processed.
/// Defaults to <c>false</c>.
/// </summary>
- (bool) cancel;
- (id) init;
/// <summary>
/// Sets whether or not to cancel the request.
/// If set to <c>true</c>, the request will not be processed.
/// Defaults to <c>false</c>.
/// </summary>
- (void) setCancel:(bool)value;

@end



/// <summary>
/// Generic base arguments for <see cref="FMWebSyncClient" /> events that occur
/// before a request is sent.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseClientRequestEventArgsGeneric : FMWebSyncBaseClientRequestEventArgs 

+ (FMWebSyncBaseClientRequestEventArgsGeneric*) baseClientRequestEventArgsGeneric;
- (id) init;
/// <summary>
/// Gets the original arguments passed into the client method.
/// </summary>
- (NSObject*) methodArgs;
/// <summary>
/// Sets the original arguments passed into the client method.
/// </summary>
- (void) setMethodArgs:(NSObject*)value;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnNotifyRequest:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientNotifyRequestArgs : FMWebSyncBaseClientRequestEventArgsGeneric 

+ (FMWebSyncClientNotifyRequestArgs*) clientNotifyRequestArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnSubscribeEnd:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientSubscribeEndArgs : FMWebSyncBaseClientEndEventArgsGeneric 

+ (FMWebSyncClientSubscribeEndArgs*) clientSubscribeEndArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnBindEnd:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientBindEndArgs : FMWebSyncBaseClientEndEventArgsGeneric 

+ (FMWebSyncClientBindEndArgs*) clientBindEndArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnConnectEnd:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientConnectEndArgs : FMWebSyncBaseClientEndEventArgsGeneric 

+ (FMWebSyncClientConnectEndArgs*) clientConnectEndArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnDisconnectEnd:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientDisconnectEndArgs : FMWebSyncBaseClientEndEventArgsGeneric 

+ (FMWebSyncClientDisconnectEndArgs*) clientDisconnectEndArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnNotifyEnd:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientNotifyEndArgs : FMWebSyncBaseClientEndEventArgsGeneric 

+ (FMWebSyncClientNotifyEndArgs*) clientNotifyEndArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnPublishEnd:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientPublishEndArgs : FMWebSyncBaseClientEndEventArgsGeneric 

+ (FMWebSyncClientPublishEndArgs*) clientPublishEndArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnServiceEnd:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientServiceEndArgs : FMWebSyncBaseClientEndEventArgsGeneric 

+ (FMWebSyncClientServiceEndArgs*) clientServiceEndArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnUnbindEnd:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientUnbindEndArgs : FMWebSyncBaseClientEndEventArgsGeneric 

+ (FMWebSyncClientUnbindEndArgs*) clientUnbindEndArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnUnsubscribeEnd:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientUnsubscribeEndArgs : FMWebSyncBaseClientEndEventArgsGeneric 

+ (FMWebSyncClientUnsubscribeEndArgs*) clientUnsubscribeEndArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncPublisher#addOnServiceRequest:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublisherServiceRequestArgs : FMWebSyncBasePublisherRequestEventArgsGeneric 

- (id) init;
+ (FMWebSyncPublisherServiceRequestArgs*) publisherServiceRequestArgs;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncPublisher#addOnServiceResponse:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublisherServiceResponseArgs : FMWebSyncBasePublisherResponseEventArgsGeneric 

- (id) init;
+ (FMWebSyncPublisherServiceResponseArgs*) publisherServiceResponseArgs;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncConnectArgs#onStateRestored" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncStateRestoredArgs : FMWebSyncBaseSuccessArgs 

- (id) init;
+ (FMWebSyncStateRestoredArgs*) stateRestoredArgs;

@end


@class NSStringFMExtensions;
@class NSMutableDataFMExtensions;
@class FMWebSyncNotifyingClient;

/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnNotify:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncNotifyReceiveArgs : FMWebSyncBaseReceiveArgs 

/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyReceiveArgs" /> class.
/// </summary>
/// <param name="dataJson">The data in JSON format.</param>
/// <param name="dataBytes">The data in binary format.</param>
/// <param name="connectionType">The current connection type.</param>
/// <param name="reconnectAfter">The amount of time in milliseconds to pause before reconnecting to the server.</param>
- (id) initWithDataJson:(NSString*)dataJson dataBytes:(NSMutableData*)dataBytes connectionType:(FMWebSyncConnectionType)connectionType reconnectAfter:(int)reconnectAfter;
/// <summary>
/// Gets details about the client sending the notification.
/// </summary>
- (FMWebSyncNotifyingClient*) notifyingClient;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyReceiveArgs" /> class.
/// </summary>
/// <param name="dataJson">The data in JSON format.</param>
/// <param name="dataBytes">The data in binary format.</param>
/// <param name="connectionType">The current connection type.</param>
/// <param name="reconnectAfter">The amount of time in milliseconds to pause before reconnecting to the server.</param>
+ (FMWebSyncNotifyReceiveArgs*) notifyReceiveArgsWithDataJson:(NSString*)dataJson dataBytes:(NSMutableData*)dataBytes connectionType:(FMWebSyncConnectionType)connectionType reconnectAfter:(int)reconnectAfter;
/// <summary>
/// Gets whether the data was sent by the current client.
/// </summary>
- (bool) wasSentByMe;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnServerSubscribe:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncServerSubscribeArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets the channel to which the client was subscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncServerSubscribeArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels to which the client was subscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncServerSubscribeArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
- (id) init;
+ (FMWebSyncServerSubscribeArgs*) serverSubscribeArgs;
/// <summary>
/// Gets the tag associated with the subscribe request.
/// </summary>
- (NSString*) tag;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnServerUnsubscribe:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncServerUnsubscribeArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets the channel from which the client was unsubscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncServerUnsubscribeArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels from which the client was unsubscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncServerUnsubscribeArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
- (id) init;
+ (FMWebSyncServerUnsubscribeArgs*) serverUnsubscribeArgs;
/// <summary>
/// Gets the tag associated with the unsubscribe request.
/// </summary>
- (NSString*) tag;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;
@class FMWebSyncRecord;

/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnServerUnbind:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncServerUnbindArgs : FMWebSyncBaseSuccessArgs 

- (id) init;
/// <summary>
/// Gets the record key from which the client was unbound.
/// Overrides <see cref="FMWebSyncServerUnbindArgs#keys" />, <see cref="FMWebSyncServerUnbindArgs#record" />, and <see cref="FMWebSyncServerUnbindArgs#records" />.
/// </summary>
- (NSString*) key;
/// <summary>
/// Gets the record keys from which the client was unbound.
/// Overrides <see cref="FMWebSyncServerUnbindArgs#key" />, <see cref="FMWebSyncServerUnbindArgs#record" />, and <see cref="FMWebSyncServerUnbindArgs#records" />.
/// </summary>
- (NSMutableArray*) keys;
/// <summary>
/// Gets the record from which the client was unbound.
/// Overrides <see cref="FMWebSyncServerUnbindArgs#records" />, <see cref="FMWebSyncServerUnbindArgs#key" />, and <see cref="FMWebSyncServerUnbindArgs#keys" />.
/// </summary>
- (FMWebSyncRecord*) record;
/// <summary>
/// Gets the records from which the client was unbound.
/// Overrides <see cref="FMWebSyncServerUnbindArgs#record" />, <see cref="FMWebSyncServerUnbindArgs#key" />, and <see cref="FMWebSyncServerUnbindArgs#keys" />.
/// </summary>
- (NSMutableArray*) records;
+ (FMWebSyncServerUnbindArgs*) serverUnbindArgs;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;
@class FMWebSyncRecord;

/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnServerBind:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncServerBindArgs : FMWebSyncBaseServerArgs 

- (id) init;
/// <summary>
/// Gets the record key to which the client was bound.
/// Overrides <see cref="FMWebSyncServerBindArgs#keys" />, <see cref="FMWebSyncServerBindArgs#record" />, and <see cref="FMWebSyncServerBindArgs#records" />.
/// </summary>
- (NSString*) key;
/// <summary>
/// Gets the record keys to which the client was bound.
/// Overrides <see cref="FMWebSyncServerBindArgs#key" />, <see cref="FMWebSyncServerBindArgs#record" />, and <see cref="FMWebSyncServerBindArgs#records" />.
/// </summary>
- (NSMutableArray*) keys;
/// <summary>
/// Gets the record to which the client was bound.
/// Overrides <see cref="FMWebSyncServerBindArgs#records" />, <see cref="FMWebSyncServerBindArgs#key" />, and <see cref="FMWebSyncServerBindArgs#keys" />.
/// </summary>
- (FMWebSyncRecord*) record;
/// <summary>
/// Gets the records to which the client was bound.
/// Overrides <see cref="FMWebSyncServerBindArgs#record" />, <see cref="FMWebSyncServerBindArgs#key" />, and <see cref="FMWebSyncServerBindArgs#keys" />.
/// </summary>
- (NSMutableArray*) records;
+ (FMWebSyncServerBindArgs*) serverBindArgs;

@end


@class NSMutableArrayFMExtensions;

/// <summary>
/// Arguments passed into callbacks when a message request is created.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncMessageRequestCreatedArgs : NSObject 

- (id) init;
+ (FMWebSyncMessageRequestCreatedArgs*) messageRequestCreatedArgs;
/// <summary>
/// Gets the outgoing messages about to be sent to the server.
/// </summary>
- (NSMutableArray*) requests;
/// <summary>
/// Gets the sender of the request, either a client or publisher.
/// </summary>
- (NSObject*) sender;
- (void) setRequests:(NSMutableArray*)value;
- (void) setSender:(NSObject*)value;

@end


@class NSMutableArrayFMExtensions;

/// <summary>
/// Arguments passed into callbacks when a message response is created.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncMessageResponseReceivedArgs : NSObject 

- (id) init;
+ (FMWebSyncMessageResponseReceivedArgs*) messageResponseReceivedArgs;
/// <summary>
/// Gets the incoming messages about to be processed by the client.
/// </summary>
- (NSMutableArray*) responses;
/// <summary>
/// Gets the sender of the request, either a client or publisher.
/// </summary>
- (NSObject*) sender;
- (void) setResponses:(NSMutableArray*)value;
- (void) setSender:(NSObject*)value;

@end


@class FMWebSyncMessageRequestCreatedArgs;
@class FMWebSyncMessageResponseReceivedArgs;
@class FMHttpRequestCreatedArgs;
@class FMHttpResponseReceivedArgs;
@class FMNameValueCollection;
@class NSMutableArrayFMExtensions;
@class FMCallback;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for sending a message request.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncMessageRequestArgs : FMDynamic 

/// <summary>
/// Gets the headers for the request.
/// </summary>
- (FMNameValueCollection*) headers;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncMessageRequestArgs" /> class
/// with default values.
/// </summary>
- (id) initWithHeaders:(FMNameValueCollection*)headers;
/// <summary>
/// Gets whether or not each message in the batch is in binary format and can
/// be tranferred as such.
/// </summary>
- (bool) isBinary;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncMessageRequestArgs" /> class
/// with default values.
/// </summary>
+ (FMWebSyncMessageRequestArgs*) messageRequestArgsWithHeaders:(FMNameValueCollection*)headers;
/// <summary>
/// Gets the messages to transfer.
/// </summary>
- (NSMutableArray*) messages;
/// <summary>
/// Gets the callback to invoke whenever an underlying HTTP request
/// has been created and is about to be transferred to the server. This is a
/// good place to add headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (FMCallback*) onHttpRequestCreated;
/// <summary>
/// Gets the callback to invoke whenever an underlying HTTP response
/// has been received and is about to be processed by the client. This is a
/// good place to read headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (FMCallback*) onHttpResponseReceived;
/// <summary>
/// Gets the callback to invoke whenever a new request is created
/// and about to be transferred to the server. This is a good place to read
/// or modify outgoing messages.
/// </summary>
- (FMCallback*) onRequestCreated;
/// <summary>
/// Gets the callback to invoke whenever a new response is received
/// and about to be processed by the client. This is a good place to read
/// or modify incoming messages.
/// </summary>
- (FMCallback*) onResponseReceived;
/// <summary>
/// Gets the sender of the content, either a client or publisher.
/// </summary>
- (NSObject*) sender;
/// <summary>
/// Sets the headers for the request.
/// </summary>
- (void) setHeaders:(FMNameValueCollection*)value;
/// <summary>
/// Sets the messages to transfer.
/// </summary>
- (void) setMessages:(NSMutableArray*)value;
/// <summary>
/// Sets the callback to invoke whenever an underlying HTTP request
/// has been created and is about to be transferred to the server. This is a
/// good place to add headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (void) setOnHttpRequestCreated:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke whenever an underlying HTTP request
/// has been created and is about to be transferred to the server. This is a
/// good place to add headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (void) setOnHttpRequestCreatedBlock:(void (^) (FMHttpRequestCreatedArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke whenever an underlying HTTP response
/// has been received and is about to be processed by the client. This is a
/// good place to read headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (void) setOnHttpResponseReceived:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke whenever an underlying HTTP response
/// has been received and is about to be processed by the client. This is a
/// good place to read headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (void) setOnHttpResponseReceivedBlock:(void (^) (FMHttpResponseReceivedArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke whenever a new request is created
/// and about to be transferred to the server. This is a good place to read
/// or modify outgoing messages.
/// </summary>
- (void) setOnRequestCreated:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke whenever a new request is created
/// and about to be transferred to the server. This is a good place to read
/// or modify outgoing messages.
/// </summary>
- (void) setOnRequestCreatedBlock:(void (^) (FMWebSyncMessageRequestCreatedArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke whenever a new response is received
/// and about to be processed by the client. This is a good place to read
/// or modify incoming messages.
/// </summary>
- (void) setOnResponseReceived:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke whenever a new response is received
/// and about to be processed by the client. This is a good place to read
/// or modify incoming messages.
/// </summary>
- (void) setOnResponseReceivedBlock:(void (^) (FMWebSyncMessageResponseReceivedArgs*))valueBlock;
/// <summary>
/// Sets the sender of the content, either a client or publisher.
/// </summary>
- (void) setSender:(NSObject*)value;
/// <summary>
/// Sets the number of milliseconds to wait before timing out the transfer.
/// Defaults to 15000 (15 seconds).
/// </summary>
- (void) setTimeout:(int)value;
/// <summary>
/// Sets the target URL for the request.
/// </summary>
- (void) setUrl:(NSString*)value;
/// <summary>
/// Gets the number of milliseconds to wait before timing out the transfer.
/// Defaults to 15000 (15 seconds).
/// </summary>
- (int) timeout;
/// <summary>
/// Gets the target URL for the request.
/// </summary>
- (NSString*) url;

@end


@class NSExceptionFMExtensions;
@class FMNameValueCollection;
@class NSMutableArrayFMExtensions;
@class FMWebSyncMessageRequestArgs;

/// <summary>
/// Arguments for receiving a message response.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncMessageResponseArgs : FMDynamic 

/// <summary>
/// Gets the exception generated while completing the request.
/// </summary>
- (NSException*) exception;
/// <summary>
/// Gets the headers for the response.
/// </summary>
- (FMNameValueCollection*) headers;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncMessageResponseArgs" /> class.
/// </summary>
/// <param name="requestArgs">The request arguments.</param>
- (id) initWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncMessageResponseArgs" /> class.
/// </summary>
/// <param name="requestArgs">The request arguments.</param>
+ (FMWebSyncMessageResponseArgs*) messageResponseArgsWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs;
/// <summary>
/// Gets the messages read from the response.
/// </summary>
- (NSMutableArray*) messages;
/// <summary>
/// Gets the original <see cref="FMWebSyncMessageRequestArgs" />.
/// </summary>
- (FMWebSyncMessageRequestArgs*) requestArgs;
/// <summary>
/// Sets the exception generated while completing the request.
/// </summary>
- (void) setException:(NSException*)value;
/// <summary>
/// Sets the headers for the response.
/// </summary>
- (void) setHeaders:(FMNameValueCollection*)value;
/// <summary>
/// Sets the messages read from the response.
/// </summary>
- (void) setMessages:(NSMutableArray*)value;
/// <summary>
/// Sets the original <see cref="FMWebSyncMessageRequestArgs" />.
/// </summary>
- (void) setRequestArgs:(FMWebSyncMessageRequestArgs*)value;

@end


@class FMWebSyncNotifyCompleteArgs;
@class FMWebSyncNotifyFailureArgs;
@class FMWebSyncNotifySuccessArgs;
@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;
@class FMCallback;
@class FMGuid;

/// <summary>
/// Arguments for client notify requests.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncNotifyArgs : FMWebSyncBaseInputArgs 

/// <summary>
/// Gets the client ID to notify.
/// </summary>
- (FMGuid*) clientId;
/// <summary>
/// Gets the data to send in binary format.
/// (Overrides <see cref="FMWebSyncNotifyArgs#dataJson" />.)
/// </summary>
- (NSMutableData*) dataBytes;
/// <summary>
/// Gets the data to send in JSON format.
/// (Overrides <see cref="FMWebSyncNotifyArgs#dataBytes" />.)
/// </summary>
- (NSString*) dataJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyArgs" /> class.
/// </summary>
/// <param name="clientId">The client ID to which the data should be sent.</param>
/// <param name="dataBytes">The data to send in binary format.</param>
- (id) initWithClientId:(FMGuid*)clientId dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyArgs" /> class.
/// </summary>
/// <param name="clientId">The client ID to which the data should be sent.</param>
/// <param name="dataBytes">The data to send in binary format.</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
- (id) initWithClientId:(FMGuid*)clientId dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyArgs" /> class.
/// </summary>
/// <param name="clientId">The client ID to which the data should be sent.</param>
/// <param name="dataJson">The data to send in JSON format.</param>
- (id) initWithClientId:(FMGuid*)clientId dataJson:(NSString*)dataJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyArgs" /> class.
/// </summary>
/// <param name="clientId">The client ID to which the data should be sent.</param>
/// <param name="dataJson">The data to send in JSON format.</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
- (id) initWithClientId:(FMGuid*)clientId dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Gets whether or not the data is binary.
/// </summary>
- (bool) isBinary;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyArgs" /> class.
/// </summary>
/// <param name="clientId">The client ID to which the data should be sent.</param>
/// <param name="dataBytes">The data to send in binary format.</param>
+ (FMWebSyncNotifyArgs*) notifyArgsWithClientId:(FMGuid*)clientId dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyArgs" /> class.
/// </summary>
/// <param name="clientId">The client ID to which the data should be sent.</param>
/// <param name="dataBytes">The data to send in binary format.</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
+ (FMWebSyncNotifyArgs*) notifyArgsWithClientId:(FMGuid*)clientId dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyArgs" /> class.
/// </summary>
/// <param name="clientId">The client ID to which the data should be sent.</param>
/// <param name="dataJson">The data to send in JSON format.</param>
+ (FMWebSyncNotifyArgs*) notifyArgsWithClientId:(FMGuid*)clientId dataJson:(NSString*)dataJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyArgs" /> class.
/// </summary>
/// <param name="clientId">The client ID to which the data should be sent.</param>
/// <param name="dataJson">The data to send in JSON format.</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
+ (FMWebSyncNotifyArgs*) notifyArgsWithClientId:(FMGuid*)clientId dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Gets the callback to invoke after <see cref="FMWebSyncNotifyArgs#onSuccess" /> or <see cref="FMWebSyncNotifyArgs#onFailure" />.
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
/// Sets the client ID to notify.
/// </summary>
- (void) setClientId:(FMGuid*)value;
/// <summary>
/// Sets the data to send in binary format.
/// (Overrides <see cref="FMWebSyncNotifyArgs#dataJson" />.)
/// </summary>
- (void) setDataBytes:(NSMutableData*)value;
/// <summary>
/// Sets the data to send in JSON format.
/// (Overrides <see cref="FMWebSyncNotifyArgs#dataBytes" />.)
/// </summary>
- (void) setDataJson:(NSString*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncNotifyArgs#onSuccess" /> or <see cref="FMWebSyncNotifyArgs#onFailure" />.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncNotifyArgs#onSuccess" /> or <see cref="FMWebSyncNotifyArgs#onFailure" />.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMWebSyncNotifyCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMWebSyncNotifyFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMWebSyncNotifySuccessArgs*))valueBlock;
/// <summary>
/// Sets the tag that identifies the contents of the payload.
/// </summary>
- (void) setTag:(NSString*)value;
/// <summary>
/// Gets the tag that identifies the contents of the payload.
/// </summary>
- (NSString*) tag;

@end



/// <summary>
/// Base arguments for <see cref="FMWebSyncClient" /> "OnComplete" callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseCompleteArgs : FMWebSyncBaseOutputArgs 

+ (FMWebSyncBaseCompleteArgs*) baseCompleteArgs;
- (id) init;

@end



/// <summary>
/// Arguments for notify complete callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncNotifyCompleteArgs : FMWebSyncBaseCompleteArgs 

- (id) init;
+ (FMWebSyncNotifyCompleteArgs*) notifyCompleteArgs;

@end


@class NSExceptionFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Base arguments for <see cref="FMWebSyncClient" /> "OnFailure" callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseFailureArgs : FMWebSyncBaseOutputArgs 

+ (FMWebSyncBaseFailureArgs*) baseFailureArgs;
/// <summary>
/// Gets the error code value, if the exception was generated by WebSync; otherwise -1.
/// </summary>
- (int) errorCode;
/// <summary>
/// Gets the error message value, if the exception was generated by WebSync; otherwise <c>null</c>.
/// </summary>
- (NSString*) errorMessage;
/// <summary>
/// Gets the exception generated while completing the request.
/// </summary>
- (NSException*) exception;
+ (int) getErrorCodeWithException:(NSException*)exception;
+ (NSString*) getErrorMessageWithException:(NSException*)exception;
- (id) init;
/// <summary>
/// Gets whether or not to retry automatically after completing this operation.
/// </summary>
- (bool) retry;
/// <summary>
/// Sets the exception generated while completing the request.
/// </summary>
- (void) setException:(NSException*)value;
/// <summary>
/// Sets whether or not to retry automatically after completing this operation.
/// </summary>
- (void) setRetry:(bool)value;

@end


@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;
@class FMGuid;

/// <summary>
/// Arguments for notify failure callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncNotifyFailureArgs : FMWebSyncBaseFailureArgs 

/// <summary>
/// Gets the client ID to which the data failed to be sent.
/// </summary>
- (FMGuid*) clientId;
/// <summary>
/// Gets the data that failed to be sent in binary format.
/// </summary>
- (NSMutableData*) dataBytes;
/// <summary>
/// Gets the data that failed to be sent in JSON format.
/// </summary>
- (NSString*) dataJson;
- (id) init;
/// <summary>
/// Gets whether or not the data is binary.
/// </summary>
- (bool) isBinary;
+ (FMWebSyncNotifyFailureArgs*) notifyFailureArgs;
/// <summary>
/// Gets the tag that identifies the contents of the payload.
/// </summary>
- (NSString*) tag;

@end


@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;
@class FMGuid;

/// <summary>
/// Arguments for notify success callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncNotifySuccessArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets the client ID to which the data was sent.
/// </summary>
- (FMGuid*) clientId;
/// <summary>
/// Gets the data that was sent in binary format.
/// </summary>
- (NSMutableData*) dataBytes;
/// <summary>
/// Gets the data that was sent in JSON format.
/// </summary>
- (NSString*) dataJson;
- (id) init;
/// <summary>
/// Gets whether or not the data is binary.
/// </summary>
- (bool) isBinary;
+ (FMWebSyncNotifySuccessArgs*) notifySuccessArgs;
/// <summary>
/// Gets the tag that identifies the contents of the payload.
/// </summary>
- (NSString*) tag;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncPublisher#addOnNotifyResponse:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublisherNotifyResponseArgs : FMWebSyncBasePublisherResponseEventArgsGeneric 

- (id) init;
+ (FMWebSyncPublisherNotifyResponseArgs*) publisherNotifyResponseArgs;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncPublisher#addOnNotifyRequest:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublisherNotifyRequestArgs : FMWebSyncBasePublisherRequestEventArgsGeneric 

- (id) init;
+ (FMWebSyncPublisherNotifyRequestArgs*) publisherNotifyRequestArgs;

@end


@class NSExceptionFMExtensions;

/// <summary>
/// Arguments for an unhandled exception.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncUnhandledExceptionArgs : NSObject 

/// <summary>
/// Gets the unhandled exception.
/// </summary>
- (NSException*) exception;
/// <summary>
/// Gets whether the exception has been
/// appropriately handled. If set to <c>true</c>,
/// then the exception will not be thrown.
/// </summary>
- (bool) handled;
- (id) init;
/// <summary>
/// Sets whether the exception has been
/// appropriately handled. If set to <c>true</c>,
/// then the exception will not be thrown.
/// </summary>
- (void) setHandled:(bool)value;
+ (FMWebSyncUnhandledExceptionArgs*) unhandledExceptionArgs;

@end


@class NSExceptionFMExtensions;
@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;
@class FMWebSyncMessage;

#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientResponseArgs : FMDynamic 

+ (FMWebSyncClientResponseArgs*) clientResponseArgs;
- (int) errorCode;
- (NSString*) errorMessage;
- (NSException*) exception;
- (id) init;
- (FMWebSyncMessage*) response;
- (NSMutableArray*) responses;
- (void) setException:(NSException*)value;
- (void) setResponse:(FMWebSyncMessage*)value;
- (void) setResponses:(NSMutableArray*)value;

@end


@class FMWebSyncConnectCompleteArgs;
@class FMWebSyncConnectFailureArgs;
@class FMWebSyncConnectSuccessArgs;
@class FMWebSyncStreamFailureArgs;
@class FMWebSyncStateRestoredArgs;
@class FMNullableGuid;
@class FMCallback;

/// <summary>
/// Arguments for client connect requests.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncConnectArgs : FMWebSyncBaseInputArgs 

/// <summary>
/// Creates a new instance of <see cref="FMWebSyncConnectArgs" />.
/// </summary>
+ (FMWebSyncConnectArgs*) connectArgs;
/// <summary>
/// Creates a new instance of <see cref="FMWebSyncConnectArgs" />.
/// </summary>
- (id) init;
- (bool) isReconnect;
- (FMNullableGuid*) lastClientId;
- (FMNullableGuid*) lastSessionId;
/// <summary>
/// Gets the callback to invoke after <see cref="FMWebSyncConnectArgs#onSuccess" /> or <see cref="FMWebSyncConnectArgs#onFailure" />.
/// </summary>
- (FMCallback*) onComplete;
/// <summary>
/// Gets the callback to invoke if the request fails.
/// </summary>
- (FMCallback*) onFailure;
/// <summary>
/// Gets the callback to invoke after all bindings and subscriptions
/// are restored following a reconnect.
/// See <see cref="FMWebSyncStateRestoredArgs" /> for callback argument details.
/// </summary>
- (FMCallback*) onStateRestored;
/// <summary>
/// Gets the callback to invoke if the streaming connection fails.
/// See <see cref="FMWebSyncStreamFailureArgs" /> for callback argument details.
/// </summary>
/// <remarks>
/// <para>
/// This method will be invoked if the connection was lost or the client
/// record no longer exists on the server (either due to network loss or
/// an application pool recycle). In either case, the client will automatically
/// reconnect after firing this callback. If the reconnect succeeds, the
/// OnSuccess callback will be invoked with <see cref="FMWebSyncConnectSuccessArgs#isReconnect" />
/// set to <c>true</c>. If the reconnect succeeds, the OnFailure callback
/// will be invoked with <see cref="FMWebSyncConnectFailureArgs#isReconnect" /> set
/// to <c>true</c>.
/// </para>
/// <para>
/// This is the recommended place to perform any UI updates necessary to
/// inform the application user that the connection has been temporarily
/// lost. Any UI components shown by this callback can be hidden in
/// either OnSuccess or OnFailure.
/// </para>
/// </remarks>
- (FMCallback*) onStreamFailure;
/// <summary>
/// Gets the callback to invoke if the request succeeds.
/// </summary>
- (FMCallback*) onSuccess;
/// <summary>
/// Gets the backoff algorithm to use when retrying a failed connect handshake.
/// Used to calculate the sleep timeout before retrying if <see cref="FMWebSyncBaseFailureArgs#retry" />
/// is set to <c>true</c> in <see cref="FMWebSyncConnectFailureArgs" />. The function should return
/// the desired timeout in milliseconds.
/// </summary>
- (FMCallback*) retryBackoff;
/// <summary>
/// Gets the mode under which the client is expected to operate when
/// a connect handshake fails. This property controls the default value of
/// <see cref="FMWebSyncBaseFailureArgs#retry" /> in <see cref="FMWebSyncConnectFailureArgs" />,
/// which can be overridden.
/// </summary>
- (FMWebSyncConnectRetryMode) retryMode;
- (void) setIsReconnect:(bool)value;
- (void) setLastClientId:(FMNullableGuid*)value;
- (void) setLastSessionId:(FMNullableGuid*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncConnectArgs#onSuccess" /> or <see cref="FMWebSyncConnectArgs#onFailure" />.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncConnectArgs#onSuccess" /> or <see cref="FMWebSyncConnectArgs#onFailure" />.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMWebSyncConnectCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMWebSyncConnectFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke after all bindings and subscriptions
/// are restored following a reconnect.
/// See <see cref="FMWebSyncStateRestoredArgs" /> for callback argument details.
/// </summary>
- (void) setOnStateRestored:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after all bindings and subscriptions
/// are restored following a reconnect.
/// See <see cref="FMWebSyncStateRestoredArgs" /> for callback argument details.
/// </summary>
- (void) setOnStateRestoredBlock:(void (^) (FMWebSyncStateRestoredArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the streaming connection fails.
/// See <see cref="FMWebSyncStreamFailureArgs" /> for callback argument details.
/// </summary>
/// <remarks>
/// <para>
/// This method will be invoked if the connection was lost or the client
/// record no longer exists on the server (either due to network loss or
/// an application pool recycle). In either case, the client will automatically
/// reconnect after firing this callback. If the reconnect succeeds, the
/// OnSuccess callback will be invoked with <see cref="FMWebSyncConnectSuccessArgs#isReconnect" />
/// set to <c>true</c>. If the reconnect succeeds, the OnFailure callback
/// will be invoked with <see cref="FMWebSyncConnectFailureArgs#isReconnect" /> set
/// to <c>true</c>.
/// </para>
/// <para>
/// This is the recommended place to perform any UI updates necessary to
/// inform the application user that the connection has been temporarily
/// lost. Any UI components shown by this callback can be hidden in
/// either OnSuccess or OnFailure.
/// </para>
/// </remarks>
- (void) setOnStreamFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the streaming connection fails.
/// See <see cref="FMWebSyncStreamFailureArgs" /> for callback argument details.
/// </summary>
/// <remarks>
/// <para>
/// This method will be invoked if the connection was lost or the client
/// record no longer exists on the server (either due to network loss or
/// an application pool recycle). In either case, the client will automatically
/// reconnect after firing this callback. If the reconnect succeeds, the
/// OnSuccess callback will be invoked with <see cref="FMWebSyncConnectSuccessArgs#isReconnect" />
/// set to <c>true</c>. If the reconnect succeeds, the OnFailure callback
/// will be invoked with <see cref="FMWebSyncConnectFailureArgs#isReconnect" /> set
/// to <c>true</c>.
/// </para>
/// <para>
/// This is the recommended place to perform any UI updates necessary to
/// inform the application user that the connection has been temporarily
/// lost. Any UI components shown by this callback can be hidden in
/// either OnSuccess or OnFailure.
/// </para>
/// </remarks>
- (void) setOnStreamFailureBlock:(void (^) (FMWebSyncStreamFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMWebSyncConnectSuccessArgs*))valueBlock;
/// <summary>
/// Sets the backoff algorithm to use when retrying a failed connect handshake.
/// Used to calculate the sleep timeout before retrying if <see cref="FMWebSyncBaseFailureArgs#retry" />
/// is set to <c>true</c> in <see cref="FMWebSyncConnectFailureArgs" />. The function should return
/// the desired timeout in milliseconds.
/// </summary>
- (void) setRetryBackoff:(FMCallback*)value;
/// <summary>
/// Sets the mode under which the client is expected to operate when
/// a connect handshake fails. This property controls the default value of
/// <see cref="FMWebSyncBaseFailureArgs#retry" /> in <see cref="FMWebSyncConnectFailureArgs" />,
/// which can be overridden.
/// </summary>
- (void) setRetryMode:(FMWebSyncConnectRetryMode)value;

@end


@class FMWebSyncBindCompleteArgs;
@class FMWebSyncBindFailureArgs;
@class FMWebSyncBindSuccessArgs;
@class NSMutableArrayFMExtensions;
@class FMNullableBool;
@class FMCallback;
@class NSStringFMExtensions;
@class FMWebSyncRecord;

/// <summary>
/// Arguments for client bind requests.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBindArgs : FMWebSyncBaseInputArgs 

/// <summary>
/// Gets whether to call Bind with these args
/// immediately after a reconnect following a stream failure.
/// Generally, this should be <c>null</c>. The client will
/// analyze the current context and set this flag as needed.
/// However, it can be overridden for special cases. If set
/// explicitly to <c>false</c>, then the client will assume
/// that this call to Bind is being invoked from the
/// OnSuccess callback of another WebSync method call, and
/// therefore will be called again implicitly after a
/// network reconnection. If set to
/// <c>true</c>, then the client will assume this call to
/// Bind is being invoked as a part of some external
/// action and will force a Bind call using these arguments
/// after a network reconnection. Defaults to <c>null</c>.
/// </summary>
- (FMNullableBool*) autoRebind;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBindArgs" /> class.
/// </summary>
/// <param name="key">The record key.</param>
/// <param name="valueJson">The record value in JSON format.</param>
+ (FMWebSyncBindArgs*) bindArgsWithKey:(NSString*)key valueJson:(NSString*)valueJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBindArgs" /> class.
/// </summary>
/// <param name="key">The record key.</param>
/// <param name="valueJson">The record value in JSON format.</param>
/// <param name="priv">Whether the record is (to be) private.</param>
+ (FMWebSyncBindArgs*) bindArgsWithKey:(NSString*)key valueJson:(NSString*)valueJson priv:(bool)priv;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBindArgs" /> class.
/// </summary>
/// <param name="record">The record to bind.</param>
+ (FMWebSyncBindArgs*) bindArgsWithRecord:(FMWebSyncRecord*)record;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBindArgs" /> class.
/// </summary>
/// <param name="records">The records to bind.</param>
+ (FMWebSyncBindArgs*) bindArgsWithRecords:(NSMutableArray*)records;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBindArgs" /> class.
/// </summary>
/// <param name="key">The record key.</param>
/// <param name="valueJson">The record value in JSON format.</param>
- (id) initWithKey:(NSString*)key valueJson:(NSString*)valueJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBindArgs" /> class.
/// </summary>
/// <param name="key">The record key.</param>
/// <param name="valueJson">The record value in JSON format.</param>
/// <param name="priv">Whether the record is (to be) private.</param>
- (id) initWithKey:(NSString*)key valueJson:(NSString*)valueJson priv:(bool)priv;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBindArgs" /> class.
/// </summary>
/// <param name="record">The record to bind.</param>
- (id) initWithRecord:(FMWebSyncRecord*)record;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBindArgs" /> class.
/// </summary>
/// <param name="records">The records to bind.</param>
- (id) initWithRecords:(NSMutableArray*)records;
- (bool) isRebind;
/// <summary>
/// Gets the callback to invoke after <see cref="FMWebSyncBindArgs#onSuccess" /> or <see cref="FMWebSyncBindArgs#onFailure" />.
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
/// Gets the record to bind.
/// Overrides <see cref="FMWebSyncBindArgs#records" />.
/// </summary>
- (FMWebSyncRecord*) record;
/// <summary>
/// Gets the records to bind.
/// Overrides <see cref="FMWebSyncBindArgs#record" />.
/// </summary>
- (NSMutableArray*) records;
/// <summary>
/// Sets whether to call Bind with these args
/// immediately after a reconnect following a stream failure.
/// Generally, this should be <c>null</c>. The client will
/// analyze the current context and set this flag as needed.
/// However, it can be overridden for special cases. If set
/// explicitly to <c>false</c>, then the client will assume
/// that this call to Bind is being invoked from the
/// OnSuccess callback of another WebSync method call, and
/// therefore will be called again implicitly after a
/// network reconnection. If set to
/// <c>true</c>, then the client will assume this call to
/// Bind is being invoked as a part of some external
/// action and will force a Bind call using these arguments
/// after a network reconnection. Defaults to <c>null</c>.
/// </summary>
- (void) setAutoRebind:(FMNullableBool*)value;
- (void) setIsRebind:(bool)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncBindArgs#onSuccess" /> or <see cref="FMWebSyncBindArgs#onFailure" />.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncBindArgs#onSuccess" /> or <see cref="FMWebSyncBindArgs#onFailure" />.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMWebSyncBindCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMWebSyncBindFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMWebSyncBindSuccessArgs*))valueBlock;
/// <summary>
/// Sets the record to bind.
/// Overrides <see cref="FMWebSyncBindArgs#records" />.
/// </summary>
- (void) setRecord:(FMWebSyncRecord*)value;
/// <summary>
/// Sets the records to bind.
/// Overrides <see cref="FMWebSyncBindArgs#record" />.
/// </summary>
- (void) setRecords:(NSMutableArray*)value;

@end


@class FMWebSyncServiceCompleteArgs;
@class FMWebSyncServiceFailureArgs;
@class FMWebSyncServiceSuccessArgs;
@class NSStringFMExtensions;
@class NSMutableDataFMExtensions;
@class FMCallback;

/// <summary>
/// Arguments for client service requests.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncServiceArgs : FMWebSyncBaseInputArgs 

/// <summary>
/// Gets the channel to which the data should be sent.
/// Must start with a forward slash (/).
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the data to send in binary format.
/// (Overrides <see cref="FMWebSyncServiceArgs#dataJson" />.)
/// </summary>
- (NSMutableData*) dataBytes;
/// <summary>
/// Gets the data to send in JSON format.
/// (Overrides <see cref="FMWebSyncServiceArgs#dataBytes" />.)
/// </summary>
- (NSString*) dataJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncServiceArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataBytes">The data to send in binary format.</param>
- (id) initWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncServiceArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataBytes">The data to send in binary format.</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
- (id) initWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncServiceArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataJson">The data to send in JSON format.</param>
- (id) initWithChannel:(NSString*)channel dataJson:(NSString*)dataJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncServiceArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataJson">The data to send in JSON format.</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
- (id) initWithChannel:(NSString*)channel dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Gets whether or not the data is binary.
/// </summary>
- (bool) isBinary;
/// <summary>
/// Gets the callback to invoke after <see cref="FMWebSyncServiceArgs#onSuccess" /> or <see cref="FMWebSyncServiceArgs#onFailure" />.
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
/// Initializes a new instance of the <see cref="FMWebSyncServiceArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataBytes">The data to send in binary format.</param>
+ (FMWebSyncServiceArgs*) serviceArgsWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncServiceArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataBytes">The data to send in binary format.</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
+ (FMWebSyncServiceArgs*) serviceArgsWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncServiceArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataJson">The data to send in JSON format.</param>
+ (FMWebSyncServiceArgs*) serviceArgsWithChannel:(NSString*)channel dataJson:(NSString*)dataJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncServiceArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataJson">The data to send in JSON format.</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
+ (FMWebSyncServiceArgs*) serviceArgsWithChannel:(NSString*)channel dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Sets the channel to which the data should be sent.
/// Must start with a forward slash (/).
/// </summary>
- (void) setChannel:(NSString*)value;
/// <summary>
/// Sets the data to send in binary format.
/// (Overrides <see cref="FMWebSyncServiceArgs#dataJson" />.)
/// </summary>
- (void) setDataBytes:(NSMutableData*)value;
/// <summary>
/// Sets the data to send in JSON format.
/// (Overrides <see cref="FMWebSyncServiceArgs#dataBytes" />.)
/// </summary>
- (void) setDataJson:(NSString*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncServiceArgs#onSuccess" /> or <see cref="FMWebSyncServiceArgs#onFailure" />.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncServiceArgs#onSuccess" /> or <see cref="FMWebSyncServiceArgs#onFailure" />.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMWebSyncServiceCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMWebSyncServiceFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMWebSyncServiceSuccessArgs*))valueBlock;
/// <summary>
/// Sets the tag that identifies the contents of the payload.
/// </summary>
- (void) setTag:(NSString*)value;
/// <summary>
/// Gets the tag that identifies the contents of the payload.
/// </summary>
- (NSString*) tag;

@end


@class FMWebSyncUnbindCompleteArgs;
@class FMWebSyncUnbindFailureArgs;
@class FMWebSyncUnbindSuccessArgs;
@class NSMutableArrayFMExtensions;
@class FMCallback;
@class NSStringFMExtensions;
@class FMWebSyncRecord;

/// <summary>
/// Arguments for client unbind requests.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncUnbindArgs : FMWebSyncBaseInputArgs 

/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnbindArgs" /> class.
/// </summary>
/// <param name="key">The key to unbind.</param>
- (id) initWithKey:(NSString*)key;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnbindArgs" /> class.
/// </summary>
/// <param name="keys">The keys to unbind.</param>
- (id) initWithKeys:(NSMutableArray*)keys;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnbindArgs" /> class.
/// </summary>
/// <param name="record">The record to unbind.</param>
- (id) initWithRecord:(FMWebSyncRecord*)record;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnbindArgs" /> class.
/// </summary>
/// <param name="records">The records to unbind.</param>
- (id) initWithRecords:(NSMutableArray*)records;
/// <summary>
/// Gets the record key to unbind.
/// Overrides <see cref="FMWebSyncUnbindArgs#keys" />, <see cref="FMWebSyncUnbindArgs#record" />, and <see cref="FMWebSyncUnbindArgs#records" />.
/// </summary>
- (NSString*) key;
/// <summary>
/// Gets the record keys to unbind.
/// Overrides <see cref="FMWebSyncUnbindArgs#key" />, <see cref="FMWebSyncUnbindArgs#record" />, and <see cref="FMWebSyncUnbindArgs#records" />.
/// </summary>
- (NSMutableArray*) keys;
/// <summary>
/// Gets the callback to invoke after <see cref="FMWebSyncUnbindArgs#onSuccess" /> or <see cref="FMWebSyncUnbindArgs#onFailure" />.
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
/// Gets the record to unbind.
/// Overrides <see cref="FMWebSyncUnbindArgs#records" />, <see cref="FMWebSyncUnbindArgs#key" />, and <see cref="FMWebSyncUnbindArgs#keys" />.
/// </summary>
- (FMWebSyncRecord*) record;
/// <summary>
/// Gets the records to unbind.
/// Overrides <see cref="FMWebSyncUnbindArgs#record" />, <see cref="FMWebSyncUnbindArgs#key" />, and <see cref="FMWebSyncUnbindArgs#keys" />.
/// </summary>
- (NSMutableArray*) records;
/// <summary>
/// Sets the record key to unbind.
/// Overrides <see cref="FMWebSyncUnbindArgs#keys" />, <see cref="FMWebSyncUnbindArgs#record" />, and <see cref="FMWebSyncUnbindArgs#records" />.
/// </summary>
- (void) setKey:(NSString*)value;
/// <summary>
/// Sets the record keys to unbind.
/// Overrides <see cref="FMWebSyncUnbindArgs#key" />, <see cref="FMWebSyncUnbindArgs#record" />, and <see cref="FMWebSyncUnbindArgs#records" />.
/// </summary>
- (void) setKeys:(NSMutableArray*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncUnbindArgs#onSuccess" /> or <see cref="FMWebSyncUnbindArgs#onFailure" />.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncUnbindArgs#onSuccess" /> or <see cref="FMWebSyncUnbindArgs#onFailure" />.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMWebSyncUnbindCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMWebSyncUnbindFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMWebSyncUnbindSuccessArgs*))valueBlock;
/// <summary>
/// Sets the record to unbind.
/// Overrides <see cref="FMWebSyncUnbindArgs#records" />, <see cref="FMWebSyncUnbindArgs#key" />, and <see cref="FMWebSyncUnbindArgs#keys" />.
/// </summary>
- (void) setRecord:(FMWebSyncRecord*)value;
/// <summary>
/// Sets the records to unbind.
/// Overrides <see cref="FMWebSyncUnbindArgs#record" />, <see cref="FMWebSyncUnbindArgs#key" />, and <see cref="FMWebSyncUnbindArgs#keys" />.
/// </summary>
- (void) setRecords:(NSMutableArray*)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnbindArgs" /> class.
/// </summary>
/// <param name="key">The key to unbind.</param>
+ (FMWebSyncUnbindArgs*) unbindArgsWithKey:(NSString*)key;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnbindArgs" /> class.
/// </summary>
/// <param name="keys">The keys to unbind.</param>
+ (FMWebSyncUnbindArgs*) unbindArgsWithKeys:(NSMutableArray*)keys;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnbindArgs" /> class.
/// </summary>
/// <param name="record">The record to unbind.</param>
+ (FMWebSyncUnbindArgs*) unbindArgsWithRecord:(FMWebSyncRecord*)record;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnbindArgs" /> class.
/// </summary>
/// <param name="records">The records to unbind.</param>
+ (FMWebSyncUnbindArgs*) unbindArgsWithRecords:(NSMutableArray*)records;

@end


@class FMWebSyncDisconnectCompleteArgs;
@class FMCallback;

/// <summary>
/// Arguments for client disconnect requests.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncDisconnectArgs : FMWebSyncBaseInputArgs 

+ (FMWebSyncDisconnectArgs*) disconnectArgs;
- (id) init;
/// <summary>
/// Gets the callback to invoke after the disconnection is complete.
/// </summary>
- (FMCallback*) onComplete;
/// <summary>
/// Sets the callback to invoke after the disconnection is complete.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after the disconnection is complete.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMWebSyncDisconnectCompleteArgs*))valueBlock;

@end


@class FMWebSyncPublishCompleteArgs;
@class FMWebSyncPublishFailureArgs;
@class FMWebSyncPublishSuccessArgs;
@class NSStringFMExtensions;
@class NSMutableDataFMExtensions;
@class FMCallback;

/// <summary>
/// Arguments for client publish requests.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublishArgs : FMWebSyncBaseInputArgs 

/// <summary>
/// Gets the channel to which the data should be sent.
/// Must start with a forward slash (/).
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the data to send in binary format.
/// (Overrides <see cref="FMWebSyncPublishArgs#dataJson" />.)
/// </summary>
- (NSMutableData*) dataBytes;
/// <summary>
/// Gets the data to send in JSON format.
/// (Overrides <see cref="FMWebSyncPublishArgs#dataBytes" />.)
/// </summary>
- (NSString*) dataJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublishArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataBytes">The data to send in binary format.</param>
- (id) initWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublishArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataBytes">The data to send in binary format.</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
- (id) initWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublishArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataJson">The data to send in JSON format.</param>
- (id) initWithChannel:(NSString*)channel dataJson:(NSString*)dataJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublishArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataJson">The data to send in JSON format.</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
- (id) initWithChannel:(NSString*)channel dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Gets whether or not the data is binary.
/// </summary>
- (bool) isBinary;
/// <summary>
/// Gets the callback to invoke after <see cref="FMWebSyncPublishArgs#onSuccess" /> or <see cref="FMWebSyncPublishArgs#onFailure" />.
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
/// Initializes a new instance of the <see cref="FMWebSyncPublishArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataBytes">The data to send in binary format.</param>
+ (FMWebSyncPublishArgs*) publishArgsWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublishArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataBytes">The data to send in binary format.</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
+ (FMWebSyncPublishArgs*) publishArgsWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublishArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataJson">The data to send in JSON format.</param>
+ (FMWebSyncPublishArgs*) publishArgsWithChannel:(NSString*)channel dataJson:(NSString*)dataJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublishArgs" /> class.
/// </summary>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataJson">The data to send in JSON format.</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
+ (FMWebSyncPublishArgs*) publishArgsWithChannel:(NSString*)channel dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Sets the channel to which the data should be sent.
/// Must start with a forward slash (/).
/// </summary>
- (void) setChannel:(NSString*)value;
/// <summary>
/// Sets the data to send in binary format.
/// (Overrides <see cref="FMWebSyncPublishArgs#dataJson" />.)
/// </summary>
- (void) setDataBytes:(NSMutableData*)value;
/// <summary>
/// Sets the data to send in JSON format.
/// (Overrides <see cref="FMWebSyncPublishArgs#dataBytes" />.)
/// </summary>
- (void) setDataJson:(NSString*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncPublishArgs#onSuccess" /> or <see cref="FMWebSyncPublishArgs#onFailure" />.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncPublishArgs#onSuccess" /> or <see cref="FMWebSyncPublishArgs#onFailure" />.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMWebSyncPublishCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMWebSyncPublishFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMWebSyncPublishSuccessArgs*))valueBlock;
/// <summary>
/// Sets the tag that identifies the contents of the payload.
/// </summary>
- (void) setTag:(NSString*)value;
/// <summary>
/// Gets the tag that identifies the contents of the payload.
/// </summary>
- (NSString*) tag;

@end


@class FMWebSyncSubscribeCompleteArgs;
@class FMWebSyncSubscribeFailureArgs;
@class FMWebSyncSubscribeSuccessArgs;
@class FMWebSyncSubscribeReceiveArgs;
@class NSMutableArrayFMExtensions;
@class FMNullableBool;
@class FMCallback;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for client subscribe requests.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribeArgs : FMWebSyncBaseInputArgs 

/// <summary>
/// Gets whether to call Subscribe with these args
/// immediately after a reconnect following a stream failure.
/// Generally, this should be <c>null</c>. The client will
/// analyze the current context and set this flag as needed.
/// However, it can be overridden for special cases. If set
/// explicitly to <c>false</c>, then the client will assume
/// that this call to Subscribe is being invoked from the
/// OnSuccess callback of another WebSync method call, and
/// therefore will be called again implicitly after a
/// network reconnection. If set to
/// <c>true</c>, then the client will assume this call to
/// Subscribe is being invoked as a part of some external
/// action and will force a Subscribe call using these arguments
/// after a network reconnection. Defaults to <c>null</c>.
/// </summary>
- (FMNullableBool*) autoResubscribe;
/// <summary>
/// Gets the channel to which the client should be subscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncSubscribeArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels to which the client should be subscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncSubscribeArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribeArgs" /> class.
/// </summary>
/// <param name="channel">The channel to subscribe.</param>
- (id) initWithChannel:(NSString*)channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribeArgs" /> class.
/// </summary>
/// <param name="channel">The channel to subscribe.</param>
/// <param name="tag">The tag identifying the subscription.</param>
- (id) initWithChannel:(NSString*)channel tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribeArgs" /> class.
/// </summary>
/// <param name="channels">The channels to subscribe.</param>
- (id) initWithChannels:(NSMutableArray*)channels;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribeArgs" /> class.
/// </summary>
/// <param name="channels">The channels to subscribe.</param>
/// <param name="tag">The tag identifying the subscription.</param>
- (id) initWithChannels:(NSMutableArray*)channels tag:(NSString*)tag;
- (bool) isResubscribe;
/// <summary>
/// Gets the callback to invoke after <see cref="FMWebSyncSubscribeArgs#onSuccess" /> or <see cref="FMWebSyncSubscribeArgs#onFailure" />.
/// </summary>
- (FMCallback*) onComplete;
/// <summary>
/// Gets the callback to invoke if the request fails.
/// </summary>
- (FMCallback*) onFailure;
/// <summary>
/// Gets the callback to invoke when data is received on the channel(s).
/// See <see cref="FMWebSyncSubscribeReceiveArgs" /> for callback argument details.
/// </summary>
- (FMCallback*) onReceive;
/// <summary>
/// Gets the callback to invoke if the request succeeds.
/// </summary>
- (FMCallback*) onSuccess;
/// <summary>
/// Sets whether to call Subscribe with these args
/// immediately after a reconnect following a stream failure.
/// Generally, this should be <c>null</c>. The client will
/// analyze the current context and set this flag as needed.
/// However, it can be overridden for special cases. If set
/// explicitly to <c>false</c>, then the client will assume
/// that this call to Subscribe is being invoked from the
/// OnSuccess callback of another WebSync method call, and
/// therefore will be called again implicitly after a
/// network reconnection. If set to
/// <c>true</c>, then the client will assume this call to
/// Subscribe is being invoked as a part of some external
/// action and will force a Subscribe call using these arguments
/// after a network reconnection. Defaults to <c>null</c>.
/// </summary>
- (void) setAutoResubscribe:(FMNullableBool*)value;
/// <summary>
/// Sets the channel to which the client should be subscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncSubscribeArgs#channels" />.
/// </summary>
- (void) setChannel:(NSString*)value;
/// <summary>
/// Sets the channels to which the client should be subscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncSubscribeArgs#channel" />.
/// </summary>
- (void) setChannels:(NSMutableArray*)value;
- (void) setIsResubscribe:(bool)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncSubscribeArgs#onSuccess" /> or <see cref="FMWebSyncSubscribeArgs#onFailure" />.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncSubscribeArgs#onSuccess" /> or <see cref="FMWebSyncSubscribeArgs#onFailure" />.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMWebSyncSubscribeCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMWebSyncSubscribeFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke when data is received on the channel(s).
/// See <see cref="FMWebSyncSubscribeReceiveArgs" /> for callback argument details.
/// </summary>
- (void) setOnReceive:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke when data is received on the channel(s).
/// See <see cref="FMWebSyncSubscribeReceiveArgs" /> for callback argument details.
/// </summary>
- (void) setOnReceiveBlock:(void (^) (FMWebSyncSubscribeReceiveArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMWebSyncSubscribeSuccessArgs*))valueBlock;
/// <summary>
/// Sets a tag that will uniquely identify this subscription so it
/// can be unsubscribed later without affecting other subscriptions with the same channel.
/// </summary>
- (void) setTag:(NSString*)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribeArgs" /> class.
/// </summary>
/// <param name="channel">The channel to subscribe.</param>
+ (FMWebSyncSubscribeArgs*) subscribeArgsWithChannel:(NSString*)channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribeArgs" /> class.
/// </summary>
/// <param name="channel">The channel to subscribe.</param>
/// <param name="tag">The tag identifying the subscription.</param>
+ (FMWebSyncSubscribeArgs*) subscribeArgsWithChannel:(NSString*)channel tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribeArgs" /> class.
/// </summary>
/// <param name="channels">The channels to subscribe.</param>
+ (FMWebSyncSubscribeArgs*) subscribeArgsWithChannels:(NSMutableArray*)channels;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribeArgs" /> class.
/// </summary>
/// <param name="channels">The channels to subscribe.</param>
/// <param name="tag">The tag identifying the subscription.</param>
+ (FMWebSyncSubscribeArgs*) subscribeArgsWithChannels:(NSMutableArray*)channels tag:(NSString*)tag;
/// <summary>
/// Gets a tag that will uniquely identify this subscription so it
/// can be unsubscribed later without affecting other subscriptions with the same channel.
/// </summary>
- (NSString*) tag;

@end


@class FMWebSyncUnsubscribeCompleteArgs;
@class FMWebSyncUnsubscribeFailureArgs;
@class FMWebSyncUnsubscribeSuccessArgs;
@class NSMutableArrayFMExtensions;
@class FMCallback;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for client unsubscribe requests.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncUnsubscribeArgs : FMWebSyncBaseInputArgs 

/// <summary>
/// Gets the channel from which the client should be unsubscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncUnsubscribeArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels from which the client should be unsubscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncUnsubscribeArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnsubscribeArgs" /> class.
/// </summary>
/// <param name="channel">The channel to unsubscribe.</param>
- (id) initWithChannel:(NSString*)channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnsubscribeArgs" /> class.
/// </summary>
/// <param name="channel">The channel to unsubscribe.</param>
/// <param name="tag">The tag identifying the subscription.</param>
- (id) initWithChannel:(NSString*)channel tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnsubscribeArgs" /> class.
/// </summary>
/// <param name="channels">The channels to unsubscribe.</param>
- (id) initWithChannels:(NSMutableArray*)channels;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnsubscribeArgs" /> class.
/// </summary>
/// <param name="channels">The channels to unsubscribe.</param>
/// <param name="tag">The tag identifying the subscription.</param>
- (id) initWithChannels:(NSMutableArray*)channels tag:(NSString*)tag;
/// <summary>
/// Gets the callback to invoke after <see cref="FMWebSyncUnsubscribeArgs#onSuccess" /> or <see cref="FMWebSyncUnsubscribeArgs#onFailure" />.
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
/// Overrides <see cref="FMWebSyncUnsubscribeArgs#channels" />.
/// </summary>
- (void) setChannel:(NSString*)value;
/// <summary>
/// Sets the channels from which the client should be unsubscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncUnsubscribeArgs#channel" />.
/// </summary>
- (void) setChannels:(NSMutableArray*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncUnsubscribeArgs#onSuccess" /> or <see cref="FMWebSyncUnsubscribeArgs#onFailure" />.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after <see cref="FMWebSyncUnsubscribeArgs#onSuccess" /> or <see cref="FMWebSyncUnsubscribeArgs#onFailure" />.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMWebSyncUnsubscribeCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request fails.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMWebSyncUnsubscribeFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the request succeeds.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMWebSyncUnsubscribeSuccessArgs*))valueBlock;
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
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnsubscribeArgs" /> class.
/// </summary>
/// <param name="channel">The channel to unsubscribe.</param>
+ (FMWebSyncUnsubscribeArgs*) unsubscribeArgsWithChannel:(NSString*)channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnsubscribeArgs" /> class.
/// </summary>
/// <param name="channel">The channel to unsubscribe.</param>
/// <param name="tag">The tag identifying the subscription.</param>
+ (FMWebSyncUnsubscribeArgs*) unsubscribeArgsWithChannel:(NSString*)channel tag:(NSString*)tag;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnsubscribeArgs" /> class.
/// </summary>
/// <param name="channels">The channels to unsubscribe.</param>
+ (FMWebSyncUnsubscribeArgs*) unsubscribeArgsWithChannels:(NSMutableArray*)channels;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncUnsubscribeArgs" /> class.
/// </summary>
/// <param name="channels">The channels to unsubscribe.</param>
/// <param name="tag">The tag identifying the subscription.</param>
+ (FMWebSyncUnsubscribeArgs*) unsubscribeArgsWithChannels:(NSMutableArray*)channels tag:(NSString*)tag;

@end



/// <summary>
/// Arguments for connect complete callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncConnectCompleteArgs : FMWebSyncBaseCompleteArgs 

+ (FMWebSyncConnectCompleteArgs*) connectCompleteArgs;
- (id) init;
/// <summary>
/// Gets whether the connect call was automatically
/// invoked following a stream failure.
/// </summary>
- (bool) isReconnect;
- (void) setIsReconnect:(bool)value;

@end



/// <summary>
/// Arguments for bind complete callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBindCompleteArgs : FMWebSyncBaseCompleteArgs 

+ (FMWebSyncBindCompleteArgs*) bindCompleteArgs;
- (id) init;
/// <summary>
/// Gets whether the bind call was automatically
/// invoked following a stream failure.
/// </summary>
- (bool) isRebind;
- (void) setIsRebind:(bool)value;

@end



/// <summary>
/// Arguments for service complete callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncServiceCompleteArgs : FMWebSyncBaseCompleteArgs 

- (id) init;
+ (FMWebSyncServiceCompleteArgs*) serviceCompleteArgs;

@end



/// <summary>
/// Arguments for unbind complete callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncUnbindCompleteArgs : FMWebSyncBaseCompleteArgs 

/// <summary>
/// Gets whether this unbind was forced due to a disconnect.
/// </summary>
- (bool) forced;
- (id) init;
+ (FMWebSyncUnbindCompleteArgs*) unbindCompleteArgs;

@end


@class NSExceptionFMExtensions;

/// <summary>
/// Arguments for disconnect complete callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncDisconnectCompleteArgs : FMWebSyncBaseCompleteArgs 

+ (FMWebSyncDisconnectCompleteArgs*) disconnectCompleteArgs;
/// <summary>
/// Gets the exception that was thrown while disconnecting.
/// Will be <c>null</c> if the disconnect was performed gracefully.
/// </summary>
- (NSException*) exception;
- (id) init;
- (void) setException:(NSException*)value;

@end



/// <summary>
/// Arguments for publish complete callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublishCompleteArgs : FMWebSyncBaseCompleteArgs 

- (id) init;
+ (FMWebSyncPublishCompleteArgs*) publishCompleteArgs;

@end



/// <summary>
/// Arguments for subscribe complete callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribeCompleteArgs : FMWebSyncBaseCompleteArgs 

- (id) init;
/// <summary>
/// Gets whether the subscribe call was automatically
/// invoked following a stream failure.
/// </summary>
- (bool) isResubscribe;
- (void) setIsResubscribe:(bool)value;
+ (FMWebSyncSubscribeCompleteArgs*) subscribeCompleteArgs;

@end



/// <summary>
/// Arguments for unsubscribe complete callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncUnsubscribeCompleteArgs : FMWebSyncBaseCompleteArgs 

/// <summary>
/// Gets whether this unsubscribe was forced due to a disconnect.
/// </summary>
- (bool) forced;
- (id) init;
+ (FMWebSyncUnsubscribeCompleteArgs*) unsubscribeCompleteArgs;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnConnectResponse:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientConnectResponseArgs : FMWebSyncBaseClientResponseEventArgsGeneric 

+ (FMWebSyncClientConnectResponseArgs*) clientConnectResponseArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnDisconnectResponse:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientDisconnectResponseArgs : FMWebSyncBaseClientResponseEventArgsGeneric 

+ (FMWebSyncClientDisconnectResponseArgs*) clientDisconnectResponseArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnPublishResponse:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientPublishResponseArgs : FMWebSyncBaseClientResponseEventArgsGeneric 

+ (FMWebSyncClientPublishResponseArgs*) clientPublishResponseArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnSubscribeResponse:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientSubscribeResponseArgs : FMWebSyncBaseClientResponseEventArgsGeneric 

+ (FMWebSyncClientSubscribeResponseArgs*) clientSubscribeResponseArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnUnsubscribeResponse:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientUnsubscribeResponseArgs : FMWebSyncBaseClientResponseEventArgsGeneric 

+ (FMWebSyncClientUnsubscribeResponseArgs*) clientUnsubscribeResponseArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnBindResponse:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientBindResponseArgs : FMWebSyncBaseClientResponseEventArgsGeneric 

+ (FMWebSyncClientBindResponseArgs*) clientBindResponseArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnUnbindResponse:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientUnbindResponseArgs : FMWebSyncBaseClientResponseEventArgsGeneric 

+ (FMWebSyncClientUnbindResponseArgs*) clientUnbindResponseArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnServiceResponse:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientServiceResponseArgs : FMWebSyncBaseClientResponseEventArgsGeneric 

+ (FMWebSyncClientServiceResponseArgs*) clientServiceResponseArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnConnectRequest:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientConnectRequestArgs : FMWebSyncBaseClientRequestEventArgsGeneric 

+ (FMWebSyncClientConnectRequestArgs*) clientConnectRequestArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnDisconnectRequest:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientDisconnectRequestArgs : FMWebSyncBaseClientRequestEventArgsGeneric 

+ (FMWebSyncClientDisconnectRequestArgs*) clientDisconnectRequestArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnPublishRequest:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientPublishRequestArgs : FMWebSyncBaseClientRequestEventArgsGeneric 

+ (FMWebSyncClientPublishRequestArgs*) clientPublishRequestArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnSubscribeRequest:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientSubscribeRequestArgs : FMWebSyncBaseClientRequestEventArgsGeneric 

+ (FMWebSyncClientSubscribeRequestArgs*) clientSubscribeRequestArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnUnsubscribeRequest:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientUnsubscribeRequestArgs : FMWebSyncBaseClientRequestEventArgsGeneric 

+ (FMWebSyncClientUnsubscribeRequestArgs*) clientUnsubscribeRequestArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnBindRequest:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientBindRequestArgs : FMWebSyncBaseClientRequestEventArgsGeneric 

+ (FMWebSyncClientBindRequestArgs*) clientBindRequestArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnUnbindRequest:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientUnbindRequestArgs : FMWebSyncBaseClientRequestEventArgsGeneric 

+ (FMWebSyncClientUnbindRequestArgs*) clientUnbindRequestArgs;
- (id) init;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncClient#addOnServiceRequest:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientServiceRequestArgs : FMWebSyncBaseClientRequestEventArgsGeneric 

+ (FMWebSyncClientServiceRequestArgs*) clientServiceRequestArgs;
- (id) init;

@end



/// <summary>
/// Arguments for connect failure callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncConnectFailureArgs : FMWebSyncBaseFailureArgs 

+ (FMWebSyncConnectFailureArgs*) connectFailureArgs;
- (id) init;
/// <summary>
/// Gets whether the connect call was automatically
/// invoked following a stream failure.
/// </summary>
- (bool) isReconnect;
- (void) setIsReconnect:(bool)value;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;
@class FMWebSyncRecord;

/// <summary>
/// Arguments for bind failure callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBindFailureArgs : FMWebSyncBaseFailureArgs 

+ (FMWebSyncBindFailureArgs*) bindFailureArgs;
- (id) init;
/// <summary>
/// Gets whether the bind call was automatically
/// invoked following a stream failure.
/// </summary>
- (bool) isRebind;
/// <summary>
/// Gets the record key to which the client failed to be bound.
/// Overrides <see cref="FMWebSyncBindFailureArgs#keys" />, <see cref="FMWebSyncBindFailureArgs#record" />, and <see cref="FMWebSyncBindFailureArgs#records" />.
/// </summary>
- (NSString*) key;
/// <summary>
/// Gets the record keys to which the client failed to be bound.
/// Overrides <see cref="FMWebSyncBindFailureArgs#key" />, <see cref="FMWebSyncBindFailureArgs#record" />, and <see cref="FMWebSyncBindFailureArgs#records" />.
/// </summary>
- (NSMutableArray*) keys;
/// <summary>
/// Gets the record to which the client failed to be bound.
/// Overrides <see cref="FMWebSyncBindFailureArgs#records" />, <see cref="FMWebSyncBindFailureArgs#key" />, and <see cref="FMWebSyncBindFailureArgs#keys" />.
/// </summary>
- (FMWebSyncRecord*) record;
/// <summary>
/// Gets the records to which the client failed to be bound.
/// Overrides <see cref="FMWebSyncBindFailureArgs#record" />, <see cref="FMWebSyncBindFailureArgs#key" />, and <see cref="FMWebSyncBindFailureArgs#keys" />.
/// </summary>
- (NSMutableArray*) records;
- (void) setIsRebind:(bool)value;

@end


@class NSStringFMExtensions;
@class NSMutableDataFMExtensions;

/// <summary>
/// Arguments for service failure callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncServiceFailureArgs : FMWebSyncBaseFailureArgs 

/// <summary>
/// Gets the channel to which the data failed to be sent.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the data that failed to be sent in binary format.
/// </summary>
- (NSMutableData*) dataBytes;
/// <summary>
/// Gets the data that failed to be sent in JSON format.
/// </summary>
- (NSString*) dataJson;
- (id) init;
/// <summary>
/// Gets whether or not the data is binary.
/// </summary>
- (bool) isBinary;
+ (FMWebSyncServiceFailureArgs*) serviceFailureArgs;
/// <summary>
/// Gets the tag that identifies the contents of the payload.
/// </summary>
- (NSString*) tag;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;
@class FMWebSyncRecord;

/// <summary>
/// Arguments for unbind failure callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncUnbindFailureArgs : FMWebSyncBaseFailureArgs 

- (id) init;
/// <summary>
/// Gets the record key from which the client failed to be unbound.
/// Overrides <see cref="FMWebSyncUnbindFailureArgs#keys" />, <see cref="FMWebSyncUnbindFailureArgs#record" />, and <see cref="FMWebSyncUnbindFailureArgs#records" />.
/// </summary>
- (NSString*) key;
/// <summary>
/// Gets the record keys from which the client failed to be unbound.
/// Overrides <see cref="FMWebSyncUnbindFailureArgs#key" />, <see cref="FMWebSyncUnbindFailureArgs#record" />, and <see cref="FMWebSyncUnbindFailureArgs#records" />.
/// </summary>
- (NSMutableArray*) keys;
/// <summary>
/// Gets the record from which the client failed to be unbound.
/// Overrides <see cref="FMWebSyncUnbindFailureArgs#records" />, <see cref="FMWebSyncUnbindFailureArgs#key" />, and <see cref="FMWebSyncUnbindFailureArgs#keys" />.
/// </summary>
- (FMWebSyncRecord*) record;
/// <summary>
/// Gets the records from which the client failed to be unbound.
/// Overrides <see cref="FMWebSyncUnbindFailureArgs#record" />, <see cref="FMWebSyncUnbindFailureArgs#key" />, and <see cref="FMWebSyncUnbindFailureArgs#keys" />.
/// </summary>
- (NSMutableArray*) records;
+ (FMWebSyncUnbindFailureArgs*) unbindFailureArgs;

@end


@class FMWebSyncConnectArgs;

/// <summary>
/// Arguments for <see cref="FMWebSyncConnectArgs#onStreamFailure" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncStreamFailureArgs : FMWebSyncBaseFailureArgs 

/// <summary>
/// Gets the connect arguments to use
/// for the next connect attempt.
/// </summary>
- (FMWebSyncConnectArgs*) connectArgs;
- (id) init;
/// <summary>
/// Sets the connect arguments to use
/// for the next connect attempt.
/// </summary>
- (void) setConnectArgs:(FMWebSyncConnectArgs*)value;
+ (FMWebSyncStreamFailureArgs*) streamFailureArgs;

@end


@class NSStringFMExtensions;
@class NSMutableDataFMExtensions;

/// <summary>
/// Arguments for publish failure callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublishFailureArgs : FMWebSyncBaseFailureArgs 

/// <summary>
/// Gets the channel to which the data failed to be sent.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the data that failed to be sent in binary format.
/// </summary>
- (NSMutableData*) dataBytes;
/// <summary>
/// Gets the data that failed to be sent in JSON format.
/// </summary>
- (NSString*) dataJson;
- (id) init;
/// <summary>
/// Gets whether or not the data is binary.
/// </summary>
- (bool) isBinary;
+ (FMWebSyncPublishFailureArgs*) publishFailureArgs;
/// <summary>
/// Gets the tag that identifies the contents of the payload.
/// </summary>
- (NSString*) tag;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for subscribe failure callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribeFailureArgs : FMWebSyncBaseFailureArgs 

/// <summary>
/// Gets the channel to which the client failed to be subscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncSubscribeFailureArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels to which the client failed to be subscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncSubscribeFailureArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
- (id) init;
/// <summary>
/// Gets whether the subscribe call was automatically
/// invoked following a stream failure.
/// </summary>
- (bool) isResubscribe;
- (void) setIsResubscribe:(bool)value;
+ (FMWebSyncSubscribeFailureArgs*) subscribeFailureArgs;
/// <summary>
/// Gets the tag associated with the subscribe request.
/// </summary>
- (NSString*) tag;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for unsubscribe failure callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncUnsubscribeFailureArgs : FMWebSyncBaseFailureArgs 

/// <summary>
/// Gets the channel from which the client failed to be unsubscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncUnsubscribeFailureArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels from which the client failed to be unsubscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncUnsubscribeFailureArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
- (id) init;
/// <summary>
/// Gets the tag associated with the subscribe request.
/// </summary>
- (NSString*) tag;
+ (FMWebSyncUnsubscribeFailureArgs*) unsubscribeFailureArgs;

@end



/// <summary>
/// Arguments for connect success callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncConnectSuccessArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets the connection type of the stream.
/// </summary>
- (FMWebSyncConnectionType) connectionType;
+ (FMWebSyncConnectSuccessArgs*) connectSuccessArgs;
- (id) init;
/// <summary>
/// Gets whether the connect call was automatically
/// invoked following a stream failure.
/// </summary>
- (bool) isReconnect;
- (void) setConnectionType:(FMWebSyncConnectionType)value;
- (void) setIsReconnect:(bool)value;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;
@class FMWebSyncRecord;

/// <summary>
/// Arguments for bind success callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBindSuccessArgs : FMWebSyncBaseSuccessArgs 

+ (FMWebSyncBindSuccessArgs*) bindSuccessArgs;
- (id) init;
/// <summary>
/// Gets whether the bind call was automatically
/// invoked following a stream failure.
/// </summary>
- (bool) isRebind;
/// <summary>
/// Gets the record key to which the client was bound.
/// Overrides <see cref="FMWebSyncBindSuccessArgs#keys" />, <see cref="FMWebSyncBindSuccessArgs#record" />, and <see cref="FMWebSyncBindSuccessArgs#records" />.
/// </summary>
- (NSString*) key;
/// <summary>
/// Gets the record keys to which the client was bound.
/// Overrides <see cref="FMWebSyncBindSuccessArgs#key" />, <see cref="FMWebSyncBindSuccessArgs#record" />, and <see cref="FMWebSyncBindSuccessArgs#records" />.
/// </summary>
- (NSMutableArray*) keys;
/// <summary>
/// Gets the record to which the client was bound.
/// Overrides <see cref="FMWebSyncBindSuccessArgs#records" />, <see cref="FMWebSyncBindSuccessArgs#key" />, and <see cref="FMWebSyncBindSuccessArgs#keys" />.
/// </summary>
- (FMWebSyncRecord*) record;
/// <summary>
/// Gets the records to which the client was bound.
/// Overrides <see cref="FMWebSyncBindSuccessArgs#record" />, <see cref="FMWebSyncBindSuccessArgs#key" />, and <see cref="FMWebSyncBindSuccessArgs#keys" />.
/// </summary>
- (NSMutableArray*) records;
- (void) setIsRebind:(bool)value;

@end


@class NSStringFMExtensions;
@class NSMutableDataFMExtensions;

/// <summary>
/// Arguments for service success callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncServiceSuccessArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets the channel to which the data was sent.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the data that was sent in binary format.
/// </summary>
- (NSMutableData*) dataBytes;
/// <summary>
/// Gets the data that was sent in JSON format.
/// </summary>
- (NSString*) dataJson;
- (id) init;
/// <summary>
/// Gets whether or not the data is binary.
/// </summary>
- (bool) isBinary;
+ (FMWebSyncServiceSuccessArgs*) serviceSuccessArgs;
/// <summary>
/// Gets the tag that identifies the contents of the payload.
/// </summary>
- (NSString*) tag;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;
@class FMWebSyncRecord;

/// <summary>
/// Arguments for unbind success callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncUnbindSuccessArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets whether this unbind was forced due to a disconnect.
/// </summary>
- (bool) forced;
- (id) init;
/// <summary>
/// Gets the record key from which the client was unbound.
/// Overrides <see cref="FMWebSyncUnbindSuccessArgs#keys" />, <see cref="FMWebSyncUnbindSuccessArgs#record" />, and <see cref="FMWebSyncUnbindSuccessArgs#records" />.
/// </summary>
- (NSString*) key;
/// <summary>
/// Gets the record keys from which the client was unbound.
/// Overrides <see cref="FMWebSyncUnbindSuccessArgs#key" />, <see cref="FMWebSyncUnbindSuccessArgs#record" />, and <see cref="FMWebSyncUnbindSuccessArgs#records" />.
/// </summary>
- (NSMutableArray*) keys;
/// <summary>
/// Gets the record from which the client was unbound.
/// Overrides <see cref="FMWebSyncUnbindSuccessArgs#records" />, <see cref="FMWebSyncUnbindSuccessArgs#key" />, and <see cref="FMWebSyncUnbindSuccessArgs#keys" />.
/// </summary>
- (FMWebSyncRecord*) record;
/// <summary>
/// Gets the records from which the client was unbound.
/// Overrides <see cref="FMWebSyncUnbindSuccessArgs#record" />, <see cref="FMWebSyncUnbindSuccessArgs#key" />, and <see cref="FMWebSyncUnbindSuccessArgs#keys" />.
/// </summary>
- (NSMutableArray*) records;
+ (FMWebSyncUnbindSuccessArgs*) unbindSuccessArgs;

@end


@class NSStringFMExtensions;
@class NSMutableDataFMExtensions;

/// <summary>
/// Arguments for publish success callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublishSuccessArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets the channel to which the data was sent.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the data that was sent in binary format.
/// </summary>
- (NSMutableData*) dataBytes;
/// <summary>
/// Gets the data that was sent in JSON format.
/// </summary>
- (NSString*) dataJson;
- (id) init;
/// <summary>
/// Gets whether or not the data is binary.
/// </summary>
- (bool) isBinary;
+ (FMWebSyncPublishSuccessArgs*) publishSuccessArgs;
/// <summary>
/// Gets the tag that identifies the contents of the payload.
/// </summary>
- (NSString*) tag;

@end


@class NSStringFMExtensions;
@class NSMutableDataFMExtensions;
@class FMWebSyncPublishingClient;

/// <summary>
/// Arguments for <see cref="FMWebSyncSubscribeArgs#onReceive" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribeReceiveArgs : FMWebSyncBaseReceiveArgs 

/// <summary>
/// Gets the channel over which the data was published.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribeReceiveArgs" /> class.
/// </summary>
/// <param name="channel">The channel over which data was received.</param>
/// <param name="dataJson">The data in JSON format.</param>
/// <param name="dataBytes">The data in binary format.</param>
/// <param name="connectionType">The current connection type.</param>
/// <param name="reconnectAfter">The amount of time in milliseconds to pause before reconnecting to the server.</param>
- (id) initWithChannel:(NSString*)channel dataJson:(NSString*)dataJson dataBytes:(NSMutableData*)dataBytes connectionType:(FMWebSyncConnectionType)connectionType reconnectAfter:(int)reconnectAfter;
/// <summary>
/// Gets details about the client sending the publication.
/// </summary>
- (FMWebSyncPublishingClient*) publishingClient;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribeReceiveArgs" /> class.
/// </summary>
/// <param name="channel">The channel over which data was received.</param>
/// <param name="dataJson">The data in JSON format.</param>
/// <param name="dataBytes">The data in binary format.</param>
/// <param name="connectionType">The current connection type.</param>
/// <param name="reconnectAfter">The amount of time in milliseconds to pause before reconnecting to the server.</param>
+ (FMWebSyncSubscribeReceiveArgs*) subscribeReceiveArgsWithChannel:(NSString*)channel dataJson:(NSString*)dataJson dataBytes:(NSMutableData*)dataBytes connectionType:(FMWebSyncConnectionType)connectionType reconnectAfter:(int)reconnectAfter;
/// <summary>
/// Gets whether the data was sent by the current client.
/// </summary>
- (bool) wasSentByMe;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for subscribe success callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribeSuccessArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets the channel to which the client was subscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncSubscribeSuccessArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels to which the client was subscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncSubscribeSuccessArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
- (id) init;
/// <summary>
/// Gets whether the subscribe call was automatically
/// invoked following a stream failure.
/// </summary>
- (bool) isResubscribe;
- (void) setIsResubscribe:(bool)value;
+ (FMWebSyncSubscribeSuccessArgs*) subscribeSuccessArgs;
/// <summary>
/// Gets the tag associated with the subscribe request.
/// </summary>
- (NSString*) tag;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for unsubscribe success callbacks.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncUnsubscribeSuccessArgs : FMWebSyncBaseSuccessArgs 

/// <summary>
/// Gets the channel from which the client was unsubscribed.
/// Must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncUnsubscribeSuccessArgs#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels from which the client was unsubscribed.
/// Each must start with a forward slash (/).
/// Overrides <see cref="FMWebSyncUnsubscribeSuccessArgs#channel" />.
/// </summary>
- (NSMutableArray*) channels;
/// <summary>
/// Gets whether this unsubscribe was forced due to a disconnect.
/// </summary>
- (bool) forced;
- (id) init;
/// <summary>
/// Gets the tag associated with the subscribe request.
/// </summary>
- (NSString*) tag;
+ (FMWebSyncUnsubscribeSuccessArgs*) unsubscribeSuccessArgs;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncPublisher#addOnPublishResponse:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublisherPublishResponseArgs : FMWebSyncBasePublisherResponseEventArgsGeneric 

- (id) init;
+ (FMWebSyncPublisherPublishResponseArgs*) publisherPublishResponseArgs;

@end



/// <summary>
/// Arguments for <see cref="FMWebSyncPublisher#addOnPublishRequest:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublisherPublishRequestArgs : FMWebSyncBasePublisherRequestEventArgsGeneric 

- (id) init;
+ (FMWebSyncPublisherPublishRequestArgs*) publisherPublishRequestArgs;

@end


@class FMWebSyncConnectArgs;

#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncDeferredRetryConnectState : NSObject 

- (int) backoffTimeout;
- (FMWebSyncConnectArgs*) connectArgs;
+ (FMWebSyncDeferredRetryConnectState*) deferredRetryConnectState;
- (id) init;
- (void) setBackoffTimeout:(int)value;
- (void) setConnectArgs:(FMWebSyncConnectArgs*)value;

@end


@class FMWebSyncConnectArgs;

#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncDeferredStreamState : NSObject 

- (FMWebSyncConnectArgs*) connectArgs;
+ (FMWebSyncDeferredStreamState*) deferredStreamState;
- (id) init;
- (bool) receivedMessages;
- (void) setConnectArgs:(FMWebSyncConnectArgs*)value;
- (void) setReceivedMessages:(bool)value;

@end


@class NSExceptionFMExtensions;
@class FMWebSyncPublisher;
@class FMCallback;
@class NSMutableArrayFMExtensions;
@class FMManagedCondition;
@class FMManagedThread;
@class FMWebSyncPublication;

/// <summary>
/// A thread-safe publisher queue that ensures synchronous
/// delivery of publications from anywhere in your application
/// while optimizing network resource consumption.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublisherQueue : NSObject 

/// <summary>
/// Adds a handler that is raised when an exception is thrown while publishing.
/// </summary>
- (FMCallback*) addExceptionWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised when an exception is thrown while publishing.
/// </summary>
- (FMCallback*) addException:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised when an exception is thrown while publishing.
/// </summary>
- (FMCallback*) addExceptionWithValueBlock:(void (^) (NSException*))valueBlock;
/// <summary>
/// Adds a handler that is raised when an exception is thrown while publishing.
/// </summary>
- (FMCallback*) addExceptionBlock:(void (^) (NSException*))valueBlock;
/// <summary>
/// Adds a publication to the queue.
/// </summary>
/// <param name="publication">The publication to add.</param>
- (void) addPublicationWithPublication:(FMWebSyncPublication*)publication;
/// <summary>
/// Adds a publication to the queue.
/// </summary>
/// <param name="publication">The publication to add.</param>
- (void) addPublication:(FMWebSyncPublication*)publication;
/// <summary>
/// Adds a handler that is raised immediately after a Publish call has been made.
/// </summary>
- (FMCallback*) addPublishedWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised immediately after a Publish call has been made.
/// </summary>
- (FMCallback*) addPublished:(FMCallback*)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublisherQueue" /> class.
/// </summary>
/// <param name="publisher">The publisher to use for sending messages to the WebSync server.</param>
- (id) initWithPublisher:(FMWebSyncPublisher*)publisher;
/// <summary>
/// Gets the maximum number of publications that
/// will be transferred to a server in one HTTP request.
/// A MaxBatchSize of 0 or less will remove the maximum
/// limit, and all queued publications will be sent every
/// time. Defaults to 1000.
/// </summary>
- (int) maxBatchSize;
/// <summary>
/// Gets the <see cref="FMWebSyncPublisherQueue#publisher" /> used by the queue.
/// </summary>
- (FMWebSyncPublisher*) publisher;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublisherQueue" /> class.
/// </summary>
/// <param name="publisher">The publisher to use for sending messages to the WebSync server.</param>
+ (FMWebSyncPublisherQueue*) publisherQueueWithPublisher:(FMWebSyncPublisher*)publisher;
/// <summary>
/// Removes a handler that is raised when an exception is thrown while publishing.
/// </summary>
- (void) removeExceptionWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised when an exception is thrown while publishing.
/// </summary>
- (void) removeException:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised immediately after a Publish call has been made.
/// </summary>
- (void) removePublishedWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised immediately after a Publish call has been made.
/// </summary>
- (void) removePublished:(FMCallback*)value;
/// <summary>
/// Sets the maximum number of publications that
/// will be transferred to a server in one HTTP request.
/// A MaxBatchSize of 0 or less will remove the maximum
/// limit, and all queued publications will be sent every
/// time. Defaults to 1000.
/// </summary>
- (void) setMaxBatchSize:(int)value;
/// <summary>
/// Starts the queue's internal thread.
/// </summary>
- (void) start;
/// <summary>
/// Stops the queue's internal thread.
/// </summary>
- (void) stop;

@end


@class FMWebSyncMessageTransfer;
@class NSStringFMExtensions;
@class FMWebSyncWebSocketMessageTransfer;
@class FMCallback;

/// <summary>
/// Creates implementations of <see cref="FMWebSyncMessageTransfer" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncMessageTransferFactory : NSObject 

/// <summary>
/// Gets the callback that creates an HTTP-based message transfer class.
/// </summary>
+ (FMCallback*) createHttpMessageTransfer;
/// <summary>
/// Gets the callback that creates a WebSocket-based message transfer class.
/// </summary>
+ (FMCallback*) createWebSocketMessageTransfer;
+ (FMWebSyncMessageTransfer*) defaultCreateHttpMessageTransfer;
+ (FMWebSyncWebSocketMessageTransfer*) defaultCreateWebSocketMessageTransferWithRequestUrl:(NSString*)requestUrl;
/// <summary>
/// Gets an instance of the HTTP-based message transfer class.
/// </summary>
/// <returns></returns>
+ (FMWebSyncMessageTransfer*) getHttpMessageTransfer;
/// <summary>
/// Gets an instance of the WebSocket-based message transfer class.
/// </summary>
/// <returns></returns>
+ (FMWebSyncWebSocketMessageTransfer*) getWebSocketMessageTransferWithRequestUrl:(NSString*)requestUrl;
- (id) init;
+ (FMWebSyncMessageTransferFactory*) messageTransferFactory;
/// <summary>
/// Sets the callback that creates an HTTP-based message transfer class.
/// </summary>
+ (void) setCreateHttpMessageTransfer:(FMCallback*)value;
/// <summary>
/// Sets the callback that creates an HTTP-based message transfer class.
/// </summary>
+ (void) setCreateHttpMessageTransferBlock:(FMWebSyncMessageTransfer* (^) (void))valueBlock;
/// <summary>
/// Sets the callback that creates a WebSocket-based message transfer class.
/// </summary>
+ (void) setCreateWebSocketMessageTransfer:(FMCallback*)value;
/// <summary>
/// Sets the callback that creates a WebSocket-based message transfer class.
/// </summary>
+ (void) setCreateWebSocketMessageTransferBlock:(FMWebSyncWebSocketMessageTransfer* (^) (NSString*))valueBlock;

@end


@class FMWebSyncMessageResponseArgs;
@class NSStringFMExtensions;
@class FMHttpResponseArgs;
@class FMHttpRequestArgs;
@class FMWebSyncMessageRequestArgs;
@class FMCallback;

/// <summary>
/// Base class that defines methods for transferring messages over HTTP.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncMessageTransfer : NSObject 

/// <summary>
/// Converts an <see cref="FMHttpResponseArgs" /> to a <see cref="FMWebSyncMessageRequestArgs" />.
/// </summary>
/// <param name="httpResponseArgs">The HTTP response arguments.</param>
/// <returns></returns>
- (FMWebSyncMessageResponseArgs*) httpResponseArgsToMessageResponseArgsWithHttpResponseArgs:(FMHttpResponseArgs*)httpResponseArgs;
- (id) init;
/// <summary>
/// Converts a <see cref="FMWebSyncMessageRequestArgs" /> to an <see cref="FMHttpRequestArgs" />.
/// </summary>
/// <param name="requestArgs">The request arguments.</param>
/// <returns></returns>
- (FMHttpRequestArgs*) messageRequestArgsToHttpRequestArgsWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs;
/// <summary>
/// Converts a <see cref="FMWebSyncMessageRequestArgs" /> to an <see cref="FMHttpRequestArgs" />.
/// </summary>
/// <param name="requestArgs">The request arguments.</param>
/// <returns></returns>
- (FMHttpRequestArgs*) messageRequestArgsToHttpRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs;
+ (FMWebSyncMessageTransfer*) messageTransfer;
/// <summary>
/// Sends messages asynchronously.
/// </summary>
/// <param name="requestArgs">The message parameters.</param>
/// <param name="callback">The callback to execute with the resulting response.</param>
- (void) sendAsyncWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs callback:(FMCallback*)callback;
/// <summary>
/// Sends messages asynchronously.
/// </summary>
/// <param name="requestArgs">The message parameters.</param>
/// <param name="callback">The callback to execute with the resulting response.</param>
- (void) sendAsyncWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs callbackBlock:(void (^) (FMWebSyncMessageResponseArgs*))callbackBlock;
/// <summary>
/// Sends a request asynchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <param name="callback">The callback to execute with the response parameters.</param>
- (void) sendMessagesAsyncWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs callback:(FMCallback*)callback;
/// <summary>
/// Sends a request asynchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <param name="callback">The callback to execute with the response parameters.</param>
- (void) sendMessagesAsyncWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs callbackBlock:(void (^) (FMWebSyncMessageResponseArgs*))callbackBlock;
/// <summary>
/// Sends a request synchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <returns>The response parameters.</returns>
- (FMWebSyncMessageResponseArgs*) sendMessagesWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs;
/// <summary>
/// Sends messages synchronously.
/// </summary>
/// <param name="requestArgs">The message parameters.</param>
/// <returns>The resulting response.</returns>
- (FMWebSyncMessageResponseArgs*) sendWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs;
/// <summary>
/// Releases any resources and shuts down.
/// </summary>
- (void) shutdown;

@end


@class FMWebSyncMessageResponseArgs;
@class NSStringFMExtensions;
@class FMHttpTransfer;
@class FMWebSyncMessageRequestArgs;
@class FMCallback;

/// <summary>
/// Defines methods for transferring messages using an instance of <see cref="FMHttpWebRequestTransfer" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncHttpMessageTransfer : FMWebSyncMessageTransfer 

/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncHttpMessageTransfer" /> class.
/// </summary>
+ (FMWebSyncHttpMessageTransfer*) httpMessageTransfer;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncHttpMessageTransfer" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Sends a request asynchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <param name="callback">The callback to execute with the resulting response.</param>
- (void) sendMessagesAsyncWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs callback:(FMCallback*)callback;
/// <summary>
/// Sends a request asynchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <param name="callback">The callback to execute with the resulting response.</param>
- (void) sendMessagesAsyncWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs callbackBlock:(void (^) (FMWebSyncMessageResponseArgs*))callbackBlock;
/// <summary>
/// Sends a request synchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <returns>The response parameters.</returns>
- (FMWebSyncMessageResponseArgs*) sendMessagesWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs;
/// <summary>
/// Releases any resources and shuts down.
/// </summary>
- (void) shutdown;

@end


@class NSMutableDictionaryFMExtensions;
@class FMNullableGuid;
@class NSStringFMExtensions;

/// <summary>
/// Details about the client sending the notification data.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncNotifyingClient : FMSerializable 

/// <summary>
/// Gets the notifying client's bound records.
/// </summary>
- (NSMutableDictionary*) boundRecords;
/// <summary>
/// Gets the notifying client's ID.
/// </summary>
- (FMNullableGuid*) clientId;
/// <summary>
/// Deserializes a JSON-formatted notifying client.
/// </summary>
/// <param name="notifyingClientJson">The JSON-formatted notifying client to deserialize.</param>
/// <returns>The notifying client.</returns>
+ (FMWebSyncNotifyingClient*) fromJsonWithNotifyingClientJson:(NSString*)notifyingClientJson;
/// <summary>
/// Gets the JSON value of a record bound to the notifying client.
/// </summary>
/// <param name="key">The record key.</param>
/// <returns>The JSON value of the record, if it exists, or <c>null</c>.</returns>
- (NSString*) getBoundRecordValueJsonWithKey:(NSString*)key;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyingClient" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyingClient" /> class.
/// </summary>
/// <param name="clientId">The notifying client's ID.</param>
/// <param name="boundRecords">The records bound to the client.</param>
- (id) initWithClientId:(FMNullableGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyingClient" /> class.
/// </summary>
+ (FMWebSyncNotifyingClient*) notifyingClient;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyingClient" /> class.
/// </summary>
/// <param name="clientId">The notifying client's ID.</param>
/// <param name="boundRecords">The records bound to the client.</param>
+ (FMWebSyncNotifyingClient*) notifyingClientWithClientId:(FMNullableGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncNotifyingClient" /> class.
/// </summary>
/// <param name="clientId">The notifying client's ID.</param>
/// <param name="boundRecords">The records bound to the client.</param>
+ (FMWebSyncNotifyingClient*) notifyingClientWithId:(FMNullableGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Sets the notifying client's bound records.
/// </summary>
- (void) setBoundRecords:(NSMutableDictionary*)value;
/// <summary>
/// Sets the notifying client's ID.
/// </summary>
- (void) setClientId:(FMNullableGuid*)value;
/// <summary>
/// Serializes this instance to JSON.
/// </summary>
/// <returns>The JSON-formatted notifying client.</returns>
- (NSString*) toJson;
/// <summary>
/// Serializes a notifying client to JSON.
/// </summary>
/// <param name="notifyingClient">The notifying client to serialize.</param>
/// <returns>The JSON-formatted notifying client.</returns>
+ (NSString*) toJsonWithNotifyingClient:(FMWebSyncNotifyingClient*)notifyingClient;

@end


@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;
@class FMNullableDate;

/// <summary>
/// Base class for WebSync client/publisher messages.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseMessage : FMWebSyncExtensible 

/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBaseMessage" /> class.
/// </summary>
+ (FMWebSyncBaseMessage*) baseMessage;
/// <summary>
/// Gets the data payload
/// in binary format. (Overrides <see cref="FMWebSyncBaseMessage#dataJson" />.)
/// </summary>
- (NSMutableData*) dataBytes;
/// <summary>
/// Gets the data payload
/// in JSON format. (Overrides <see cref="FMWebSyncBaseMessage#dataBytes" />.)
/// </summary>
- (NSString*) dataJson;
/// <summary>
/// Gets the friendly error message if <see cref="FMWebSyncBaseMessage#successful" /> is
/// <c>false</c>.
/// </summary>
- (NSString*) error;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBaseMessage" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Gets whether or not the data is binary.
/// </summary>
- (bool) isBinary;
/// <summary>
/// Sets the data payload
/// in binary format. (Overrides <see cref="FMWebSyncBaseMessage#dataJson" />.)
/// </summary>
- (void) setDataBytes:(NSMutableData*)value;
/// <summary>
/// Sets the data payload
/// in JSON format. (Overrides <see cref="FMWebSyncBaseMessage#dataBytes" />.)
/// </summary>
- (void) setDataJson:(NSString*)value;
/// <summary>
/// Sets the friendly error message if <see cref="FMWebSyncBaseMessage#successful" /> is
/// <c>false</c>.
/// </summary>
- (void) setError:(NSString*)value;
/// <summary>
/// Sets the flag that indicates whether the request should be
/// processed. If the message represents a response, this indicates whether the
/// processing was successful. If set to <c>false</c>, the <see cref="FMWebSyncBaseMessage#error" />
/// property should be set to a friendly error message.
/// </summary>
- (void) setSuccessful:(bool)value;
/// <summary>
/// Sets the date/time the message was processed on the server (in UTC/GMT).
/// </summary>
- (void) setTimestamp:(FMNullableDate*)value;
/// <summary>
/// Sets whether to skip validation while deserializing, used internally.
/// </summary>
- (void) setValidate:(bool)value;
/// <summary>
/// Gets the flag that indicates whether the request should be
/// processed. If the message represents a response, this indicates whether the
/// processing was successful. If set to <c>false</c>, the <see cref="FMWebSyncBaseMessage#error" />
/// property should be set to a friendly error message.
/// </summary>
- (bool) successful;
/// <summary>
/// Gets the date/time the message was processed on the server (in UTC/GMT).
/// </summary>
- (FMNullableDate*) timestamp;
/// <summary>
/// Gets whether to skip validation while deserializing, used internally.
/// </summary>
- (bool) validate;

@end


@class FMGuid;
@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;
@class FMWebSyncMessage;
@class NSMutableDataFMExtensions;

/// <summary>
/// The WebSync notification used for direct notifying.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncNotification : FMWebSyncBaseMessage 

/// <summary>
/// Gets the client ID the publisher is targeting.
/// </summary>
- (FMGuid*) clientId;
/// <summary>
/// Deserializes a list of notifications from JSON.
/// </summary>
/// <param name="notificationsJson">A JSON string to deserialize.</param>
/// <returns>A deserialized list of notifications.</returns>
+ (NSMutableArray*) fromJsonMultipleWithNotificationsJson:(NSString*)notificationsJson;
/// <summary>
/// Deserializes a notification from JSON.
/// </summary>
/// <param name="notificationJson">A JSON string to deserialize.</param>
/// <returns>A deserialized notification.</returns>
+ (FMWebSyncNotification*) fromJsonWithNotificationJson:(NSString*)notificationJson;
/// <summary>
/// Converts a set of Notifications from their Message formats.
/// </summary>
/// <param name="messages">The messages.</param>
/// <returns>The notifications.</returns>
+ (NSMutableArray*) fromMessagesWithMessages:(NSMutableArray*)messages;
/// <summary>
/// Converts a set of Notifications from their Message formats.
/// </summary>
/// <param name="messages">The messages.</param>
/// <returns>The notifications.</returns>
+ (NSMutableArray*) fromMessages:(NSMutableArray*)messages;
/// <summary>
/// Converts a Notification from its Message format.
/// </summary>
/// <param name="message">The message.</param>
/// <returns>The notification.</returns>
+ (FMWebSyncNotification*) fromMessageWithMessage:(FMWebSyncMessage*)message;
/// <summary>
/// Converts a Notification from its Message format.
/// </summary>
/// <param name="message">The message.</param>
/// <returns>The notification.</returns>
+ (FMWebSyncNotification*) fromMessage:(FMWebSyncMessage*)message;
/// <summary>
/// Creates a new notification.
/// </summary>
- (id) init;
/// <summary>
/// Creates a new notification with a client ID.
/// </summary>
/// <param name="clientId">The client ID to target.</param>
- (id) initWithClientId:(FMGuid*)clientId;
/// <summary>
/// Creates a new notification with a client ID and JSON data.
/// </summary>
/// <param name="clientId">The client ID to target.</param>
/// <param name="dataBytes">The data to send (in binary format).</param>
- (id) initWithClientId:(FMGuid*)clientId dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Creates a new notification with a client ID and JSON data.
/// </summary>
/// <param name="clientId">The client ID to target.</param>
/// <param name="dataBytes">The data to send (in binary format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
- (id) initWithClientId:(FMGuid*)clientId dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Creates a new notification with a client ID and JSON data.
/// </summary>
/// <param name="clientId">The client ID to target.</param>
/// <param name="dataJson">The data to send (in JSON format).</param>
- (id) initWithClientId:(FMGuid*)clientId dataJson:(NSString*)dataJson;
/// <summary>
/// Creates a new notification with a client ID and JSON data.
/// </summary>
/// <param name="clientId">The client ID to target.</param>
/// <param name="dataJson">The data to send (in JSON format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
- (id) initWithClientId:(FMGuid*)clientId dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Creates a new notification.
/// </summary>
+ (FMWebSyncNotification*) notification;
/// <summary>
/// Creates a new notification with a client ID.
/// </summary>
/// <param name="clientId">The client ID to target.</param>
+ (FMWebSyncNotification*) notificationWithClientId:(FMGuid*)clientId;
/// <summary>
/// Creates a new notification with a client ID and JSON data.
/// </summary>
/// <param name="clientId">The client ID to target.</param>
/// <param name="dataBytes">The data to send (in binary format).</param>
+ (FMWebSyncNotification*) notificationWithClientId:(FMGuid*)clientId dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Creates a new notification with a client ID and JSON data.
/// </summary>
/// <param name="clientId">The client ID to target.</param>
/// <param name="dataBytes">The data to send (in binary format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
+ (FMWebSyncNotification*) notificationWithClientId:(FMGuid*)clientId dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Creates a new notification with a client ID and JSON data.
/// </summary>
/// <param name="clientId">The client ID to target.</param>
/// <param name="dataJson">The data to send (in JSON format).</param>
+ (FMWebSyncNotification*) notificationWithClientId:(FMGuid*)clientId dataJson:(NSString*)dataJson;
/// <summary>
/// Creates a new notification with a client ID and JSON data.
/// </summary>
/// <param name="clientId">The client ID to target.</param>
/// <param name="dataJson">The data to send (in JSON format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
+ (FMWebSyncNotification*) notificationWithClientId:(FMGuid*)clientId dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Sets the client ID the publisher is targeting.
/// </summary>
- (void) setClientId:(FMGuid*)value;
/// <summary>
/// Sets the tag that identifies the contents of the payload.
/// </summary>
- (void) setTag:(NSString*)value;
/// <summary>
/// Gets the tag that identifies the contents of the payload.
/// </summary>
- (NSString*) tag;
/// <summary>
/// Serializes the notification to JSON.
/// </summary>
/// <returns>The notification in JSON-serialized format.</returns>
- (NSString*) toJson;
/// <summary>
/// Serializes a list of notifications to JSON.
/// </summary>
/// <param name="notifications">A list of notifications to serialize.</param>
/// <returns>A JSON-serialized array of notifications.</returns>
+ (NSString*) toJsonMultipleWithNotifications:(NSMutableArray*)notifications;
/// <summary>
/// Serializes a notification to JSON.
/// </summary>
/// <param name="notification">A notification to serialize.</param>
/// <returns>A JSON-serialized notification.</returns>
+ (NSString*) toJsonWithNotification:(FMWebSyncNotification*)notification;
/// <summary>
/// Converts a set of Notifications to their Message formats.
/// </summary>
/// <param name="notifications">The notifications.</param>
/// <returns>The messages.</returns>
+ (NSMutableArray*) toMessagesWithNotifications:(NSMutableArray*)notifications;
/// <summary>
/// Converts a Notification to its Message format.
/// </summary>
/// <param name="notification">The notification.</param>
/// <returns>The message.</returns>
+ (FMWebSyncMessage*) toMessageWithNotification:(FMWebSyncNotification*)notification;

@end


@class NSExceptionFMExtensions;
@class NSMutableArrayFMExtensions;
@class FMWebSyncMessage;

#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublisherResponseArgs : NSObject 

- (NSException*) exception;
- (id) init;
+ (FMWebSyncPublisherResponseArgs*) publisherResponseArgs;
- (FMWebSyncMessage*) response;
- (NSMutableArray*) responses;
- (void) setException:(NSException*)value;
- (void) setResponse:(FMWebSyncMessage*)value;
- (void) setResponses:(NSMutableArray*)value;

@end


@class FMWebSyncUnhandledExceptionArgs;
@class FMWebSyncMessageRequestCreatedArgs;
@class FMWebSyncMessageResponseReceivedArgs;
@class FMHttpRequestCreatedArgs;
@class FMHttpResponseReceivedArgs;
@class NSStringFMExtensions;
@class FMGuid;
@class FMCallback;
@class FMNameValueCollection;
@class NSExceptionFMExtensions;

/// <summary>
/// Base class for WebSync clients and publishers.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseClient : FMDynamic 

/// <summary>
/// Adds a handler that is raised whenever an underlying HTTP request
/// has been created and is about to be transferred to the server. This is a
/// good place to add headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (FMCallback*) addOnHttpRequestCreatedWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever an underlying HTTP request
/// has been created and is about to be transferred to the server. This is a
/// good place to add headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (FMCallback*) addOnHttpRequestCreated:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever an underlying HTTP request
/// has been created and is about to be transferred to the server. This is a
/// good place to add headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (FMCallback*) addOnHttpRequestCreatedWithValueBlock:(void (^) (FMHttpRequestCreatedArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever an underlying HTTP request
/// has been created and is about to be transferred to the server. This is a
/// good place to add headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (FMCallback*) addOnHttpRequestCreatedBlock:(void (^) (FMHttpRequestCreatedArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever an underlying HTTP response
/// has been received and is about to be processed by the client. This is a
/// good place to read headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (FMCallback*) addOnHttpResponseReceivedWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever an underlying HTTP response
/// has been received and is about to be processed by the client. This is a
/// good place to read headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (FMCallback*) addOnHttpResponseReceived:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever an underlying HTTP response
/// has been received and is about to be processed by the client. This is a
/// good place to read headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (FMCallback*) addOnHttpResponseReceivedWithValueBlock:(void (^) (FMHttpResponseReceivedArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever an underlying HTTP response
/// has been received and is about to be processed by the client. This is a
/// good place to read headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (FMCallback*) addOnHttpResponseReceivedBlock:(void (^) (FMHttpResponseReceivedArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a new request is created
/// and about to be transferred to the server. This is a good place to read
/// or modify outgoing messages.
/// </summary>
- (FMCallback*) addOnRequestCreatedWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a new request is created
/// and about to be transferred to the server. This is a good place to read
/// or modify outgoing messages.
/// </summary>
- (FMCallback*) addOnRequestCreated:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a new request is created
/// and about to be transferred to the server. This is a good place to read
/// or modify outgoing messages.
/// </summary>
- (FMCallback*) addOnRequestCreatedWithValueBlock:(void (^) (FMWebSyncMessageRequestCreatedArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a new request is created
/// and about to be transferred to the server. This is a good place to read
/// or modify outgoing messages.
/// </summary>
- (FMCallback*) addOnRequestCreatedBlock:(void (^) (FMWebSyncMessageRequestCreatedArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a new response is received
/// and about to be processed by the client. This is a good place to read
/// or modify incoming messages.
/// </summary>
- (FMCallback*) addOnResponseReceivedWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a new response is received
/// and about to be processed by the client. This is a good place to read
/// or modify incoming messages.
/// </summary>
- (FMCallback*) addOnResponseReceived:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a new response is received
/// and about to be processed by the client. This is a good place to read
/// or modify incoming messages.
/// </summary>
- (FMCallback*) addOnResponseReceivedWithValueBlock:(void (^) (FMWebSyncMessageResponseReceivedArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a new response is received
/// and about to be processed by the client. This is a good place to read
/// or modify incoming messages.
/// </summary>
- (FMCallback*) addOnResponseReceivedBlock:(void (^) (FMWebSyncMessageResponseReceivedArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised when an exception is thrown in user code and not handled,
/// typically in a callback or event handler.
/// </summary>
- (FMCallback*) addOnUnhandledExceptionWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised when an exception is thrown in user code and not handled,
/// typically in a callback or event handler.
/// </summary>
- (FMCallback*) addOnUnhandledException:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised when an exception is thrown in user code and not handled,
/// typically in a callback or event handler.
/// </summary>
- (FMCallback*) addOnUnhandledExceptionWithValueBlock:(void (^) (FMWebSyncUnhandledExceptionArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised when an exception is thrown in user code and not handled,
/// typically in a callback or event handler.
/// </summary>
- (FMCallback*) addOnUnhandledExceptionBlock:(void (^) (FMWebSyncUnhandledExceptionArgs*))valueBlock;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBaseClient" /> class.
/// </summary>
+ (FMWebSyncBaseClient*) baseClient;
/// <summary>
/// Gets a flag indicating the level of concurrency in the current process.
/// The intended use of this property is to lighten the processor load when hundreds
/// or thousands of instances are created in a single process for the purposes of
/// generating load for testing.
/// </summary>
- (FMWebSyncConcurrencyMode) concurrencyMode;
/// <summary>
/// Creates an initial set of headers, including
/// the domain key and domain name.
/// </summary>
/// <returns></returns>
- (FMNameValueCollection*) createHeaders;
/// <summary>
/// Gets whether to disable the transmission of binary payloads
/// as binary on the wire. If set to <c>true</c>, binary payloads will
/// be sent over the wire as base64-encoded strings.
/// </summary>
- (bool) disableBinary;
/// <summary>
/// Gets the domain key for sandboxing connections to the server.
/// Defaults to "11111111-1111-1111-1111-111111111111". If you are using
/// WebSync On-Demand, this should be set to the private domain key if you
/// are attempting to use methods that have been secured in the Portal;
/// otherwise, use the public domain key.
/// </summary>
- (FMGuid*) domainKey;
/// <summary>
/// Gets the <see cref="FMWebSyncBaseClient#domainKey" />
/// as a string value.
/// </summary>
- (NSString*) domainKeyString;
/// <summary>
/// Gets the domain name to send as the <tt>Referrer</tt> with each request.
/// Defaults to "localhost". If you are using WebSync On-Demand, this field is only
/// necessary if you are using the public domain key, in which case it should be set
/// to equal the domain name entered in the Portal for the domain key (e.g.
/// "frozenmountain.com").
/// </summary>
- (NSString*) domainName;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncBaseClient" /> class.
/// </summary>
- (id) init;
- (void) internalOnHttpRequestCreatedWithE:(FMHttpRequestCreatedArgs*)e;
- (void) internalOnHttpResponseReceivedWithE:(FMHttpResponseReceivedArgs*)e;
- (void) internalOnRequestCreatedWithE:(FMWebSyncMessageRequestCreatedArgs*)e;
- (void) internalOnResponseReceivedWithE:(FMWebSyncMessageResponseReceivedArgs*)e;
/// <summary>
/// Raises an unhandled exception.
/// </summary>
/// <param name="exception">The unhandled exception.</param>
/// <returns><c>true</c> if the exception was handled; otherwise, <c>false</c>.</returns>
- (bool) raiseUnhandledExceptionWithException:(NSException*)exception;
/// <summary>
/// Raises an unhandled exception.
/// </summary>
/// <param name="exception">The unhandled exception.</param>
/// <returns><c>true</c> if the exception was handled; otherwise, <c>false</c>.</returns>
- (bool) raiseUnhandledException:(NSException*)exception;
/// <summary>
/// Removes a handler that is raised whenever an underlying HTTP request
/// has been created and is about to be transferred to the server. This is a
/// good place to add headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (void) removeOnHttpRequestCreatedWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever an underlying HTTP request
/// has been created and is about to be transferred to the server. This is a
/// good place to add headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (void) removeOnHttpRequestCreated:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever an underlying HTTP response
/// has been received and is about to be processed by the client. This is a
/// good place to read headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (void) removeOnHttpResponseReceivedWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever an underlying HTTP response
/// has been received and is about to be processed by the client. This is a
/// good place to read headers/cookies. For WebSocket streams, this will fire
/// only once for the initial HTTP-based handshake.
/// </summary>
- (void) removeOnHttpResponseReceived:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a new request is created
/// and about to be transferred to the server. This is a good place to read
/// or modify outgoing messages.
/// </summary>
- (void) removeOnRequestCreatedWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a new request is created
/// and about to be transferred to the server. This is a good place to read
/// or modify outgoing messages.
/// </summary>
- (void) removeOnRequestCreated:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a new response is received
/// and about to be processed by the client. This is a good place to read
/// or modify incoming messages.
/// </summary>
- (void) removeOnResponseReceivedWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a new response is received
/// and about to be processed by the client. This is a good place to read
/// or modify incoming messages.
/// </summary>
- (void) removeOnResponseReceived:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised when an exception is thrown in user code and not handled,
/// typically in a callback or event handler.
/// </summary>
- (void) removeOnUnhandledExceptionWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised when an exception is thrown in user code and not handled,
/// typically in a callback or event handler.
/// </summary>
- (void) removeOnUnhandledException:(FMCallback*)value;
/// <summary>
/// Gets the number of milliseconds to wait for a standard request to
/// return a response before it is aborted and another request is attempted.
/// Defaults to 15000 (15 seconds).
/// </summary>
- (int) requestTimeout;
/// <summary>
/// Gets the absolute URL of the WebSync request handler, typically
/// ending with websync.ashx.
/// </summary>
- (NSString*) requestUrl;
/// <summary>
/// Sets a flag indicating the level of concurrency in the current process.
/// The intended use of this property is to lighten the processor load when hundreds
/// or thousands of instances are created in a single process for the purposes of
/// generating load for testing.
/// </summary>
- (void) setConcurrencyMode:(FMWebSyncConcurrencyMode)value;
/// <summary>
/// Sets whether to disable the transmission of binary payloads
/// as binary on the wire. If set to <c>true</c>, binary payloads will
/// be sent over the wire as base64-encoded strings.
/// </summary>
- (void) setDisableBinary:(bool)value;
/// <summary>
/// Sets the domain key for sandboxing connections to the server.
/// Defaults to "11111111-1111-1111-1111-111111111111". If you are using
/// WebSync On-Demand, this should be set to the private domain key if you
/// are attempting to use methods that have been secured in the Portal;
/// otherwise, use the public domain key.
/// </summary>
- (void) setDomainKey:(FMGuid*)value;
/// <summary>
/// Sets the <see cref="FMWebSyncBaseClient#domainKey" />
/// as a string value.
/// </summary>
- (void) setDomainKeyString:(NSString*)value;
/// <summary>
/// Sets the domain name to send as the <tt>Referrer</tt> with each request.
/// Defaults to "localhost". If you are using WebSync On-Demand, this field is only
/// necessary if you are using the public domain key, in which case it should be set
/// to equal the domain name entered in the Portal for the domain key (e.g.
/// "frozenmountain.com").
/// </summary>
- (void) setDomainName:(NSString*)value;
/// <summary>
/// Sets the number of milliseconds to wait for a standard request to
/// return a response before it is aborted and another request is attempted.
/// Defaults to 15000 (15 seconds).
/// </summary>
- (void) setRequestTimeout:(int)value;
/// <summary>
/// Sets the absolute URL of the WebSync request handler, typically
/// ending with websync.ashx.
/// </summary>
- (void) setRequestUrl:(NSString*)value;

@end


@class NSMutableArrayFMExtensions;
@class FMNullableInt;
@class FMWebSyncNullableReconnect;
@class NSStringFMExtensions;

/// <summary>
/// Base advice class used in <see cref="FMWebSyncMessage">Messages</see> and for nested advice.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncBaseAdvice : FMSerializable 

+ (FMWebSyncBaseAdvice*) baseAdvice;
/// <summary>
/// Deserializes a single base advice object from JSON.
/// </summary>
/// <param name="baseAdviceJson">The JSON base advice object to deserialize.</param>
/// <returns>The deserialized advice object.</returns>
+ (FMWebSyncBaseAdvice*) fromJsonWithBaseAdviceJson:(NSString*)baseAdviceJson;
/// <summary>
/// Gets the list of host names that may be used as alternate servers.
/// </summary>
- (NSMutableArray*) hosts;
- (id) init;
/// <summary>
/// Gets the interval to wait before following the reconnect advice.
/// </summary>
- (FMNullableInt*) interval;
/// <summary>
/// Gets how the client should attempt to re-establish a connection with the server.
/// </summary>
- (FMWebSyncNullableReconnect*) reconnect;
/// <summary>
/// Sets the list of host names that may be used as alternate servers.
/// </summary>
- (void) setHosts:(NSMutableArray*)value;
/// <summary>
/// Sets the interval to wait before following the reconnect advice.
/// </summary>
- (void) setInterval:(FMNullableInt*)value;
/// <summary>
/// Sets how the client should attempt to re-establish a connection with the server.
/// </summary>
- (void) setReconnect:(FMWebSyncNullableReconnect*)value;
/// <summary>
/// Serializes the base advice object to JSON.
/// </summary>
/// <returns>The serialized advice object.</returns>
- (NSString*) toJson;
/// <summary>
/// Serializes a single base advice object to JSON.
/// </summary>
/// <param name="baseAdvice">The base advice object to serialize.</param>
/// <returns>The serialized advice object.</returns>
+ (NSString*) toJsonWithBaseAdvice:(FMWebSyncBaseAdvice*)baseAdvice;

@end


@class FMWebSyncBaseAdvice;
@class NSStringFMExtensions;

/// <summary>
/// Advice class used in <see cref="FMWebSyncMessage">Messages</see>.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncAdvice : FMWebSyncBaseAdvice 

+ (FMWebSyncAdvice*) advice;
/// <summary>
/// Gets advice specific to callback-polling clients.
/// </summary>
- (FMWebSyncBaseAdvice*) callbackPolling;
/// <summary>
/// Deserializes a single advice object from JSON.
/// </summary>
/// <param name="adviceJson">The JSON advice object to deserialize.</param>
/// <returns>The deserialized advice object.</returns>
+ (FMWebSyncAdvice*) fromJsonWithAdviceJson:(NSString*)adviceJson;
- (id) init;
/// <summary>
/// Gets advice specific to long-polling clients.
/// </summary>
- (FMWebSyncBaseAdvice*) longPolling;
/// <summary>
/// Sets advice specific to callback-polling clients.
/// </summary>
- (void) setCallbackPolling:(FMWebSyncBaseAdvice*)value;
/// <summary>
/// Sets advice specific to long-polling clients.
/// </summary>
- (void) setLongPolling:(FMWebSyncBaseAdvice*)value;
/// <summary>
/// Sets advice specific to WebSocket clients.
/// </summary>
- (void) setWebSocket:(FMWebSyncBaseAdvice*)value;
/// <summary>
/// Serializes the advice object to JSON.
/// </summary>
/// <returns>The serialized advice object.</returns>
- (NSString*) toJson;
/// <summary>
/// Serializes a single advice object to JSON.
/// </summary>
/// <param name="advice">The advice object to serialize.</param>
/// <returns>The serialized advice object.</returns>
+ (NSString*) toJsonWithAdvice:(FMWebSyncAdvice*)advice;
/// <summary>
/// Gets advice specific to WebSocket clients.
/// </summary>
- (FMWebSyncBaseAdvice*) webSocket;

@end


@class NSStringFMExtensions;

/// <summary>
/// Contains the reserved Bayeux meta-channels and methods to assist in detecting them.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncMetaChannels : NSObject 

/// <summary>
/// Converts a serviced channel into its original form.
/// </summary>
/// <param name="channel">The channel to convert.</param>
/// <returns>The channel without the service prefix.</returns>
+ (NSString*) convertChannelFromServicedWithChannel:(NSString*)channel;
/// <summary>
/// Converts a channel into its serviced equivalent.
/// </summary>
/// <param name="channel">The channel to convert.</param>
/// <returns>The channel with the service prefix.</returns>
+ (NSString*) convertChannelToServicedWithChannel:(NSString*)channel;
+ (FMWebSyncMessageType) getMessageTypeWithBayeuxChannel:(NSString*)bayeuxChannel;
/// <summary>
/// Determines whether the specified channel name is a reserved Bayeux /meta channel.
/// </summary>
/// <param name="channel">The channel name to check.</param>
/// <returns>
/// <c>true</c> if the specified channel name is a reserved Bayeux /meta channel; otherwise, <c>false</c>.
/// </returns>
+ (bool) isMetaChannelWithChannel:(NSString*)channel;
/// <summary>
/// Determines whether the specified channel name is a reserved Bayeux /meta channel.
/// </summary>
/// <param name="channel">The channel name to check.</param>
/// <returns>
/// <c>true</c> if the specified channel name is a reserved Bayeux /meta channel; otherwise, <c>false</c>.
/// </returns>
+ (bool) isMetaChannel:(NSString*)channel;
/// <summary>
/// Determines whether the specified channel name is a reserved Bayeux channel.
/// </summary>
/// <param name="channel">The channel name to check.</param>
/// <returns>
/// <c>true</c> if the specified channel name is reserved; otherwise, <c>false</c>.
/// </returns>
+ (bool) isReservedChannelWithChannel:(NSString*)channel;
/// <summary>
/// Determines whether the specified channel name is a reserved Bayeux channel.
/// </summary>
/// <param name="channel">The channel name to check.</param>
/// <returns>
/// <c>true</c> if the specified channel name is reserved; otherwise, <c>false</c>.
/// </returns>
+ (bool) isReservedChannel:(NSString*)channel;
/// <summary>
/// Determines whether the specified channel name is a reserved Bayeux /service channel.
/// </summary>
/// <param name="channel">The channel name to check.</param>
/// <returns>
/// <c>true</c> if the specified channel name is a reserved Bayeux /service channel; otherwise, <c>false</c>.
/// </returns>
+ (bool) isServiceChannelWithChannel:(NSString*)channel;
/// <summary>
/// Determines whether the specified channel name is a reserved Bayeux /service channel.
/// </summary>
/// <param name="channel">The channel name to check.</param>
/// <returns>
/// <c>true</c> if the specified channel name is a reserved Bayeux /service channel; otherwise, <c>false</c>.
/// </returns>
+ (bool) isServiceChannel:(NSString*)channel;

@end


@class FMWebSyncNotifyReceiveArgs;
@class FMWebSyncServerBindArgs;
@class FMWebSyncServerUnbindArgs;
@class FMWebSyncServerSubscribeArgs;
@class FMCallback;
@class FMWebSyncServerUnsubscribeArgs;
@class FMWebSyncConnectSuccessArgs;
@class FMWebSyncConnectFailureArgs;
@class FMWebSyncConnectCompleteArgs;
@class FMWebSyncSubscribeSuccessArgs;
@class FMWebSyncSubscribeFailureArgs;
@class FMWebSyncSubscribeCompleteArgs;
@class FMWebSyncBindSuccessArgs;
@class FMWebSyncBindFailureArgs;
@class FMWebSyncBindCompleteArgs;
@class FMWebSyncUnsubscribeSuccessArgs;
@class FMWebSyncUnsubscribeFailureArgs;
@class FMWebSyncUnsubscribeCompleteArgs;
@class FMWebSyncUnbindSuccessArgs;
@class FMWebSyncUnbindFailureArgs;
@class FMWebSyncUnbindCompleteArgs;
@class FMWebSyncDisconnectCompleteArgs;
@class FMWebSyncPublishSuccessArgs;
@class FMWebSyncPublishFailureArgs;
@class FMWebSyncPublishCompleteArgs;
@class FMWebSyncNotifySuccessArgs;
@class FMWebSyncNotifyFailureArgs;
@class FMWebSyncNotifyCompleteArgs;
@class FMWebSyncServiceSuccessArgs;
@class FMWebSyncServiceFailureArgs;
@class FMWebSyncServiceCompleteArgs;
@class FMWebSyncStreamFailureArgs;
@class FMWebSyncStateRestoredArgs;
@class FMWebSyncClientConnectRequestArgs;
@class FMWebSyncClientConnectResponseArgs;
@class FMWebSyncClientConnectEndArgs;
@class FMWebSyncClientDisconnectRequestArgs;
@class FMWebSyncClientDisconnectResponseArgs;
@class FMWebSyncClientDisconnectEndArgs;
@class FMWebSyncClientBindRequestArgs;
@class FMWebSyncClientBindResponseArgs;
@class FMWebSyncClientBindEndArgs;
@class FMWebSyncClientUnbindRequestArgs;
@class FMWebSyncClientUnbindResponseArgs;
@class FMWebSyncClientUnbindEndArgs;
@class FMWebSyncClientSubscribeRequestArgs;
@class FMWebSyncClientSubscribeResponseArgs;
@class FMWebSyncClientSubscribeEndArgs;
@class FMWebSyncClientUnsubscribeRequestArgs;
@class FMWebSyncClientUnsubscribeResponseArgs;
@class FMWebSyncClientUnsubscribeEndArgs;
@class FMWebSyncClientPublishRequestArgs;
@class FMWebSyncClientPublishResponseArgs;
@class FMWebSyncClientPublishEndArgs;
@class FMWebSyncClientNotifyRequestArgs;
@class FMWebSyncClientNotifyResponseArgs;
@class FMWebSyncClientNotifyEndArgs;
@class FMWebSyncClientServiceRequestArgs;
@class FMWebSyncClientServiceResponseArgs;
@class FMWebSyncClientServiceEndArgs;
@class FMWebSyncSubscribeReceiveArgs;
@class NSStringFMExtensions;
@class NSMutableDictionaryFMExtensions;
@class FMGuid;
@class FMWebSyncConnectArgs;
@class FMWebSyncNullableReconnect;
@class NSMutableArrayFMExtensions;
@class FMWebSyncMessageTransfer;
@class FMWebSyncClientResponseArgs;
@class FMNullableBool;
@class FMWebSyncBindArgs;
@class FMWebSyncDisconnectArgs;
@class FMWebSyncNotifyArgs;
@class FMWebSyncPublishArgs;
@class FMWebSyncServiceArgs;
@class FMWebSyncSubscribeArgs;
@class FMWebSyncUnbindArgs;
@class FMWebSyncUnsubscribeArgs;

/// <summary>
/// <para>
/// The WebSync client, used for subscribing to channels and receiving data, as well as
/// publishing data to specific channels.
/// </para>
/// </summary>
/// <remarks>
/// <para>
/// The WebSync client has 9 primary operations:
/// </para>
/// <list type="number">
/// <item>
/// Connect/Disconnect: Sets up/takes down a streaming connection to the server.
/// </item>
/// <item>
/// Bind/Unbind: Attaches/detaches records to the client (e.g. display name, user ID).
/// </item>
/// <item>
/// Subscribe/Unsubscribe: Opts in/out of receiving data published to a channel.
/// </item>
/// <item>
/// Publish: Broadcasts data to any clients subscribed to the channel.
/// </item>
/// <item>
/// Notify: Pushes data directly to a specific client (no subscription necessary).
/// </item>
/// <item>
/// Service: Sends data to the server for traditional request/response processing.
/// </item>
/// </list>
/// <para>
/// Each method (and the constructor) take a single "args" object. This object defines
/// callback functions, configuration settings, and error handling information. It
/// allows the client to default to sensible values while allowing easy overrides.
/// </para>
/// <para>
/// The WebSync client is designed to be as robust and fault-tolerant as possible. If
/// there are any failures in the streaming connection, the client will automatically
/// reconnect and set up a new one.
/// </para>
/// <para>
/// Maintaining a streaming connection lies at the heart of WebSync, and so special care
/// is given to ensure that a streaming connection remains active, even in the presence
/// of total network failure.
/// </para>
/// <para>
/// Since WebSync clients often subscribe to channels to receive partial updates, it is
/// highly recommended to do initial state load in the OnSuccess callback of the call
/// to Subscribe. This way, (a) there are no missed
/// partial updates between the state load and the subscription, and (b) in the event of
/// connection failure and automatic reconnection/resubscription, the state will be
/// automatically refreshed.
/// </para>
/// <para>
/// When a connection is lost, <see cref="FMWebSyncClientConnectArgs" />.OnStreamFailure will be called.
/// This is an excellent time to update the UI to let your user know that the connection
/// is temporarily offline and a new one is being established. The client will
/// automatically re-attempt a connect.
/// </para>
/// <para>
/// Shortly afterwards, either <see cref="FMWebSyncClientConnectArgs" />.OnSuccess or
/// <see cref="FMWebSyncClientConnectArgs" />.OnFailure will be called, depending on whether or not
/// the client could successfully negotiate a new connection with the server.
/// If <see cref="FMWebSyncClientConnectArgs" />.OnSuccess is called, the connection is officially
/// re-established. If <see cref="FMWebSyncClientConnectArgs" />.OnFailure is called, you should
/// analyze the response, and if appropriate, set <see cref="FMWebSyncBaseFailureArgs#retry" />
/// to true or false, depending on whether you want to retry the connection. The default
/// value of <see cref="FMWebSyncBaseFailureArgs#retry" /> is governed by <see cref="FMWebSyncClientConnectArgs" />.RetryMode.
/// Custom backoff algorithms can be defined using <see cref="FMWebSyncClientConnectArgs" />.RetryBackoff.
/// </para>
/// <para>
/// By the time <see cref="FMWebSyncClientConnectArgs" />.OnSuccess is called, the client has a new
/// client ID. Any pre-existing subscriptions or bindings performed outside the
/// connect callback chain will be automatically recreated.
/// </para>
/// <para>
/// Within a given OnSuccess or OnFailure callback, a boolean flag is always present to
/// indicate whether the callback is being executed as part of an automatic reconnect.
/// Refer to <see cref="FMWebSyncConnectSuccessArgs#isReconnect" />,
/// <see cref="FMWebSyncConnectFailureArgs#isReconnect" />,
/// <see cref="FMWebSyncSubscribeSuccessArgs#isResubscribe" />,
/// <see cref="FMWebSyncSubscribeFailureArgs#isResubscribe" />,
/// <see cref="FMWebSyncBindSuccessArgs#isRebind" />, and
/// <see cref="FMWebSyncBindFailureArgs#isRebind" />.
/// </para>
/// </remarks>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClient : FMWebSyncBaseClient 

/// <summary>
/// Adds a handler that is raised whenever a client completes a bind, successfully or not.
/// </summary>
- (FMCallback*) addOnBindCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a bind, successfully or not.
/// </summary>
- (FMCallback*) addOnBindComplete:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a bind, successfully or not.
/// </summary>
- (FMCallback*) addOnBindCompleteWithValueBlock:(void (^) (FMWebSyncBindCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a bind, successfully or not.
/// </summary>
- (FMCallback*) addOnBindCompleteBlock:(void (^) (FMWebSyncBindCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> bind ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnBindEndWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> bind ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnBindEnd:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> bind ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnBindEndWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientBindEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> bind ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnBindEndBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientBindEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to bind.
/// </summary>
- (FMCallback*) addOnBindFailureWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to bind.
/// </summary>
- (FMCallback*) addOnBindFailure:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to bind.
/// </summary>
- (FMCallback*) addOnBindFailureWithValueBlock:(void (^) (FMWebSyncBindFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to bind.
/// </summary>
- (FMCallback*) addOnBindFailureBlock:(void (^) (FMWebSyncBindFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> bind request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnBindRequestWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> bind request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnBindRequest:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> bind request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnBindRequestWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientBindRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> bind request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnBindRequestBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientBindRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> bind response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnBindResponseWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> bind response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnBindResponse:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> bind response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnBindResponseWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientBindResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> bind response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnBindResponseBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientBindResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully binds.
/// </summary>
- (FMCallback*) addOnBindSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully binds.
/// </summary>
- (FMCallback*) addOnBindSuccess:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully binds.
/// </summary>
- (FMCallback*) addOnBindSuccessWithValueBlock:(void (^) (FMWebSyncBindSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully binds.
/// </summary>
- (FMCallback*) addOnBindSuccessBlock:(void (^) (FMWebSyncBindSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a connect, successfully or not.
/// </summary>
- (FMCallback*) addOnConnectCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a connect, successfully or not.
/// </summary>
- (FMCallback*) addOnConnectComplete:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a connect, successfully or not.
/// </summary>
- (FMCallback*) addOnConnectCompleteWithValueBlock:(void (^) (FMWebSyncConnectCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a connect, successfully or not.
/// </summary>
- (FMCallback*) addOnConnectCompleteBlock:(void (^) (FMWebSyncConnectCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> connect ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnConnectEndWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> connect ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnConnectEnd:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> connect ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnConnectEndWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientConnectEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> connect ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnConnectEndBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientConnectEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to connect.
/// </summary>
- (FMCallback*) addOnConnectFailureWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to connect.
/// </summary>
- (FMCallback*) addOnConnectFailure:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to connect.
/// </summary>
- (FMCallback*) addOnConnectFailureWithValueBlock:(void (^) (FMWebSyncConnectFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to connect.
/// </summary>
- (FMCallback*) addOnConnectFailureBlock:(void (^) (FMWebSyncConnectFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> connect request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnConnectRequestWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> connect request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnConnectRequest:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> connect request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnConnectRequestWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientConnectRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> connect request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnConnectRequestBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientConnectRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> connect response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnConnectResponseWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> connect response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnConnectResponse:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> connect response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnConnectResponseWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientConnectResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> connect response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnConnectResponseBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientConnectResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully connects.
/// </summary>
- (FMCallback*) addOnConnectSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully connects.
/// </summary>
- (FMCallback*) addOnConnectSuccess:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully connects.
/// </summary>
- (FMCallback*) addOnConnectSuccessWithValueBlock:(void (^) (FMWebSyncConnectSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully connects.
/// </summary>
- (FMCallback*) addOnConnectSuccessBlock:(void (^) (FMWebSyncConnectSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a disconnect.
/// </summary>
- (FMCallback*) addOnDisconnectCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a disconnect.
/// </summary>
- (FMCallback*) addOnDisconnectComplete:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a disconnect.
/// </summary>
- (FMCallback*) addOnDisconnectCompleteWithValueBlock:(void (^) (FMWebSyncDisconnectCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a disconnect.
/// </summary>
- (FMCallback*) addOnDisconnectCompleteBlock:(void (^) (FMWebSyncDisconnectCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> disconnect ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnDisconnectEndWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> disconnect ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnDisconnectEnd:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> disconnect ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnDisconnectEndWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientDisconnectEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> disconnect ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnDisconnectEndBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientDisconnectEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> disconnect request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnDisconnectRequestWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> disconnect request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnDisconnectRequest:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> disconnect request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnDisconnectRequestWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientDisconnectRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> disconnect request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnDisconnectRequestBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientDisconnectRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> disconnect response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnDisconnectResponseWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> disconnect response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnDisconnectResponse:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> disconnect response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnDisconnectResponseWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientDisconnectResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> disconnect response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnDisconnectResponseBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientDisconnectResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a notify, successfully or not.
/// </summary>
- (FMCallback*) addOnNotifyCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a notify, successfully or not.
/// </summary>
- (FMCallback*) addOnNotifyComplete:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a notify, successfully or not.
/// </summary>
- (FMCallback*) addOnNotifyCompleteWithValueBlock:(void (^) (FMWebSyncNotifyCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a notify, successfully or not.
/// </summary>
- (FMCallback*) addOnNotifyCompleteBlock:(void (^) (FMWebSyncNotifyCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> notify ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyEndWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> notify ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyEnd:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> notify ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyEndWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientNotifyEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> notify ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyEndBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientNotifyEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to notify.
/// </summary>
- (FMCallback*) addOnNotifyFailureWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to notify.
/// </summary>
- (FMCallback*) addOnNotifyFailure:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to notify.
/// </summary>
- (FMCallback*) addOnNotifyFailureWithValueBlock:(void (^) (FMWebSyncNotifyFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to notify.
/// </summary>
- (FMCallback*) addOnNotifyFailureBlock:(void (^) (FMWebSyncNotifyFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> notify request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyRequestWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> notify request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyRequest:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> notify request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyRequestWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientNotifyRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> notify request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyRequestBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientNotifyRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> notify response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyResponseWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> notify response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyResponse:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> notify response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyResponseWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientNotifyResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> notify response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyResponseBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientNotifyResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully notifies.
/// </summary>
- (FMCallback*) addOnNotifySuccessWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully notifies.
/// </summary>
- (FMCallback*) addOnNotifySuccess:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully notifies.
/// </summary>
- (FMCallback*) addOnNotifySuccessWithValueBlock:(void (^) (FMWebSyncNotifySuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully notifies.
/// </summary>
- (FMCallback*) addOnNotifySuccessBlock:(void (^) (FMWebSyncNotifySuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a notification is sent to this client.
/// </summary>
- (FMCallback*) addOnNotifyWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a notification is sent to this client.
/// </summary>
- (FMCallback*) addOnNotify:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a notification is sent to this client.
/// </summary>
- (FMCallback*) addOnNotifyWithValueBlock:(void (^) (FMWebSyncNotifyReceiveArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a notification is sent to this client.
/// </summary>
- (FMCallback*) addOnNotifyBlock:(void (^) (FMWebSyncNotifyReceiveArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a publish, successfully or not.
/// </summary>
- (FMCallback*) addOnPublishCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a publish, successfully or not.
/// </summary>
- (FMCallback*) addOnPublishComplete:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a publish, successfully or not.
/// </summary>
- (FMCallback*) addOnPublishCompleteWithValueBlock:(void (^) (FMWebSyncPublishCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a publish, successfully or not.
/// </summary>
- (FMCallback*) addOnPublishCompleteBlock:(void (^) (FMWebSyncPublishCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> publish ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishEndWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> publish ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishEnd:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> publish ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishEndWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientPublishEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> publish ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishEndBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientPublishEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to publish.
/// </summary>
- (FMCallback*) addOnPublishFailureWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to publish.
/// </summary>
- (FMCallback*) addOnPublishFailure:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to publish.
/// </summary>
- (FMCallback*) addOnPublishFailureWithValueBlock:(void (^) (FMWebSyncPublishFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to publish.
/// </summary>
- (FMCallback*) addOnPublishFailureBlock:(void (^) (FMWebSyncPublishFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> publish request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishRequestWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> publish request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishRequest:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> publish request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishRequestWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientPublishRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> publish request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishRequestBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientPublishRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> publish response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishResponseWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> publish response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishResponse:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> publish response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishResponseWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientPublishResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> publish response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishResponseBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientPublishResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully publishes.
/// </summary>
- (FMCallback*) addOnPublishSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully publishes.
/// </summary>
- (FMCallback*) addOnPublishSuccess:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully publishes.
/// </summary>
- (FMCallback*) addOnPublishSuccessWithValueBlock:(void (^) (FMWebSyncPublishSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully publishes.
/// </summary>
- (FMCallback*) addOnPublishSuccessBlock:(void (^) (FMWebSyncPublishSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever the server binds
/// the client to a record or set of records.
/// </summary>
- (FMCallback*) addOnServerBindWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever the server binds
/// the client to a record or set of records.
/// </summary>
- (FMCallback*) addOnServerBind:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever the server binds
/// the client to a record or set of records.
/// </summary>
- (FMCallback*) addOnServerBindWithValueBlock:(void (^) (FMWebSyncServerBindArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever the server binds
/// the client to a record or set of records.
/// </summary>
- (FMCallback*) addOnServerBindBlock:(void (^) (FMWebSyncServerBindArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever the server subscribes
/// the client to a channel or set of channels.
/// </summary>
- (FMCallback*) addOnServerSubscribeWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever the server subscribes
/// the client to a channel or set of channels.
/// </summary>
- (FMCallback*) addOnServerSubscribe:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever the server subscribes
/// the client to a channel or set of channels.
/// </summary>
- (FMCallback*) addOnServerSubscribeWithValueBlock:(FMCallback* (^) (FMWebSyncServerSubscribeArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever the server subscribes
/// the client to a channel or set of channels.
/// </summary>
- (FMCallback*) addOnServerSubscribeBlock:(FMCallback* (^) (FMWebSyncServerSubscribeArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever the server unbinds
/// the client from a record or set of records.
/// </summary>
- (FMCallback*) addOnServerUnbindWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever the server unbinds
/// the client from a record or set of records.
/// </summary>
- (FMCallback*) addOnServerUnbind:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever the server unbinds
/// the client from a record or set of records.
/// </summary>
- (FMCallback*) addOnServerUnbindWithValueBlock:(void (^) (FMWebSyncServerUnbindArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever the server unbinds
/// the client from a record or set of records.
/// </summary>
- (FMCallback*) addOnServerUnbindBlock:(void (^) (FMWebSyncServerUnbindArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever the server unsubscribes
/// the client from a channel or set of channels.
/// </summary>
- (FMCallback*) addOnServerUnsubscribeWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever the server unsubscribes
/// the client from a channel or set of channels.
/// </summary>
- (FMCallback*) addOnServerUnsubscribe:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever the server unsubscribes
/// the client from a channel or set of channels.
/// </summary>
- (FMCallback*) addOnServerUnsubscribeWithValueBlock:(void (^) (FMWebSyncServerUnsubscribeArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever the server unsubscribes
/// the client from a channel or set of channels.
/// </summary>
- (FMCallback*) addOnServerUnsubscribeBlock:(void (^) (FMWebSyncServerUnsubscribeArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a service, successfully or not.
/// </summary>
- (FMCallback*) addOnServiceCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a service, successfully or not.
/// </summary>
- (FMCallback*) addOnServiceComplete:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a service, successfully or not.
/// </summary>
- (FMCallback*) addOnServiceCompleteWithValueBlock:(void (^) (FMWebSyncServiceCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a service, successfully or not.
/// </summary>
- (FMCallback*) addOnServiceCompleteBlock:(void (^) (FMWebSyncServiceCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> service ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceEndWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> service ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceEnd:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> service ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceEndWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientServiceEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> service ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceEndBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientServiceEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to service.
/// </summary>
- (FMCallback*) addOnServiceFailureWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to service.
/// </summary>
- (FMCallback*) addOnServiceFailure:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to service.
/// </summary>
- (FMCallback*) addOnServiceFailureWithValueBlock:(void (^) (FMWebSyncServiceFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to service.
/// </summary>
- (FMCallback*) addOnServiceFailureBlock:(void (^) (FMWebSyncServiceFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> service request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceRequestWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> service request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceRequest:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> service request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceRequestWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientServiceRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> service request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceRequestBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientServiceRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> service response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceResponseWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> service response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceResponse:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> service response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceResponseWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientServiceResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> service response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceResponseBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientServiceResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully services.
/// </summary>
- (FMCallback*) addOnServiceSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully services.
/// </summary>
- (FMCallback*) addOnServiceSuccess:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully services.
/// </summary>
- (FMCallback*) addOnServiceSuccessWithValueBlock:(void (^) (FMWebSyncServiceSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully services.
/// </summary>
- (FMCallback*) addOnServiceSuccessBlock:(void (^) (FMWebSyncServiceSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever the client's state is restored after a reconnection.
/// </summary>
- (FMCallback*) addOnStateRestoredWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever the client's state is restored after a reconnection.
/// </summary>
- (FMCallback*) addOnStateRestored:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever the client's state is restored after a reconnection.
/// </summary>
- (FMCallback*) addOnStateRestoredWithValueBlock:(void (^) (FMWebSyncStateRestoredArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever the client's state is restored after a reconnection.
/// </summary>
- (FMCallback*) addOnStateRestoredBlock:(void (^) (FMWebSyncStateRestoredArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever the client's streaming connection breaks down.
/// </summary>
- (FMCallback*) addOnStreamFailureWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever the client's streaming connection breaks down.
/// </summary>
- (FMCallback*) addOnStreamFailure:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever the client's streaming connection breaks down.
/// </summary>
- (FMCallback*) addOnStreamFailureWithValueBlock:(void (^) (FMWebSyncStreamFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever the client's streaming connection breaks down.
/// </summary>
- (FMCallback*) addOnStreamFailureBlock:(void (^) (FMWebSyncStreamFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a subscribe, successfully or not.
/// </summary>
- (FMCallback*) addOnSubscribeCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a subscribe, successfully or not.
/// </summary>
- (FMCallback*) addOnSubscribeComplete:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes a subscribe, successfully or not.
/// </summary>
- (FMCallback*) addOnSubscribeCompleteWithValueBlock:(void (^) (FMWebSyncSubscribeCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes a subscribe, successfully or not.
/// </summary>
- (FMCallback*) addOnSubscribeCompleteBlock:(void (^) (FMWebSyncSubscribeCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> subscribe ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSubscribeEndWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> subscribe ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSubscribeEnd:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> subscribe ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSubscribeEndWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientSubscribeEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> subscribe ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSubscribeEndBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientSubscribeEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to subscribe.
/// </summary>
- (FMCallback*) addOnSubscribeFailureWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to subscribe.
/// </summary>
- (FMCallback*) addOnSubscribeFailure:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to subscribe.
/// </summary>
- (FMCallback*) addOnSubscribeFailureWithValueBlock:(void (^) (FMWebSyncSubscribeFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to subscribe.
/// </summary>
- (FMCallback*) addOnSubscribeFailureBlock:(void (^) (FMWebSyncSubscribeFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> subscribe request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSubscribeRequestWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> subscribe request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSubscribeRequest:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> subscribe request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSubscribeRequestWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientSubscribeRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> subscribe request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSubscribeRequestBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientSubscribeRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> subscribe response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSubscribeResponseWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> subscribe response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSubscribeResponse:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> subscribe response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSubscribeResponseWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientSubscribeResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> subscribe response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSubscribeResponseBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientSubscribeResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully subscribes.
/// </summary>
- (FMCallback*) addOnSubscribeSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully subscribes.
/// </summary>
- (FMCallback*) addOnSubscribeSuccess:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully subscribes.
/// </summary>
- (FMCallback*) addOnSubscribeSuccessWithValueBlock:(void (^) (FMWebSyncSubscribeSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully subscribes.
/// </summary>
- (FMCallback*) addOnSubscribeSuccessBlock:(void (^) (FMWebSyncSubscribeSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes an unbind, successfully or not.
/// </summary>
- (FMCallback*) addOnUnbindCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes an unbind, successfully or not.
/// </summary>
- (FMCallback*) addOnUnbindComplete:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes an unbind, successfully or not.
/// </summary>
- (FMCallback*) addOnUnbindCompleteWithValueBlock:(void (^) (FMWebSyncUnbindCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes an unbind, successfully or not.
/// </summary>
- (FMCallback*) addOnUnbindCompleteBlock:(void (^) (FMWebSyncUnbindCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unbind ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnbindEndWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unbind ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnbindEnd:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unbind ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnbindEndWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientUnbindEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unbind ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnbindEndBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientUnbindEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to unbind.
/// </summary>
- (FMCallback*) addOnUnbindFailureWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to unbind.
/// </summary>
- (FMCallback*) addOnUnbindFailure:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to unbind.
/// </summary>
- (FMCallback*) addOnUnbindFailureWithValueBlock:(void (^) (FMWebSyncUnbindFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to unbind.
/// </summary>
- (FMCallback*) addOnUnbindFailureBlock:(void (^) (FMWebSyncUnbindFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> unbind request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnbindRequestWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> unbind request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnbindRequest:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> unbind request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnbindRequestWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientUnbindRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> unbind request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnbindRequestBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientUnbindRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unbind response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnbindResponseWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unbind response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnbindResponse:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unbind response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnbindResponseWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientUnbindResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unbind response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnbindResponseBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientUnbindResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully unbinds.
/// </summary>
- (FMCallback*) addOnUnbindSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully unbinds.
/// </summary>
- (FMCallback*) addOnUnbindSuccess:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully unbinds.
/// </summary>
- (FMCallback*) addOnUnbindSuccessWithValueBlock:(void (^) (FMWebSyncUnbindSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully unbinds.
/// </summary>
- (FMCallback*) addOnUnbindSuccessBlock:(void (^) (FMWebSyncUnbindSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes an unsubscribe, successfully or not.
/// </summary>
- (FMCallback*) addOnUnsubscribeCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes an unsubscribe, successfully or not.
/// </summary>
- (FMCallback*) addOnUnsubscribeComplete:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client completes an unsubscribe, successfully or not.
/// </summary>
- (FMCallback*) addOnUnsubscribeCompleteWithValueBlock:(void (^) (FMWebSyncUnsubscribeCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client completes an unsubscribe, successfully or not.
/// </summary>
- (FMCallback*) addOnUnsubscribeCompleteBlock:(void (^) (FMWebSyncUnsubscribeCompleteArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unsubscribe ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnsubscribeEndWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unsubscribe ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnsubscribeEnd:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unsubscribe ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnsubscribeEndWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientUnsubscribeEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unsubscribe ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeEndArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnsubscribeEndBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientUnsubscribeEndArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to unsubscribe.
/// </summary>
- (FMCallback*) addOnUnsubscribeFailureWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to unsubscribe.
/// </summary>
- (FMCallback*) addOnUnsubscribeFailure:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client fails to unsubscribe.
/// </summary>
- (FMCallback*) addOnUnsubscribeFailureWithValueBlock:(void (^) (FMWebSyncUnsubscribeFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client fails to unsubscribe.
/// </summary>
- (FMCallback*) addOnUnsubscribeFailureBlock:(void (^) (FMWebSyncUnsubscribeFailureArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> unsubscribe request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnsubscribeRequestWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> unsubscribe request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnsubscribeRequest:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> unsubscribe request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnsubscribeRequestWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientUnsubscribeRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncClient" /> unsubscribe request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnsubscribeRequestBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientUnsubscribeRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unsubscribe response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnsubscribeResponseWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unsubscribe response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnsubscribeResponse:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unsubscribe response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnsubscribeResponseWithValueBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientUnsubscribeResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncClient" /> unsubscribe response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnUnsubscribeResponseBlock:(void (^) (FMWebSyncClient*, FMWebSyncClientUnsubscribeResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully unsubscribes.
/// </summary>
- (FMCallback*) addOnUnsubscribeSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully unsubscribes.
/// </summary>
- (FMCallback*) addOnUnsubscribeSuccess:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised whenever a client successfully unsubscribes.
/// </summary>
- (FMCallback*) addOnUnsubscribeSuccessWithValueBlock:(void (^) (FMWebSyncUnsubscribeSuccessArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised whenever a client successfully unsubscribes.
/// </summary>
- (FMCallback*) addOnUnsubscribeSuccessBlock:(void (^) (FMWebSyncUnsubscribeSuccessArgs*))valueBlock;
/// <summary>
/// Binds the client to a public or private data record so it is visible to other
/// clients or just to the server.
/// </summary>
/// <remarks>
/// <para>
/// When the bind completes successfully, the OnSuccess callback
/// will be invoked, passing in the bound record(s),
/// <b>including any modifications made on the server</b>.
/// </para>
/// </remarks>
/// <param name="bindArgs">The bind arguments.
/// See <see cref="FMWebSyncBindArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) bindWithBindArgs:(FMWebSyncBindArgs*)bindArgs;
/// <summary>
/// Binds the client to a public or private data record so it is visible to other
/// clients or just to the server.
/// </summary>
/// <remarks>
/// <para>
/// When the bind completes successfully, the OnSuccess callback
/// will be invoked, passing in the bound record(s),
/// <b>including any modifications made on the server</b>.
/// </para>
/// </remarks>
/// <param name="bindArgs">The bind arguments.
/// See <see cref="FMWebSyncBindArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) bindWithArgs:(FMWebSyncBindArgs*)bindArgs;
- (bool) checkSynchronousWithSynchronous:(FMNullableBool*)synchronous;
- (bool) checkSynchronous:(FMNullableBool*)synchronous;
/// <summary>
/// Gets the server-generated WebSync client ID. This value is only set if the client is
/// connected, so reference it only after successfully connecting the client.
/// </summary>
- (FMGuid*) clientId;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncClient" /> class.
/// </summary>
/// <param name="requestUrl">The absolute URL of the WebSync server request handler.</param>
+ (FMWebSyncClient*) clientWithRequestUrl:(NSString*)requestUrl;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncClient" /> class.
/// </summary>
/// <param name="requestUrl">The absolute URL of the WebSync server request handler for non-streaming requests.</param>
/// <param name="streamRequestUrl">The absolute URL of the WebSync server request handler for streaming requests.</param>
+ (FMWebSyncClient*) clientWithRequestUrl:(NSString*)requestUrl streamRequestUrl:(NSString*)streamRequestUrl;
/// <summary>
/// Sets up and maintains a streaming connection to the server using default values.
/// </summary>
/// <remarks>
/// While this method will typically run asychronously, the WebSync client is
/// designed to be used without (much) consideration for its asynchronous nature.
/// To that end, any calls to methods that require an active connection, like
/// bind, subscribe, and publish, will be
/// queued automatically and executed once this method has completed successfully.
/// </remarks>
/// <returns>The client.</returns>
- (FMWebSyncClient*) connect;
/// <summary>
/// Sets up and maintains a streaming connection to the server.
/// </summary>
/// <remarks>
/// <para>
/// While this method will typically run asychronously, the WebSync client
/// is designed to be used without (much) consideration for its asynchronous nature.
/// To that end, any calls to methods that require an active connection, like
/// bind, subscribe, and publish, will be
/// queued automatically and executed once this method has completed successfully.
/// </para>
/// </remarks>
/// <param name="connectArgs">The connect arguments.
/// See <see cref="FMWebSyncClientConnectArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) connectWithConnectArgs:(FMWebSyncConnectArgs*)connectArgs;
/// <summary>
/// Sets up and maintains a streaming connection to the server.
/// </summary>
/// <remarks>
/// <para>
/// While this method will typically run asychronously, the WebSync client
/// is designed to be used without (much) consideration for its asynchronous nature.
/// To that end, any calls to methods that require an active connection, like
/// bind, subscribe, and publish, will be
/// queued automatically and executed once this method has completed successfully.
/// </para>
/// </remarks>
/// <param name="connectArgs">The connect arguments.
/// See <see cref="FMWebSyncClientConnectArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) connectWithArgs:(FMWebSyncConnectArgs*)connectArgs;
/// <summary>
/// Gets whether to disable WebSocket protocol support and use long-polling,
/// even if the server is capable of accepting WebSocket requests.
/// </summary>
- (bool) disableWebSockets;
/// <summary>
/// Takes down a streaming connection to the server and unsubscribes the client
/// using default values.
/// </summary>
/// <remarks>
/// After the disconnect completes successfully,
/// any further calls to methods that require an active connection, like
/// bind, subscribe, and publish, will be
/// queued automatically and executed only if/when the client reconnects.
/// </remarks>
/// <returns>The client.</returns>
- (FMWebSyncClient*) disconnect;
/// <summary>
/// Takes down a streaming connection to the server and unsubscribes/unbinds the client.
/// </summary>
/// <remarks>
/// <para>
/// After the disconnect completes successfully,
/// any further calls to methods that require an active connection, like
/// bind, subscribe, and publish, will be
/// queued automatically and executed only if/when the client reconnects.
/// </para>
/// </remarks>
/// <param name="disconnectArgs">The disconnect arguments.
/// See <see cref="FMWebSyncDisconnectArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) disconnectWithDisconnectArgs:(FMWebSyncDisconnectArgs*)disconnectArgs;
/// <summary>
/// Takes down a streaming connection to the server and unsubscribes/unbinds the client.
/// </summary>
/// <remarks>
/// <para>
/// After the disconnect completes successfully,
/// any further calls to methods that require an active connection, like
/// bind, subscribe, and publish, will be
/// queued automatically and executed only if/when the client reconnects.
/// </para>
/// </remarks>
/// <param name="disconnectArgs">The disconnect arguments.
/// See <see cref="FMWebSyncDisconnectArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) disconnectWithArgs:(FMWebSyncDisconnectArgs*)disconnectArgs;
/// <summary>
/// Flags the end of a batch of requests and starts sending them to the server.
/// </summary>
/// <remarks>
/// This is used in conjunction with <see cref="FMWebSyncClient#startBatch" />, which must
/// be called first to flag the start of a batch of requests to be sent together
/// to the server. Batching is used to optimize round-trips to the server by
/// reducing the overhead associated with creating multiple HTTP requests.
/// </remarks>
/// <returns>The client.</returns>
- (FMWebSyncClient*) endBatch;
/// <summary>
/// Generates a new token based on the current date/time.
/// </summary>
/// <returns>The generated token.</returns>
+ (NSString*) generateToken;
/// <summary>
/// Gets a collection of all the records to which the client is currently bound.
/// </summary>
/// <returns>A collection of all the records to which the client is currently bound</returns>
- (NSMutableDictionary*) getBoundRecords;
/// <summary>
/// Gets the callback invoked whenever messages are received on the specified
/// channel.
/// </summary>
/// <param name="channel">The channel over which the messages are being received.</param>
/// <returns>The callback invoked when a message is received, if a callback
/// is set; otherwise <c>null</c>.</returns>
- (FMCallback*) getCustomOnReceiveWithChannel:(NSString*)channel;
/// <summary>
/// Gets the callback invoked whenever messages are received on the specified
/// channel.  The tag denotes a specific callback.
/// </summary>
/// <param name="channel">The channel over which the messages are being received.</param>
/// <param name="tag">The identifier for the callback.</param>
/// <returns>The callback invoked when a message is received, if a callback
/// is set; otherwise <c>null</c>.</returns>
- (FMCallback*) getCustomOnReceiveWithTagWithChannel:(NSString*)channel tag:(NSString*)tag;
/// <summary>
/// Gets a list of all the channels to which the client is currently subscribed.
/// </summary>
/// <returns>A list of all the channels to which the client is currently subscribed</returns>
- (NSMutableArray*) getSubscribedChannels;
/// <summary>
/// Gets a list of all the channels to which the client is currently subscribed.
/// </summary>
/// <param name="tag">The subscription tag identifier.</param>
/// <returns>
/// A list of all the channels to which the client is currently subscribed
/// </returns>
- (NSMutableArray*) getSubscribedChannelsWithTag:(NSString*)tag;
/// <summary>
/// Gets whether or not requests are currently being batched.
/// </summary>
/// <returns><c>true</c> if requests are being batched; otherwise <c>false</c>.</returns>
- (bool) inBatch;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncClient" /> class.
/// </summary>
/// <param name="requestUrl">The absolute URL of the WebSync server request handler.</param>
- (id) initWithRequestUrl:(NSString*)requestUrl;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncClient" /> class.
/// </summary>
/// <param name="requestUrl">The absolute URL of the WebSync server request handler for non-streaming requests.</param>
/// <param name="streamRequestUrl">The absolute URL of the WebSync server request handler for streaming requests.</param>
- (id) initWithRequestUrl:(NSString*)requestUrl streamRequestUrl:(NSString*)streamRequestUrl;
/// <summary>
/// Gets a locally-generated instance ID. This value is set immediately upon construction,
/// is local-only, and does not change for the duration of this client instance, unless overriden
/// by application code.
/// </summary>
- (FMGuid*) instanceId;
/// <summary>
/// Gets whether the client is currently connected.
/// </summary>
- (bool) isConnected;
/// <summary>
/// Gets whether the client is currently connecting.
/// </summary>
- (bool) isConnecting;
/// <summary>
/// Gets whether the client is currently disconnecting.
/// </summary>
- (bool) isDisconnecting;
/// <summary>
/// Sends data to a specified client ID.
/// </summary>
/// <remarks>
/// When the notify completes successfully, the OnSuccess callback
/// will be invoked, passing in the
/// channel and published data, <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="notifyArgs">The notify arguments.
/// See <see cref="FMWebSyncNotifyArgs" /> for more details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) notifyWithNotifyArgs:(FMWebSyncNotifyArgs*)notifyArgs;
/// <summary>
/// Sends data to a specified client ID.
/// </summary>
/// <remarks>
/// When the notify completes successfully, the OnSuccess callback
/// will be invoked, passing in the
/// channel and published data, <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="notifyArgs">The notify arguments.
/// See <see cref="FMWebSyncNotifyArgs" /> for more details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) notifyWithArgs:(FMWebSyncNotifyArgs*)notifyArgs;
/// <summary>
/// Sends data to a specified channel.
/// </summary>
/// <remarks>
/// When the publish completes successfully, the OnSuccess callback
/// will be invoked, passing in the
/// channel and published data, <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="publishArgs">The publish arguments.
/// See <see cref="FMWebSyncPublishArgs" /> for more details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) publishWithPublishArgs:(FMWebSyncPublishArgs*)publishArgs;
/// <summary>
/// Sends data to a specified channel.
/// </summary>
/// <remarks>
/// When the publish completes successfully, the OnSuccess callback
/// will be invoked, passing in the
/// channel and published data, <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="publishArgs">The publish arguments.
/// See <see cref="FMWebSyncPublishArgs" /> for more details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) publishWithArgs:(FMWebSyncPublishArgs*)publishArgs;
/// <summary>
/// Removes a handler that is raised whenever a client completes a bind, successfully or not.
/// </summary>
- (void) removeOnBindCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a bind, successfully or not.
/// </summary>
- (void) removeOnBindComplete:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> bind ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindEndArgs" /> associated with the event.</parameter>
+ (void) removeOnBindEndWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> bind ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindEndArgs" /> associated with the event.</parameter>
+ (void) removeOnBindEnd:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to bind.
/// </summary>
- (void) removeOnBindFailureWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to bind.
/// </summary>
- (void) removeOnBindFailure:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> bind request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnBindRequestWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> bind request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnBindRequest:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> bind response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnBindResponseWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> bind response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientBindResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnBindResponse:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully binds.
/// </summary>
- (void) removeOnBindSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully binds.
/// </summary>
- (void) removeOnBindSuccess:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a connect, successfully or not.
/// </summary>
- (void) removeOnConnectCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a connect, successfully or not.
/// </summary>
- (void) removeOnConnectComplete:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> connect ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectEndArgs" /> associated with the event.</parameter>
+ (void) removeOnConnectEndWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> connect ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectEndArgs" /> associated with the event.</parameter>
+ (void) removeOnConnectEnd:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to connect.
/// </summary>
- (void) removeOnConnectFailureWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to connect.
/// </summary>
- (void) removeOnConnectFailure:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> connect request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnConnectRequestWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> connect request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnConnectRequest:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> connect response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnConnectResponseWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> connect response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientConnectResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnConnectResponse:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully connects.
/// </summary>
- (void) removeOnConnectSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully connects.
/// </summary>
- (void) removeOnConnectSuccess:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a disconnect.
/// </summary>
- (void) removeOnDisconnectCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a disconnect.
/// </summary>
- (void) removeOnDisconnectComplete:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> disconnect ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectEndArgs" /> associated with the event.</parameter>
+ (void) removeOnDisconnectEndWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> disconnect ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectEndArgs" /> associated with the event.</parameter>
+ (void) removeOnDisconnectEnd:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> disconnect request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnDisconnectRequestWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> disconnect request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnDisconnectRequest:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> disconnect response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnDisconnectResponseWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> disconnect response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientDisconnectResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnDisconnectResponse:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a notify, successfully or not.
/// </summary>
- (void) removeOnNotifyCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a notify, successfully or not.
/// </summary>
- (void) removeOnNotifyComplete:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> notify ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyEndArgs" /> associated with the event.</parameter>
+ (void) removeOnNotifyEndWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> notify ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyEndArgs" /> associated with the event.</parameter>
+ (void) removeOnNotifyEnd:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to notify.
/// </summary>
- (void) removeOnNotifyFailureWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to notify.
/// </summary>
- (void) removeOnNotifyFailure:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> notify request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnNotifyRequestWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> notify request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnNotifyRequest:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> notify response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnNotifyResponseWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> notify response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientNotifyResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnNotifyResponse:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully notifies.
/// </summary>
- (void) removeOnNotifySuccessWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully notifies.
/// </summary>
- (void) removeOnNotifySuccess:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a notification is sent to this client.
/// </summary>
- (void) removeOnNotifyWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a notification is sent to this client.
/// </summary>
- (void) removeOnNotify:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a publish, successfully or not.
/// </summary>
- (void) removeOnPublishCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a publish, successfully or not.
/// </summary>
- (void) removeOnPublishComplete:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> publish ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishEndArgs" /> associated with the event.</parameter>
+ (void) removeOnPublishEndWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> publish ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishEndArgs" /> associated with the event.</parameter>
+ (void) removeOnPublishEnd:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to publish.
/// </summary>
- (void) removeOnPublishFailureWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to publish.
/// </summary>
- (void) removeOnPublishFailure:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> publish request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnPublishRequestWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> publish request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnPublishRequest:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> publish response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnPublishResponseWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> publish response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientPublishResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnPublishResponse:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully publishes.
/// </summary>
- (void) removeOnPublishSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully publishes.
/// </summary>
- (void) removeOnPublishSuccess:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever the server binds
/// the client to a record or set of records.
/// </summary>
- (void) removeOnServerBindWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever the server binds
/// the client to a record or set of records.
/// </summary>
- (void) removeOnServerBind:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever the server subscribes
/// the client to a channel or set of channels.
/// </summary>
- (void) removeOnServerSubscribeWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever the server subscribes
/// the client to a channel or set of channels.
/// </summary>
- (void) removeOnServerSubscribe:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever the server unbinds
/// the client from a record or set of records.
/// </summary>
- (void) removeOnServerUnbindWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever the server unbinds
/// the client from a record or set of records.
/// </summary>
- (void) removeOnServerUnbind:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever the server unsubscribes
/// the client from a channel or set of channels.
/// </summary>
- (void) removeOnServerUnsubscribeWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever the server unsubscribes
/// the client from a channel or set of channels.
/// </summary>
- (void) removeOnServerUnsubscribe:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a service, successfully or not.
/// </summary>
- (void) removeOnServiceCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a service, successfully or not.
/// </summary>
- (void) removeOnServiceComplete:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> service ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceEndArgs" /> associated with the event.</parameter>
+ (void) removeOnServiceEndWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> service ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceEndArgs" /> associated with the event.</parameter>
+ (void) removeOnServiceEnd:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to service.
/// </summary>
- (void) removeOnServiceFailureWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to service.
/// </summary>
- (void) removeOnServiceFailure:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> service request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnServiceRequestWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> service request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnServiceRequest:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> service response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnServiceResponseWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> service response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientServiceResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnServiceResponse:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully services.
/// </summary>
- (void) removeOnServiceSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully services.
/// </summary>
- (void) removeOnServiceSuccess:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever the client's state is restored after a reconnection.
/// </summary>
- (void) removeOnStateRestoredWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever the client's state is restored after a reconnection.
/// </summary>
- (void) removeOnStateRestored:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever the client's streaming connection breaks down.
/// </summary>
- (void) removeOnStreamFailureWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever the client's streaming connection breaks down.
/// </summary>
- (void) removeOnStreamFailure:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a subscribe, successfully or not.
/// </summary>
- (void) removeOnSubscribeCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes a subscribe, successfully or not.
/// </summary>
- (void) removeOnSubscribeComplete:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> subscribe ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeEndArgs" /> associated with the event.</parameter>
+ (void) removeOnSubscribeEndWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> subscribe ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeEndArgs" /> associated with the event.</parameter>
+ (void) removeOnSubscribeEnd:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to subscribe.
/// </summary>
- (void) removeOnSubscribeFailureWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to subscribe.
/// </summary>
- (void) removeOnSubscribeFailure:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> subscribe request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnSubscribeRequestWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> subscribe request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnSubscribeRequest:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> subscribe response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnSubscribeResponseWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> subscribe response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientSubscribeResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnSubscribeResponse:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully subscribes.
/// </summary>
- (void) removeOnSubscribeSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully subscribes.
/// </summary>
- (void) removeOnSubscribeSuccess:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes an unbind, successfully or not.
/// </summary>
- (void) removeOnUnbindCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes an unbind, successfully or not.
/// </summary>
- (void) removeOnUnbindComplete:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> unbind ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindEndArgs" /> associated with the event.</parameter>
+ (void) removeOnUnbindEndWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> unbind ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindEndArgs" /> associated with the event.</parameter>
+ (void) removeOnUnbindEnd:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to unbind.
/// </summary>
- (void) removeOnUnbindFailureWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to unbind.
/// </summary>
- (void) removeOnUnbindFailure:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> unbind request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnUnbindRequestWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> unbind request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnUnbindRequest:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> unbind response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnUnbindResponseWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> unbind response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnbindResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnUnbindResponse:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully unbinds.
/// </summary>
- (void) removeOnUnbindSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully unbinds.
/// </summary>
- (void) removeOnUnbindSuccess:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes an unsubscribe, successfully or not.
/// </summary>
- (void) removeOnUnsubscribeCompleteWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client completes an unsubscribe, successfully or not.
/// </summary>
- (void) removeOnUnsubscribeComplete:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> unsubscribe ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeEndArgs" /> associated with the event.</parameter>
+ (void) removeOnUnsubscribeEndWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> unsubscribe ends. This event is
/// designed to support extensions by allowing modifications to be applied
/// to the client after processing.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeEndArgs" /> associated with the event.</parameter>
+ (void) removeOnUnsubscribeEnd:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to unsubscribe.
/// </summary>
- (void) removeOnUnsubscribeFailureWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client fails to unsubscribe.
/// </summary>
- (void) removeOnUnsubscribeFailure:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> unsubscribe request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnUnsubscribeRequestWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncClient" /> unsubscribe request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnUnsubscribeRequest:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> unsubscribe response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnUnsubscribeResponseWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncClient" /> unsubscribe response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The client that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncClientUnsubscribeResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnUnsubscribeResponse:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully unsubscribes.
/// </summary>
- (void) removeOnUnsubscribeSuccessWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised whenever a client successfully unsubscribes.
/// </summary>
- (void) removeOnUnsubscribeSuccess:(FMCallback*)value;
/// <summary>
/// Gets the number of milliseconds before the server takes action to discover
/// if this client is idling or still active.
/// </summary>
- (int) serverTimeout;
/// <summary>
/// Services data to a specified channel.
/// </summary>
/// <remarks>
/// <para>
/// Servicing allows the client to send data to the server in a traditional
/// request/response fashion. Data is not broadcast and the state of the
/// client remains unchanged after service calls.
/// </para>
/// <para>
/// When the service completes successfully, the OnSuccess callback
/// will be invoked, passing in the
/// channel and serviced data, <b>including any modifications made on the server</b>.
/// </para>
/// </remarks>
/// <param name="serviceArgs">The service arguments.
/// See <see cref="FMWebSyncServiceArgs" /> for more details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) serviceWithServiceArgs:(FMWebSyncServiceArgs*)serviceArgs;
/// <summary>
/// Services data to a specified channel.
/// </summary>
/// <remarks>
/// <para>
/// Servicing allows the client to send data to the server in a traditional
/// request/response fashion. Data is not broadcast and the state of the
/// client remains unchanged after service calls.
/// </para>
/// <para>
/// When the service completes successfully, the OnSuccess callback
/// will be invoked, passing in the
/// channel and serviced data, <b>including any modifications made on the server</b>.
/// </para>
/// </remarks>
/// <param name="serviceArgs">The service arguments.
/// See <see cref="FMWebSyncServiceArgs" /> for more details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) serviceWithArgs:(FMWebSyncServiceArgs*)serviceArgs;
/// <summary>
/// Gets the server-generated WebSync session ID. This value is only set if the client is
/// connected.
/// </summary>
- (FMGuid*) sessionId;
/// <summary>
/// Sets a callback to be invoked whenever messages are received on the specified
/// channel.
/// </summary>
/// <remarks>
/// <para>
/// This method does <b>not</b> subscribe you to a channel. Rather, it caches a
/// callback to be executed when messages are received on a particular
/// channel.
/// </para>
/// </remarks>
/// <param name="channel">The channel over which the messages will be received.</param>
/// <param name="onReceive">The callback to invoke when a message is received.</param>
- (void) setCustomOnReceiveWithChannel:(NSString*)channel onReceive:(FMCallback*)onReceive;
/// <summary>
/// Sets a callback to be invoked whenever messages are received on the specified
/// channel.
/// </summary>
/// <remarks>
/// <para>
/// This method does <b>not</b> subscribe you to a channel. Rather, it caches a
/// callback to be executed when messages are received on a particular
/// channel.
/// </para>
/// </remarks>
/// <param name="channel">The channel over which the messages will be received.</param>
/// <param name="onReceive">The callback to invoke when a message is received.</param>
- (void) setCustomOnReceiveWithChannel:(NSString*)channel onReceiveBlock:(void (^) (FMWebSyncSubscribeReceiveArgs*))onReceiveBlock;
/// <summary>
/// Sets a callback to be invoked whenever messages are received on the specified
/// channel. The tag allows multiple callbacks to be registered for
/// the same channel.
/// </summary>
/// <remarks>
/// <para>
/// This method does <b>not</b> subscribe you to a channel. Rather, it caches a
/// callback to be executed when messages are received on a particular
/// channel.
/// </para>
/// </remarks>
/// <param name="channel">The channel over which the messages will be received.</param>
/// <param name="tag">The identifier for this callback.</param>
/// <param name="onReceive">The callback to invoke when a message is received.</param>
- (void) setCustomOnReceiveWithTagWithChannel:(NSString*)channel tag:(NSString*)tag onReceive:(FMCallback*)onReceive;
/// <summary>
/// Sets a callback to be invoked whenever messages are received on the specified
/// channel. The tag allows multiple callbacks to be registered for
/// the same channel.
/// </summary>
/// <remarks>
/// <para>
/// This method does <b>not</b> subscribe you to a channel. Rather, it caches a
/// callback to be executed when messages are received on a particular
/// channel.
/// </para>
/// </remarks>
/// <param name="channel">The channel over which the messages will be received.</param>
/// <param name="tag">The identifier for this callback.</param>
/// <param name="onReceive">The callback to invoke when a message is received.</param>
- (void) setCustomOnReceiveWithTagWithChannel:(NSString*)channel tag:(NSString*)tag onReceiveBlock:(void (^) (FMWebSyncSubscribeReceiveArgs*))onReceiveBlock;
/// <summary>
/// Sets whether to disable WebSocket protocol support and use long-polling,
/// even if the server is capable of accepting WebSocket requests.
/// </summary>
- (void) setDisableWebSockets:(bool)value;
/// <summary>
/// Sets a locally-generated instance ID. This value is set immediately upon construction,
/// is local-only, and does not change for the duration of this client instance, unless overriden
/// by application code.
/// </summary>
- (void) setInstanceId:(FMGuid*)value;
/// <summary>
/// Sets the absolute URL of the WebSync request handler for streaming connections, typically
/// ending with websync.ashx.
/// </summary>
- (void) setStreamRequestUrl:(NSString*)value;
/// <summary>
/// Sets whether or not to execute client methods synchronously. This approach is not
/// recommended for UI threads, as it will block until the request completes.
/// Defaults to <c>false</c>.
/// </summary>
- (void) setSynchronous:(FMNullableBool*)value;
/// <summary>
/// Sets the token sent with each request for load balancing purposes.
/// </summary>
- (void) setToken:(NSString*)value;
/// <summary>
/// Flags the start of a batch of requests to be sent together to the server.
/// </summary>
/// <remarks>
/// This is used in conjunction with <see cref="FMWebSyncClient#endBatch" />, which flags
/// the end of a batch of requests and starts sending them to the server. Batching
/// is used to optimize round-trips to the server by reducing the overhead
/// associated with creating multiple HTTP requests.
/// </remarks>
/// <returns>The client.</returns>
- (FMWebSyncClient*) startBatch;
/// <summary>
/// Gets the number of milliseconds to wait for a stream request to
/// return a response before it is aborted and another stream request is attempted.
/// </summary>
- (int) streamRequestTimeout;
/// <summary>
/// Gets the absolute URL of the WebSync request handler for streaming connections, typically
/// ending with websync.ashx.
/// </summary>
- (NSString*) streamRequestUrl;
/// <summary>
/// Subscribes the client to receive messages on one or more channels.
/// </summary>
/// <remarks>
/// When the subscribe completes successfully, the OnSuccess callback
/// will be invoked, passing in the subscribed
/// channel(s), <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="subscribeArgs">The subscribe arguments.
/// See <see cref="FMWebSyncSubscribeArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) subscribeWithSubscribeArgs:(FMWebSyncSubscribeArgs*)subscribeArgs;
/// <summary>
/// Subscribes the client to receive messages on one or more channels.
/// </summary>
/// <remarks>
/// When the subscribe completes successfully, the OnSuccess callback
/// will be invoked, passing in the subscribed
/// channel(s), <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="subscribeArgs">The subscribe arguments.
/// See <see cref="FMWebSyncSubscribeArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) subscribeWithArgs:(FMWebSyncSubscribeArgs*)subscribeArgs;
/// <summary>
/// Gets whether or not to execute client methods synchronously. This approach is not
/// recommended for UI threads, as it will block until the request completes.
/// Defaults to <c>false</c>.
/// </summary>
- (FMNullableBool*) synchronous;
/// <summary>
/// Gets the token sent with each request for load balancing purposes.
/// </summary>
- (NSString*) token;
/// <summary>
/// Unbinds the client from a public or private data record so it is no longer visible
/// by other clients or the server.
/// </summary>
/// <remarks>
/// When the unbind completes successfully, the OnSuccess callback
/// will be invoked, passing in the unbound
/// record(s), <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="unbindArgs">The unbind arguments.
/// See <see cref="FMWebSyncUnbindArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) unbindWithUnbindArgs:(FMWebSyncUnbindArgs*)unbindArgs;
/// <summary>
/// Unbinds the client from a public or private data record so it is no longer visible
/// by other clients or the server.
/// </summary>
/// <remarks>
/// When the unbind completes successfully, the OnSuccess callback
/// will be invoked, passing in the unbound
/// record(s), <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="unbindArgs">The unbind arguments.
/// See <see cref="FMWebSyncUnbindArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) unbindWithArgs:(FMWebSyncUnbindArgs*)unbindArgs;
/// <summary>
/// Unsets a callback invoked whenever messages are received on the specified
/// channel.
/// </summary>
/// <remarks>
/// <para>
/// This method does <b>not</b> unsubscribe you from a channel. Rather, it stop the
/// callback from executing when messages are received on a particular
/// channel.
/// </para>
/// </remarks>
/// <param name="channel">The channel over which the messages are being received.</param>
/// <returns><c>true</c> if the callback was previously set; otherwise, <c>false</c>.</returns>
- (bool) unsetCustomOnReceiveWithChannel:(NSString*)channel;
/// <summary>
/// Unsets a callback invoked whenever messages are received on the specified
/// channel.  The tag denotes a specific callback.
/// </summary>
/// <remarks>
/// <para>
/// This method does <b>not</b> unsubscribe you from a channel. Rather, it stop the
/// callback from executing when messages are received on a particular
/// channel.
/// </para>
/// </remarks>
/// <param name="channel">The channel over which the messages are being received.</param>
/// <param name="tag">The identifier for this callback.</param>
/// <returns><c>true</c> if the callback was previously set; otherwise, <c>false</c>.</returns>
- (bool) unsetCustomOnReceiveWithTagWithChannel:(NSString*)channel tag:(NSString*)tag;
/// <summary>
/// Unsubscribes the client from receiving messages on one or more channels.
/// </summary>
/// <remarks>
/// When the unsubscribe completes successfully, the OnSuccess callback
/// will be invoked, passing in the
/// unsubscribed channel(s), <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="unsubscribeArgs">The unsubscribe arguments.
/// See <see cref="FMWebSyncUnsubscribeArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) unsubscribeWithUnsubscribeArgs:(FMWebSyncUnsubscribeArgs*)unsubscribeArgs;
/// <summary>
/// Unsubscribes the client from receiving messages on one or more channels.
/// </summary>
/// <remarks>
/// When the unsubscribe completes successfully, the OnSuccess callback
/// will be invoked, passing in the
/// unsubscribed channel(s), <b>including any modifications made on the server</b>.
/// </remarks>
/// <param name="unsubscribeArgs">The unsubscribe arguments.
/// See <see cref="FMWebSyncUnsubscribeArgs" /> for details.</param>
/// <returns>The client.</returns>
- (FMWebSyncClient*) unsubscribeWithArgs:(FMWebSyncUnsubscribeArgs*)unsubscribeArgs;

@end


@class NSMutableDictionaryFMExtensions;
@class NSMutableArrayFMExtensions;

#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientSendState : NSObject 

+ (FMWebSyncClientSendState*) clientSendState;
- (id) init;
- (bool) isStream;
- (NSMutableDictionary*) requestMapping;
- (NSMutableArray*) requests;
- (void) setIsStream:(bool)value;
- (void) setRequestMapping:(NSMutableDictionary*)value;
- (void) setRequests:(NSMutableArray*)value;

@end


@class FMWebSyncClientResponseArgs;
@class FMCallback;
@class FMWebSyncMessage;

#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncClientRequest : FMDynamic 

- (FMCallback*) callback;
+ (FMWebSyncClientRequest*) clientRequest;
- (id) init;
- (FMWebSyncMessage*) message;
- (void) setCallback:(FMCallback*)value;
- (void) setCallbackBlock:(void (^) (FMWebSyncClientResponseArgs*))valueBlock;
- (void) setMessage:(FMWebSyncMessage*)value;

@end


@class FMGuid;
@class NSStringFMExtensions;

/// <summary>
/// A collection of read-only default values for WebSync.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncDefaults : NSObject 

+ (FMWebSyncDefaults*) defaults;
/// <summary>
/// Gets the default domain key ("11111111-1111-1111-1111-111111111111").
/// </summary>
+ (FMGuid*) domainKey;
/// <summary>
/// Gets the default domain name ("localhost").
/// </summary>
+ (NSString*) domainName;
- (id) init;

@end


@class NSMutableDictionaryFMExtensions;
@class FMNullableGuid;
@class NSStringFMExtensions;

/// <summary>
/// Details about the client sending the publication data.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublishingClient : FMSerializable 

/// <summary>
/// Gets the publishing client's bound records.
/// </summary>
- (NSMutableDictionary*) boundRecords;
/// <summary>
/// Gets the publishing client's ID.
/// </summary>
- (FMNullableGuid*) clientId;
/// <summary>
/// Deserializes a JSON-formatted publishing client.
/// </summary>
/// <param name="publishingClientJson">The JSON-formatted publishing client to deserialize.</param>
/// <returns>The publishing client.</returns>
+ (FMWebSyncPublishingClient*) fromJsonWithPublishingClientJson:(NSString*)publishingClientJson;
/// <summary>
/// Gets the JSON value of a record bound to the publishing client.
/// </summary>
/// <param name="key">The record key.</param>
/// <returns>The JSON value of the record, if it exists, or <c>null</c>.</returns>
- (NSString*) getBoundRecordValueJsonWithKey:(NSString*)key;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublishingClient" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublishingClient" /> class.
/// </summary>
/// <param name="clientId">The publishing client's ID.</param>
/// <param name="boundRecords">The records bound to the client.</param>
- (id) initWithClientId:(FMNullableGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublishingClient" /> class.
/// </summary>
+ (FMWebSyncPublishingClient*) publishingClient;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublishingClient" /> class.
/// </summary>
/// <param name="clientId">The publishing client's ID.</param>
/// <param name="boundRecords">The records bound to the client.</param>
+ (FMWebSyncPublishingClient*) publishingClientWithClientId:(FMNullableGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublishingClient" /> class.
/// </summary>
/// <param name="clientId">The publishing client's ID.</param>
/// <param name="boundRecords">The records bound to the client.</param>
+ (FMWebSyncPublishingClient*) publishingClientWithId:(FMNullableGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Sets the publishing client's bound records.
/// </summary>
- (void) setBoundRecords:(NSMutableDictionary*)value;
/// <summary>
/// Sets the publishing client's ID.
/// </summary>
- (void) setClientId:(FMNullableGuid*)value;
/// <summary>
/// Serializes this instance to JSON.
/// </summary>
/// <returns>The JSON-formatted publishing client.</returns>
- (NSString*) toJson;
/// <summary>
/// Serializes a publishing client to JSON.
/// </summary>
/// <param name="publishingClient">The publishing client to serialize.</param>
/// <returns>The JSON-formatted publishing client.</returns>
+ (NSString*) toJsonWithPublishingClient:(FMWebSyncPublishingClient*)publishingClient;

@end


@class NSMutableDictionaryFMExtensions;
@class NSStringFMExtensions;
@class NSMutableArrayFMExtensions;

/// <summary>
/// The extensions library that wraps the Bayeux Ext field, used with instances of classes
/// that derive from <see cref="FMWebSyncExtensible" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncExtensions : FMDynamic 

/// <summary>
/// Gets the number of extensions in the library.
/// </summary>
- (int) count;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncExtensions" /> class.
/// </summary>
+ (FMWebSyncExtensions*) extensions;
/// <summary>
/// Deserializes a single extensions library from JSON.
/// </summary>
/// <param name="extensionsJson">The JSON extensions library to deserialize.</param>
/// <returns>The deserialized extensions library.</returns>
+ (FMWebSyncExtensions*) fromJsonWithExtensionsJson:(NSString*)extensionsJson;
/// <summary>
/// Gets a serialized value stored in the extensions.
/// </summary>
/// <param name="name">Fully-qualified extension name.</param>
/// <returns>The extension value (in JSON format).</returns>
- (NSString*) getValueJsonWithName:(NSString*)name;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncExtensions" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Gets the names of the extensions in the library.
/// </summary>
- (NSMutableArray*) names;
/// <summary>
/// Stores a serialized value in the extensions.  Must be valid JSON.
/// </summary>
/// <param name="name">Fully-qualified extension name.</param>
/// <param name="valueJson">The extension value in valid JSON format.</param>
- (void) setValueJsonWithName:(NSString*)name valueJson:(NSString*)valueJson;
/// <summary>
/// Stores a serialized value in the extensions.  Must be valid JSON.
/// </summary>
/// <param name="name">Fully-qualified extension name.</param>
/// <param name="valueJson">The extension value in valid JSON format.</param>
/// <param name="validate">Whether or not to validate the JSON.</param>
- (void) setValueJsonWithName:(NSString*)name valueJson:(NSString*)valueJson validate:(bool)validate;
/// <summary>
/// Serializes the extensions library to JSON.
/// </summary>
/// <returns>The serialized extensions library.</returns>
- (NSString*) toJson;
/// <summary>
/// Serializes a single extensions library to JSON.
/// </summary>
/// <param name="extensions">The extensions library to serialize.</param>
/// <returns>The serialized extensions library.</returns>
+ (NSString*) toJsonWithExtensions:(FMWebSyncExtensions*)extensions;

@end


@class FMWebSyncAdvice;
@class NSStringFMExtensions;
@class NSMutableArrayFMExtensions;
@class FMNullableGuid;
@class FMWebSyncNullableConnectionType;
@class FMNullableBool;
@class NSMutableDataFMExtensions;
@class FMWebSyncNotifyingClient;
@class FMWebSyncPublishingClient;
@class FMWebSyncRecord;
@class FMNullableInt;

/// <summary>
/// The WebSync message used for all <see cref="FMWebSyncClient" /> requests/responses.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncMessage : FMWebSyncBaseMessage 

/// <summary>
/// Gets the acknowledgement flag, used internally for stream requests following message delivery.
/// </summary>
- (FMNullableBool*) acknowledgement;
/// <summary>
/// Gets details on how the client should reconnect, used internally.
/// </summary>
- (FMWebSyncAdvice*) advice;
/// <summary>
/// Gets the Bayeux message channel.
/// </summary>
- (NSString*) bayeuxChannel;
/// <summary>
/// Gets the channel to which the current client is publishing, subscribing, or unsubscribing.
/// Overrides <see cref="FMWebSyncMessage#channels" />.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Gets the channels to which the current client is subscribing or unsubscribing.
/// Overrides <see cref="FMWebSyncMessage#channel" />.
/// </summary>
- (NSMutableArray*) channels;
/// <summary>
/// Gets the unique identifier of the current client associated with the request/response.
/// </summary>
- (FMNullableGuid*) clientId;
/// <summary>
/// Gets the type of connection the client is using, used internally.
/// </summary>
- (FMWebSyncNullableConnectionType*) connectionType;
/// <summary>
/// Gets whether binary is disabled.
/// </summary>
- (FMNullableBool*) disableBinary;
/// <summary>
/// Deserializes a list of messages from binary.
/// </summary>
/// <param name="bytes">A byte array to deserialize.</param>
/// <returns>A deserialized list of messages.</returns>
+ (NSMutableArray*) fromBinaryMultipleWithBytes:(NSMutableData*)bytes;
/// <summary>
/// Deserializes a message from binary.
/// </summary>
/// <param name="bytes">A byte array to deserialize.</param>
/// <returns>A deserialized message.</returns>
+ (FMWebSyncMessage*) fromBinaryWithBytes:(NSMutableData*)bytes;
/// <summary>
/// Deserializes a message from binary.
/// </summary>
/// <param name="bytes">A byte array to deserialize.</param>
/// <param name="offset">The offset into the array.</param>
/// <returns>A deserialized message.</returns>
+ (FMWebSyncMessage*) fromBinaryWithBytes:(NSMutableData*)bytes offset:(int)offset;
/// <summary>
/// Deserializes a list of messages from JSON.
/// </summary>
/// <param name="messagesJson">A JSON string to deserialize.</param>
/// <returns>A deserialized list of messages.</returns>
+ (NSMutableArray*) fromJsonMultipleWithMessagesJson:(NSString*)messagesJson;
/// <summary>
/// Deserializes a message from JSON.
/// </summary>
/// <param name="messageJson">A JSON string to deserialize.</param>
/// <returns>A deserialized message.</returns>
+ (FMWebSyncMessage*) fromJsonWithMessageJson:(NSString*)messageJson;
/// <summary>
/// Gets the unique message identifier.
/// </summary>
- (NSString*) id;
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncMessage" /> class.
/// </summary>
/// <param name="bayeuxChannel">The Bayeux channel with which to initialize the message.</param>
- (id) initWithBayeuxChannel:(NSString*)bayeuxChannel;
/// <summary>
/// Detects whether this is a bind request/response.
/// </summary>
/// <returns></returns>
- (bool) isBind;
/// <summary>
/// Determines whether or not the current message represents a bind
/// request/response for a particular key.
/// </summary>
/// <param name="key">The key to test.</param>
/// <returns><c>true</c> if the message represents a bind request/response
/// for the specified key; otherwise <c>false</c>.</returns>
- (bool) isBindingToWithKey:(NSString*)key;
/// <summary>
/// Detects whether this is a connect request/response.
/// </summary>
/// <returns></returns>
- (bool) isConnect;
/// <summary>
/// Detects whether this is a disconnect request/response.
/// </summary>
/// <returns></returns>
- (bool) isDisconnect;
/// <summary>
/// Detects whether this is a notify request/response.
/// </summary>
/// <returns></returns>
- (bool) isNotify;
/// <summary>
/// Detects whether this is a publish request/response.
/// </summary>
/// <returns></returns>
- (bool) isPublish;
/// <summary>
/// Detects whether this is a service request/response.
/// </summary>
/// <returns></returns>
- (bool) isService;
/// <summary>
/// Detects whether this is a stream request/response.
/// </summary>
/// <returns></returns>
- (bool) isStream;
/// <summary>
/// Detects whether this is a subscribe request/response.
/// </summary>
/// <returns></returns>
- (bool) isSubscribe;
/// <summary>
/// Determines whether or not the current message represents a subscribe
/// request/response for a particular channel.
/// </summary>
/// <param name="channel">The channel to test.</param>
/// <returns><c>true</c> if the message represents a subscribe request/response
/// for the specified channel; otherwise <c>false</c>.</returns>
- (bool) isSubscribingToWithChannel:(NSString*)channel;
/// <summary>
/// Detects whether this is a bind request/response.
/// </summary>
/// <returns></returns>
- (bool) isUnbind;
/// <summary>
/// Determines whether or not the current message represents an unbind
/// request/response for a particular key.
/// </summary>
/// <param name="key">The key to test.</param>
/// <returns><c>true</c> if the message represents an unbind request/response
/// for the specified key; otherwise <c>false</c>.</returns>
- (bool) isUnbindingFromWithKey:(NSString*)key;
/// <summary>
/// Detects whether this is an unsubscribe request/response.
/// </summary>
/// <returns></returns>
- (bool) isUnsubscribe;
/// <summary>
/// Determines whether or not the current message represents an unsubscribe
/// request/response for a particular channel.
/// </summary>
/// <param name="channel">The channel to test.</param>
/// <returns><c>true</c> if the message represents an unsubscribe request/response
/// for the specified channel; otherwise <c>false</c>.</returns>
- (bool) isUnsubscribingFromWithChannel:(NSString*)channel;
/// <summary>
/// Gets the record key to which the current client is binding or unbinding.
/// Overrides <see cref="FMWebSyncMessage#keys" />, <see cref="FMWebSyncMessage#record" />, and <see cref="FMWebSyncMessage#records" />.
/// </summary>
- (NSString*) key;
/// <summary>
/// Gets the record keys to which the current client is binding or unbinding.
/// Overrides <see cref="FMWebSyncMessage#key" />, <see cref="FMWebSyncMessage#record" />, and <see cref="FMWebSyncMessage#records" />.
/// </summary>
- (NSMutableArray*) keys;
/// <summary>
/// Gets the last used client ID.
/// </summary>
- (FMNullableGuid*) lastClientId;
/// <summary>
/// Gets the last used session ID.
/// </summary>
- (FMNullableGuid*) lastSessionId;
+ (FMWebSyncMessage*) message;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncMessage" /> class.
/// </summary>
/// <param name="bayeuxChannel">The Bayeux channel with which to initialize the message.</param>
+ (FMWebSyncMessage*) messageWithBayeuxChannel:(NSString*)bayeuxChannel;
/// <summary>
/// Gets the minimum supported server version, used internally.
/// </summary>
- (NSString*) minimumVersion;
/// <summary>
/// Gets the ID of the client which the current client is notifying.
/// </summary>
- (FMNullableGuid*) notifyClientId;
/// <summary>
/// Gets the notifying client details, used internally.
/// </summary>
- (FMWebSyncNotifyingClient*) notifyingClient;
/// <summary>
/// Gets the publishing client details, used internally.
/// </summary>
- (FMWebSyncPublishingClient*) publishingClient;
/// <summary>
/// Gets the record to which the current client is binding or unbinding.
/// Overrides <see cref="FMWebSyncMessage#records" />, <see cref="FMWebSyncMessage#key" />, and <see cref="FMWebSyncMessage#keys" />.
/// </summary>
- (FMWebSyncRecord*) record;
/// <summary>
/// Gets the records to which the current client is binding or unbinding.
/// Overrides <see cref="FMWebSyncMessage#record" />, <see cref="FMWebSyncMessage#key" />, and <see cref="FMWebSyncMessage#keys" />.
/// </summary>
- (NSMutableArray*) records;
/// <summary>
/// Gets the server actions, used internally.
/// </summary>
- (NSMutableArray*) serverActions;
/// <summary>
/// Gets the server timeout, used internally.
/// </summary>
- (FMNullableInt*) serverTimeout;
/// <summary>
/// Gets the session ID associated with the message, used internally.
/// </summary>
- (FMNullableGuid*) sessionId;
/// <summary>
/// Sets the acknowledgement flag, used internally for stream requests following message delivery.
/// </summary>
- (void) setAcknowledgement:(FMNullableBool*)value;
/// <summary>
/// Sets details on how the client should reconnect, used internally.
/// </summary>
- (void) setAdvice:(FMWebSyncAdvice*)value;
/// <summary>
/// Sets the Bayeux message channel.
/// </summary>
- (void) setBayeuxChannel:(NSString*)value;
/// <summary>
/// Sets the channel to which the current client is publishing, subscribing, or unsubscribing.
/// Overrides <see cref="FMWebSyncMessage#channels" />.
/// </summary>
- (void) setChannel:(NSString*)value;
/// <summary>
/// Sets the channels to which the current client is subscribing or unsubscribing.
/// Overrides <see cref="FMWebSyncMessage#channel" />.
/// </summary>
- (void) setChannels:(NSMutableArray*)value;
/// <summary>
/// Sets the unique identifier of the current client associated with the request/response.
/// </summary>
- (void) setClientId:(FMNullableGuid*)value;
/// <summary>
/// Sets the type of connection the client is using, used internally.
/// </summary>
- (void) setConnectionType:(FMWebSyncNullableConnectionType*)value;
/// <summary>
/// Sets whether binary is disabled.
/// </summary>
- (void) setDisableBinary:(FMNullableBool*)value;
/// <summary>
/// Sets the unique message identifier.
/// </summary>
- (void) setId:(NSString*)value;
/// <summary>
/// Sets the record key to which the current client is binding or unbinding.
/// Overrides <see cref="FMWebSyncMessage#keys" />, <see cref="FMWebSyncMessage#record" />, and <see cref="FMWebSyncMessage#records" />.
/// </summary>
- (void) setKey:(NSString*)value;
/// <summary>
/// Sets the record keys to which the current client is binding or unbinding.
/// Overrides <see cref="FMWebSyncMessage#key" />, <see cref="FMWebSyncMessage#record" />, and <see cref="FMWebSyncMessage#records" />.
/// </summary>
- (void) setKeys:(NSMutableArray*)value;
/// <summary>
/// Sets the last used client ID.
/// </summary>
- (void) setLastClientId:(FMNullableGuid*)value;
/// <summary>
/// Sets the last used session ID.
/// </summary>
- (void) setLastSessionId:(FMNullableGuid*)value;
/// <summary>
/// Sets the minimum supported server version, used internally.
/// </summary>
- (void) setMinimumVersion:(NSString*)value;
/// <summary>
/// Sets the ID of the client which the current client is notifying.
/// </summary>
- (void) setNotifyClientId:(FMNullableGuid*)value;
/// <summary>
/// Sets the notifying client details, used internally.
/// </summary>
- (void) setNotifyingClient:(FMWebSyncNotifyingClient*)value;
/// <summary>
/// Sets the publishing client details, used internally.
/// </summary>
- (void) setPublishingClient:(FMWebSyncPublishingClient*)value;
/// <summary>
/// Sets the record to which the current client is binding or unbinding.
/// Overrides <see cref="FMWebSyncMessage#records" />, <see cref="FMWebSyncMessage#key" />, and <see cref="FMWebSyncMessage#keys" />.
/// </summary>
- (void) setRecord:(FMWebSyncRecord*)value;
/// <summary>
/// Sets the records to which the current client is binding or unbinding.
/// Overrides <see cref="FMWebSyncMessage#record" />, <see cref="FMWebSyncMessage#key" />, and <see cref="FMWebSyncMessage#keys" />.
/// </summary>
- (void) setRecords:(NSMutableArray*)value;
/// <summary>
/// Sets the server actions, used internally.
/// </summary>
- (void) setServerActions:(NSMutableArray*)value;
/// <summary>
/// Sets the server timeout, used internally.
/// </summary>
- (void) setServerTimeout:(FMNullableInt*)value;
/// <summary>
/// Sets the session ID associated with the message, used internally.
/// </summary>
- (void) setSessionId:(FMNullableGuid*)value;
/// <summary>
/// Sets the connection types supported by an endpoint, used internally.
/// </summary>
- (void) setSupportedConnectionTypes:(NSMutableArray*)value;
/// <summary>
/// Sets the tag associated with the request.
/// </summary>
- (void) setTag:(NSString*)value;
/// <summary>
/// Sets the current server version, used internally.
/// </summary>
- (void) setVersion:(NSString*)value;
/// <summary>
/// Gets the connection types supported by an endpoint, used internally.
/// </summary>
- (NSMutableArray*) supportedConnectionTypes;
/// <summary>
/// Gets the tag associated with the request.
/// </summary>
- (NSString*) tag;
/// <summary>
/// Serializes the message to binary.
/// </summary>
/// <returns>The message in binary-serialized format.</returns>
- (NSMutableData*) toBinary;
/// <summary>
/// Serializes a list of messages to binary.
/// </summary>
/// <param name="messages">A list of messages to serialize.</param>
/// <returns>A binary-serialized array of messages.</returns>
+ (NSMutableData*) toBinaryMultipleWithMessages:(NSMutableArray*)messages;
/// <summary>
/// Serializes a message to binary.
/// </summary>
/// <param name="message">A message to serialize.</param>
/// <returns>A binary-serialized message.</returns>
+ (NSMutableData*) toBinaryWithMessage:(FMWebSyncMessage*)message;
/// <summary>
/// Serializes the message to JSON.
/// </summary>
/// <returns>The message in JSON-serialized format.</returns>
- (NSString*) toJson;
/// <summary>
/// Serializes a list of messages to JSON.
/// </summary>
/// <param name="messages">A list of messages to serialize.</param>
/// <returns>A JSON-serialized array of messages.</returns>
+ (NSString*) toJsonMultipleWithMessages:(NSMutableArray*)messages;
/// <summary>
/// Serializes a message to JSON.
/// </summary>
/// <param name="message">A message to serialize.</param>
/// <returns>A JSON-serialized message.</returns>
+ (NSString*) toJsonWithMessage:(FMWebSyncMessage*)message;
/// <summary>
/// Gets the type of the message.
/// </summary>
- (FMWebSyncMessageType) type;
/// <summary>
/// Gets the current server version, used internally.
/// </summary>
- (NSString*) version;

@end


@class NSStringFMExtensions;
@class NSMutableArrayFMExtensions;
@class FMWebSyncMessage;
@class NSMutableDataFMExtensions;

/// <summary>
/// The WebSync publication used for direct publishing.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublication : FMWebSyncBaseMessage 

/// <summary>
/// Gets the channel the publisher is targeting.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Deserializes a list of publications from JSON.
/// </summary>
/// <param name="publicationsJson">A JSON string to deserialize.</param>
/// <returns>A deserialized list of publications.</returns>
+ (NSMutableArray*) fromJsonMultipleWithPublicationsJson:(NSString*)publicationsJson;
/// <summary>
/// Deserializes a publication from JSON.
/// </summary>
/// <param name="publicationJson">A JSON string to deserialize.</param>
/// <returns>A deserialized publication.</returns>
+ (FMWebSyncPublication*) fromJsonWithPublicationJson:(NSString*)publicationJson;
/// <summary>
/// Converts a set of Publications from their Message formats.
/// </summary>
/// <param name="messages">The messages.</param>
/// <returns>The publications.</returns>
+ (NSMutableArray*) fromMessagesWithMessages:(NSMutableArray*)messages;
/// <summary>
/// Converts a set of Publications from their Message formats.
/// </summary>
/// <param name="messages">The messages.</param>
/// <returns>The publications.</returns>
+ (NSMutableArray*) fromMessages:(NSMutableArray*)messages;
/// <summary>
/// Converts a Publication from its Message format.
/// </summary>
/// <param name="message">The message.</param>
/// <returns>The publication.</returns>
+ (FMWebSyncPublication*) fromMessageWithMessage:(FMWebSyncMessage*)message;
/// <summary>
/// Converts a Publication from its Message format.
/// </summary>
/// <param name="message">The message.</param>
/// <returns>The publication.</returns>
+ (FMWebSyncPublication*) fromMessage:(FMWebSyncMessage*)message;
/// <summary>
/// Creates a new publication.
/// </summary>
- (id) init;
/// <summary>
/// Creates a new publication with a channel.
/// </summary>
/// <param name="channel">The channel to target.</param>
- (id) initWithChannel:(NSString*)channel;
/// <summary>
/// Creates a new publication with a channel, JSON data, and binary data.
/// </summary>
/// <param name="channel">The channel to target.</param>
/// <param name="dataBytes">The data to send (in binary format).</param>
- (id) initWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Creates a new publication with a channel, JSON data, and binary data.
/// </summary>
/// <param name="channel">The channel to target.</param>
/// <param name="dataBytes">The data to send (in binary format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
- (id) initWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Creates a new publication with a channel and JSON data.
/// </summary>
/// <param name="channel">The channel to target.</param>
/// <param name="dataJson">The data to send (in JSON format).</param>
- (id) initWithChannel:(NSString*)channel dataJson:(NSString*)dataJson;
/// <summary>
/// Creates a new publication with a channel and JSON data.
/// </summary>
/// <param name="channel">The channel to target.</param>
/// <param name="dataJson">The data to send (in JSON format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
- (id) initWithChannel:(NSString*)channel dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Creates a new publication.
/// </summary>
+ (FMWebSyncPublication*) publication;
/// <summary>
/// Creates a new publication with a channel.
/// </summary>
/// <param name="channel">The channel to target.</param>
+ (FMWebSyncPublication*) publicationWithChannel:(NSString*)channel;
/// <summary>
/// Creates a new publication with a channel, JSON data, and binary data.
/// </summary>
/// <param name="channel">The channel to target.</param>
/// <param name="dataBytes">The data to send (in binary format).</param>
+ (FMWebSyncPublication*) publicationWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Creates a new publication with a channel, JSON data, and binary data.
/// </summary>
/// <param name="channel">The channel to target.</param>
/// <param name="dataBytes">The data to send (in binary format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
+ (FMWebSyncPublication*) publicationWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Creates a new publication with a channel and JSON data.
/// </summary>
/// <param name="channel">The channel to target.</param>
/// <param name="dataJson">The data to send (in JSON format).</param>
+ (FMWebSyncPublication*) publicationWithChannel:(NSString*)channel dataJson:(NSString*)dataJson;
/// <summary>
/// Creates a new publication with a channel and JSON data.
/// </summary>
/// <param name="channel">The channel to target.</param>
/// <param name="dataJson">The data to send (in JSON format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
+ (FMWebSyncPublication*) publicationWithChannel:(NSString*)channel dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Sets the channel the publisher is targeting.
/// </summary>
- (void) setChannel:(NSString*)value;
/// <summary>
/// Sets the tag that identifies the contents of the payload.
/// </summary>
- (void) setTag:(NSString*)value;
/// <summary>
/// Gets the tag that identifies the contents of the payload.
/// </summary>
- (NSString*) tag;
/// <summary>
/// Serializes the publication to JSON.
/// </summary>
/// <returns>The publication in JSON-serialized format.</returns>
- (NSString*) toJson;
/// <summary>
/// Serializes a list of publications to JSON.
/// </summary>
/// <param name="publications">A list of publications to serialize.</param>
/// <returns>A JSON-serialized array of publications.</returns>
+ (NSString*) toJsonMultipleWithPublications:(NSMutableArray*)publications;
/// <summary>
/// Serializes a publication to JSON.
/// </summary>
/// <param name="publication">A publication to serialize.</param>
/// <returns>A JSON-serialized publication.</returns>
+ (NSString*) toJsonWithPublication:(FMWebSyncPublication*)publication;
/// <summary>
/// Converts a set of Publications to their Message formats.
/// </summary>
/// <param name="publications">The publications.</param>
/// <returns>The messages.</returns>
+ (NSMutableArray*) toMessagesWithPublications:(NSMutableArray*)publications;
/// <summary>
/// Converts a Publication to its Message format.
/// </summary>
/// <param name="publication">The publication.</param>
/// <returns>The message.</returns>
+ (FMWebSyncMessage*) toMessageWithPublication:(FMWebSyncPublication*)publication;

@end


@class FMWebSyncPublisherPublishRequestArgs;
@class FMWebSyncPublisherPublishResponseArgs;
@class FMWebSyncPublisherNotifyRequestArgs;
@class FMWebSyncPublisherNotifyResponseArgs;
@class FMWebSyncPublisherServiceRequestArgs;
@class FMWebSyncPublisherServiceResponseArgs;
@class FMCallback;
@class NSStringFMExtensions;
@class NSMutableArrayFMExtensions;
@class FMWebSyncNotification;
@class FMGuid;
@class NSMutableDataFMExtensions;
@class FMWebSyncPublication;
@class FMWebSyncMessage;

/// <summary>
/// <para>
/// The WebSync publisher, used for publishing data rapidly and efficiently.
/// </para>
/// </summary>
/// <remarks>
/// <para>
/// When developing real-time applications, it is often most efficient and secure to
/// publish data from a server, a web service, or in general, a source that doesn't
/// require the ability to subscribe to channels.  The <see cref="FMWebSyncPublisher" /> is
/// designed to do just that.
/// </para>
/// <para>
/// A common use case for the <see cref="FMWebSyncPublisher" /> is to send out data as it
/// arrives from a real-time feed (e.g. stock data, sports scores, news articles, etc.).
/// Wherever the feed is located, the <see cref="FMWebSyncPublisher" /> can be used to send
/// out the data rapidly to any subscribed clients.
/// </para>
/// <para>
/// For security reasons, WebSync Server blocks Publisher requests by default. To
/// enable direct publication, make sure "allowPublishers" is enabled in web.config.
/// </para>
/// <para>
/// The publisher always runs synchronously.
/// </para>
/// <para>
/// There are multiple overloads for the "Publish" method. For batch
/// publications, use the overloads that take a collection of
/// <see cref="FMWebSyncPublication">Publications</see>. They will be automatically batched and
/// delivered in a single round-trip.
/// </para>
/// </remarks>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncPublisher : FMWebSyncBaseClient 

/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncPublisher" /> notify request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherNotifyRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyRequestWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncPublisher" /> notify request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherNotifyRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyRequest:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncPublisher" /> notify request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherNotifyRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyRequestWithValueBlock:(void (^) (FMWebSyncPublisher*, FMWebSyncPublisherNotifyRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncPublisher" /> notify request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherNotifyRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyRequestBlock:(void (^) (FMWebSyncPublisher*, FMWebSyncPublisherNotifyRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncPublisher" /> notify response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherNotifyResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyResponseWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncPublisher" /> notify response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherNotifyResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyResponse:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncPublisher" /> notify response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherNotifyResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyResponseWithValueBlock:(void (^) (FMWebSyncPublisher*, FMWebSyncPublisherNotifyResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncPublisher" /> notify response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherNotifyResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnNotifyResponseBlock:(void (^) (FMWebSyncPublisher*, FMWebSyncPublisherNotifyResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncPublisher" /> publish request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherPublishRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishRequestWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncPublisher" /> publish request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherPublishRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishRequest:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncPublisher" /> publish request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherPublishRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishRequestWithValueBlock:(void (^) (FMWebSyncPublisher*, FMWebSyncPublisherPublishRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncPublisher" /> publish request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherPublishRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishRequestBlock:(void (^) (FMWebSyncPublisher*, FMWebSyncPublisherPublishRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncPublisher" /> publish response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherPublishResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishResponseWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncPublisher" /> publish response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherPublishResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishResponse:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncPublisher" /> publish response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherPublishResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishResponseWithValueBlock:(void (^) (FMWebSyncPublisher*, FMWebSyncPublisherPublishResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncPublisher" /> publish response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherPublishResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnPublishResponseBlock:(void (^) (FMWebSyncPublisher*, FMWebSyncPublisherPublishResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncPublisher" /> service request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherServiceRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceRequestWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncPublisher" /> service request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherServiceRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceRequest:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncPublisher" /> service request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherServiceRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceRequestWithValueBlock:(void (^) (FMWebSyncPublisher*, FMWebSyncPublisherServiceRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before a <see cref="FMWebSyncPublisher" /> service request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherServiceRequestArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceRequestBlock:(void (^) (FMWebSyncPublisher*, FMWebSyncPublisherServiceRequestArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncPublisher" /> service response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherServiceResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceResponseWithValue:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncPublisher" /> service response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherServiceResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceResponse:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncPublisher" /> service response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherServiceResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceResponseWithValueBlock:(void (^) (FMWebSyncPublisher*, FMWebSyncPublisherServiceResponseArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised after a <see cref="FMWebSyncPublisher" /> service response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherServiceResponseArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnServiceResponseBlock:(void (^) (FMWebSyncPublisher*, FMWebSyncPublisherServiceResponseArgs*))valueBlock;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublisher" /> class.
/// </summary>
/// <param name="requestUrl">The absolute URL of the WebSync server request handler.</param>
- (id) initWithRequestUrl:(NSString*)requestUrl;
/// <summary>
/// Sends an array of notifications synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncNotification">Notifications</see> it sends.
/// </remarks>
/// <param name="notifications">The notifications to send.</param>
/// <returns>The completed notifications.</returns>
- (NSMutableArray*) notifyManyWithNotifications:(NSMutableArray*)notifications;
/// <summary>
/// Sends a notification synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncNotification" /> it automatically creates.
/// </remarks>
/// <param name="clientId">The client to which the data should be sent.</param>
/// <param name="dataBytes">The data to deliver (in binary format).</param>
/// <returns>The generated notification.</returns>
- (FMWebSyncNotification*) notifyWithClientId:(FMGuid*)clientId dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Sends a notification synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncNotification" /> it automatically creates.
/// </remarks>
/// <param name="clientId">The client to which the data should be sent.</param>
/// <param name="dataBytes">The data to deliver (in binary format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
/// <returns>The generated notification.</returns>
- (FMWebSyncNotification*) notifyWithClientId:(FMGuid*)clientId dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Sends a notification synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncNotification" /> it automatically creates.
/// </remarks>
/// <param name="clientId">The client to which the data should be sent.</param>
/// <param name="dataJson">The data to deliver (in JSON format).</param>
/// <returns>The generated notification.</returns>
- (FMWebSyncNotification*) notifyWithClientId:(FMGuid*)clientId dataJson:(NSString*)dataJson;
/// <summary>
/// Sends a notification synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncNotification" /> it automatically creates.
/// </remarks>
/// <param name="clientId">The client to which the data should be sent.</param>
/// <param name="dataJson">The data to deliver (in JSON format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
/// <returns>The generated notification.</returns>
- (FMWebSyncNotification*) notifyWithClientId:(FMGuid*)clientId dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Sends a notification synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncNotification" /> it sends.
/// </remarks>
/// <param name="notification">The notification to send.</param>
/// <returns>The completed notification.</returns>
- (FMWebSyncNotification*) notifyWithNotification:(FMWebSyncNotification*)notification;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncPublisher" /> class.
/// </summary>
/// <param name="requestUrl">The absolute URL of the WebSync server request handler.</param>
+ (FMWebSyncPublisher*) publisherWithRequestUrl:(NSString*)requestUrl;
/// <summary>
/// Sends an array of publications synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncPublication">Publications</see> it sends.
/// </remarks>
/// <param name="publications">The publications to send.</param>
/// <returns>The completed publications.</returns>
- (NSMutableArray*) publishManyWithPublications:(NSMutableArray*)publications;
/// <summary>
/// Sends a publication synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncPublication" /> it automatically creates.
/// </remarks>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataBytes">The data to send (in binary format).</param>
/// <returns>The generated publication.</returns>
- (FMWebSyncPublication*) publishWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Sends a publication synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncPublication" /> it automatically creates.
/// </remarks>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataBytes">The data to send (in binary format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
/// <returns>The generated publication.</returns>
- (FMWebSyncPublication*) publishWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Sends a publication synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncPublication" /> it automatically creates.
/// </remarks>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataJson">The data to send (in JSON format).</param>
/// <returns>The generated publication.</returns>
- (FMWebSyncPublication*) publishWithChannel:(NSString*)channel dataJson:(NSString*)dataJson;
/// <summary>
/// Sends a publication synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncPublication" /> it automatically creates.
/// </remarks>
/// <param name="channel">The channel to which the data should be sent.</param>
/// <param name="dataJson">The data to send (in JSON format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
/// <returns>The generated publication.</returns>
- (FMWebSyncPublication*) publishWithChannel:(NSString*)channel dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Sends a publication synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncPublication" /> it sends.
/// </remarks>
/// <param name="publication">The publication to send.</param>
/// <returns>The completed publication.</returns>
- (FMWebSyncPublication*) publishWithPublication:(FMWebSyncPublication*)publication;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncPublisher" /> notify request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherNotifyRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnNotifyRequestWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncPublisher" /> notify request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherNotifyRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnNotifyRequest:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncPublisher" /> notify response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherNotifyResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnNotifyResponseWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncPublisher" /> notify response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherNotifyResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnNotifyResponse:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncPublisher" /> publish request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherPublishRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnPublishRequestWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncPublisher" /> publish request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherPublishRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnPublishRequest:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncPublisher" /> publish response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherPublishResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnPublishResponseWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncPublisher" /> publish response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherPublishResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnPublishResponse:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncPublisher" /> service request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherServiceRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnServiceRequestWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before a <see cref="FMWebSyncPublisher" /> service request begins. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a request before it is sent to the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherServiceRequestArgs" /> associated with the event.</parameter>
+ (void) removeOnServiceRequest:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncPublisher" /> service response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherServiceResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnServiceResponseWithValue:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised after a <see cref="FMWebSyncPublisher" /> service response returns. This event is
/// designed to support extensions by allowing modifications to be applied
/// to a response after it is received from the server.
/// </summary>
/// <parameter name="source">The publisher that fired the event</parameter>
/// <parameter name="args">The <see cref="FMWebSyncPublisherServiceResponseArgs" /> associated with the event.</parameter>
+ (void) removeOnServiceResponse:(FMCallback*)value;
/// <summary>
/// Services an array of messages synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncMessage">Messages</see> it sends.
/// </remarks>
/// <param name="messages">The messages to send.</param>
/// <returns>The completed messages.</returns>
- (NSMutableArray*) serviceManyWithMessages:(NSMutableArray*)messages;
/// <summary>
/// Services a message synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncMessage" /> it automatically creates.
/// </remarks>
/// <param name="channel">The channel to which the data should be serviced.</param>
/// <param name="dataBytes">The data to send (in binary format).</param>
/// <returns>The generated message.</returns>
- (FMWebSyncMessage*) serviceWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes;
/// <summary>
/// Services a message synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncMessage" /> it automatically creates.
/// </remarks>
/// <param name="channel">The channel to which the data should be serviced.</param>
/// <param name="dataBytes">The data to send (in binary format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
/// <returns>The generated message.</returns>
- (FMWebSyncMessage*) serviceWithChannel:(NSString*)channel dataBytes:(NSMutableData*)dataBytes tag:(NSString*)tag;
/// <summary>
/// Services a message synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncMessage" /> it automatically creates.
/// </remarks>
/// <param name="channel">The channel to which the data should be serviced.</param>
/// <param name="dataJson">The data to send (in JSON format).</param>
/// <returns>The generated message.</returns>
- (FMWebSyncMessage*) serviceWithChannel:(NSString*)channel dataJson:(NSString*)dataJson;
/// <summary>
/// Services a message synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncMessage" /> it automatically creates.
/// </remarks>
/// <param name="channel">The channel to which the data should be serviced.</param>
/// <param name="dataJson">The data to send (in JSON format).</param>
/// <param name="tag">The tag that identifies the contents of the payload.</param>
/// <returns>The generated message.</returns>
- (FMWebSyncMessage*) serviceWithChannel:(NSString*)channel dataJson:(NSString*)dataJson tag:(NSString*)tag;
/// <summary>
/// Services a message synchronously over HTTP.
/// </summary>
/// <remarks>
/// This method always executes synchronously and returns the
/// <see cref="FMWebSyncMessage" /> it sends.
/// </remarks>
/// <param name="message">The message to send.</param>
/// <returns>The completed message.</returns>
- (FMWebSyncMessage*) serviceWithMessage:(FMWebSyncMessage*)message;

@end


@class NSStringFMExtensions;
@class NSMutableArrayFMExtensions;

/// <summary>
/// A key-value record for binding to a client.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncRecord : FMDynamic 

/// <summary>
/// Creates a deep clone of this record.
/// </summary>
/// <returns>A deep clone of this record.</returns>
- (FMWebSyncRecord*) duplicate;
/// <summary>
/// Deserializes a list of records from JSON.
/// </summary>
/// <param name="recordsJson">A JSON string to deserialize.</param>
/// <returns>A deserialized list of records.</returns>
+ (NSMutableArray*) fromJsonMultipleWithRecordsJson:(NSString*)recordsJson;
/// <summary>
/// Deserializes a record from JSON.
/// </summary>
/// <param name="recordJson">A JSON string to deserialize.</param>
/// <returns>A deserialized record.</returns>
+ (FMWebSyncRecord*) fromJsonWithRecordJson:(NSString*)recordJson;
/// <summary>
/// Returns a hash code for this instance.
/// </summary>
/// <returns>
/// A hash code for this instance, suitable for use in hashing algorithms and data structures like a hash table.
/// </returns>
- (int) hash;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncRecord" /> class.
/// </summary>
/// <param name="key">The key used to locate the value.</param>
- (id) initWithKey:(NSString*)key;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncRecord" /> class.
/// </summary>
/// <param name="key">The key used to locate the value.</param>
/// <param name="valueJson">The value in JSON format.</param>
- (id) initWithKey:(NSString*)key valueJson:(NSString*)valueJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncRecord" /> class.
/// </summary>
/// <param name="key">The key used to locate the value.</param>
/// <param name="valueJson">The value in JSON format.</param>
/// <param name="priv">Whether the record is (to be) private.</param>
- (id) initWithKey:(NSString*)key valueJson:(NSString*)valueJson priv:(bool)priv;
/// <summary>
/// Determines whether the specified object is equal to this instance.
/// </summary>
/// <param name="obj">The object to compare with this instance.</param>
/// <returns>
/// <c>true</c> if the specified object is equal to this instance; otherwise, <c>false</c>.
/// </returns>
- (bool) isEqualWithObj:(NSObject*)obj;
/// <summary>
/// Gets the key used to locate the value.
/// </summary>
- (NSString*) key;
/// <summary>
/// Gets the flag that indicates whether or not the record is (to be) hidden from other
/// clients. If <c>true</c>, the record will only be visible to the source client
/// and the server. If <c>false</c> or <c>null</c>, the record will be publicly
/// visible to other clients. Defaults to <c>null</c>.
/// </summary>
- (bool) private;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncRecord" /> class.
/// </summary>
/// <param name="key">The key used to locate the value.</param>
+ (FMWebSyncRecord*) recordWithKey:(NSString*)key;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncRecord" /> class.
/// </summary>
/// <param name="key">The key used to locate the value.</param>
/// <param name="valueJson">The value in JSON format.</param>
+ (FMWebSyncRecord*) recordWithKey:(NSString*)key valueJson:(NSString*)valueJson;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncRecord" /> class.
/// </summary>
/// <param name="key">The key used to locate the value.</param>
/// <param name="valueJson">The value in JSON format.</param>
/// <param name="priv">Whether the record is (to be) private.</param>
+ (FMWebSyncRecord*) recordWithKey:(NSString*)key valueJson:(NSString*)valueJson priv:(bool)priv;
/// <summary>
/// Sets the key used to locate the value.
/// </summary>
- (void) setKey:(NSString*)value;
/// <summary>
/// Sets the flag that indicates whether or not the record is (to be) hidden from other
/// clients. If <c>true</c>, the record will only be visible to the source client
/// and the server. If <c>false</c> or <c>null</c>, the record will be publicly
/// visible to other clients. Defaults to <c>null</c>.
/// </summary>
- (void) setPrivate:(bool)value;
- (void) setValidate:(bool)value;
/// <summary>
/// Sets the record value.  This must be valid JSON.
/// </summary>
- (void) setValueJson:(NSString*)value;
/// <summary>
/// Serializes the record to JSON.
/// </summary>
/// <returns>The record in JSON-serialized format.</returns>
- (NSString*) toJson;
/// <summary>
/// Serializes a list of records to JSON.
/// </summary>
/// <param name="records">A list of records to serialize.</param>
/// <returns>A JSON-serialized array of records.</returns>
+ (NSString*) toJsonMultipleWithRecords:(NSMutableArray*)records;
/// <summary>
/// Serializes a record to JSON.
/// </summary>
/// <param name="record">A record to serialize.</param>
/// <returns>A JSON-serialized record.</returns>
+ (NSString*) toJsonWithRecord:(FMWebSyncRecord*)record;
/// <summary>
/// Returns a string that represents this instance.
/// </summary>
/// <returns>
/// A string that represents this instance.
/// </returns>
- (NSString*) toString;
/// <summary>
/// Returns a string that represents this instance.
/// </summary>
/// <returns>
/// A string that represents this instance.
/// </returns>
- (NSString*) description;
- (bool) validate;
/// <summary>
/// Gets the record value.  This must be valid JSON.
/// </summary>
- (NSString*) valueJson;

@end


@class FMWebSyncAdvice;
@class FMWebSyncBaseAdvice;
@class NSMutableDictionaryFMExtensions;
@class FMWebSyncExtensions;
@class FMWebSyncMessage;
@class FMWebSyncNotification;
@class FMWebSyncNotifyingClient;
@class FMWebSyncPublication;
@class FMWebSyncPublishingClient;
@class FMWebSyncRecord;
@class FMWebSyncSubscribedClient;
@class NSStringFMExtensions;
@class NSMutableArrayFMExtensions;
@class FMWebSyncSubscription;
@class NSDateFMExtensions;
@class FMNullableDate;

#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSerializer : NSObject 

+ (FMWebSyncAdvice*) createAdvice;
+ (FMWebSyncBaseAdvice*) createBaseAdvice;
+ (NSMutableDictionary*) createBoundRecords;
+ (FMWebSyncExtensions*) createExtensions;
+ (FMWebSyncMessage*) createMessage;
+ (FMWebSyncNotification*) createNotification;
+ (FMWebSyncNotifyingClient*) createNotifyingClient;
+ (FMWebSyncPublication*) createPublication;
+ (FMWebSyncPublishingClient*) createPublishingClient;
+ (FMWebSyncRecord*) createRecord;
+ (FMWebSyncSubscribedClient*) createSubscribedClient;
+ (void) deserializeAdviceCallbackWithAdvice:(FMWebSyncAdvice*)advice name:(NSString*)name valueJson:(NSString*)valueJson;
+ (FMWebSyncAdvice*) deserializeAdviceWithAdviceJson:(NSString*)adviceJson;
+ (FMWebSyncAdvice*) deserializeAdviceWithJson:(NSString*)adviceJson;
+ (void) deserializeBaseAdviceCallbackWithAdvice:(FMWebSyncBaseAdvice*)advice name:(NSString*)name valueJson:(NSString*)valueJson;
+ (FMWebSyncBaseAdvice*) deserializeBaseAdviceWithBaseAdviceJson:(NSString*)baseAdviceJson;
+ (FMWebSyncBaseAdvice*) deserializeBaseAdviceWithJson:(NSString*)baseAdviceJson;
+ (void) deserializeBoundRecordsCallbackWithBoundRecords:(NSMutableDictionary*)boundRecords name:(NSString*)name valueJson:(NSString*)valueJson;
+ (NSMutableDictionary*) deserializeBoundRecordsWithBoundRecordsJson:(NSString*)boundRecordsJson;
+ (NSMutableDictionary*) deserializeBoundRecordsWithJson:(NSString*)boundRecordsJson;
+ (NSMutableArray*) deserializeConnectionTypeArrayWithConnectionTypesJson:(NSString*)connectionTypesJson;
+ (FMWebSyncConnectionType) deserializeConnectionTypeWithConnectionTypeJson:(NSString*)connectionTypeJson;
+ (FMWebSyncConnectionType) deserializeConnectionTypeWithJson:(NSString*)connectionTypeJson;
+ (void) deserializeExtensionsCallbackWithExtensions:(FMWebSyncExtensions*)extensions name:(NSString*)name valueJson:(NSString*)valueJson;
+ (FMWebSyncExtensions*) deserializeExtensionsWithExtensionsJson:(NSString*)extensionsJson;
+ (FMWebSyncExtensions*) deserializeExtensionsWithJson:(NSString*)extensionsJson;
+ (NSMutableArray*) deserializeMessageArrayWithMessagesJson:(NSString*)messagesJson;
+ (void) deserializeMessageCallbackWithMessage:(FMWebSyncMessage*)message name:(NSString*)name valueJson:(NSString*)valueJson;
+ (FMWebSyncMessage*) deserializeMessageWithMessageJson:(NSString*)messageJson;
+ (FMWebSyncMessage*) deserializeMessageWithJson:(NSString*)messageJson;
+ (NSMutableArray*) deserializeNotificationArrayWithNotificationsJson:(NSString*)notificationsJson;
+ (void) deserializeNotificationCallbackWithNotification:(FMWebSyncNotification*)notification name:(NSString*)name valueJson:(NSString*)valueJson;
+ (FMWebSyncNotification*) deserializeNotificationWithNotificationJson:(NSString*)notificationJson;
+ (FMWebSyncNotification*) deserializeNotificationWithJson:(NSString*)notificationJson;
+ (void) deserializeNotifyingClientCallbackWithNotifyingClient:(FMWebSyncNotifyingClient*)notifyingClient name:(NSString*)name valueJson:(NSString*)valueJson;
+ (FMWebSyncNotifyingClient*) deserializeNotifyingClientWithNotifyingClientJson:(NSString*)notifyingClientJson;
+ (FMWebSyncNotifyingClient*) deserializeNotifyingClientWithJson:(NSString*)notifyingClientJson;
+ (NSMutableArray*) deserializePublicationArrayWithPublicationsJson:(NSString*)publicationsJson;
+ (void) deserializePublicationCallbackWithPublication:(FMWebSyncPublication*)publication name:(NSString*)name valueJson:(NSString*)valueJson;
+ (FMWebSyncPublication*) deserializePublicationWithPublicationJson:(NSString*)publicationJson;
+ (FMWebSyncPublication*) deserializePublicationWithJson:(NSString*)publicationJson;
+ (void) deserializePublishingClientCallbackWithPublishingClient:(FMWebSyncPublishingClient*)publishingClient name:(NSString*)name valueJson:(NSString*)valueJson;
+ (FMWebSyncPublishingClient*) deserializePublishingClientWithPublishingClientJson:(NSString*)publishingClientJson;
+ (FMWebSyncPublishingClient*) deserializePublishingClientWithJson:(NSString*)publishingClientJson;
+ (FMWebSyncReconnect) deserializeReconnectWithReconnectJson:(NSString*)reconnectJson;
+ (FMWebSyncReconnect) deserializeReconnectWithJson:(NSString*)reconnectJson;
+ (NSMutableArray*) deserializeRecordArrayWithRecordsJson:(NSString*)recordsJson;
+ (void) deserializeRecordCallbackWithRecord:(FMWebSyncRecord*)record name:(NSString*)name valueJson:(NSString*)valueJson;
+ (FMWebSyncRecord*) deserializeRecordWithRecordJson:(NSString*)recordJson;
+ (FMWebSyncRecord*) deserializeRecordWithJson:(NSString*)recordJson;
+ (NSMutableArray*) deserializeSubscribedClientArrayWithSubscribedClientsJson:(NSString*)subscribedClientsJson;
+ (void) deserializeSubscribedClientCallbackWithSubscribedClient:(FMWebSyncSubscribedClient*)subscribedClient name:(NSString*)name valueJson:(NSString*)valueJson;
+ (FMWebSyncSubscribedClient*) deserializeSubscribedClientWithSubscribedClientJson:(NSString*)subscribedClientJson;
+ (FMWebSyncSubscribedClient*) deserializeSubscribedClientWithJson:(NSString*)subscribedClientJson;
+ (NSMutableArray*) deserializeSubscriptionArrayWithSubscriptionsJson:(NSString*)subscriptionsJson;
+ (FMWebSyncSubscription*) deserializeSubscriptionWithSubscriptionJson:(NSString*)subscriptionJson;
+ (FMWebSyncSubscription*) deserializeSubscriptionWithJson:(NSString*)subscriptionJson;
+ (NSDate*) deserializeTimestampWithTimestampJson:(NSString*)timestampJson;
+ (NSDate*) deserializeTimestampWithJson:(NSString*)timestampJson;
- (id) init;
+ (void) serializeAdviceCallbackWithAdvice:(FMWebSyncAdvice*)advice jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializeAdviceWithAdvice:(FMWebSyncAdvice*)advice;
+ (NSString*) serializeAdvice:(FMWebSyncAdvice*)advice;
+ (void) serializeBaseAdviceCallbackWithBaseAdvice:(FMWebSyncBaseAdvice*)baseAdvice jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializeBaseAdviceWithBaseAdvice:(FMWebSyncBaseAdvice*)baseAdvice;
+ (NSString*) serializeBaseAdvice:(FMWebSyncBaseAdvice*)baseAdvice;
+ (void) serializeBoundRecordsCallbackWithBoundRecords:(NSMutableDictionary*)boundRecords jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializeBoundRecordsWithBoundRecords:(NSMutableDictionary*)boundRecords;
+ (NSString*) serializeBoundRecords:(NSMutableDictionary*)boundRecords;
+ (NSString*) serializeConnectionTypeArrayWithConnectionTypes:(NSMutableArray*)connectionTypes;
+ (NSString*) serializeConnectionTypeWithConnectionType:(FMWebSyncConnectionType)connectionType;
+ (NSString*) serializeConnectionType:(FMWebSyncConnectionType)connectionType;
+ (void) serializeExtensionsCallbackWithExtensions:(FMWebSyncExtensions*)extensions jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializeExtensionsWithExtensions:(FMWebSyncExtensions*)extensions;
+ (NSString*) serializeExtensions:(FMWebSyncExtensions*)extensions;
+ (NSString*) serializeMessageArrayWithMessages:(NSMutableArray*)messages;
+ (void) serializeMessageCallbackWithMessage:(FMWebSyncMessage*)message jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializeMessageWithMessage:(FMWebSyncMessage*)message;
+ (NSString*) serializeMessage:(FMWebSyncMessage*)message;
+ (NSString*) serializeNotificationArrayWithNotifications:(NSMutableArray*)notifications;
+ (void) serializeNotificationCallbackWithNotification:(FMWebSyncNotification*)notification jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializeNotificationWithNotification:(FMWebSyncNotification*)notification;
+ (NSString*) serializeNotification:(FMWebSyncNotification*)notification;
+ (void) serializeNotifyingClientCallbackWithNotifyingClient:(FMWebSyncNotifyingClient*)notifyingClient jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializeNotifyingClientWithNotifyingClient:(FMWebSyncNotifyingClient*)notifyingClient;
+ (NSString*) serializeNotifyingClient:(FMWebSyncNotifyingClient*)notifyingClient;
+ (NSString*) serializePublicationArrayWithPublications:(NSMutableArray*)publications;
+ (void) serializePublicationCallbackWithPublication:(FMWebSyncPublication*)publication jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializePublicationWithPublication:(FMWebSyncPublication*)publication;
+ (NSString*) serializePublication:(FMWebSyncPublication*)publication;
+ (void) serializePublishingClientCallbackWithPublishingClient:(FMWebSyncPublishingClient*)publishingClient jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializePublishingClientWithPublishingClient:(FMWebSyncPublishingClient*)publishingClient;
+ (NSString*) serializePublishingClient:(FMWebSyncPublishingClient*)publishingClient;
+ (FMWebSyncSerializer*) serializer;
+ (NSString*) serializeReconnectWithReconnect:(FMWebSyncReconnect)reconnect;
+ (NSString*) serializeReconnect:(FMWebSyncReconnect)reconnect;
+ (NSString*) serializeRecordArrayWithRecords:(NSMutableArray*)records;
+ (void) serializeRecordCallbackWithRecord:(FMWebSyncRecord*)record jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializeRecordWithRecord:(FMWebSyncRecord*)record;
+ (NSString*) serializeRecord:(FMWebSyncRecord*)record;
+ (NSString*) serializeSubscribedClientArrayWithSubscribedClients:(NSMutableArray*)subscribedClients;
+ (void) serializeSubscribedClientCallbackWithSubscribedClient:(FMWebSyncSubscribedClient*)subscribedClient jsonObject:(NSMutableDictionary*)jsonObject;
+ (NSString*) serializeSubscribedClientWithSubscribedClient:(FMWebSyncSubscribedClient*)subscribedClient;
+ (NSString*) serializeSubscribedClient:(FMWebSyncSubscribedClient*)subscribedClient;
+ (NSString*) serializeSubscriptionArrayWithSubscriptions:(NSMutableArray*)subscriptions;
+ (NSString*) serializeSubscriptionWithSubscription:(FMWebSyncSubscription*)subscription;
+ (NSString*) serializeSubscription:(FMWebSyncSubscription*)subscription;
+ (NSString*) serializeTimestampWithTimestamp:(FMNullableDate*)timestamp;
+ (NSString*) serializeTimestamp:(FMNullableDate*)timestamp;

@end


@class FMHttpRequestCreatedArgs;
@class FMHttpResponseReceivedArgs;
@class FMWebSocketOpenSuccessArgs;
@class FMWebSocketOpenFailureArgs;
@class FMWebSocketStreamFailureArgs;
@class FMWebSyncMessageResponseArgs;
@class NSStringFMExtensions;
@class FMWebSocketTransfer;
@class FMCallback;
@class FMNameValueCollection;
@class FMWebSyncMessageRequestArgs;

/// <summary>
/// Base class that defines methods for transferring messages over HTTP.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncWebSocketMessageTransfer : FMWebSyncMessageTransfer 

/// <summary>
/// Gets the timeout for the initial handshake.
/// </summary>
- (int) handshakeTimeout;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncWebSocketMessageTransfer" /> class.
/// </summary>
/// <param name="url">The URL.</param>
- (id) initWithUrl:(NSString*)url;
/// <summary>
/// Gets the callback to invoke if the handshake fails.
/// </summary>
- (FMCallback*) onOpenFailure;
/// <summary>
/// Gets the callback to invoke if the handshake succeeds.
/// </summary>
- (FMCallback*) onOpenSuccess;
/// <summary>
/// Gets the callback to invoke when the handshake request is created.
/// </summary>
- (FMCallback*) onRequestCreated;
/// <summary>
/// Gets the callback to invoke when the handshake response is received.
/// </summary>
- (FMCallback*) onResponseReceived;
/// <summary>
/// Gets the callback to invoke if the stream errors out.
/// </summary>
- (FMCallback*) onStreamFailure;
/// <summary>
/// Opens the socket.
/// </summary>
/// <param name="headers">The headers to pass in with the initial handshake.</param>
- (void) openWithHeaders:(FMNameValueCollection*)headers;
/// <summary>
/// Gets the sender of the messages.
/// </summary>
- (NSObject*) sender;
/// <summary>
/// Sends a request asynchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <param name="callback">The callback to execute with the response parameters.</param>
- (void) sendMessagesAsyncWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs callback:(FMCallback*)callback;
/// <summary>
/// Sends a request asynchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <param name="callback">The callback to execute with the response parameters.</param>
- (void) sendMessagesAsyncWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs callbackBlock:(void (^) (FMWebSyncMessageResponseArgs*))callbackBlock;
/// <summary>
/// Sends a request synchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <returns>
/// The response parameters.
/// </returns>
- (FMWebSyncMessageResponseArgs*) sendMessagesWithRequestArgs:(FMWebSyncMessageRequestArgs*)requestArgs;
/// <summary>
/// Sets the timeout for the initial handshake.
/// </summary>
- (void) setHandshakeTimeout:(int)value;
/// <summary>
/// Sets the callback to invoke if the handshake fails.
/// </summary>
- (void) setOnOpenFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the handshake fails.
/// </summary>
- (void) setOnOpenFailureBlock:(void (^) (FMWebSocketOpenFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the handshake succeeds.
/// </summary>
- (void) setOnOpenSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the handshake succeeds.
/// </summary>
- (void) setOnOpenSuccessBlock:(void (^) (FMWebSocketOpenSuccessArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke when the handshake request is created.
/// </summary>
- (void) setOnRequestCreated:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke when the handshake request is created.
/// </summary>
- (void) setOnRequestCreatedBlock:(void (^) (FMHttpRequestCreatedArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke when the handshake response is received.
/// </summary>
- (void) setOnResponseReceived:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke when the handshake response is received.
/// </summary>
- (void) setOnResponseReceivedBlock:(void (^) (FMHttpResponseReceivedArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke if the stream errors out.
/// </summary>
- (void) setOnStreamFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke if the stream errors out.
/// </summary>
- (void) setOnStreamFailureBlock:(void (^) (FMWebSocketStreamFailureArgs*))valueBlock;
/// <summary>
/// Sets the sender of the messages.
/// </summary>
- (void) setSender:(NSObject*)value;
/// <summary>
/// Sets the timeout for the stream.
/// </summary>
- (void) setStreamTimeout:(int)value;
/// <summary>
/// Sets the URL.
/// </summary>
- (void) setUrl:(NSString*)value;
/// <summary>
/// Releases any resources and shuts down.
/// </summary>
- (void) shutdown;
/// <summary>
/// Gets the timeout for the stream.
/// </summary>
- (int) streamTimeout;
/// <summary>
/// Gets the URL.
/// </summary>
- (NSString*) url;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncWebSocketMessageTransfer" /> class.
/// </summary>
/// <param name="url">The URL.</param>
+ (FMWebSyncWebSocketMessageTransfer*) webSocketMessageTransferWithUrl:(NSString*)url;

@end


@class NSStringFMExtensions;
@class NSMutableArrayFMExtensions;

/// <summary>
/// A channel/tag identifier for a client subscription.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscription : FMDynamic 

/// <summary>
/// Gets the subscription channel.
/// </summary>
- (NSString*) channel;
/// <summary>
/// Creates a deep clone of this subscription.
/// </summary>
/// <returns>A deep clone of this subscription.</returns>
- (FMWebSyncSubscription*) duplicate;
/// <summary>
/// Deserializes a list of subscriptions from JSON.
/// </summary>
/// <param name="subscriptionsJson">A JSON string to deserialize.</param>
/// <returns>A deserialized list of subscriptions.</returns>
+ (NSMutableArray*) fromJsonMultipleWithSubscriptionsJson:(NSString*)subscriptionsJson;
/// <summary>
/// Deserializes a subscription from JSON.
/// </summary>
/// <param name="subscriptionJson">A JSON string to deserialize.</param>
/// <returns>A deserialized subscription.</returns>
+ (FMWebSyncSubscription*) fromJsonWithSubscriptionJson:(NSString*)subscriptionJson;
/// <summary>
/// Returns a hash code for this instance.
/// </summary>
/// <returns>
/// A hash code for this instance, suitable for use in hashing algorithms and data structures like a hash table.
/// </returns>
- (int) hash;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscription" /> class.
/// </summary>
/// <param name="channel">The subscription channel.</param>
- (id) initWithChannel:(NSString*)channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscription" /> class.
/// </summary>
/// <param name="channel">The subscription channel.</param>
/// <param name="tag">The identifier for the subscription.</param>
- (id) initWithChannel:(NSString*)channel tag:(NSString*)tag;
/// <summary>
/// Determines whether the specified <see cref="FMWebSyncSubscription" /> is equal to this instance.
/// </summary>
/// <param name="obj">The <see cref="FMWebSyncSubscription" /> to compare with this instance.</param>
/// <returns>
/// <c>true</c> if the specified <see cref="FMWebSyncSubscription" /> is equal to this instance; otherwise, <c>false</c>.
/// </returns>
- (bool) isEqualWithObj:(NSObject*)obj;
/// <summary>
/// Sets the subscription channel.
/// </summary>
- (void) setChannel:(NSString*)value;
/// <summary>
/// Sets the identifier for the subscription.
/// </summary>
- (void) setTag:(NSString*)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscription" /> class.
/// </summary>
/// <param name="channel">The subscription channel.</param>
+ (FMWebSyncSubscription*) subscriptionWithChannel:(NSString*)channel;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscription" /> class.
/// </summary>
/// <param name="channel">The subscription channel.</param>
/// <param name="tag">The identifier for the subscription.</param>
+ (FMWebSyncSubscription*) subscriptionWithChannel:(NSString*)channel tag:(NSString*)tag;
/// <summary>
/// Gets the identifier for the subscription.
/// </summary>
- (NSString*) tag;
/// <summary>
/// Serializes the record to JSON.
/// </summary>
/// <returns>The record in JSON-serialized format.</returns>
- (NSString*) toJson;
/// <summary>
/// Serializes a list of subscriptions to JSON.
/// </summary>
/// <param name="subscriptions">A list of subscriptions to serialize.</param>
/// <returns>A JSON-serialized array of subscriptions.</returns>
+ (NSString*) toJsonMultipleWithSubscriptions:(NSMutableArray*)subscriptions;
/// <summary>
/// Serializes a subscription to JSON.
/// </summary>
/// <param name="subscription">A subscription to serialize.</param>
/// <returns>A JSON-serialized subscription.</returns>
+ (NSString*) toJsonWithSubscription:(FMWebSyncSubscription*)subscription;

@end


@class NSMutableDictionaryFMExtensions;
@class FMGuid;
@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Details about the subscribed client.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSyncSubscribedClient : FMSerializable 

/// <summary>
/// Gets the subscribed client's bound records.
/// </summary>
- (NSMutableDictionary*) boundRecords;
/// <summary>
/// Gets the subscribed client's ID.
/// </summary>
- (FMGuid*) clientId;
/// <summary>
/// Deserializes a JSON-formatted array of subscribed clients.
/// </summary>
/// <param name="subscribedClientsJson">The JSON-formatted array of subscribed clients to deserialize.</param>
/// <returns>The array of subscribed clients.</returns>
+ (NSMutableArray*) fromJsonMultipleWithSubscribedClientsJson:(NSString*)subscribedClientsJson;
/// <summary>
/// Deserializes a JSON-formatted subscribed client.
/// </summary>
/// <param name="subscribedClientJson">The JSON-formatted subscribed client to deserialize.</param>
/// <returns>The subscribed client.</returns>
+ (FMWebSyncSubscribedClient*) fromJsonWithSubscribedClientJson:(NSString*)subscribedClientJson;
/// <summary>
/// Gets the JSON value of a record bound to the subscribed client.
/// </summary>
/// <param name="key">The record key.</param>
/// <returns>The JSON value of the record, if it exists, or <c>null</c>.</returns>
- (NSString*) getBoundRecordValueJsonWithKey:(NSString*)key;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribedClient" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribedClient" /> class.
/// </summary>
/// <param name="clientId">The subscribed client's ID.</param>
/// <param name="boundRecords">The records bound to the client.</param>
- (id) initWithClientId:(FMGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Sets the subscribed client's bound records.
/// </summary>
- (void) setBoundRecords:(NSMutableDictionary*)value;
/// <summary>
/// Sets the subscribed client's ID.
/// </summary>
- (void) setClientId:(FMGuid*)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribedClient" /> class.
/// </summary>
+ (FMWebSyncSubscribedClient*) subscribedClient;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribedClient" /> class.
/// </summary>
/// <param name="clientId">The subscribed client's ID.</param>
/// <param name="boundRecords">The records bound to the client.</param>
+ (FMWebSyncSubscribedClient*) subscribedClientWithClientId:(FMGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSyncSubscribedClient" /> class.
/// </summary>
/// <param name="clientId">The subscribed client's ID.</param>
/// <param name="boundRecords">The records bound to the client.</param>
+ (FMWebSyncSubscribedClient*) subscribedClientWithId:(FMGuid*)clientId boundRecords:(NSMutableDictionary*)boundRecords;
/// <summary>
/// Serializes this instance to JSON.
/// </summary>
/// <returns>The JSON-formatted subscribed client.</returns>
- (NSString*) toJson;
/// <summary>
/// Serializes an array of subscribed clients to JSON.
/// </summary>
/// <param name="subscribedClients">The array of subscribed clients to serialize.</param>
/// <returns>The JSON-formatted array of subscribed clients.</returns>
+ (NSString*) toJsonMultipleWithSubscribedClients:(NSMutableArray*)subscribedClients;
/// <summary>
/// Serializes a subscribed client to JSON.
/// </summary>
/// <param name="subscribedClient">The subscribed client to serialize.</param>
/// <returns>The JSON-formatted subscribed client.</returns>
+ (NSString*) toJsonWithSubscribedClient:(FMWebSyncSubscribedClient*)subscribedClient;

@end



@interface FMWebSyncNullableConnectionType : NSObject 

+ (FMWebSyncNullableConnectionType*) fromValue: (FMWebSyncConnectionType) theValue;
+ (FMWebSyncNullableConnectionType*) null;
- (id) initWithConnectionTypeValue: (FMWebSyncConnectionType) theValue;
- (bool) hasValue;
- (FMWebSyncConnectionType) value;
- (void) setValue: (FMWebSyncConnectionType) theValue;

@end



@interface FMWebSyncNullableReconnect : NSObject 

+ (FMWebSyncNullableReconnect*) fromValue: (FMWebSyncReconnect) theValue;
+ (FMWebSyncNullableReconnect*) null;
- (id) initWithReconnectValue: (FMWebSyncReconnect) theValue;
- (bool) hasValue;
- (FMWebSyncReconnect) value;
- (void) setValue: (FMWebSyncReconnect) theValue;

@end

