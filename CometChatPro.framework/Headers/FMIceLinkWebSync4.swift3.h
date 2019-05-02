//
// Title: IceLink WebSync 4 Extension for Cocoa
// Version: 0.0.0.0
// Copyright Frozen Mountain Software 2011+
//

#import <Foundation/Foundation.h>

#import "FMIceLink.swift3.h"

@class FMSingleAction;
@class FMWeakArray;
@class FMWeakDictionary;
@class FMZeroingWeakProxy;
@class FMZeroingWeakRef;
@class FMIFormatProvider;
@class FMCultureInfo;
@class FMAsyncException;
@class FMBitAssistant;
@class FMByteCollection;
@class FMCallback;
@class FMCallbackAction;
@class FMConvert;
@class FMCrypto;
@class FMDateTimeFormatInfo;
@class FMDelegate;
@class FMEncoding;
@class FMEnvironment;
@class FMGlobal;
@class FMGuid;
@class FMJsonChecker;
@class FMRecursiveCondition;
@class FMManagedLock;
@class FMManagedCondition;
@class FMManagedStopwatch;
@class FMManagedThread;
@class FMMathAssistant;
@class FMNameValueCollection;
@class FMNullableBool;
@class FMNullableChar;
@class FMNullableDate;
@class FMNullableDecimal;
@class FMNullableDouble;
@class FMNullableFloat;
@class FMNullableGuid;
@class FMNullableInt;
@class FMNullableLong;
@class FMNullableShort;
@class FMNullableUnichar;
@class FMNumberFormatInfo;
@class FMParseAssistant;
@class FMRandom;
@class FMTimeoutTimer;
@class FMTimeSpan;
@class FMRandomizer;
@class FMDnsRequest;
@class FMWebSocketMockRequest;
@class FMWebSocketMockResponse;
@class FMSerializable;
@class FMDynamic;
@class FMTcpOutputArgs;
@class FMTcpAcceptArgs;
@class FMTcpAcceptCompleteArgs;
@class FMTcpAcceptFailureArgs;
@class FMTcpAcceptSuccessArgs;
@class FMUdpOutputArgs;
@class FMUdpReceiveArgs;
@class FMUdpReceiveCompleteArgs;
@class FMUdpReceiveFailureArgs;
@class FMUdpReceiveSuccessArgs;
@class FMUdpSendArgs;
@class FMUdpSendCompleteArgs;
@class FMUdpSendFailureArgs;
@class FMUdpSendSuccessArgs;
@class FMTcpReceiveArgs;
@class FMTcpReceiveCompleteArgs;
@class FMTcpReceiveFailureArgs;
@class FMTcpReceiveSuccessArgs;
@class FMTcpSendArgs;
@class FMTcpSendCompleteArgs;
@class FMTcpSendFailureArgs;
@class FMTcpSendSuccessArgs;
@class FMTcpConnectCompleteArgs;
@class FMTcpConnectFailureArgs;
@class FMTcpConnectSuccessArgs;
@class FMTcpConnectArgs;
@class FMHttpResponseReceivedArgs;
@class FMWebSocketCloseArgs;
@class FMWebSocketCloseCompleteArgs;
@class FMWebSocketOpenArgs;
@class FMWebSocketOpenFailureArgs;
@class FMWebSocketOpenSuccessArgs;
@class FMWebSocketReceiveArgs;
@class FMWebSocketSendArgs;
@class FMWebSocketStreamFailureArgs;
@class FMBaseTimeoutTimer;
@class FMBaseWebSocket;
@class FMBinary;
@class FMByteHolder;
@class FMByteInputStream;
@class FMCallbackState;
@class FMCharacterHolder;
@class FMLogProvider;
@class FMByteOutputStream;
@class FMBooleanHolder;
@class FMDns;
@class FMWebSocketTransfer;
@class FMWebSocketTransferFactory;
@class FMLittleEndianBuffer;
@class FMFileStream;
@class FMJson;
@class FMJsonProvider;
@class FMNullJsonProvider;
@class FMDoubleHolder;
@class FMFloatHolder;
@class FMHttpRequestArgs;
@class FMHttpRequestCreatedArgs;
@class FMHttpResponseArgs;
@class FMHttpSendFinishArgs;
@class FMHttpSendStartArgs;
@class FMIntegerHolder;
@class FMLockedRandomizer;
@class FMLog;
@class FMLongHolder;
@class FMNetworkBuffer;
@class FMShortHolder;
@class FMSplitter;
@class FMTextLogProvider;
@class FMStringAssistant;
@class FMHttpTransfer;
@class FMHttpTransferFactory;
@class FMNullLogProvider;
@class FMSerializer;
@class FMWebSocket;
@class FMWebSocketSendState;
@class FMWebSocketRequest;
@class FMWebSocketWebRequestTransfer;
@class FMFile;
@class FMHttpRequest;
@class FMHttpWebRequest;
@class FMHttpWebRequestTransfer;
@class FMAsyncSocket;
@class FMTcpSocket;
@class FMUdpSocket;
@class FMNSLogProvider;
@class FMTextViewLogProvider;
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
@class FMWebSyncNullableConnectionType;
@class FMWebSyncNullableReconnect;
@class FMWebSyncChatUserClientJoinArgs;
@class FMWebSyncChatUserClientLeaveArgs;
@class FMWebSyncChatChatClient;
@class FMWebSyncChatChatUser;
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
@class FMWebSyncSubscribersBase;
@class FMWebSyncSubscribersClientUnsubscribeArgs;
@class FMWebSyncSubscribersSerializer;
@class FMWebSyncSubscribersSubscriberChange;
@class FMWebSyncSubscribersClientSubscribeArgs;
@class FMIceLinkWebSync4JoinConferenceArgs;
@class FMIceLinkWebSync4JoinConferenceFailureArgs;
@class FMIceLinkWebSync4JoinConferenceReceiveArgs;
@class FMIceLinkWebSync4JoinConferenceSuccessArgs;
@class FMIceLinkWebSync4LeaveConferenceArgs;
@class FMIceLinkWebSync4LeaveConferenceFailureArgs;
@class FMIceLinkWebSync4LeaveConferenceSuccessArgs;
@class FMWebSyncClientExtensions;
@class FMIceLinkWebSync4PeerClient;

@interface FMSingleAction : FMCallback

- (instancetype)initWithBlock:(void (^)(id))block;

@end


/*!
 * <div>
 * Arguments for a client joining an IceLink conference.
 * </div>
 */
@interface FMIceLinkWebSync4JoinConferenceArgs : FMWebSyncBaseInputArgs

/*!
 * <div>
 * Gets the conference channel.
 * </div>
 */
- (NSString*) conferenceChannel;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkWebSync4JoinConferenceArgs class.
 * </div>
 * @param conferenceChannel The conference channel.
 */
- (instancetype) initWithConferenceChannel:(NSString*)conferenceChannel;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkWebSync4JoinConferenceArgs class.
 * </div>
 * @param conferenceChannel The conference channel.
 */
+ (FMIceLinkWebSync4JoinConferenceArgs*) joinConferenceArgsWithConferenceChannel:(NSString*)conferenceChannel;
/*!
 * <div>
 * Gets the callback to invoke if the request fails.
 * See FMIceLinkWebSync4JoinConferenceFailureArgs for callback argument details.
 * </div>
 */
- (FMIceLinkAction1*) onFailure;
/*!
 * <div>
 * Gets the callback to invoke when data is received on the channel.
 * See FMIceLinkWebSync4JoinConferenceReceiveArgs for callback argument details.
 * </div>
 */
- (FMIceLinkAction1*) onReceive;
/*!
 * <div>
 * Gets the callback to invoke when a new remote client needs a connection.
 * </div>
 */
- (FMIceLinkFunction1*) onRemoteClient;
/*!
 * <div>
 * Gets the callback to invoke if the request succeeds.
 * See FMIceLinkWebSync4JoinConferenceSuccessArgs for callback argument details.
 * </div>
 */
- (FMIceLinkAction1*) onSuccess;
/*!
 * <div>
 * Sets the conference channel.
 * </div>
 */
- (void) setConferenceChannel:(NSString*)value;
/*!
 * <div>
 * Sets the callback to invoke if the request fails.
 * See FMIceLinkWebSync4JoinConferenceFailureArgs for callback argument details.
 * </div>
 */
- (void) setOnFailure:(FMIceLinkAction1*)value;
/*!
 * <div>
 * Sets the callback to invoke if the request fails.
 * See FMIceLinkWebSync4JoinConferenceFailureArgs for callback argument details.
 * </div>
 */
- (void (^)(void(^)(FMIceLinkWebSync4JoinConferenceFailureArgs*))) setOnFailureBlock;
/*!
 * <div>
 * Sets the callback to invoke if the request fails.
 * See FMIceLinkWebSync4JoinConferenceFailureArgs for callback argument details.
 * </div>
 */
- (void) setOnFailureBlock:(void(^)(FMIceLinkWebSync4JoinConferenceFailureArgs*))valueBlock;
/*!
 * <div>
 * Sets the callback to invoke when data is received on the channel.
 * See FMIceLinkWebSync4JoinConferenceReceiveArgs for callback argument details.
 * </div>
 */
- (void) setOnReceive:(FMIceLinkAction1*)value;
/*!
 * <div>
 * Sets the callback to invoke when data is received on the channel.
 * See FMIceLinkWebSync4JoinConferenceReceiveArgs for callback argument details.
 * </div>
 */
- (void (^)(void(^)(FMIceLinkWebSync4JoinConferenceReceiveArgs*))) setOnReceiveBlock;
/*!
 * <div>
 * Sets the callback to invoke when data is received on the channel.
 * See FMIceLinkWebSync4JoinConferenceReceiveArgs for callback argument details.
 * </div>
 */
- (void) setOnReceiveBlock:(void(^)(FMIceLinkWebSync4JoinConferenceReceiveArgs*))valueBlock;
/*!
 * <div>
 * Sets the callback to invoke when a new remote client needs a connection.
 * </div>
 */
- (void) setOnRemoteClient:(FMIceLinkFunction1*)value;
/*!
 * <div>
 * Sets the callback to invoke when a new remote client needs a connection.
 * </div>
 */
- (void (^)(FMIceLinkConnection*(^)(FMIceLinkWebSync4PeerClient*))) setOnRemoteClientBlock;
/*!
 * <div>
 * Sets the callback to invoke when a new remote client needs a connection.
 * </div>
 */
- (void) setOnRemoteClientBlock:(FMIceLinkConnection*(^)(FMIceLinkWebSync4PeerClient*))valueBlock;
/*!
 * <div>
 * Sets the callback to invoke if the request succeeds.
 * See FMIceLinkWebSync4JoinConferenceSuccessArgs for callback argument details.
 * </div>
 */
- (void) setOnSuccess:(FMIceLinkAction1*)value;
/*!
 * <div>
 * Sets the callback to invoke if the request succeeds.
 * See FMIceLinkWebSync4JoinConferenceSuccessArgs for callback argument details.
 * </div>
 */
- (void (^)(void(^)(FMIceLinkWebSync4JoinConferenceSuccessArgs*))) setOnSuccessBlock;
/*!
 * <div>
 * Sets the callback to invoke if the request succeeds.
 * See FMIceLinkWebSync4JoinConferenceSuccessArgs for callback argument details.
 * </div>
 */
- (void) setOnSuccessBlock:(void(^)(FMIceLinkWebSync4JoinConferenceSuccessArgs*))valueBlock;
/*!
 * <div>
 * Sets a value indicating whether this endpoint
 * should drop existing links in favour of new ones
 * when remote peers join the channel.
 * Defaults to <code>true</code>.
 * </div>
 */
- (void) setUnlinkExistingOnUserJoin:(bool)value;
/*!
 * <div>
 * Sets a value indicating whether this endpoint
 * should initiate an unlink when remote peers leave the channel.
 * Defaults to <code>true</code>.
 * </div>
 */
- (void) setUnlinkOnUserLeave:(bool)value;
/*!
 * <div>
 * Gets a value indicating whether this endpoint
 * should drop existing links in favour of new ones
 * when remote peers join the channel.
 * Defaults to <code>true</code>.
 * </div>
 */
- (bool) unlinkExistingOnUserJoin;
/*!
 * <div>
 * Gets a value indicating whether this endpoint
 * should initiate an unlink when remote peers leave the channel.
 * Defaults to <code>true</code>.
 * </div>
 */
- (bool) unlinkOnUserLeave;

@end

/*!
 * <div>
 * Arguments for join-conference failure callbacks.
 * </div>
 */
@interface FMIceLinkWebSync4JoinConferenceFailureArgs : FMWebSyncBaseFailureArgs

/*!
 * <div>
 * Gets the ID of the conference that failed to be joined.
 * </div>
 */
- (NSString*) conferenceChannel;
- (instancetype) init;
+ (FMIceLinkWebSync4JoinConferenceFailureArgs*) joinConferenceFailureArgs;

@end

/*!
 * <div>
 * Arguments for join-conference receive callbacks.
 * </div>
 */
@interface FMIceLinkWebSync4JoinConferenceReceiveArgs : FMWebSyncSubscribeReceiveArgs

/*!
 * <div>
 * Initializes a new instance of the FMIceLinkWebSync4JoinConferenceReceiveArgs class.
 * </div>
 * @param channel The channel over which data was received.
 * @param dataJson The data in JSON format.
 * @param dataBytes The data in binary format.
 * @param connectionType The current connection type.
 * @param reconnectAfter The amount of time in milliseconds to pause before reconnecting to the server.
 */
- (instancetype) initWithChannel:(NSString*)channel dataJson:(NSString*)dataJson dataBytes:(NSMutableData*)dataBytes connectionType:(FMWebSyncConnectionType)connectionType reconnectAfter:(int)reconnectAfter;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkWebSync4JoinConferenceReceiveArgs class.
 * </div>
 * @param channel The channel over which data was received.
 * @param dataJson The data in JSON format.
 * @param dataBytes The data in binary format.
 * @param connectionType The current connection type.
 * @param reconnectAfter The amount of time in milliseconds to pause before reconnecting to the server.
 */
+ (FMIceLinkWebSync4JoinConferenceReceiveArgs*) joinConferenceReceiveArgsWithChannel:(NSString*)channel dataJson:(NSString*)dataJson dataBytes:(NSMutableData*)dataBytes connectionType:(FMWebSyncConnectionType)connectionType reconnectAfter:(int)reconnectAfter;
/*!
 * <div>
 * Gets the user that published the message.
 * </div>
 */
- (FMIceLinkWebSync4PeerClient*) publishingPeer;

@end

/*!
 * <div>
 * Arguments for join-conference success callbacks.
 * </div>
 */
@interface FMIceLinkWebSync4JoinConferenceSuccessArgs : FMWebSyncBaseSuccessArgs

/*!
 * <div>
 * Gets the ID of the conference that was joined.
 * </div>
 */
- (NSString*) conferenceChannel;
- (instancetype) init;
+ (FMIceLinkWebSync4JoinConferenceSuccessArgs*) joinConferenceSuccessArgs;
/*!
 * <div>
 * Gets the array of users in the channel.
 * </div>
 */
- (NSMutableArray*) users;

@end

/*!
 * <div>
 * Arguments for a client leaving an IceLink conference.
 * </div>
 */
@interface FMIceLinkWebSync4LeaveConferenceArgs : FMWebSyncBaseInputArgs

/*!
 * <div>
 * Gets the conference channel.
 * </div>
 */
- (NSString*) conferenceChannel;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkWebSync4LeaveConferenceArgs class.
 * </div>
 * @param conferenceChannel The conference ID.
 */
- (instancetype) initWithConferenceChannel:(NSString*)conferenceChannel;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkWebSync4LeaveConferenceArgs class.
 * </div>
 * @param conferenceChannel The conference ID.
 */
+ (FMIceLinkWebSync4LeaveConferenceArgs*) leaveConferenceArgsWithConferenceChannel:(NSString*)conferenceChannel;
/*!
 * <div>
 * Gets the callback to invoke if the request fails.
 * </div>
 */
- (FMIceLinkAction1*) onFailure;
/*!
 * <div>
 * Gets the callback to invoke if the request succeeds.
 * </div>
 */
- (FMIceLinkAction1*) onSuccess;
/*!
 * <div>
 * Sets the conference channel.
 * </div>
 */
- (void) setConferenceChannel:(NSString*)value;
/*!
 * <div>
 * Sets the callback to invoke if the request fails.
 * </div>
 */
- (void) setOnFailure:(FMIceLinkAction1*)value;
/*!
 * <div>
 * Sets the callback to invoke if the request fails.
 * </div>
 */
- (void (^)(void(^)(FMIceLinkWebSync4LeaveConferenceFailureArgs*))) setOnFailureBlock;
/*!
 * <div>
 * Sets the callback to invoke if the request fails.
 * </div>
 */
- (void) setOnFailureBlock:(void(^)(FMIceLinkWebSync4LeaveConferenceFailureArgs*))valueBlock;
/*!
 * <div>
 * Sets the callback to invoke if the request succeeds.
 * </div>
 */
- (void) setOnSuccess:(FMIceLinkAction1*)value;
/*!
 * <div>
 * Sets the callback to invoke if the request succeeds.
 * </div>
 */
- (void (^)(void(^)(FMIceLinkWebSync4LeaveConferenceSuccessArgs*))) setOnSuccessBlock;
/*!
 * <div>
 * Sets the callback to invoke if the request succeeds.
 * </div>
 */
- (void) setOnSuccessBlock:(void(^)(FMIceLinkWebSync4LeaveConferenceSuccessArgs*))valueBlock;
/*!
 * <div>
 * Sets a value indicating whether this endpoint
 * should initiate an unlink from everyone after leaving
 * the channel successfully.
 * Defaults to <code>true</code>.
 * </div>
 */
- (void) setUnlinkAllOnSuccess:(bool)value;
/*!
 * <div>
 * Gets a value indicating whether this endpoint
 * should initiate an unlink from everyone after leaving
 * the channel successfully.
 * Defaults to <code>true</code>.
 * </div>
 */
- (bool) unlinkAllOnSuccess;

@end

/*!
 * <div>
 * Arguments for leave-conference failure callbacks.
 * </div>
 */
@interface FMIceLinkWebSync4LeaveConferenceFailureArgs : FMWebSyncBaseFailureArgs

/*!
 * <div>
 * Gets the ID of the conference that failed to be left.
 * </div>
 */
- (NSString*) conferenceChannel;
- (instancetype) init;
+ (FMIceLinkWebSync4LeaveConferenceFailureArgs*) leaveConferenceFailureArgs;

@end

/*!
 * <div>
 * Arguments for leave-conference success callbacks.
 * </div>
 */
@interface FMIceLinkWebSync4LeaveConferenceSuccessArgs : FMWebSyncBaseSuccessArgs

/*!
 * <div>
 * Gets the ID of the conference that was left.
 * </div>
 */
- (NSString*) conferenceChannel;
- (instancetype) init;
+ (FMIceLinkWebSync4LeaveConferenceSuccessArgs*) leaveConferenceSuccessArgs;

@end

/*!
 * <div>
 * Extension methods for FMWebSyncClient instances.
 * </div>
 */
@interface FMWebSyncClient (FMIceLinkWebSync4Extensions)

/*!
 * <div>
 * Joins an IceLink conference.
 * </div>
 * @param args The arguments.
 * @return The WebSync client.
 */
- (FMWebSyncClient*) joinConferenceWithArgs:(FMIceLinkWebSync4JoinConferenceArgs*)args;
/*!
 * <div>
 * Joins an IceLink conference.
 * </div>
 * @param client The WebSync client.
 * @param args The arguments.
 * @return The WebSync client.
 */
+ (FMWebSyncClient*) joinConferenceWithClient:(FMWebSyncClient*)client args:(FMIceLinkWebSync4JoinConferenceArgs*)args;
/*!
 * <div>
 * Leaves an IceLink conference.
 * </div>
 * @param args The arguments.
 * @return The WebSync client.
 */
- (FMWebSyncClient*) leaveConferenceWithArgs:(FMIceLinkWebSync4LeaveConferenceArgs*)args;
/*!
 * <div>
 * Leaves an IceLink conference.
 * </div>
 * @param client The WebSync client.
 * @param args The arguments.
 * @return The WebSync client.
 */
+ (FMWebSyncClient*) leaveConferenceWithClient:(FMWebSyncClient*)client args:(FMIceLinkWebSync4LeaveConferenceArgs*)args;
/*!
 * <div>
 * Reconnects remote client.
 * </div>
 * @param remoteClient The remote client.
 * @param failedConnection Failed connection that requires reconnection.
 */
- (void) reconnectRemoteClient:(FMIceLinkWebSync4PeerClient*)remoteClient failedConnection:(FMIceLinkConnection*)failedConnection;
/*!
 * <div>
 * Reconnects remote client.
 * </div>
 * @param client The WebSync client.
 * @param remoteClient The remote client.
 * @param failedConnection Failed connection that requires reconnection.
 */
+ (void) reconnectRemoteClient:(FMWebSyncClient*)client remoteClient:(FMIceLinkWebSync4PeerClient*)remoteClient failedConnection:(FMIceLinkConnection*)failedConnection;
/*!
 * <div>
 * Commences session description renegotiation for the specified connection.
 * </div>
 * @param client The WebSync client.
 * @param conferenceChannel Conference channel.
 * @param connection The connection on which to renegotiate.
 */
+ (FMIceLinkFuture*) renegotiateWithClient:(FMWebSyncClient*)client conferenceChannel:(NSString*)conferenceChannel connection:(FMIceLinkConnection*)connection;
/*!
 * <div>
 * Commences session description renegotiation for the specified connection.
 * </div>
 * @param conferenceChannel Conference channel.
 * @param connection The connection on which to renegotiate.
 */
- (FMIceLinkFuture*) renegotiateWithConferenceChannel:(NSString*)conferenceChannel connection:(FMIceLinkConnection*)connection;

@end

/*!
 * <div>
 * Details about a remote WebSync instance.
 * </div>
 */
@interface FMIceLinkWebSync4PeerClient : NSObject

/*!
 * <div>
 * Gets the WebSync bound records.
 * </div>
 */
- (NSMutableDictionary*) boundRecords;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkWebSync4PeerClient class.
 * </div>
 * @param instanceId The WebSync instance ID.
 * @param boundRecords The WebSync bound records.
 */
- (instancetype) initWithInstanceId:(NSString*)instanceId boundRecords:(NSMutableDictionary*)boundRecords;
/*!
 * <div>
 * Gets the WebSync instance ID.
 * </div>
 */
- (NSString*) instanceId;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkWebSync4PeerClient class.
 * </div>
 * @param instanceId The WebSync instance ID.
 * @param boundRecords The WebSync bound records.
 */
+ (FMIceLinkWebSync4PeerClient*) peerClientWithInstanceId:(NSString*)instanceId boundRecords:(NSMutableDictionary*)boundRecords;
/*!
 * <div>
 * Sets the WebSync bound records.
 * </div>
 */
- (void) setBoundRecords:(NSMutableDictionary*)value;
/*!
 * <div>
 * Sets the WebSync instance ID.
 * </div>
 */
- (void) setInstanceId:(NSString*)value;

@end

