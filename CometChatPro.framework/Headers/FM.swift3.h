//
// Title: FM Core for Cocoa
// Version: 2.9.32
// Copyright Frozen Mountain Software 2011+
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#if TARGET_OS_IPHONE
  #import <UIKit/UIKit.h>
#else
  #import <AppKit/AppKit.h>
#endif

@class FMAdobeExtension;
@class FMAsyncException;
@class FMAsyncSocket;
@class FMBitAssistant;
@class FMByteCollection;
@class FMCallback;
@class FMCallbackAction;
@class FMConvert;
@class FMCrypto;
@class FMCultureInfo;
@class FMDateTimeFormatInfo;
@class FMDeferrer;
@class FMDelegate;
@class FMDnsRequest;
@class FMEncoding;
@class FMEnvironment;
@class FMFile;
@class FMGlobal;
@class FMGuid;
@class FMHttpRequest;
@class FMHttpWebRequest;
@class FMHttpWebRequestTransfer;
@class FMIFormatProvider;
@class FMJsonChecker;
@class FMManagedCondition;
@class FMManagedLock;
@class FMManagedStopwatch;
@class FMManagedThread;
@class FMMathAssistant;
@class FMNameValueCollection;
@class FMNotificationCenterAdditions;
@class FMNSLogProvider;
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
@class FMRandomizer;
@class FMRecursiveCondition;
@class FMTcpSocket;
@class FMTextViewLogProvider;
@class FMTimeoutTimer;
@class FMTimeSpan;
@class FMUdpSocket;
@class FMWeakArray;
@class FMWeakDictionary;
@class FMWebSocketMockRequest;
@class FMWebSocketMockResponse;
@class FMZeroingWeakProxy;
@class FMZeroingWeakRef;
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


@interface NSNotificationCenter (FMZeroingWeakRefAdditions)

/**
 * Returns an opaque observation handle that can be removed with NSNotificationCenter's 'removeObserver:'.
 */
- (id)addWeakObserver: (id)observer selector: (SEL)selector name: (NSString *)name object: (id)object;

@end




@interface FMWeakArray : NSMutableArray

@end




@interface FMWeakDictionary : NSMutableDictionary

@end




@class FMZeroingWeakRef;

@interface FMZeroingWeakProxy : NSProxy

+ (id)proxyWithTarget: (id)target;

- (id)initWithTarget: (id)target;

- (id)zeroingProxyTarget;

#if NS_BLOCKS_AVAILABLE
// same caveats/restrictions as FMZeroingWeakRef cleanup block
- (void)setCleanupBlock: (void (^)(id target))block;
#endif

@end




@interface FMZeroingWeakRef : NSObject

+ (BOOL)canRefCoreFoundationObjects;

+ (id)refWithTarget: (id)target;

- (id)initWithTarget: (id)target;

#if NS_BLOCKS_AVAILABLE
// ON 10.7:
// cleanup block runs while the target's memory is still
// allocated but after all dealloc methods have run
// (it runs at associated object cleanup time)
// you can use the target's pointer value but don't
// manipulate its contents!

// ON 10.6 AND BELOW:
// cleanup block runs while the global ZWR lock is held
// so make it short and sweet!
// use GCD or something to schedule execution later
// if you need to do something that may take a while
//
// it is unsafe to call -target on the weak ref from
// inside the cleanup block, which is why the target
// is passed in as a parameter
// note that you must not resurrect the target at this point!
- (void)setCleanupBlock: (void (^)(id target))block;
#endif

- (id)target;

@end

#ifndef __has_feature
#define __has_feature(feature) 0
#endif

#define FMWeakVar(var)            __weak_ ## var

#if __has_feature(objc_arc_weak)

#define FMWeakDeclare(var)        __weak __typeof__((var)) FMWeakVar(var) = var
#define FMWeakImport(var)         __typeof__((FMWeakVar(var))) var = FMWeakVar(var)
#define FMWeakImportReturn(var)   FMWeakImport(var); do { if(var == nil) return; } while(NO)

#else

#define FMWeakDeclare(var)        __typeof__((var)) FMWeakVar(var) = (id)[FMZeroingWeakRef refWithTarget:var]
#define FMWeakImport(var)         __typeof__((FMWeakVar(var))) var = [(FMZeroingWeakRef *)FMWeakVar(var) target]
#define FMWeakImportReturn(var)   FMWeakImport(var); do { if(var == nil) return; } while(NO)

#endif

#define FMWeakSelfDeclare()       FMWeakDeclare(self)
#define FMWeakSelfImport()        FMWeakImport(self)
#define FMWeakSelfImportReturn()  FMWeakImportReturn(self)



typedef enum {
    FMStringComparisonCurrentCulture = 0,
    FMStringComparisonCurrentCultureIgnoreCase = 1,
    FMStringComparisonInvariantCulture = 2,
    FMStringComparisonInvariantCultureIgnoreCase = 3,
    FMStringComparisonOrdinal = 4,
    FMStringComparisonOrdinalIgnoreCase = 5
} FMStringComparison;


typedef enum {
    FMUriKindRelativeOrAbsolute = 0,
    FMUriKindAbsolute = 1,
    FMUriKindRelative = 2
} FMUriKind;


@interface FMIFormatProvider : NSObject 

@end



@interface FMCultureInfo : FMIFormatProvider 

+ (FMCultureInfo*) invariantCulture;
+ (FMCultureInfo*) currentCulture;

@end



@interface NSDate (FMExtensions)

+ (NSDate*) now;
+ (NSDate*) utcNow;
- (id)initWithTicks:(long long)ticks;
- (id)initWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second;
- (long long) ticks;
- (NSDate*) toUniversalTime;
- (NSString*) toStringWithFormat: (NSString*) format provider: (FMIFormatProvider*) provider;
- (NSDate*) addSecondsWithValue: (double) value;
- (NSDate*) addMillisecondsWithValue: (double) value;
- (int) year;
- (int) month;
- (int) day;
- (int) hour;
- (int) minute;
- (int) second;

@end


@interface NSException (FMExtensions)

- (id) init;
- (id) initWithMessage: (NSString*) message;
- (id) initWithMessage: (NSString*) message innerException: (NSException*) innerException;
- (NSString*) message;

@end


@interface NSMutableArray (FMExtensions)

- (NSMutableArray*) item;
- (NSMutableArray*) toArray;
- (bool) removeWithItem: (id) item;
- (int) length;
- (void) copyToWithArray: (NSMutableArray*) array arrayIndex: (int) arrayIndex;
- (void) insertWithIndex: (int) index item: (id) item;
- (void) removeRangeWithIndex: (int) index count: (int) count;
- (id) setObj: (id) obj atIndex: (int) index;
- (id) getObjAtIndex: (int) index;
- (id) getWithIndex: (int) index;

@end


@interface NSMutableData (FMExtensions)

- (id)initWithCollection:(NSData*)collection;
- (NSMutableData*)item;
- (NSMutableData*)toArray;
- (void)addRangeWithCollection:(NSData*)collection;
- (NSMutableData*)getRangeWithIndex:(int)index count:(int)count;
- (void)removeRangeWithIndex:(int)index count:(int)count;
- (void)insertRangeWithIndex:(int)index collection:(NSData*)collection;
- (NSNumber*)getObjAtIndex:(int)index;
- (void)setObj:(NSNumber*)object atIndex:(int)index;
- (int)count;
- (void)addWithItem:(unsigned char)item;

@end


@interface NSMutableDictionary (FMExtensions)

- (NSMutableDictionary*) item;
- (bool) removeWithKey: (NSString*) key;
- (bool) containsKeyWithKey: (NSString*) key;
- (bool) containsValueWithValue: (id) value;
- (NSMutableArray*) keys;
- (NSMutableArray*) values;
- (bool) tryGetValueWithKey: (NSString*) key value: (NSObject**) value;
- (void) addWithKey: (NSString*) key value: (id) value;
- (id) setObject: (id) obj atKey: (NSString*) key;
- (id) getObjectAtKey: (NSString*) key;

@end


@interface NSMutableString (FMExtensions)

- (NSMutableString *)removeWithStartIndex:(int) startIndex length:(int) length;
- (NSMutableString *)appendWithValue:(NSString *)value;
- (NSMutableString *)appendWithValue:(NSString *)value startIndex:(int)startIndex count:(int)count;
- (NSString *)toString;

@end



@interface NSString (FMExtensions)

- (bool) startsWithValue: (NSString*) str;
- (bool) startsWithValue: (NSString*) str comparisonType: (FMStringComparison) comparisonType;
- (bool) endsWithValue: (NSString*) str;
- (bool) endsWithValue: (NSString*) str comparisonType: (FMStringComparison) comparisonType;
- (int) indexOfWithValue: (NSString*) value;
- (int) indexOfWithValue: (NSString*) value comparisonType: (FMStringComparison) comparisonType;
- (int) lastIndexOfWithValue: (NSString*) value;
- (int) lastIndexOfWithValue: (NSString*) value comparisonType: (FMStringComparison) comparisonType;
- (NSString*) substringWithStartIndex: (int) startIndex;
- (NSString*) substringWithStartIndex: (int) startIndex length: (int) length;
- (NSString*) trim;
- (NSString*)trimEndWithTrimChars:(NSArray*)trimChars;
- (NSMutableArray*) splitWithSeparator: (NSMutableArray*) separator;
- (NSString*) toLower;
- (NSString*) toUpper;
- (NSString*) toLowerWithCulture: (FMCultureInfo*) culture;
- (NSString*) replaceWithOldValue: (NSString*) oldValue newValue: (NSString*) newValue;
- (int) compareToWithStrB: (NSString *) strB;
+ (NSString*) formatWithFormat: (NSString*) format args: (NSMutableArray*) args;
+ (NSString*) formatWithFormat: (NSString*) format arg0: (NSObject*) arg0;
+ (NSString*) formatWithFormat: (NSString*) format arg0: (NSObject*) arg0 arg1: (NSObject*) arg1;
+ (NSString*) formatWithFormat: (NSString*) format arg0: (NSObject*) arg0 arg1: (NSObject*) arg1 arg2: (NSObject*) arg2;
+ (NSString*) formatWithFormat: (NSString*) format arg0: (NSObject*) arg0 arg1: (NSObject*) arg1 arg2: (NSObject*) arg2 arg3: (NSObject*) arg3;
+ (NSString*) formatWithFormat: (NSString*) format arg0: (NSObject*) arg0 arg1: (NSObject*) arg1 arg2: (NSObject*) arg2 arg3: (NSObject*) arg3 arg4: (NSObject*) arg4;
+ (NSString*) formatWithFormat: (NSString*) format arg0: (NSObject*) arg0 arg1: (NSObject*) arg1 arg2: (NSObject*) arg2 arg3: (NSObject*) arg3 arg4: (NSObject*) arg4 arg5: (NSObject*) arg5;
+ (bool) isNullOrEmptyWithValue: (NSString*) value;
+ (NSString*) empty;
+ (NSString*) joinWithSeparator: (NSString*) separator value: (NSMutableArray*) value;
+ (NSString*) concatWithValues: (NSMutableArray*) values;
+ (NSString*) concatWithArgs: (NSMutableArray*) args;
+ (NSString*) concatWithArg0: (NSString*) arg0;
+ (NSString*) concatWithArg0: (NSString*) arg0 arg1: (NSString*) arg1;
+ (NSString*) concatWithArg0: (NSString*) arg0 arg1: (NSString*) arg1 arg2: (NSString*) arg2;
+ (NSString*) concatWithArg0: (NSString*) arg0 arg1: (NSString*) arg1 arg2: (NSString*) arg2 arg3: (NSString*) arg3;
+ (NSString*) concatWithStr0: (NSString*) str0;
+ (NSString*) concatWithStr0: (NSString*) str0 str1: (NSString*) str1;
+ (NSString*) concatWithStr0: (NSString*) str0 str1: (NSString*) str1 str2: (NSString*) str2;
+ (NSString*) concatWithStr0: (NSString*) str0 str1: (NSString*) str1 str2: (NSString*) str2 str3: (NSString*) str3;
+ (NSString*) reformatNetFormat: (NSString*) format count: (int) count;

@end


@interface NSThread (FMExtensions)

+ (void)performBlockOnMainThread:(void (^)(void))block;
+ (void)performBlockInBackground:(void (^)(void))block;
+ (void)runBlock:(void (^)(void))block;
- (void)performBlock:(void (^)(void))block;
- (void)performBlock:(void (^)(void))block waitUntilDone:(BOOL)wait;
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end



@interface NSURL (FMExtensions)

- (id) initWithUriString: (NSString*) uriString;
- (NSString*) toString;
- (NSString*) dnsSafeHost;
- (NSString*) absolutePath;
- (int) portNet;
- (NSString*) queryNet;
+ (bool) tryCreateWithUriString: (NSString*) uriString uriKind: (FMUriKind) uriKind result: (NSURL**) result;
+ (bool) tryCreateWithBaseUri: (NSURL*) baseUri relativeUri: (NSString*) relativeUri result: (NSURL**) result;
+ (NSString*) escapeDataStringWithStringToEscape: (NSString*) stringToEscape;

@end


@interface NSURLResponse (FMExtensions)

- (NSStream*) getResponseStream;

@end


@interface FMAsyncException : NSObject 

+ (void) asyncThrowWithEx:(NSException *)ex source:(NSString *)source;

@end



@interface FMBitAssistant : NSObject 

+ (bool)isLittleEndian;
+ (unsigned char)castByteWithValue:(int)value;
+ (int)castIntegerWithValue:(unsigned char)value;
+ (long long)castLongWithValue:(unsigned char)value;
+ (unsigned char)leftShiftWithValue:(unsigned char)value count:(int)count;
+ (short)leftShiftShortWithValue:(short)value count:(int)count;
+ (int)leftShiftIntegerWithValue:(int)value count:(int)count;
+ (long long)leftShiftLongWithValue:(long long)value count:(int)count;
+ (unsigned char)rightShiftWithValue:(unsigned char)value count:(int)count;
+ (short)rightShiftShortWithValue:(short)value count:(int)count;
+ (int)rightShiftIntegerWithValue:(int)value count:(int)count;
+ (long long)rightShiftLongWithValue:(long long)value count:(int)count;
+ (bool)sequencesAreEqualWithArray1:(NSData*)array1 array2:(NSData*)array2;
+ (bool)sequencesAreEqualWithArray1:(NSData*)array1 offset1:(int)offset1 array2:(NSData*)array2 offset2:(int)offset2 length:(int)length;
+ (bool)sequencesAreEqualConstantTimeWithArray1:(NSData*)array1 array2:(NSData*)array2;
+ (bool)sequencesAreEqualConstantTimeWithArray1:(NSData*)array1 offset1:(int)offset1 array2:(NSData*)array2 offset2:(int)offset2 length:(int)length;
+ (NSMutableData*)subArrayWithArray:(NSData*)array offset:(int)offset;
+ (NSMutableData*)subArrayWithArray:(NSData*)array offset:(int)offset count:(int)count;
+ (NSString*)getHexStringWithArray:(NSData*)array offset:(int)offset length:(int)length;
+ (NSString*)getHexStringWithArray:(NSData*)array;
+ (NSMutableData*)getHexBytesWithS:(NSString*)s;
+ (NSString*)getBinaryStringWithArray:(NSData*)array offset:(int)offset length:(int)length;
+ (NSString*)getBinaryStringWithArray:(NSData*)array;
+ (NSMutableData*)getBinaryBytesWithS:(NSString*)s;

+ (void) reverseWithArray:(NSMutableData*)array;
+ (void) copyWithSource:(NSData*)source sourceIndex:(int)sourceIndex destination:(NSMutableData*)destination destinationIndex:(int)destinationIndex length:(int)length;
+ (void) copyFloatsWithSource:(NSArray*)source sourceIndex:(int)sourceIndex destination:(NSMutableArray*)destination destinationIndex:(int)destinationIndex length:(int)length;
+ (void) setWithArray:(NSMutableData*)array index:(int)index length:(int)length value:(char)value;
/*
+ (short)toShortWithValue:(NSMutableData*)value startIndex:(int)startIndex;
+ (int)toIntegerFromShortWithValue:(NSMutableData*)value startIndex:(int)startIndex;
+ (int)toIntegerWithValue:(NSMutableData*)value startIndex:(int)startIndex;
+ (long long)toLongFromIntegerWithValue:(NSMutableData*)value startIndex:(int)startIndex;
+ (long long)toLongWithValue:(NSMutableData*)value startIndex:(int)startIndex;

+ (NSMutableData*)getShortBytesWithValue:(short)value;
+ (NSMutableData*)getShortBytesFromIntegerWithValue:(int)value;
+ (NSMutableData*)getIntegerBytesWithValue:(int)value;
+ (NSMutableData*)getIntegerBytesFromLongWithValue:(long long)value;
+ (NSMutableData*)getLongBytesWithValue:(long long)value;
*/
+ (float)toFloatNetworkWithValue:(NSMutableData*)value startIndex:(int)startIndex;
+ (double)toDoubleNetworkWithValue:(NSMutableData*)value startIndex:(int)startIndex;
+ (short)toShortNetworkWithValue:(NSMutableData*)value startIndex:(int)startIndex;
+ (int)toIntegerFromShortNetworkWithValue:(NSMutableData*)value startIndex:(int)startIndex;
+ (int)toIntegerNetworkWithValue:(NSMutableData*)value startIndex:(int)startIndex;
+ (long long)toLongFromIntegerNetworkWithValue:(NSMutableData*)value startIndex:(int)startIndex;
+ (long long)toLongNetworkWithValue:(NSMutableData*)value startIndex:(int)startIndex;

+ (NSMutableData*)getFloatBytesNetworkWithValue:(float)value;
+ (NSMutableData*)getDoubleBytesNetworkWithValue:(double)value;
+ (NSMutableData*)getShortBytesNetworkWithValue:(short)value;
+ (NSMutableData*)getShortBytesFromIntegerNetworkWithValue:(int)value;
+ (NSMutableData*)getIntegerBytesNetworkWithValue:(int)value;
+ (NSMutableData*)getIntegerBytesFromLongNetworkWithValue:(long long)value;
+ (NSMutableData*)getLongBytesNetworkWithValue:(long long)value;

@end


@interface FMByteCollection : NSObject 

- (int)count;
- (id)init;
- (id)initWithBuffer:(NSData *)buffer;
- (void)addWithB:(char)b;
- (void)addRangeWithBuffer:(NSData *)buffer;
- (void)addRangeWithCollection:(FMByteCollection *)collection;
- (void)removeRangeWithIndex:(int)index count:(int)count;
- (void)insertRangeWithIndex:(int)index buffer:(NSData *)buffer;
- (void)insertRangeWithIndex:(int)index collection:(FMByteCollection *)collection;
- (NSMutableData *)getRangeWithIndex:(int)index count:(int)count;
- (char)getWithIndex:(int)index;
- (NSMutableData *)toArray;

@end


@interface FMCallback : NSObject 

@property (nonatomic, retain) NSMutableArray *actions;

+ (FMCallback *)callback:(SEL)selector target:(id)target;
+ (FMCallback *)callback:(SEL)selector target:(id)target retainTarget:(bool)retainTarget;
+ (FMCallback *)callbackWithEmptyAction:(void (^)(void))emptyAction;
+ (FMCallback *)callbackWithSingleAction:(void (^)(id))singleAction;
+ (FMCallback *)callbackWithDoubleAction:(void (^)(id, id))doubleAction;
+ (FMCallback *)callbackWithEmptyFunction:(id (^)(void))emptyFunction;
+ (FMCallback *)callbackWithSingleFunction:(id (^)(id))singleFunction;
+ (FMCallback *)callbackWithDoubleFunction:(id (^)(id, id))doubleFunction;

- (id)init;

- (void)add:(SEL)selector target:(id)target;
- (void)add:(SEL)selector target:(id)target retainTarget:(bool)retainTarget;
- (void)addEmptyAction:(void (^)(void))emptyAction;
- (void)addSingleAction:(void (^)(id))singleAction;
- (void)addDoubleAction:(void (^)(id, id))doubleAction;
- (void)addEmptyFunction:(id (^)(void))emptyFunction;
- (void)addSingleFunction:(id (^)(id))singleFunction;
- (void)addDoubleFunction:(id (^)(id, id))doubleFunction;

- (void)remove:(SEL)selector target:(id)target;
- (void)removeEmptyAction:(void (^)(void))emptyAction;
- (void)removeSingleAction:(void (^)(id))singleAction;
- (void)removeDoubleAction:(void (^)(id, id))doubleAction;
- (void)removeEmptyFunction:(id (^)(void))emptyFunction;
- (void)removeSingleFunction:(id (^)(id))singleFunction;
- (void)removeDoubleFunction:(id (^)(id, id))doubleFunction;

- (void)merge:(FMCallback *)callback;
- (void)split:(FMCallback *)callback;
- (id)invoke;
- (id)invokeWithArg0:(id)arg0;
- (id)invokeWithArg0:(id)arg0 arg1:(id)arg1;
- (id)invokeWithArg0:(id)arg0 arg1:(id)arg1 arg2:(id)arg2;
- (id)invokeWithArg0:(id)arg0 arg1:(id)arg1 arg2:(id)arg2 arg3:(id)arg3;
- (id)invokeWithArg0:(id)arg0 arg1:(id)arg1 arg2:(id)arg2 arg3:(id)arg3 arg4:(id)arg4;
- (id)invokeWithArg0:(id)arg0 arg1:(id)arg1 arg2:(id)arg2 arg3:(id)arg3 arg4:(id)arg4 arg5:(id)arg5;

@end

//
//  FMCallbackAction.h
//  FM-iOS
//
//  Created by Anton Venema on 11-11-02.
//  Copyright (c) 2011 Frozen Mountain Software LTD. All rights reserved.
//


@interface FMCallbackAction : NSObject

+ (FMCallbackAction *)callbackActionWithSelector:(SEL)selector target:(id)target;
+ (FMCallbackAction *)callbackActionWithSelector:(SEL)selector target:(id)target retainTarget:(bool)retainTarget;
+ (FMCallbackAction *)callbackActionWithEmptyAction:(void (^)(void))emptyAction;
+ (FMCallbackAction *)callbackActionWithSingleAction:(void (^)(id))singleAction;
+ (FMCallbackAction *)callbackActionWithDoubleAction:(void (^)(id, id))doubleAction;
+ (FMCallbackAction *)callbackActionWithEmptyFunction:(id (^)(void))emptyFunction;
+ (FMCallbackAction *)callbackActionWithSingleFunction:(id (^)(id))singleFunction;
+ (FMCallbackAction *)callbackActionWithDoubleFunction:(id (^)(id, id))doubleFunction;
- (id)initWithSelector:(SEL)selector target:(id)target;
- (id)initWithSelector:(SEL)selector target:(id)target retainTarget:(bool)retainTarget;
- (id)initWithEmptyAction:(void (^)(void))emptyAction;
- (id)initWithSingleAction:(void (^)(id))singleAction;
- (id)initWithDoubleAction:(void (^)(id, id))doubleAction;
- (id)initWithEmptyFunction:(id (^)(void))emptyFunction;
- (id)initWithSingleFunction:(id (^)(id))singleFunction;
- (id)initWithDoubleFunction:(id (^)(id, id))doubleFunction;
- (SEL)selector;
- (id)target;
- (bool)retainTarget;
- (void (^)(void))emptyAction;
- (void (^)(id))singleAction;
- (void (^)(id, id))doubleAction;
- (id (^)(void))emptyFunction;
- (id (^)(id))singleFunction;
- (id (^)(id, id))doubleFunction;

@end



@interface FMConvert : NSObject 

+ (int) toInt32WithValue: (NSString*) value fromBase: (int) fromBase;
+ (NSString*) toBase64StringWithInArray: (NSData*) inArray;
+ (NSMutableData*) fromBase64StringWithS: (NSString*) s;

@end


@interface FMCrypto : NSObject 

+ (NSMutableData*)sha1HashWithS:(NSString*)s;
+ (NSString*)base64EncodeWithB:(NSData*)b;
+ (NSMutableData*)base64DecodeWithS:(NSString*)s;
+ (bool)tryBase64EncodeWithB:(NSData*)b encoded:(NSString**)encoded;
+ (bool)tryBase64DecodeWithS:(NSString*)s decoded:(NSData**)decoded;

@end



@interface FMDateTimeFormatInfo : FMIFormatProvider 

+ (FMDateTimeFormatInfo*) invariantInfo;

@end


typedef enum {
    FMDateTimeStylesNone = 0,
    FMDateTimeStylesAllowLeadingWhite = 1,
    FMDateTimeStylesAllowTrailingWhite = 2,
    FMDateTimeStylesAllowInnerWhite = 4,
    FMDateTimeStylesAllowWhiteSpaces = 7,
    FMDateTimeStylesNoCurrentDateDefault = 8,
    FMDateTimeStylesAdjustToUniversal = 16,
    FMDateTimeStylesAssumeLocal = 32,
    FMDateTimeStylesAssumeUniversal = 64,
    FMDateTimeStylesRoundtripKind = 128
} FMDateTimeStyles;



@interface FMDelegate : NSObject 

+ (FMCallback*) combineWithA: (FMCallback*) a b: (FMCallback*) b;
+ (FMCallback*) removeWithSource: (FMCallback*) source value: (FMCallback*) value;

@end


@interface FMEncoding : NSObject 

+ (FMEncoding*)utf8;
- (NSString*)getStringWithBytes:(NSMutableData*)bytes index:(int)index count:(int)count;
- (NSString*)getStringWithBytes:(NSMutableData*)bytes;
- (NSMutableData*)getBytesWithS:(NSString*)s;
- (int)getByteCountWithS:(NSString*)s;

@end


@interface FMEnvironment : NSObject 

+ (int) tickCount;

@end


@interface FMGlobal : NSObject 

+ (id) tryCast: (id) obj toClass: (id) cls;
+ (id) createEmptyArray: (NSArray*) dimensions;
+ (id) createEmptyData: (NSArray*) dimensions;

@end


@interface FMGuid : NSObject 

+ (FMGuid*) empty;
+ (FMGuid*) newGuid;
+ (FMGuid*) guidWithG:  (NSString*) g;
+ (NSString*) toStringWithG: (FMGuid*) g;
- (id) initWithB: (NSData *) b;
- (id) initWithG: (NSString*) g;
- (NSString*) toString;
- (NSMutableData*) toByteArray;
- (int)compareToWithValue:(FMGuid*)value;

@end



@interface FMJsonChecker : NSObject 

- (bool) checkStringWithStr: (NSString*) str;

@end

typedef struct JSON_checker_struct {
    int state;
    int depth;
    int top;
    int* stack;
} * JSON_checker;


/* JSON_checker.h */

extern JSON_checker new_JSON_checker(int depth);
extern int  JSON_checker_char(JSON_checker jc, int next_char);
extern int  JSON_checker_done(JSON_checker jc);

/*!
 * @header FMRecursiveCondition Class
 * Created by Bradley Snyder on 2/12/14.
 * @copyright
 *   Copyright 2014 Bradley J. Snyder <snyder.bradleyj@gmail.com>
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */


/*!
 * @class NSRecursiveCondition
 * Class with identical functionality to NSCondition, but with a recursive mutex for locking,
 * effectively combining the functionality of NSCondition with NSRecursiveLock.
 */
@interface FMRecursiveCondition : NSObject

- (void)lock;
- (void)unlock;
- (void)signal;
- (void)broadcast;
- (void)wait;
- (BOOL)waitUntilDate:(NSDate*)limit;

@end


@interface FMManagedLock : NSObject

- (void)lock;
- (void)unlock;

@end



@interface FMManagedCondition : NSObject

- (FMRecursiveCondition *)condition;
- (void)halt;
- (void)haltWithMillisecondsTimeout:(int)millisecondsTimeout;
- (void)pulse;
- (void)pulseAll;

@end



@interface FMManagedStopwatch : NSObject

+ (long long)frequency;
- (long long)elapsedTicks;
- (void)start;
- (void)stop;

@end



@interface FMManagedThread : NSObject 

@property (nonatomic, retain) NSObject *state;

- (id)initWithLoop:(FMCallback*)callback;
- (id)initWithLoop:(FMCallback*)callback shortLived:(bool)shortLived;
- (void)setIsBackground:(bool)isBackground;
- (bool)isBackground;
- (void)start;
- (void)loopBegin;
- (void)loopEnd;
+ (void)sleepWithMillisecondsTimeout:(int)millisecondsTimeout;
+ (NSString *)currentThreadId;

@end


@interface FMMathAssistant : NSObject 

+ (double)pi;
+ (double)e;
+ (int)absWithIntValue:(int)intValue;
+ (long long)absWithLongValue:(long long)longValue;
+ (float)absWithFloatValue:(float)floatValue;
+ (double)absWithDoubleValue:(double)doubleValue;
+ (double)acosWithValue:(double)value;
+ (double)asinWithValue:(double)value;
+ (double)atanWithValue:(double)value;
+ (double)atan2WithY:(double)y x:(double)x;
+ (double)ceilWithValue:(double)value;
+ (double)cosWithValue:(double)value;
+ (double)coshWithValue:(double)value;
+ (double)expWithValue:(double)value;
+ (double)floorWithValue:(double)value;
+ (double)logWithValue:(double)value;
+ (double)log10WithValue:(double)value;
+ (int)maxWithIntValue1:(int)intValue1 intValue2:(int)intValue2;
+ (long long)maxWithLongValue1:(long long)longValue1 longValue2:(long long)longValue2;
+ (float)maxWithFloatValue1:(float)floatValue1 floatValue2:(float)floatValue2;
+ (double)maxWithDoubleValue1:(double)doubleValue1 doubleValue2:(double)doubleValue2;
+ (int)minWithIntValue1:(int)intValue1 intValue2:(int)intValue2;
+ (long long)minWithLongValue1:(long long)longValue1 longValue2:(long long)longValue2;
+ (float)minWithFloatValue1:(float)floatValue1 floatValue2:(float)floatValue2;
+ (double)minWithDoubleValue1:(double)doubleValue1 doubleValue2:(double)doubleValue2;
+ (double)powWithX:(double)x y:(double)y;
+ (double)sinWithValue:(double)value;
+ (double)sinhWithValue:(double)value;
+ (double)sqrtWithValue:(double)value;
+ (double)tanWithValue:(double)value;
+ (double)tanhWithValue:(double)value;

@end


@interface FMNameValueCollection : NSObject 

- (id)init;
- (id)initWithCapacity:(int)capacity;
- (id)initWithCollection:(FMNameValueCollection*)collection;
- (NSMutableDictionary*)item;
- (NSArray*)allKeys;
- (NSString*)objectForKey:(NSString*)key;
- (void)setObject:(NSString*)object forKey:(NSString*)key;

@end


@interface FMNullableBool : NSObject 

+ (FMNullableBool*) fromValue: (bool) value;
+ (FMNullableBool*) null;
- (id) initWithValue: (bool) value;
- (bool) hasValue;
- (bool) value;
- (void) setValue: (bool) value;
- (bool) getValueOrDefault;
- (NSString*) toString;

@end


@interface FMNullableChar : NSObject 

+ (FMNullableChar*) fromValue: (char) value;
+ (FMNullableChar*) null;
- (id) initWithValue: (char) value;
- (bool) hasValue;
- (char) value;
- (void) setValue: (char) value;
- (char) getValueOrDefault;
- (NSString*) toString;

@end


@interface FMNullableDate : NSObject 

+ (FMNullableDate*) fromValue: (NSDate*) value;
+ (FMNullableDate*) null;
- (id) initWithValue: (NSDate*) value;
- (bool) hasValue;
- (NSDate*) value;
- (void) setValue: (NSDate*) value;
- (NSDate*) getValueOrDefault;

@end



@interface FMNullableDecimal : NSObject 

+ (FMNullableDecimal*) fromValue: (NSDecimal) value;
+ (FMNullableDecimal*) null;
- (id) initWithValue: (NSDecimal) value;
- (bool) hasValue;
- (NSDecimal) value;
- (void) setValue: (NSDecimal) value;
- (NSDecimal) getValueOrDefault;
- (NSString*) toString;
- (NSString*) toStringWithProvider: (FMIFormatProvider*) provider;

@end



@interface FMNullableDouble : NSObject 

+ (FMNullableDouble*) fromValue: (double) value;
+ (FMNullableDouble*) null;
- (id) initWithValue: (double) value;
- (bool) hasValue;
- (double) value;
- (void) setValue: (double) value;
- (double) getValueOrDefault;
- (NSString*) toString;
- (NSString*) toStringWithProvider: (FMIFormatProvider*) provider;

@end



@interface FMNullableFloat : NSObject 

+ (FMNullableFloat*) fromValue: (float) value;
+ (FMNullableFloat*) null;
- (id) initWithValue: (float) value;
- (bool) hasValue;
- (float) value;
- (void) setValue: (float) value;
- (float) getValueOrDefault;
- (NSString*) toString;
- (NSString*) toStringWithProvider: (FMIFormatProvider*) provider;

@end



@interface FMNullableGuid : NSObject 

+ (FMNullableGuid*) fromValue: (FMGuid*) value;
+ (FMNullableGuid*) null;
- (id) initWithValue: (FMGuid*) value;
- (bool) hasValue;
- (FMGuid*) value;
- (void) setValue: (FMGuid*) value;
- (FMGuid*) getValueOrDefault;
- (NSString*) toString;

@end



@interface FMNullableInt : NSObject 

+ (FMNullableInt*) fromValue: (int) value;
+ (FMNullableInt*) null;
- (id) initWithValue: (int) value;
- (bool) hasValue;
- (int) value;
- (void) setValue: (int) value;
- (int) getValueOrDefault;
- (NSString*) toString;
- (NSString*) toStringWithProvider: (FMIFormatProvider*) provider;

@end



@interface FMNullableLong : NSObject 

+ (FMNullableLong*) fromValue: (long long) value;
+ (FMNullableLong*) null;
- (id) initWithValue: (long long) value;
- (bool) hasValue;
- (long long) value;
- (void) setValue: (long long) value;
- (long long) getValueOrDefault;
- (NSString*) toString;
- (NSString*) toStringWithProvider: (FMIFormatProvider*) provider;
- (NSString*) toStringWithFormat: (NSString*) format;

@end



@interface FMNullableShort : NSObject 

+ (FMNullableShort*) fromValue: (short) value;
+ (FMNullableShort*) null;
- (id) initWithValue: (short) value;
- (bool) hasValue;
- (short) value;
- (void) setValue: (short) value;
- (short) getValueOrDefault;
- (NSString*) toString;
- (NSString*) toStringWithProvider: (FMIFormatProvider*) provider;

@end


@interface FMNullableUnichar : NSObject 

+ (FMNullableUnichar*) fromValue: (unichar) value;
+ (FMNullableUnichar*) null;
- (id) initWithValue: (unichar) value;
- (bool) hasValue;
- (unichar) value;
- (void) setValue: (unichar) value;
- (unichar) getValueOrDefault;
- (NSString*) toString;

@end



@interface FMNumberFormatInfo : FMIFormatProvider 

+ (FMNumberFormatInfo*) currentInfo;
+ (FMNumberFormatInfo*) invariantInfo;

@end



@interface FMParseAssistant : NSObject 

+ (char) parseByteValueWithS: (NSString*) s;
+ (short) parseShortValueWithS: (NSString*) s;
+ (int) parseIntegerValueWithS: (NSString*) s;
+ (long long) parseLongValueWithS: (NSString*) s;
+ (float) parseFloatValueWithS: (NSString*) s;
+ (double) parseDoubleValueWithS: (NSString*) s;
+ (NSDecimal) parseDecimalValueWithS: (NSString*) s;
+ (bool) parseBooleanValueWithS: (NSString*) s;
+ (FMGuid*) parseGuidValueWithS: (NSString*) s;

+ (bool) tryParseByteValueWithS: (NSString*) s byteResult: (char*) byteResult;
+ (bool) tryParseShortValueWithS: (NSString*) s shortResult: (short*) shortResult;
+ (bool) tryParseIntegerValueWithS: (NSString*) s intResult: (int*) intResult;
+ (bool) tryParseLongValueWithS: (NSString*) s longResult: (long long*) longResult;
+ (bool) tryParseFloatValueWithS: (NSString*) s floatResult: (float*) floatResult;
+ (bool) tryParseDoubleValueWithS: (NSString*) s doubleResult: (double*) doubleResult;
+ (bool) tryParseDecimalValueWithS: (NSString*) s decimalResult: (NSDecimal*) decimalResult;
+ (bool) tryParseBooleanValueWithS: (NSString*) s boolResult: (bool*) boolResult;
+ (bool) tryParseGuidValueWithS: (NSString*) s guidResult: (FMGuid**) guidResult;

@end



@interface FMRandom : NSObject 

- (void)nextBytesWithBuffer:(NSMutableData*)buffer;

@end





@interface FMTimeoutTimer : NSObject 

- (id) initWithCallback: (FMCallback*) callback state: (id) state;
- (void) startWithTimeout: (int) timeout;
- (bool) stop;

@end


@interface FMTimeSpan : NSObject 

- (id)initWithTicks:(long long)ticks;
- (id)initWithHours:(int)hours minutes:(int)minutes seconds:(int)seconds;
- (double)totalSeconds;
- (double)totalMilliseconds;

@end


@interface FMRandomizer : NSObject 

/// <summary>
/// Returns a nonnegative random number.
/// </summary>
/// <returns></returns>
- (int)next;

/// <summary>
/// Returns a nonnegative random number less than the specified maximum.
/// </summary>
/// <param name="maxValue">The maximum value (exclusive).</param>
/// <returns></returns>
- (int)nextWithMaxValue:(int)maxValue;

/// <summary>
/// Returns a random number within a specified range.
/// </summary>
/// <param name="minValue">The mininum value (inclusive).</param>
/// <param name="maxValue">The maximum value (exclusive).</param>
/// <returns></returns>
- (int)nextWithMinValue:(int)minValue maxValue:(int)maxValue;

/// <summary>
/// Fills the elements of a specified array of bytes with random numbers.
/// </summary>
/// <param name="buffer">The array of bytes to fill.</param>
- (void)nextBytesWithBuffer:(NSMutableData*)buffer;

/// <summary>
/// Returns a random number between 0.0 and 1.0.
/// </summary>
/// <returns></returns>
- (double)nextDouble;

/// <summary>
/// Generates a random string of a specified size.
/// </summary>
/// <param name="size">The size of the output string.</param>
/// <returns></returns>
- (NSString*)randomStringWithSize:(int)size;

@end



@interface FMDnsRequest : NSObject 

- (id)initWithName:(NSString *)name callback:(FMCallback *)callback state:(NSObject *)state;
- (void)resolve;

@end



@interface FMWebSocketMockRequest : NSMutableURLRequest 

- (FMNameValueCollection*)headers;
- (void)setRequestUriWithRequestUri:(NSURL*)requestUri;
- (void)setMethod:(NSString*)method;
- (NSString*)method;

@end



@interface FMWebSocketMockResponse : NSURLResponse 

- (FMNameValueCollection*)headers;
- (void)setResponseUriWithResponseUri:(NSURL*)responseUri;
- (int)statusCode;
- (void)setStatusCode:(int)statusCode;
- (void)setContentTypeWithContentType:(NSString*)contentType;
- (void)setContentLengthWithContentLength:(long long)contentLength;

@end



/// <summary>
/// The access to use when opening a file.
/// </summary>
typedef enum {
	/// <summary>
	/// Indicates that the file should be
	/// opened for read access.
	/// </summary>
	FMFileAccessRead = 1,
	/// <summary>
	/// Indicates that the file should be
	/// opened for write access.
	/// </summary>
	FMFileAccessWrite = 2
} FMFileAccess;



/// <summary>
/// The method used by an HTTP request.
/// </summary>
typedef enum {
	/// <summary>
	/// Indicates a GET request.
	/// </summary>
	FMHttpMethodGet = 1,
	/// <summary>
	/// Indicates a HEAD request.
	/// </summary>
	FMHttpMethodHead = 2,
	/// <summary>
	/// Indicates a POST request.
	/// </summary>
	FMHttpMethodPost = 3,
	/// <summary>
	/// Indicates a PUT request.
	/// </summary>
	FMHttpMethodPut = 4,
	/// <summary>
	/// Indicates a PATCH request.
	/// </summary>
	FMHttpMethodPatch = 5,
	/// <summary>
	/// Indicates a DELETE request.
	/// </summary>
	FMHttpMethodDelete = 6
} FMHttpMethod;



/// <summary>
/// The algorithm to use when calculating sleep time between failed requests.
/// </summary>
typedef enum {
	/// <summary>
	/// Indicates that the backoff algorithm uses an additive calculation
	/// where the current backoff is equal to the previously calculated
	/// backoff plus the specified backoff in milliseconds.
	/// </summary>
	FMBackoffModeAdditive = 1,
	/// <summary>
	/// Indicates that the backoff algorithm uses a constant calculation
	/// where the current backoff is always equal to exactly the specified
	/// backoff in milliseconds.
	/// </summary>
	FMBackoffModeConstant = 2,
	/// <summary>
	/// Indicates that no backoff interval exists between failed requests.
	/// </summary>
	FMBackoffModeNone = 3
} FMBackoffMode;



/// <summary>
/// The level at which to log.
/// </summary>
typedef enum {
	/// <summary>
	/// Logs messages relevant to development and troubleshooting.
	/// </summary>
	FMLogLevelDebug = 1,
	/// <summary>
	/// Logs messages relevant to expected use.
	/// </summary>
	FMLogLevelInfo = 2,
	/// <summary>
	/// Logs messages relevant to potential pit-falls.
	/// </summary>
	FMLogLevelWarn = 3,
	/// <summary>
	/// Logs messages relevant to errors that allow program execution to continue.
	/// </summary>
	FMLogLevelError = 4,
	/// <summary>
	/// Logs messages relevant to errors that require the program to terminate.
	/// </summary>
	FMLogLevelFatal = 5,
	/// <summary>
	/// Logs nothing.
	/// </summary>
	FMLogLevelNone = 6
} FMLogLevel;



typedef enum {
	FMStringTypeNone = 1,
	FMStringTypeSingle = 2,
	FMStringTypeDouble = 3
} FMStringType;



typedef enum {
	FMWebSocketFrameTypeUnknown = 1,
	FMWebSocketFrameTypeContinuation = 2,
	FMWebSocketFrameTypeText = 3,
	FMWebSocketFrameTypeBinary = 4,
	FMWebSocketFrameTypeClose = 5,
	FMWebSocketFrameTypePing = 6,
	FMWebSocketFrameTypePong = 7
} FMWebSocketFrameType;



/// <summary>
/// An enumeration of potential WebSocket status codes.
/// </summary>
typedef enum {
	/// <summary>
	/// Indicates normal closure, meaning that the purpose for which
	/// the connection was established has been fulfilled.
	/// </summary>
	FMWebSocketStatusCodeNormal = 1000,
	/// <summary>
	/// Indicates that an endpoint is "going away", such as a server
	/// going down or a browser having navigated away from a page.
	/// </summary>
	FMWebSocketStatusCodeGoingAway = 1001,
	/// <summary>
	/// Indicates that an endpoint is terminating the connection
	/// due to a protocol error.
	/// </summary>
	FMWebSocketStatusCodeProtocolError = 1002,
	/// <summary>
	/// Indicates that an endpoint is terminating the connection
	/// because it has received a type of data that it cannot accept.
	/// </summary>
	FMWebSocketStatusCodeInvalidType = 1003,
	/// <summary>
	/// Indicates that no status code was present in the Close frame.
	/// Reserved for use outside Close frames.
	/// </summary>
	FMWebSocketStatusCodeNoStatus = 1005,
	/// <summary>
	/// Indicates that the connection was closed abnormally, without
	/// sending a Close frame. Reserved for use outside Close frames.
	/// </summary>
	FMWebSocketStatusCodeAbnormal = 1006,
	/// <summary>
	/// Indicates that an endpoint is terminating the connection
	/// because it has received data within a message that was not
	/// consistent with the type of message.
	/// </summary>
	FMWebSocketStatusCodeInvalidData = 1007,
	/// <summary>
	/// Indicates that an endpoint is terminating the connection
	/// because it has received a message that violates its policy.
	/// </summary>
	FMWebSocketStatusCodePolicyViolation = 1008,
	/// <summary>
	/// Indicates that an endpoint is terminating the connection
	/// because it has received a message that is too big for it
	/// to process.
	/// </summary>
	FMWebSocketStatusCodeMessageTooLarge = 1009,
	/// <summary>
	/// Indicates that the client is terminating the connection
	/// because it has expected the server to negotiate one or
	/// more extensions, but the server didn't return them in the
	/// response message of the WebSocket handshake.
	/// </summary>
	FMWebSocketStatusCodeUnsupportedExtension = 1010,
	/// <summary>
	/// Indicates that the server is terminating the connection
	/// because it encountered an unexpected condition that
	/// prevented it from fulfilling the request.
	/// </summary>
	FMWebSocketStatusCodeUnexpectedCondition = 1011,
	/// <summary>
	/// Indicates that the connection was closed due to a failure
	/// to perform a TLS handshake. Reserved for use outside Close
	/// frames.
	/// </summary>
	FMWebSocketStatusCodeSecureHandshakeFailure = 1015
} FMWebSocketStatusCode;


@class NSStringFMExtensions;

/// <summary>
/// Base definition for classes that allow serialization to/from JSON.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMSerializable : NSObject 

/// <summary>
/// Initializes a new instance of the <see cref="FMSerializable" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Gets a value indicating whether this instance is dirty.
/// </summary>
- (bool) isDirty;
- (bool) isSerialized;
/// <summary>
/// Initializes a new instance of the <see cref="FMSerializable" /> class.
/// </summary>
+ (FMSerializable*) serializable;
- (NSString*) serialized;
/// <summary>
/// Sets a value indicating whether this instance is dirty.
/// </summary>
- (void) setIsDirty:(bool)value;
- (void) setIsSerialized:(bool)value;
- (void) setSerialized:(NSString*)value;

@end


@class NSMutableDictionaryFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Supplies class instances with a key-value
/// mapping to support dynamic property storage.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMDynamic : FMSerializable 

+ (FMDynamic*) dynamic;
/// <summary>
/// Gets the dynamic properties on this instance.
/// </summary>
- (NSMutableDictionary*) dynamicProperties;
/// <summary>
/// Gets a property value from the local cache.
/// </summary>
/// <param name="key">The property key. This key is used internally only, but should be namespaced to avoid conflict with third-party extensions.</param>
/// <returns>The stored value, if found; otherwise null.</returns>
- (NSObject*) getDynamicValueWithKey:(NSString*)key;
- (id) init;
/// <summary>
/// Sets the dynamic properties on this instance.
/// </summary>
- (void) setDynamicProperties:(NSMutableDictionary*)value;
/// <summary>
/// Sets a property value in the local cache.
/// </summary>
/// <param name="key">The property key. This key is used internally only, but should be namespaced to avoid conflict with third-party extensions.</param>
/// <param name="value">The property value. This can be any object that needs to be stored for future use.</param>
- (void) setDynamicValueWithKey:(NSString*)key value:(NSObject*)value;
/// <summary>
/// Unsets a property value in the local cache.
/// </summary>
/// <param name="key">The property key. This key is used internally only, but should be namespaced to avoid conflict with third-party extensions.</param>
/// <returns><c>true</c> if the value was removed; otherwise, <c>false</c>.</returns>
- (bool) unsetDynamicValueWithKey:(NSString*)key;

@end


@class FMTcpSocket;

/// <summary>
/// TCP output args.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpOutputArgs : FMDynamic 

- (id) init;
/// <summary>
/// Sets the socket.
/// </summary>
- (void) setSocket:(FMTcpSocket*)value;
/// <summary>
/// Sets the custom state object.
/// </summary>
- (void) setState:(NSObject*)value;
/// <summary>
/// Gets the socket.
/// </summary>
- (FMTcpSocket*) socket;
/// <summary>
/// Gets the custom state object.
/// </summary>
- (NSObject*) state;
+ (FMTcpOutputArgs*) tcpOutputArgs;

@end


@class FMTcpAcceptSuccessArgs;
@class FMTcpAcceptFailureArgs;
@class FMTcpAcceptCompleteArgs;
@class FMCallback;

/// <summary>
/// TCP accept arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpAcceptArgs : FMDynamic 

/// <summary>
/// Initializes a new instance of the <see cref="FMTcpAcceptArgs" /> class.
/// </summary>
/// <param name="state">The custom state object.</param>
- (id) initWithState:(NSObject*)state;
/// <summary>
/// Gets the callback to invoke on complete.
/// </summary>
- (FMCallback*) onComplete;
/// <summary>
/// Gets the callback to invoke on failure.
/// </summary>
- (FMCallback*) onFailure;
/// <summary>
/// Gets the callback to invoke on success.
/// </summary>
- (FMCallback*) onSuccess;
/// <summary>
/// Sets the callback to invoke on complete.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on complete.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMTcpAcceptCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke on failure.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on failure.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMTcpAcceptFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke on success.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on success.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMTcpAcceptSuccessArgs*))valueBlock;
/// <summary>
/// Sets the custom state object.
/// </summary>
- (void) setState:(NSObject*)value;
/// <summary>
/// Gets the custom state object.
/// </summary>
- (NSObject*) state;
/// <summary>
/// Initializes a new instance of the <see cref="FMTcpAcceptArgs" /> class.
/// </summary>
/// <param name="state">The custom state object.</param>
+ (FMTcpAcceptArgs*) tcpAcceptArgsWithState:(NSObject*)state;

@end



/// <summary>
/// TCP accept-complete arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpAcceptCompleteArgs : FMTcpOutputArgs 

- (id) init;
+ (FMTcpAcceptCompleteArgs*) tcpAcceptCompleteArgs;

@end


@class NSExceptionFMExtensions;

/// <summary>
/// TCP accept-failure arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpAcceptFailureArgs : FMTcpOutputArgs 

/// <summary>
/// Gets the exception that occurred.
/// </summary>
- (NSException*) exception;
- (id) init;
/// <summary>
/// Sets the exception that occurred.
/// </summary>
- (void) setException:(NSException*)value;
+ (FMTcpAcceptFailureArgs*) tcpAcceptFailureArgs;

@end


@class FMTcpSocket;

/// <summary>
/// TCP accept-success arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpAcceptSuccessArgs : FMTcpOutputArgs 

/// <summary>
/// Gets the new socket.
/// </summary>
- (FMTcpSocket*) acceptSocket;
- (id) init;
/// <summary>
/// Sets the new socket.
/// </summary>
- (void) setAcceptSocket:(FMTcpSocket*)value;
+ (FMTcpAcceptSuccessArgs*) tcpAcceptSuccessArgs;

@end


@class FMUdpSocket;

/// <summary>
/// UDP output args.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMUdpOutputArgs : FMDynamic 

- (id) init;
/// <summary>
/// Sets the socket.
/// </summary>
- (void) setSocket:(FMUdpSocket*)value;
/// <summary>
/// Sets the custom state object.
/// </summary>
- (void) setState:(NSObject*)value;
/// <summary>
/// Gets the socket.
/// </summary>
- (FMUdpSocket*) socket;
/// <summary>
/// Gets the custom state object.
/// </summary>
- (NSObject*) state;
+ (FMUdpOutputArgs*) udpOutputArgs;

@end


@class FMUdpReceiveSuccessArgs;
@class FMUdpReceiveFailureArgs;
@class FMUdpReceiveCompleteArgs;
@class FMCallback;

/// <summary>
/// UDP receive arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMUdpReceiveArgs : FMDynamic 

/// <summary>
/// Initializes a new instance of the <see cref="FMUdpReceiveArgs" /> class.
/// </summary>
/// <param name="state">A custom state object.</param>
- (id) initWithState:(NSObject*)state;
/// <summary>
/// Gets the callback to invoke on complete.
/// </summary>
- (FMCallback*) onComplete;
/// <summary>
/// Gets the callback to invoke on failure.
/// </summary>
- (FMCallback*) onFailure;
/// <summary>
/// Gets the callback to invoke on success.
/// </summary>
- (FMCallback*) onSuccess;
/// <summary>
/// Sets the callback to invoke on complete.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on complete.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMUdpReceiveCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke on failure.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on failure.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMUdpReceiveFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke on success.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on success.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMUdpReceiveSuccessArgs*))valueBlock;
/// <summary>
/// Sets the custom state object.
/// </summary>
- (void) setState:(NSObject*)value;
/// <summary>
/// Gets the custom state object.
/// </summary>
- (NSObject*) state;
/// <summary>
/// Initializes a new instance of the <see cref="FMUdpReceiveArgs" /> class.
/// </summary>
/// <param name="state">A custom state object.</param>
+ (FMUdpReceiveArgs*) udpReceiveArgsWithState:(NSObject*)state;

@end



/// <summary>
/// UDP receive-complete arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMUdpReceiveCompleteArgs : FMUdpOutputArgs 

- (id) init;
+ (FMUdpReceiveCompleteArgs*) udpReceiveCompleteArgs;

@end


@class NSExceptionFMExtensions;

/// <summary>
/// UDP receive-failure arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMUdpReceiveFailureArgs : FMUdpOutputArgs 

/// <summary>
/// Gets the exception that occurred.
/// </summary>
- (NSException*) exception;
- (id) init;
/// <summary>
/// Sets the exception that occurred.
/// </summary>
- (void) setException:(NSException*)value;
+ (FMUdpReceiveFailureArgs*) udpReceiveFailureArgs;

@end


@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// UDP receive-success arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMUdpReceiveSuccessArgs : FMUdpOutputArgs 

/// <summary>
/// Gets the buffer of received data.
/// </summary>
- (NSMutableData*) buffer;
/// <summary>
/// Gets the number of packets discarded after this read.
/// For more information, see <see cref="FMUdpSocket#maxQueuedPackets" />.
/// </summary>
- (int) discardedPacketCount;
- (id) init;
/// <summary>
/// Gets the remote IP address.
/// </summary>
- (NSString*) remoteIPAddress;
/// <summary>
/// Gets the remote port.
/// </summary>
- (int) remotePort;
/// <summary>
/// Sets the buffer of received data.
/// </summary>
- (void) setBuffer:(NSMutableData*)value;
/// <summary>
/// Sets the number of packets discarded after this read.
/// For more information, see <see cref="FMUdpSocket#maxQueuedPackets" />.
/// </summary>
- (void) setDiscardedPacketCount:(int)value;
/// <summary>
/// Sets the remote IP address.
/// </summary>
- (void) setRemoteIPAddress:(NSString*)value;
/// <summary>
/// Sets the remote port.
/// </summary>
- (void) setRemotePort:(int)value;
+ (FMUdpReceiveSuccessArgs*) udpReceiveSuccessArgs;

@end


@class FMUdpSendSuccessArgs;
@class FMUdpSendFailureArgs;
@class FMUdpSendCompleteArgs;
@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;
@class FMCallback;

/// <summary>
/// UDP send arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMUdpSendArgs : FMDynamic 

/// <summary>
/// Gets the buffer of data to send.
/// </summary>
- (NSMutableData*) buffer;
/// <summary>
/// Initializes a new instance of the <see cref="FMUdpSendArgs" /> class.
/// </summary>
/// <param name="buffer">The buffer of data to send.</param>
/// <param name="ipAddress">The remote IP address.</param>
/// <param name="port">The remote port.</param>
/// <param name="state">The custom state object.</param>
- (id) initWithBuffer:(NSMutableData*)buffer ipAddress:(NSString*)ipAddress port:(int)port state:(NSObject*)state;
/// <summary>
/// Gets the remote IP address.
/// </summary>
- (NSString*) ipAddress;
/// <summary>
/// Gets the callback to invoke on complete.
/// </summary>
- (FMCallback*) onComplete;
/// <summary>
/// Gets the callback to invoke on failure.
/// </summary>
- (FMCallback*) onFailure;
/// <summary>
/// Gets the callback to invoke on success.
/// </summary>
- (FMCallback*) onSuccess;
/// <summary>
/// Gets the remote port.
/// </summary>
- (int) port;
/// <summary>
/// Sets the buffer of data to send.
/// </summary>
- (void) setBuffer:(NSMutableData*)value;
/// <summary>
/// Sets the remote IP address.
/// </summary>
- (void) setIPAddress:(NSString*)value;
/// <summary>
/// Sets the callback to invoke on complete.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on complete.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMUdpSendCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke on failure.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on failure.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMUdpSendFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke on success.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on success.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMUdpSendSuccessArgs*))valueBlock;
/// <summary>
/// Sets the remote port.
/// </summary>
- (void) setPort:(int)value;
/// <summary>
/// Sets the custom state object.
/// </summary>
- (void) setState:(NSObject*)value;
/// <summary>
/// Gets the custom state object.
/// </summary>
- (NSObject*) state;
/// <summary>
/// Initializes a new instance of the <see cref="FMUdpSendArgs" /> class.
/// </summary>
/// <param name="buffer">The buffer of data to send.</param>
/// <param name="ipAddress">The remote IP address.</param>
/// <param name="port">The remote port.</param>
/// <param name="state">The custom state object.</param>
+ (FMUdpSendArgs*) udpSendArgsWithBuffer:(NSMutableData*)buffer ipAddress:(NSString*)ipAddress port:(int)port state:(NSObject*)state;

@end


@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// UDP send-complete arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMUdpSendCompleteArgs : FMUdpOutputArgs 

/// <summary>
/// Gets the original buffer of data to send.
/// </summary>
- (NSMutableData*) buffer;
- (id) init;
/// <summary>
/// Gets the original remote IP address.
/// </summary>
- (NSString*) ipAddress;
/// <summary>
/// Gets the original remote port.
/// </summary>
- (int) port;
/// <summary>
/// Sets the original buffer of data to send.
/// </summary>
- (void) setBuffer:(NSMutableData*)value;
/// <summary>
/// Sets the original remote IP address.
/// </summary>
- (void) setIPAddress:(NSString*)value;
/// <summary>
/// Sets the original remote port.
/// </summary>
- (void) setPort:(int)value;
+ (FMUdpSendCompleteArgs*) udpSendCompleteArgs;

@end


@class NSMutableDataFMExtensions;
@class NSExceptionFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// UDP send-failure arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMUdpSendFailureArgs : FMUdpOutputArgs 

/// <summary>
/// Gets the original buffer of data to send.
/// </summary>
- (NSMutableData*) buffer;
/// <summary>
/// Gets the exception that occurred.
/// </summary>
- (NSException*) exception;
- (id) init;
/// <summary>
/// Gets the original remote IP address.
/// </summary>
- (NSString*) ipAddress;
/// <summary>
/// Gets the original remote port.
/// </summary>
- (int) port;
/// <summary>
/// Sets the original buffer of data to send.
/// </summary>
- (void) setBuffer:(NSMutableData*)value;
/// <summary>
/// Sets the exception that occurred.
/// </summary>
- (void) setException:(NSException*)value;
/// <summary>
/// Sets the original remote IP address.
/// </summary>
- (void) setIPAddress:(NSString*)value;
/// <summary>
/// Sets the original remote port.
/// </summary>
- (void) setPort:(int)value;
+ (FMUdpSendFailureArgs*) udpSendFailureArgs;

@end


@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// UDP send-success arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMUdpSendSuccessArgs : FMUdpOutputArgs 

/// <summary>
/// Gets the original buffer of data to send.
/// </summary>
- (NSMutableData*) buffer;
- (id) init;
/// <summary>
/// Gets the original remote IP address.
/// </summary>
- (NSString*) ipAddress;
/// <summary>
/// Gets the original remote port.
/// </summary>
- (int) port;
/// <summary>
/// Sets the original buffer of data to send.
/// </summary>
- (void) setBuffer:(NSMutableData*)value;
/// <summary>
/// Sets the original remote IP address.
/// </summary>
- (void) setIPAddress:(NSString*)value;
/// <summary>
/// Sets the original remote port.
/// </summary>
- (void) setPort:(int)value;
+ (FMUdpSendSuccessArgs*) udpSendSuccessArgs;

@end


@class FMTcpReceiveSuccessArgs;
@class FMTcpReceiveFailureArgs;
@class FMTcpReceiveCompleteArgs;
@class FMCallback;

/// <summary>
/// TCP receive arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpReceiveArgs : FMDynamic 

/// <summary>
/// Initializes a new instance of the <see cref="FMTcpReceiveArgs" /> class.
/// </summary>
/// <param name="state">The custom state object.</param>
- (id) initWithState:(NSObject*)state;
/// <summary>
/// Initializes a new instance of the <see cref="FMTcpReceiveArgs" /> class.
/// </summary>
/// <param name="state">The custom state object.</param>
/// <param name="timeout">The timeout.</param>
- (id) initWithState:(NSObject*)state timeout:(int)timeout;
/// <summary>
/// Gets the callback to invoke on complete.
/// </summary>
- (FMCallback*) onComplete;
/// <summary>
/// Gets the callback to invoke on failure.
/// </summary>
- (FMCallback*) onFailure;
/// <summary>
/// Gets the callback to invoke on success.
/// </summary>
- (FMCallback*) onSuccess;
/// <summary>
/// Sets the callback to invoke on complete.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on complete.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMTcpReceiveCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke on failure.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on failure.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMTcpReceiveFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke on success.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on success.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMTcpReceiveSuccessArgs*))valueBlock;
/// <summary>
/// Sets the custom state object.
/// </summary>
- (void) setState:(NSObject*)value;
/// <summary>
/// Sets the timeout.
/// </summary>
- (void) setTimeout:(int)value;
/// <summary>
/// Gets the custom state object.
/// </summary>
- (NSObject*) state;
/// <summary>
/// Initializes a new instance of the <see cref="FMTcpReceiveArgs" /> class.
/// </summary>
/// <param name="state">The custom state object.</param>
+ (FMTcpReceiveArgs*) tcpReceiveArgsWithState:(NSObject*)state;
/// <summary>
/// Initializes a new instance of the <see cref="FMTcpReceiveArgs" /> class.
/// </summary>
/// <param name="state">The custom state object.</param>
/// <param name="timeout">The timeout.</param>
+ (FMTcpReceiveArgs*) tcpReceiveArgsWithState:(NSObject*)state timeout:(int)timeout;
/// <summary>
/// Gets the timeout.
/// </summary>
- (int) timeout;
/// <summary>
/// Gets whether the receive will timeout eventually.
/// </summary>
- (bool) willTimeout;

@end



/// <summary>
/// TCP receive-complete arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpReceiveCompleteArgs : FMTcpOutputArgs 

- (id) init;
/// <summary>
/// Sets the original timeout.
/// </summary>
- (void) setTimeout:(int)value;
+ (FMTcpReceiveCompleteArgs*) tcpReceiveCompleteArgs;
/// <summary>
/// Gets the original timeout.
/// </summary>
- (int) timeout;

@end


@class NSExceptionFMExtensions;

/// <summary>
/// TCP receive-failure arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpReceiveFailureArgs : FMTcpOutputArgs 

/// <summary>
/// Gets the exception that occurred.
/// </summary>
- (NSException*) exception;
- (id) init;
/// <summary>
/// Sets the exception that occurred.
/// </summary>
- (void) setException:(NSException*)value;
/// <summary>
/// Sets whether the receive timed out.
/// </summary>
- (void) setTimedOut:(bool)value;
/// <summary>
/// Sets the original timeout.
/// </summary>
- (void) setTimeout:(int)value;
+ (FMTcpReceiveFailureArgs*) tcpReceiveFailureArgs;
/// <summary>
/// Gets whether the receive timed out.
/// </summary>
- (bool) timedOut;
/// <summary>
/// Gets the original timeout.
/// </summary>
- (int) timeout;

@end


@class NSMutableDataFMExtensions;

/// <summary>
/// TCP receive-success arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpReceiveSuccessArgs : FMTcpOutputArgs 

/// <summary>
/// Gets the buffer of received data.
/// </summary>
- (NSMutableData*) buffer;
- (id) init;
/// <summary>
/// Sets the buffer of received data.
/// </summary>
- (void) setBuffer:(NSMutableData*)value;
/// <summary>
/// Sets the original timeout.
/// </summary>
- (void) setTimeout:(int)value;
+ (FMTcpReceiveSuccessArgs*) tcpReceiveSuccessArgs;
/// <summary>
/// Gets the original timeout.
/// </summary>
- (int) timeout;

@end


@class FMTcpSendSuccessArgs;
@class FMTcpSendFailureArgs;
@class FMTcpSendCompleteArgs;
@class NSMutableDataFMExtensions;
@class FMCallback;

/// <summary>
/// TCP send arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpSendArgs : FMDynamic 

/// <summary>
/// Gets the buffer of data to send.
/// </summary>
- (NSMutableData*) buffer;
/// <summary>
/// Initializes a new instance of the <see cref="FMTcpSendArgs" /> class.
/// </summary>
/// <param name="buffer">The buffer of data to send.</param>
/// <param name="state">The custom state object.</param>
- (id) initWithBuffer:(NSMutableData*)buffer state:(NSObject*)state;
/// <summary>
/// Initializes a new instance of the <see cref="FMTcpSendArgs" /> class.
/// </summary>
/// <param name="buffer">The buffer of data to send.</param>
/// <param name="state">The custom state object.</param>
/// <param name="timeout">The timeout.</param>
- (id) initWithBuffer:(NSMutableData*)buffer state:(NSObject*)state timeout:(int)timeout;
/// <summary>
/// Gets the callback to invoke on complete.
/// </summary>
- (FMCallback*) onComplete;
/// <summary>
/// Gets the callback to invoke on failure.
/// </summary>
- (FMCallback*) onFailure;
/// <summary>
/// Gets the callback to invoke on success.
/// </summary>
- (FMCallback*) onSuccess;
/// <summary>
/// Sets the buffer of data to send.
/// </summary>
- (void) setBuffer:(NSMutableData*)value;
/// <summary>
/// Sets the callback to invoke on complete.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on complete.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMTcpSendCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke on failure.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on failure.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMTcpSendFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke on success.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on success.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMTcpSendSuccessArgs*))valueBlock;
/// <summary>
/// Sets the custom state object.
/// </summary>
- (void) setState:(NSObject*)value;
/// <summary>
/// Sets the timeout.
/// </summary>
- (void) setTimeout:(int)value;
/// <summary>
/// Gets the custom state object.
/// </summary>
- (NSObject*) state;
/// <summary>
/// Initializes a new instance of the <see cref="FMTcpSendArgs" /> class.
/// </summary>
/// <param name="buffer">The buffer of data to send.</param>
/// <param name="state">The custom state object.</param>
+ (FMTcpSendArgs*) tcpSendArgsWithBuffer:(NSMutableData*)buffer state:(NSObject*)state;
/// <summary>
/// Initializes a new instance of the <see cref="FMTcpSendArgs" /> class.
/// </summary>
/// <param name="buffer">The buffer of data to send.</param>
/// <param name="state">The custom state object.</param>
/// <param name="timeout">The timeout.</param>
+ (FMTcpSendArgs*) tcpSendArgsWithBuffer:(NSMutableData*)buffer state:(NSObject*)state timeout:(int)timeout;
/// <summary>
/// Gets the timeout.
/// </summary>
- (int) timeout;
/// <summary>
/// Gets whether the send will timeout eventually.
/// </summary>
- (bool) willTimeout;

@end


@class NSMutableDataFMExtensions;

/// <summary>
/// TCP send-complete arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpSendCompleteArgs : FMTcpOutputArgs 

/// <summary>
/// Gets the original buffer of data to send.
/// </summary>
- (NSMutableData*) buffer;
- (id) init;
/// <summary>
/// Sets the original buffer of data to send.
/// </summary>
- (void) setBuffer:(NSMutableData*)value;
/// <summary>
/// Sets the original timeout.
/// </summary>
- (void) setTimeout:(int)value;
+ (FMTcpSendCompleteArgs*) tcpSendCompleteArgs;
/// <summary>
/// Gets the original timeout.
/// </summary>
- (int) timeout;

@end


@class NSMutableDataFMExtensions;
@class NSExceptionFMExtensions;

/// <summary>
/// TCP send-failure arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpSendFailureArgs : FMTcpOutputArgs 

/// <summary>
/// Gets the original buffer of data to send.
/// </summary>
- (NSMutableData*) buffer;
/// <summary>
/// Gets the exception that occurred.
/// </summary>
- (NSException*) exception;
- (id) init;
/// <summary>
/// Sets the original buffer of data to send.
/// </summary>
- (void) setBuffer:(NSMutableData*)value;
/// <summary>
/// Sets the exception that occurred.
/// </summary>
- (void) setException:(NSException*)value;
/// <summary>
/// Sets whether the send timed out.
/// </summary>
- (void) setTimedOut:(bool)value;
/// <summary>
/// Sets the original timeout.
/// </summary>
- (void) setTimeout:(int)value;
+ (FMTcpSendFailureArgs*) tcpSendFailureArgs;
/// <summary>
/// Gets whether the send timed out.
/// </summary>
- (bool) timedOut;
/// <summary>
/// Gets the original timeout.
/// </summary>
- (int) timeout;

@end


@class NSMutableDataFMExtensions;

/// <summary>
/// TCP send-success arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpSendSuccessArgs : FMTcpOutputArgs 

/// <summary>
/// Gets the original buffer of data to send.
/// </summary>
- (NSMutableData*) buffer;
- (id) init;
/// <summary>
/// Sets the original buffer of data to send.
/// </summary>
- (void) setBuffer:(NSMutableData*)value;
/// <summary>
/// Sets the original timeout.
/// </summary>
- (void) setTimeout:(int)value;
+ (FMTcpSendSuccessArgs*) tcpSendSuccessArgs;
/// <summary>
/// Gets the original timeout.
/// </summary>
- (int) timeout;

@end



/// <summary>
/// TCP connect-complete arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpConnectCompleteArgs : FMTcpOutputArgs 

- (id) init;
/// <summary>
/// Sets the original timeout.
/// </summary>
- (void) setTimeout:(int)value;
+ (FMTcpConnectCompleteArgs*) tcpConnectCompleteArgs;
/// <summary>
/// Gets the original timeout.
/// </summary>
- (int) timeout;

@end


@class NSExceptionFMExtensions;

/// <summary>
/// TCP connect-failure arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpConnectFailureArgs : FMTcpOutputArgs 

/// <summary>
/// Gets the exception that occurred.
/// </summary>
- (NSException*) exception;
- (id) init;
/// <summary>
/// Sets the exception that occurred.
/// </summary>
- (void) setException:(NSException*)value;
/// <summary>
/// Sets whether the send timed out.
/// </summary>
- (void) setTimedOut:(bool)value;
/// <summary>
/// Sets the original timeout.
/// </summary>
- (void) setTimeout:(int)value;
+ (FMTcpConnectFailureArgs*) tcpConnectFailureArgs;
/// <summary>
/// Gets whether the send timed out.
/// </summary>
- (bool) timedOut;
/// <summary>
/// Gets the original timeout.
/// </summary>
- (int) timeout;

@end



/// <summary>
/// TCP connect-success arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpConnectSuccessArgs : FMTcpOutputArgs 

- (id) init;
/// <summary>
/// Sets the original timeout.
/// </summary>
- (void) setTimeout:(int)value;
+ (FMTcpConnectSuccessArgs*) tcpConnectSuccessArgs;
/// <summary>
/// Gets the original timeout.
/// </summary>
- (int) timeout;

@end


@class FMTcpConnectSuccessArgs;
@class FMTcpConnectFailureArgs;
@class FMTcpConnectCompleteArgs;
@class NSStringFMExtensions;
@class FMCallback;

/// <summary>
/// TCP connect arguments.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTcpConnectArgs : FMDynamic 

/// <summary>
/// Initializes a new instance of the <see cref="FMTcpConnectArgs" /> class.
/// </summary>
/// <param name="ipAddress">The remote IP address.</param>
/// <param name="port">The remote port.</param>
/// <param name="state">The custom state object.</param>
- (id) initWithIPAddress:(NSString*)ipAddress port:(int)port state:(NSObject*)state;
/// <summary>
/// Initializes a new instance of the <see cref="FMTcpConnectArgs" /> class.
/// </summary>
/// <param name="ipAddress">The remote IP address.</param>
/// <param name="port">The remote port.</param>
/// <param name="state">The custom state object.</param>
/// <param name="timeout">The timeout.</param>
- (id) initWithIPAddress:(NSString*)ipAddress port:(int)port state:(NSObject*)state timeout:(int)timeout;
/// <summary>
/// Gets the remote IP address.
/// </summary>
- (NSString*) ipAddress;
/// <summary>
/// Gets the callback to invoke on complete.
/// </summary>
- (FMCallback*) onComplete;
/// <summary>
/// Gets the callback to invoke on failure.
/// </summary>
- (FMCallback*) onFailure;
/// <summary>
/// Gets the callback to invoke on success.
/// </summary>
- (FMCallback*) onSuccess;
/// <summary>
/// Gets the remote port.
/// </summary>
- (int) port;
/// <summary>
/// Sets the remote IP address.
/// </summary>
- (void) setIPAddress:(NSString*)value;
/// <summary>
/// Sets the callback to invoke on complete.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on complete.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMTcpConnectCompleteArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke on failure.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on failure.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMTcpConnectFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke on success.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke on success.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMTcpConnectSuccessArgs*))valueBlock;
/// <summary>
/// Sets the remote port.
/// </summary>
- (void) setPort:(int)value;
/// <summary>
/// Sets the custom state object.
/// </summary>
- (void) setState:(NSObject*)value;
/// <summary>
/// Sets the timeout.
/// </summary>
- (void) setTimeout:(int)value;
/// <summary>
/// Gets the custom state object.
/// </summary>
- (NSObject*) state;
/// <summary>
/// Initializes a new instance of the <see cref="FMTcpConnectArgs" /> class.
/// </summary>
/// <param name="ipAddress">The remote IP address.</param>
/// <param name="port">The remote port.</param>
/// <param name="state">The custom state object.</param>
+ (FMTcpConnectArgs*) tcpConnectArgsWithIPAddress:(NSString*)ipAddress port:(int)port state:(NSObject*)state;
/// <summary>
/// Initializes a new instance of the <see cref="FMTcpConnectArgs" /> class.
/// </summary>
/// <param name="ipAddress">The remote IP address.</param>
/// <param name="port">The remote port.</param>
/// <param name="state">The custom state object.</param>
/// <param name="timeout">The timeout.</param>
+ (FMTcpConnectArgs*) tcpConnectArgsWithIPAddress:(NSString*)ipAddress port:(int)port state:(NSObject*)state timeout:(int)timeout;
/// <summary>
/// Gets the timeout.
/// </summary>
- (int) timeout;
/// <summary>
/// Gets whether the send will timeout eventually.
/// </summary>
- (bool) willTimeout;

@end


@class FMHttpRequestArgs;
@class NSURLResponseFMExtensions;

/// <summary>
/// Arguments passed into callbacks when an HTTP response is received.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMHttpResponseReceivedArgs : NSObject 

+ (FMHttpResponseReceivedArgs*) httpResponseReceivedArgs;
- (id) init;
/// <summary>
/// Gets the original request arguments.
/// </summary>
- (FMHttpRequestArgs*) requestArgs;
/// <summary>
/// Gets the incoming HTTP response received from the server.
/// </summary>
- (NSURLResponse*) response;
/// <summary>
/// Gets the sender of the request, either a client or publisher.
/// </summary>
- (NSObject*) sender;
/// <summary>
/// Sets the original request arguments.
/// </summary>
- (void) setRequestArgs:(FMHttpRequestArgs*)value;
/// <summary>
/// Sets the incoming HTTP response received from the server.
/// </summary>
- (void) setResponse:(NSURLResponse*)value;
/// <summary>
/// Sets the sender of the request, either a client or publisher.
/// </summary>
- (void) setSender:(NSObject*)value;

@end


@class FMWebSocketCloseCompleteArgs;
@class FMCallback;
@class NSStringFMExtensions;

/// <summary>
/// Close arguments for the <see cref="FMWebSocket" /> class.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketCloseArgs : FMDynamic 

/// <summary>
/// Creates a new instance of <see cref="FMWebSocketCloseArgs" />
/// with default values.
/// </summary>
- (id) init;
/// <summary>
/// Gets the callback to execute when the connection is closed.
/// </summary>
- (FMCallback*) onComplete;
/// <summary>
/// Gets the reason to send with the close frame.
/// </summary>
- (NSString*) reason;
/// <summary>
/// Sets the callback to execute when the connection is closed.
/// </summary>
- (void) setOnComplete:(FMCallback*)value;
/// <summary>
/// Sets the callback to execute when the connection is closed.
/// </summary>
- (void) setOnCompleteBlock:(void (^) (FMWebSocketCloseCompleteArgs*))valueBlock;
/// <summary>
/// Sets the reason to send with the close frame.
/// </summary>
- (void) setReason:(NSString*)value;
/// <summary>
/// Sets the status code to send with the close frame.
/// </summary>
- (void) setStatusCode:(FMWebSocketStatusCode)value;
/// <summary>
/// Gets the status code to send with the close frame.
/// </summary>
- (FMWebSocketStatusCode) statusCode;
/// <summary>
/// Creates a new instance of <see cref="FMWebSocketCloseArgs" />
/// with default values.
/// </summary>
+ (FMWebSocketCloseArgs*) webSocketCloseArgs;

@end


@class FMWebSocketCloseArgs;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for <see cref="FMWebSocketCloseArgs#onComplete" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketCloseCompleteArgs : FMDynamic 

/// <summary>
/// Gets the original arguments passed to the close method.
/// </summary>
- (FMWebSocketCloseArgs*) closeArgs;
- (id) init;
/// <summary>
/// Gets the reason given for closing the connection.
/// </summary>
- (NSString*) reason;
/// <summary>
/// Sets the original arguments passed to the close method.
/// </summary>
- (void) setCloseArgs:(FMWebSocketCloseArgs*)value;
/// <summary>
/// Sets the reason given for closing the connection.
/// </summary>
- (void) setReason:(NSString*)value;
/// <summary>
/// Sets the status code associated with the close operation.
/// </summary>
- (void) setStatusCode:(FMWebSocketStatusCode)value;
/// <summary>
/// Gets the status code associated with the close operation.
/// </summary>
- (FMWebSocketStatusCode) statusCode;
+ (FMWebSocketCloseCompleteArgs*) webSocketCloseCompleteArgs;

@end


@class FMWebSocketOpenSuccessArgs;
@class FMWebSocketOpenFailureArgs;
@class FMWebSocketStreamFailureArgs;
@class FMHttpRequestCreatedArgs;
@class FMHttpResponseReceivedArgs;
@class FMWebSocketReceiveArgs;
@class FMNameValueCollection;
@class FMCallback;

/// <summary>
/// Open arguments for the <see cref="FMWebSocket" /> class.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketOpenArgs : FMDynamic 

/// <summary>
/// Gets the timeout for the handshake.
/// </summary>
- (int) handshakeTimeout;
/// <summary>
/// Gets headers to send with the handshake request.
/// </summary>
- (FMNameValueCollection*) headers;
/// <summary>
/// Creates a new instance of
/// </summary>
- (id) init;
/// <summary>
/// Gets the callback to invoke when a connection could not be established.
/// </summary>
- (FMCallback*) onFailure;
/// <summary>
/// Gets the callback to invoke when a message is received.
/// </summary>
- (FMCallback*) onReceive;
/// <summary>
/// Gets the callback to invoke before the handshake request is sent.
/// </summary>
- (FMCallback*) onRequestCreated;
/// <summary>
/// Gets the callback to invoke after the handshake response is received.
/// </summary>
- (FMCallback*) onResponseReceived;
/// <summary>
/// Gets the callback to invoke when a successful connection breaks down.
/// </summary>
- (FMCallback*) onStreamFailure;
/// <summary>
/// Gets the callback to invoke when a successful connection has been established.
/// </summary>
- (FMCallback*) onSuccess;
/// <summary>
/// Gets the sender of the request.
/// </summary>
- (NSObject*) sender;
/// <summary>
/// Sets the timeout for the handshake.
/// </summary>
- (void) setHandshakeTimeout:(int)value;
/// <summary>
/// Sets headers to send with the handshake request.
/// </summary>
- (void) setHeaders:(FMNameValueCollection*)value;
/// <summary>
/// Sets the callback to invoke when a connection could not be established.
/// </summary>
- (void) setOnFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke when a connection could not be established.
/// </summary>
- (void) setOnFailureBlock:(void (^) (FMWebSocketOpenFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke when a message is received.
/// </summary>
- (void) setOnReceive:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke when a message is received.
/// </summary>
- (void) setOnReceiveBlock:(void (^) (FMWebSocketReceiveArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke before the handshake request is sent.
/// </summary>
- (void) setOnRequestCreated:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke before the handshake request is sent.
/// </summary>
- (void) setOnRequestCreatedBlock:(void (^) (FMHttpRequestCreatedArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke after the handshake response is received.
/// </summary>
- (void) setOnResponseReceived:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke after the handshake response is received.
/// </summary>
- (void) setOnResponseReceivedBlock:(void (^) (FMHttpResponseReceivedArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke when a successful connection breaks down.
/// </summary>
- (void) setOnStreamFailure:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke when a successful connection breaks down.
/// </summary>
- (void) setOnStreamFailureBlock:(void (^) (FMWebSocketStreamFailureArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke when a successful connection has been established.
/// </summary>
- (void) setOnSuccess:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke when a successful connection has been established.
/// </summary>
- (void) setOnSuccessBlock:(void (^) (FMWebSocketOpenSuccessArgs*))valueBlock;
/// <summary>
/// Sets the sender of the request.
/// </summary>
- (void) setSender:(NSObject*)value;
/// <summary>
/// Sets the timeout for the stream.
/// </summary>
- (void) setStreamTimeout:(int)value;
/// <summary>
/// Gets the timeout for the stream.
/// </summary>
- (int) streamTimeout;
/// <summary>
/// Creates a new instance of
/// </summary>
+ (FMWebSocketOpenArgs*) webSocketOpenArgs;

@end


@class NSExceptionFMExtensions;
@class FMWebSocketOpenArgs;

/// <summary>
/// Arguments for <see cref="FMWebSocketOpenArgs#onFailure" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketOpenFailureArgs : FMDynamic 

/// <summary>
/// Gets the exception generated while connecting.
/// </summary>
- (NSException*) exception;
- (id) init;
/// <summary>
/// Gets the original arguments passed to the open method.
/// </summary>
- (FMWebSocketOpenArgs*) openArgs;
/// <summary>
/// Sets the exception generated while connecting.
/// </summary>
- (void) setException:(NSException*)value;
/// <summary>
/// Sets the original arguments passed to the open method.
/// </summary>
- (void) setOpenArgs:(FMWebSocketOpenArgs*)value;
/// <summary>
/// Sets the status code associated with the failure to connect.
/// </summary>
- (void) setStatusCode:(FMWebSocketStatusCode)value;
/// <summary>
/// Gets the status code associated with the failure to connect.
/// </summary>
- (FMWebSocketStatusCode) statusCode;
+ (FMWebSocketOpenFailureArgs*) webSocketOpenFailureArgs;

@end


@class FMWebSocketOpenArgs;

/// <summary>
/// Arguments for <see cref="FMWebSocketOpenArgs#onSuccess" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketOpenSuccessArgs : FMDynamic 

- (id) init;
/// <summary>
/// Gets the original arguments passed to the open method.
/// </summary>
- (FMWebSocketOpenArgs*) openArgs;
/// <summary>
/// Sets the original arguments passed to the open method.
/// </summary>
- (void) setOpenArgs:(FMWebSocketOpenArgs*)value;
+ (FMWebSocketOpenSuccessArgs*) webSocketOpenSuccessArgs;

@end


@class NSMutableDataFMExtensions;
@class FMWebSocketOpenArgs;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for <see cref="FMWebSocketOpenArgs#onReceive" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketReceiveArgs : FMDynamic 

/// <summary>
/// Gets the message received from the server as binary data.
/// </summary>
- (NSMutableData*) binaryMessage;
- (id) init;
/// <summary>
/// Gets whether or not the received message is text.
/// </summary>
- (bool) isText;
/// <summary>
/// Gets the original arguments passed to the open method.
/// </summary>
- (FMWebSocketOpenArgs*) openArgs;
/// <summary>
/// Sets the message received from the server as binary data.
/// </summary>
- (void) setBinaryMessage:(NSMutableData*)value;
/// <summary>
/// Sets the original arguments passed to the open method.
/// </summary>
- (void) setOpenArgs:(FMWebSocketOpenArgs*)value;
/// <summary>
/// Sets the message received from the server as text data.
/// </summary>
- (void) setTextMessage:(NSString*)value;
/// <summary>
/// Gets the message received from the server as text data.
/// </summary>
- (NSString*) textMessage;
+ (FMWebSocketReceiveArgs*) webSocketReceiveArgs;

@end


@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Send arguments for the <see cref="FMWebSocket" /> class.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketSendArgs : FMDynamic 

/// <summary>
/// Gets the message to send as binary data.
/// </summary>
- (NSMutableData*) binaryMessage;
/// <summary>
/// Creates a new <see cref="FMWebSocketSendArgs" /> instance.
/// </summary>
- (id) init;
- (bool) isText;
/// <summary>
/// Sets the message to send as binary data.
/// </summary>
- (void) setBinaryMessage:(NSMutableData*)value;
/// <summary>
/// Sets the message to send as text data.
/// </summary>
- (void) setTextMessage:(NSString*)value;
/// <summary>
/// Sets the timeout for the request.
/// </summary>
- (void) setTimeout:(int)value;
/// <summary>
/// Gets the message to send as text data.
/// </summary>
- (NSString*) textMessage;
/// <summary>
/// Gets the timeout for the request.
/// </summary>
- (int) timeout;
/// <summary>
/// Creates a new <see cref="FMWebSocketSendArgs" /> instance.
/// </summary>
+ (FMWebSocketSendArgs*) webSocketSendArgs;

@end


@class NSExceptionFMExtensions;
@class FMWebSocketOpenArgs;

/// <summary>
/// Arguments for <see cref="FMWebSocketOpenArgs#onStreamFailure" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketStreamFailureArgs : FMDynamic 

/// <summary>
/// Gets the exception generated by the active connection.
/// </summary>
- (NSException*) exception;
- (id) init;
/// <summary>
/// Gets the original arguments passed to the open method.
/// </summary>
- (FMWebSocketOpenArgs*) openArgs;
/// <summary>
/// Sets the exception generated by the active connection.
/// </summary>
- (void) setException:(NSException*)value;
/// <summary>
/// Sets the original arguments passed to the open method.
/// </summary>
- (void) setOpenArgs:(FMWebSocketOpenArgs*)value;
/// <summary>
/// Sets the status code associated with the stream failure.
/// </summary>
- (void) setStatusCode:(FMWebSocketStatusCode)value;
/// <summary>
/// Gets the status code associated with the stream failure.
/// </summary>
- (FMWebSocketStatusCode) statusCode;
+ (FMWebSocketStreamFailureArgs*) webSocketStreamFailureArgs;

@end



/// <summary>
/// Contract for a thread-safe class for running timeouts on asynchronous methods.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMBaseTimeoutTimer : NSObject 

+ (FMBaseTimeoutTimer*) baseTimeoutTimer;
- (id) init;
/// <summary>
/// Starts the timer.
/// </summary>
/// <param name="timeout">The timeout length, in milliseconds.</param>
- (void) startWithTimeout:(int)timeout;
/// <summary>
/// Stops the timer, notifying the calling code if the timeout has already elapsed.
/// </summary>
/// <returns><c>true</c> if the timer was successfully stopped in time; <c>false</c>
/// if the timeout elapsed and the timeout callback has been invoked.</returns>
- (bool) stop;

@end


@class FMWebSocketCloseArgs;
@class FMWebSocketOpenArgs;
@class FMWebSocketSendArgs;

/// <summary>
/// Contract for an implementation of the WebSocket protocol v8.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMBaseWebSocket : FMDynamic 

+ (FMBaseWebSocket*) baseWebSocket;
/// <summary>
/// Gets the number of bytes buffered in the send queue.
/// </summary>
- (int) bufferedAmount;
/// <summary>
/// Closes the WebSocket connection.
/// </summary>
- (void) close;
/// <summary>
/// Closes the WebSocket connection.
/// </summary>
/// <param name="closeArgs">The close arguments</param>
- (void) closeWithArgs:(FMWebSocketCloseArgs*)closeArgs;
- (id) init;
/// <summary>
/// Gets a value indicating whether the WebSocket is connected.
/// </summary>
- (bool) isOpen;
/// <summary>
/// Opens the WebSocket connection.
/// </summary>
/// <param name="openArgs">The open arguments.</param>
- (void) openWithArgs:(FMWebSocketOpenArgs*)openArgs;
/// <summary>
/// Gets a value indicating whether the WebSocket is secure.
/// </summary>
- (bool) secure;
/// <summary>
/// Sends a message to the WebSocket server.
/// </summary>
/// <param name="sendArgs">The send arguments.</param>
- (void) sendWithArgs:(FMWebSocketSendArgs*)sendArgs;

@end


@class NSMutableDataFMExtensions;

/// <summary>
/// Bitwise buffer operations.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMBinary : NSObject 

+ (FMBinary*) binary;
/// <summary>
/// Deinterleave and transform (rotate) a byte array containing two planes
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="inputStart"></param>
/// <param name="outputFrame"></param>
/// <param name="outputStart"></param>
/// <param name="width"></param>
/// <param name="height"></param>
/// <param name="stride"></param>
/// <param name="rotation">Values 0, 90, 180, 270.</param>
/// <param name="reversePlanes">Reverse output plane order.</param>
+ (void) deinterleaveTransformWithInputFrame:(NSMutableData*)inputFrame inputStart:(int)inputStart outputFrame:(NSMutableData*)outputFrame outputStart:(int)outputStart width:(int)width height:(int)height stride:(int)stride rotation:(int)rotation reversePlanes:(bool)reversePlanes;
/// <summary>
/// Deinterleave and transform (rotate) a byte array containing two planes
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="outputFrame"></param>
/// <param name="width"></param>
/// <param name="height"></param>
/// <param name="stride"></param>
/// <param name="rotation">Values 0, 90, 180, 270.</param>
+ (void) deinterleaveTransformWithInputFrame:(NSMutableData*)inputFrame outputFrame:(NSMutableData*)outputFrame width:(int)width height:(int)height stride:(int)stride rotation:(int)rotation;
/// <summary>
/// Deinterleaves a byte array
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="inputStart"></param>
/// <param name="outputFrame"></param>
/// <param name="outputStart"></param>
/// <param name="length"></param>
/// <param name="reversePlanes"></param>
+ (void) deinterleaveWithInputFrame:(NSMutableData*)inputFrame inputStart:(int)inputStart outputFrame:(NSMutableData*)outputFrame outputStart:(int)outputStart length:(int)length reversePlanes:(bool)reversePlanes;
/// <summary>
/// Deinterleaves a byte array i.e.
/// XYXYXYXY -&gt; XXXXYYYY
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="outputFrame"></param>
+ (void) deinterleaveWithInputFrame:(NSMutableData*)inputFrame outputFrame:(NSMutableData*)outputFrame;
/// <summary>
/// Deinterleaves a byte array i.e.
/// XYXYXYXY -&gt; XXXXYYYY
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="outputFrame"></param>
/// <param name="inputLength"></param>
+ (void) deinterleaveWithInputFrame:(NSMutableData*)inputFrame outputFrame:(NSMutableData*)outputFrame inputLength:(int)inputLength;
/// <summary>
/// Reads a 16-bit value from a byte array.
/// </summary>
/// <param name="input">The input byte array.</param>
/// <param name="inputIndex">The index to start reading.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The value.</returns>
+ (int) fromBytes16WithInput:(NSMutableData*)input inputIndex:(int)inputIndex littleEndian:(bool)littleEndian;
/// <summary>
/// Reads a 24-bit value from a byte array.
/// </summary>
/// <param name="input">The input byte array.</param>
/// <param name="inputIndex">The index to start reading.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The value.</returns>
+ (int) fromBytes24WithInput:(NSMutableData*)input inputIndex:(int)inputIndex littleEndian:(bool)littleEndian;
/// <summary>
/// Reads a 32-bit value from a byte array.
/// </summary>
/// <param name="input">The input byte array.</param>
/// <param name="inputIndex">The index to start reading.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The value.</returns>
+ (long long) fromBytes32WithInput:(NSMutableData*)input inputIndex:(int)inputIndex littleEndian:(bool)littleEndian;
/// <summary>
/// Reads a 40-bit value from a byte array.
/// </summary>
/// <param name="input">The input byte array.</param>
/// <param name="inputIndex">The index to start reading.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The value.</returns>
+ (long long) fromBytes40WithInput:(NSMutableData*)input inputIndex:(int)inputIndex littleEndian:(bool)littleEndian;
/// <summary>
/// Reads a 48-bit value from a byte array.
/// </summary>
/// <param name="input">The input byte array.</param>
/// <param name="inputIndex">The index to start reading.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The value.</returns>
+ (long long) fromBytes48WithInput:(NSMutableData*)input inputIndex:(int)inputIndex littleEndian:(bool)littleEndian;
/// <summary>
/// Reads a 56-bit value from a byte array.
/// </summary>
/// <param name="input">The input byte array.</param>
/// <param name="inputIndex">The index to start reading.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The value.</returns>
+ (long long) fromBytes56WithInput:(NSMutableData*)input inputIndex:(int)inputIndex littleEndian:(bool)littleEndian;
/// <summary>
/// Reads a 64-bit value from a byte array.
/// </summary>
/// <param name="input">The input byte array.</param>
/// <param name="inputIndex">The index to start reading.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The value.</returns>
+ (long long) fromBytes64WithInput:(NSMutableData*)input inputIndex:(int)inputIndex littleEndian:(bool)littleEndian;
- (id) init;
/// <summary>
/// Interleave and transform (rotate) a byte array containing two planes
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="inputStart"></param>
/// <param name="outputFrame"></param>
/// <param name="outputStart"></param>
/// <param name="width"></param>
/// <param name="height"></param>
/// <param name="stride"></param>
/// <param name="rotation">Values 0, 90, 180, 270.</param>
+ (void) interleaveTransformWithInputFrame:(NSMutableData*)inputFrame inputStart:(int)inputStart outputFrame:(NSMutableData*)outputFrame outputStart:(int)outputStart width:(int)width height:(int)height stride:(int)stride rotation:(int)rotation;
/// <summary>
/// Interleave and transform (rotate) a byte array containing two planes
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="inputStart"></param>
/// <param name="outputFrame"></param>
/// <param name="outputStart"></param>
/// <param name="width"></param>
/// <param name="height"></param>
/// <param name="stride"></param>
/// <param name="rotation">Values 0, 90, 180, 270.</param>
/// <param name="reversePlanes">Reverse output plane order.</param>
+ (void) interleaveTransformWithInputFrame:(NSMutableData*)inputFrame inputStart:(int)inputStart outputFrame:(NSMutableData*)outputFrame outputStart:(int)outputStart width:(int)width height:(int)height stride:(int)stride rotation:(int)rotation reversePlanes:(bool)reversePlanes;
/// <summary>
/// Interleave and transform (rotate) a byte array containing two planes
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="outputFrame"></param>
/// <param name="width"></param>
/// <param name="height"></param>
/// <param name="stride"></param>
/// <param name="rotation">Values 0, 90, 180, 270.</param>
+ (void) interleaveTransformWithInputFrame:(NSMutableData*)inputFrame outputFrame:(NSMutableData*)outputFrame width:(int)width height:(int)height stride:(int)stride rotation:(int)rotation;
/// <summary>
/// Interleaves a byte array i.e.
/// XXXXYYYY -&gt; XYXYXYXY
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="inputStart"></param>
/// <param name="outputFrame"></param>
/// <param name="outputStart"></param>
/// <param name="inputLength"></param>
+ (void) interleaveWithInputFrame:(NSMutableData*)inputFrame inputStart:(int)inputStart outputFrame:(NSMutableData*)outputFrame outputStart:(int)outputStart inputLength:(int)inputLength;
/// <summary>
/// Interleaves a byte array  i.e.
/// XXXXYYYY -&gt; XYXYXYXY
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="inputStart"></param>
/// <param name="outputFrame"></param>
/// <param name="outputStart"></param>
/// <param name="inputLength"></param>
/// <param name="reversePlanes">XXXXYYYY -&gt; YXYXYXYX</param>
+ (void) interleaveWithInputFrame:(NSMutableData*)inputFrame inputStart:(int)inputStart outputFrame:(NSMutableData*)outputFrame outputStart:(int)outputStart inputLength:(int)inputLength reversePlanes:(bool)reversePlanes;
/// <summary>
/// Interleaves a byte array i.e.
/// XXXXYYYY -&gt; XYXYXYXY
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="outputFrame"></param>
+ (void) interleaveWithInputFrame:(NSMutableData*)inputFrame outputFrame:(NSMutableData*)outputFrame;
/// <summary>
/// Tests the binary implementation.
/// </summary>
+ (void) test;
/// <summary>
/// Converts a 16-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The output byte array.</returns>
+ (NSMutableData*) toBytes16WithValue:(int)value littleEndian:(bool)littleEndian;
/// <summary>
/// Writes a 16-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <param name="output">The output byte array.</param>
/// <param name="outputIndex">The index to start writing.</param>
+ (void) toBytes16WithValue:(int)value littleEndian:(bool)littleEndian output:(NSMutableData*)output outputIndex:(int)outputIndex;
/// <summary>
/// Converts a 24-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The output byte array.</returns>
+ (NSMutableData*) toBytes24WithValue:(int)value littleEndian:(bool)littleEndian;
/// <summary>
/// Writes a 24-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <param name="output">The output byte array.</param>
/// <param name="outputIndex">The index to start writing.</param>
+ (void) toBytes24WithValue:(int)value littleEndian:(bool)littleEndian output:(NSMutableData*)output outputIndex:(int)outputIndex;
/// <summary>
/// Converts a 32-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The output byte array.</returns>
+ (NSMutableData*) toBytes32WithValue:(long long)value littleEndian:(bool)littleEndian;
/// <summary>
/// Writes a 32-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <param name="output">The output byte array.</param>
/// <param name="outputIndex">The index to start writing.</param>
+ (void) toBytes32WithValue:(long long)value littleEndian:(bool)littleEndian output:(NSMutableData*)output outputIndex:(int)outputIndex;
/// <summary>
/// Converts a 40-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The output byte array.</returns>
+ (NSMutableData*) toBytes40WithValue:(long long)value littleEndian:(bool)littleEndian;
/// <summary>
/// Writes a 40-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <param name="output">The output byte array.</param>
/// <param name="outputIndex">The index to start writing.</param>
+ (void) toBytes40WithValue:(long long)value littleEndian:(bool)littleEndian output:(NSMutableData*)output outputIndex:(int)outputIndex;
/// <summary>
/// Converts a 48-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The output byte array.</returns>
+ (NSMutableData*) toBytes48WithValue:(long long)value littleEndian:(bool)littleEndian;
/// <summary>
/// Writes a 48-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <param name="output">The output byte array.</param>
/// <param name="outputIndex">The index to start writing.</param>
+ (void) toBytes48WithValue:(long long)value littleEndian:(bool)littleEndian output:(NSMutableData*)output outputIndex:(int)outputIndex;
/// <summary>
/// Converts a 56-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The output byte array.</returns>
+ (NSMutableData*) toBytes56WithValue:(long long)value littleEndian:(bool)littleEndian;
/// <summary>
/// Writes a 56-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <param name="output">The output byte array.</param>
/// <param name="outputIndex">The index to start writing.</param>
+ (void) toBytes56WithValue:(long long)value littleEndian:(bool)littleEndian output:(NSMutableData*)output outputIndex:(int)outputIndex;
/// <summary>
/// Converts a 64-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <returns>The output byte array.</returns>
+ (NSMutableData*) toBytes64WithValue:(long long)value littleEndian:(bool)littleEndian;
/// <summary>
/// Writes a 64-bit value to a byte array.
/// </summary>
/// <param name="value">The value to write.</param>
/// <param name="littleEndian">Whether to use little-endian format.</param>
/// <param name="output">The output byte array.</param>
/// <param name="outputIndex">The index to start writing.</param>
+ (void) toBytes64WithValue:(long long)value littleEndian:(bool)littleEndian output:(NSMutableData*)output outputIndex:(int)outputIndex;
/// <summary>
/// Transforms a byte containing a 2D plane (rotates 90, 180, 270)
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="inputStart"></param>
/// <param name="outputFrame"></param>
/// <param name="outputStart"></param>
/// <param name="rotation"></param>
/// <param name="width"></param>
/// <param name="height"></param>
/// <param name="stride"></param>
+ (void) transformWithInputFrame:(NSMutableData*)inputFrame inputStart:(int)inputStart outputFrame:(NSMutableData*)outputFrame outputStart:(int)outputStart width:(int)width height:(int)height stride:(int)stride rotation:(int)rotation;
/// <summary>
/// Transforms a byte containing a 2D plane (rotates 90, 180, 270).
/// When transforming interleaved planes. Set the chunkLength to
/// the number of planes.
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="inputStart"></param>
/// <param name="outputFrame"></param>
/// <param name="outputStart"></param>
/// <param name="rotation"></param>
/// <param name="width"></param>
/// <param name="height"></param>
/// <param name="stride"></param>
/// <param name="chunkLength"></param>
+ (void) transformWithInputFrame:(NSMutableData*)inputFrame inputStart:(int)inputStart outputFrame:(NSMutableData*)outputFrame outputStart:(int)outputStart width:(int)width height:(int)height stride:(int)stride rotation:(int)rotation chunkLength:(int)chunkLength;
/// <summary>
/// Transforms a byte containing a 2D plane (rotates 90, 180, 270)
/// </summary>
/// <param name="inputFrame"></param>
/// <param name="outputFrame"></param>
/// <param name="rotation"></param>
/// <param name="width"></param>
/// <param name="height"></param>
/// <param name="stride"></param>
+ (void) transformWithInputFrame:(NSMutableData*)inputFrame outputFrame:(NSMutableData*)outputFrame width:(int)width height:(int)height stride:(int)stride rotation:(int)rotation;

@end



/// <summary>
/// Class to hold a byte value passed by reference.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMByteHolder : NSObject 

/// <summary>
/// Initializes a new instance of the <see cref="FMByteHolder" /> class.
/// </summary>
+ (FMByteHolder*) byteHolder;
/// <summary>
/// Initializes a new instance of the <see cref="FMByteHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
+ (FMByteHolder*) byteHolderWithValue:(uint8_t)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMByteHolder" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMByteHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
- (id) initWithValue:(uint8_t)value;
/// <summary>
/// Sets the value.
/// </summary>
- (void) setValue:(uint8_t)value;
/// <summary>
/// Gets the value.
/// </summary>
- (uint8_t) value;

@end


@class NSMutableDataFMExtensions;

/// <summary>
/// An buffer of bytes that can be read sequentially.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMByteInputStream : NSObject 

/// <summary>
/// Gets the number of available bytes for reading.
/// </summary>
- (int) available;
/// <summary>
/// Initializes a new instance of the <see cref="FMByteInputStream" /> class.
/// </summary>
/// <param name="bytes">The bytes.</param>
+ (FMByteInputStream*) byteInputStreamWithBytes:(NSMutableData*)bytes;
/// <summary>
/// Initializes a new instance of the <see cref="FMByteInputStream" /> class.
/// </summary>
/// <param name="bytes">The bytes.</param>
/// <param name="offset">The offset.</param>
+ (FMByteInputStream*) byteInputStreamWithBytes:(NSMutableData*)bytes offset:(int)offset;
/// <summary>
/// Initializes a new instance of the <see cref="FMByteInputStream" /> class.
/// </summary>
/// <param name="bytes">The bytes.</param>
- (id) initWithBytes:(NSMutableData*)bytes;
/// <summary>
/// Initializes a new instance of the <see cref="FMByteInputStream" /> class.
/// </summary>
/// <param name="bytes">The bytes.</param>
/// <param name="offset">The offset.</param>
- (id) initWithBytes:(NSMutableData*)bytes offset:(int)offset;
/// <summary>
/// Marks the current position for a later reset.
/// </summary>
- (void) mark;
/// <summary>
/// Reads a value from the byte array.
/// </summary>
/// <returns>The byte, or -1 if no more bytes are available for reading.</returns>
- (int) read;
/// <summary>
/// Reads a segment from the byte array.
/// </summary>
/// <returns>The number of bytes read.</returns>
- (int) readWithBuffer:(NSMutableData*)buffer offset:(int)offset length:(int)length;
/// <summary>
/// Resets the stream to the marked position.
/// </summary>
- (void) reset;
/// <summary>
/// Advances the stream position by the amount specified.
/// </summary>
/// <param name="n">The number of bytes to skip.</param>
/// <returns>The number of bytes skipped.</returns>
- (int) skipWithN:(int)n;

@end


@class FMCallback;

/// <summary>
/// A wrapper for a callback and state object.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMCallbackState : NSObject 

/// <summary>
/// Gets the callback.
/// </summary>
- (FMCallback*) callback;
/// <summary>
/// Initializes a new instance of the <see cref="FMCallbackState" /> class.
/// </summary>
/// <param name="callback">The callback.</param>
/// <param name="state">The state.</param>
+ (FMCallbackState*) callbackStateWithCallback:(FMCallback*)callback state:(NSObject*)state;
/// <summary>
/// Initializes a new instance of the <see cref="FMCallbackState" /> class.
/// </summary>
/// <param name="callback">The callback.</param>
/// <param name="state">The state.</param>
+ (FMCallbackState*) callbackStateWithCallbackBlock:(void (^) (NSObject*))callbackBlock state:(NSObject*)state;
/// <summary>
/// Executes the callback, passing in the state as a parameter.
/// </summary>
- (void) execute;
/// <summary>
/// Initializes a new instance of the <see cref="FMCallbackState" /> class.
/// </summary>
/// <param name="callback">The callback.</param>
/// <param name="state">The state.</param>
- (id) initWithCallback:(FMCallback*)callback state:(NSObject*)state;
/// <summary>
/// Initializes a new instance of the <see cref="FMCallbackState" /> class.
/// </summary>
/// <param name="callback">The callback.</param>
/// <param name="state">The state.</param>
- (id) initWithCallbackBlock:(void (^) (NSObject*))callbackBlock state:(NSObject*)state;
/// <summary>
/// Sets the callback.
/// </summary>
- (void) setCallback:(FMCallback*)value;
/// <summary>
/// Sets the callback.
/// </summary>
- (void) setCallbackBlock:(void (^) (NSObject*))valueBlock;
/// <summary>
/// Sets the state.
/// </summary>
- (void) setState:(NSObject*)value;
/// <summary>
/// Gets the state.
/// </summary>
- (NSObject*) state;

@end



/// <summary>
/// Class to hold a character value passed by reference.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMCharacterHolder : NSObject 

/// <summary>
/// Initializes a new instance of the <see cref="FMCharacterHolder" /> class.
/// </summary>
+ (FMCharacterHolder*) characterHolder;
/// <summary>
/// Initializes a new instance of the <see cref="FMCharacterHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
+ (FMCharacterHolder*) characterHolderWithValue:(unichar)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMCharacterHolder" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMCharacterHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
- (id) initWithValue:(unichar)value;
/// <summary>
/// Sets the value.
/// </summary>
- (void) setValue:(unichar)value;
/// <summary>
/// Gets the value.
/// </summary>
- (unichar) value;

@end


@class NSStringFMExtensions;
@class NSMutableArrayFMExtensions;
@class NSExceptionFMExtensions;
@class NSDateFMExtensions;

/// <summary>
/// Base class for all logging provider implementations.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMLogProvider : NSObject 

/// <summary>
/// Logs a debug-level message.
/// </summary>
/// <param name="format">A composite format string.</param>
/// <param name="args">An array containing zero or more objects to format.</param>
- (void) debugFormat:(NSString*)format args:(NSMutableArray*)args;
/// <summary>
/// Logs a debug-level message.
/// </summary>
/// <param name="message">The message.</param>
- (void) debugWithMessage:(NSString*)message;
/// <summary>
/// Logs a debug-level message.
/// </summary>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
- (void) debugWithMessage:(NSString*)message ex:(NSException*)ex;
/// <summary>
/// Logs an error-level message.
/// </summary>
/// <param name="format">A composite format string.</param>
/// <param name="args">An array containing zero or more objects to format.</param>
- (void) errorFormat:(NSString*)format args:(NSMutableArray*)args;
/// <summary>
/// Logs an error-level message.
/// </summary>
/// <param name="message">The message.</param>
- (void) errorWithMessage:(NSString*)message;
/// <summary>
/// Logs an error-level message.
/// </summary>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
- (void) errorWithMessage:(NSString*)message ex:(NSException*)ex;
/// <summary>
/// Logs a fatal-level message.
/// </summary>
/// <param name="format">A composite format string.</param>
/// <param name="args">An array containing zero or more objects to format.</param>
- (void) fatalFormat:(NSString*)format args:(NSMutableArray*)args;
/// <summary>
/// Logs a fatal-level message.
/// </summary>
/// <param name="message">The message.</param>
- (void) fatalWithMessage:(NSString*)message;
/// <summary>
/// Logs a fatal-level message.
/// </summary>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
- (void) fatalWithMessage:(NSString*)message ex:(NSException*)ex;
/// <summary>
/// Writes a line of text to the log.
/// </summary>
/// <param name="format">A composite format string.</param>
/// <param name="args">An array containing zero or more objects to format.</param>
- (void) formatAndWriteLineWithFormat:(NSString*)format args:(NSMutableArray*)args;
/// <summary>
/// Converts a log-level to a 5-character string for
/// consistently-spaced character sequences.
/// </summary>
/// <param name="level">The log level.</param>
/// <returns>The log level as an upper-case string
/// with right-side whitespace padding to ensure
/// a 5-character sequence.</returns>
+ (NSString*) getPrefixLevel:(FMLogLevel)level;
/// <summary>
/// Converts a timestamp to a string formatted for
/// rendering in a log message (yyyy/MM/dd-hh:mm:ss).
/// </summary>
/// <param name="timestamp">The timestamp.</param>
/// <returns>The timestamp as a formatted string.</returns>
+ (NSString*) getPrefixTimestamp:(NSDate*)timestamp;
/// <summary>
/// Converts a log-level to a 5-character string for
/// consistently-spaced character sequences.
/// </summary>
/// <param name="level">The log level.</param>
/// <param name="includeTimestamp">Whether to include a timestamp in the prefix.</param>
/// <returns>The log level as an upper-case string
/// with right-side whitespace padding to ensure
/// a 5-character sequence.</returns>
+ (NSString*) getPrefixWithLevel:(FMLogLevel)level includeTimestamp:(bool)includeTimestamp;
/// <summary>
/// Logs an info-level message.
/// </summary>
/// <param name="format">A composite format string.</param>
/// <param name="args">An array containing zero or more objects to format.</param>
- (void) infoFormat:(NSString*)format args:(NSMutableArray*)args;
/// <summary>
/// Logs an info-level message.
/// </summary>
/// <param name="message">The message.</param>
- (void) infoWithMessage:(NSString*)message;
/// <summary>
/// Logs an info-level message.
/// </summary>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
- (void) infoWithMessage:(NSString*)message ex:(NSException*)ex;
/// <summary>
/// Initializes a new instance of the <see cref="FMLogProvider" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Gets a value indicating whether logging is enabled for debug-level messages.
/// </summary>
/// <value>
/// <c>true</c> if logging is enabled for debug-level messages; otherwise, <c>false</c>.
/// </value>
- (bool) isDebugEnabled;
/// <summary>
/// Determines whether logging is enabled for the specified log level.
/// </summary>
/// <param name="level">The log level.</param>
/// <returns>
/// <c>true</c> if logging is enabled for the specified log level; otherwise, <c>false</c>.
/// </returns>
- (bool) isEnabledWithLevel:(FMLogLevel)level;
/// <summary>
/// Gets a value indicating whether logging is enabled for error-level messages.
/// </summary>
/// <value>
/// <c>true</c> if logging is enabled for error-level messages; otherwise, <c>false</c>.
/// </value>
- (bool) isErrorEnabled;
/// <summary>
/// Gets a value indicating whether logging is enabled for fatal-level messages.
/// </summary>
/// <value>
/// <c>true</c> if logging is enabled for fatal-level messages; otherwise, <c>false</c>.
/// </value>
- (bool) isFatalEnabled;
/// <summary>
/// Gets a value indicating whether logging is enabled for info-level messages.
/// </summary>
/// <value>
/// <c>true</c> if logging is enabled for info-level messages; otherwise, <c>false</c>.
/// </value>
- (bool) isInfoEnabled;
/// <summary>
/// Gets a value indicating whether logging is enabled for warn-level messages.
/// </summary>
/// <value>
/// <c>true</c> if logging is enabled for warn-level messages; otherwise, <c>false</c>.
/// </value>
- (bool) isWarnEnabled;
/// <summary>
/// Gets the log level.
/// </summary>
- (FMLogLevel) level;
/// <summary>
/// Initializes a new instance of the <see cref="FMLogProvider" /> class.
/// </summary>
+ (FMLogProvider*) logProvider;
/// <summary>
/// Logs a message at the specified log level.
/// </summary>
/// <param name="level">The log level.</param>
/// <param name="message">The message.</param>
- (void) logWithLevel:(FMLogLevel)level message:(NSString*)message;
/// <summary>
/// Logs a message at the specified log level.
/// </summary>
/// <param name="level">The log level.</param>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
- (void) logWithLevel:(FMLogLevel)level message:(NSString*)message ex:(NSException*)ex;
/// <summary>
/// Sets the log level.
/// </summary>
- (void) setLevel:(FMLogLevel)value;
/// <summary>
/// Logs a warn-level message.
/// </summary>
/// <param name="format">A composite format string.</param>
/// <param name="args">An array containing zero or more objects to format.</param>
- (void) warnFormat:(NSString*)format args:(NSMutableArray*)args;
/// <summary>
/// Logs a warn-level message.
/// </summary>
/// <param name="message">The message.</param>
- (void) warnWithMessage:(NSString*)message;
/// <summary>
/// Logs a warn-level message.
/// </summary>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
- (void) warnWithMessage:(NSString*)message ex:(NSException*)ex;
/// <summary>
/// Writes a line of text to the log.
/// </summary>
/// <param name="text">The text to write to the log.</param>
- (void) writeLineWithText:(NSString*)text;

@end


@class FMByteCollection;
@class NSMutableDataFMExtensions;

/// <summary>
/// An buffer of bytes that can be written sequentially.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMByteOutputStream : NSObject 

+ (FMByteOutputStream*) byteOutputStream;
- (id) init;
/// <summary>
/// Empties this stream and resets it.
/// </summary>
- (void) reset;
/// <summary>
/// Gets the number of bytes written to the stream.
/// </summary>
- (int) size;
/// <summary>
/// Converts the stream to a byte array.
/// </summary>
/// <returns></returns>
- (NSMutableData*) toArray;
/// <summary>
/// Writes a buffer to the stream.
/// </summary>
/// <param name="buffer">The buffer.</param>
- (void) writeBuffer:(NSMutableData*)buffer;
/// <summary>
/// Writes a buffer to the stream.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="length">The length.</param>
- (void) writeBuffer:(NSMutableData*)buffer offset:(int)offset length:(int)length;
/// <summary>
/// Writes the contents of this stream to another stream.
/// </summary>
/// <param name="stream">The stream.</param>
- (void) writeToWithStream:(FMByteOutputStream*)stream;
/// <summary>
/// Writes a value to the stream.
/// </summary>
/// <param name="value">The value.</param>
- (void) writeWithValue:(uint8_t)value;

@end



/// <summary>
/// Class to hold a boolean value passed by reference.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMBooleanHolder : NSObject 

/// <summary>
/// Initializes a new instance of the <see cref="FMBooleanHolder" /> class.
/// </summary>
+ (FMBooleanHolder*) booleanHolder;
/// <summary>
/// Initializes a new instance of the <see cref="FMBooleanHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
+ (FMBooleanHolder*) booleanHolderWithValue:(bool)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMBooleanHolder" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMBooleanHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
- (id) initWithValue:(bool)value;
/// <summary>
/// Sets the value.
/// </summary>
- (void) setValue:(bool)value;
/// <summary>
/// Gets the value.
/// </summary>
- (bool) value;

@end


@class NSStringFMExtensions;
@class FMCallback;

/// <summary>
/// DNS utility methods.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMDns : NSObject 

/// <summary>
/// Resolves a host name to an IP address.
/// </summary>
/// <param name="name">The name to resolve.</param>
/// <param name="callback">The callback to invoke when resolution is complete.</param>
/// <param name="state">A custom state object to pass into the callback.</param>
+ (void) resolveWithName:(NSString*)name callback:(FMCallback*)callback state:(NSObject*)state;

@end


@class FMHttpRequestCreatedArgs;
@class FMHttpResponseReceivedArgs;
@class FMWebSocketOpenSuccessArgs;
@class FMWebSocketOpenFailureArgs;
@class FMWebSocketStreamFailureArgs;
@class FMHttpResponseArgs;
@class NSStringFMExtensions;
@class FMCallback;
@class FMNameValueCollection;
@class FMHttpRequestArgs;

/// <summary>
/// Base class that defines methods for transferring content over the WebSocket protocol.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketTransfer : NSObject 

/// <summary>
/// Gets the timeout for the initial handshake.
/// </summary>
- (int) handshakeTimeout;
/// <summary>
/// Initializes a new instance of the <see cref="FMWebSocketTransfer" /> class.
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
/// Sends a request asynchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <param name="callback">The callback to execute with the resulting response.</param>
- (void) sendAsyncWithRequestArgs:(FMHttpRequestArgs*)requestArgs callback:(FMCallback*)callback;
/// <summary>
/// Sends a request asynchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <param name="callback">The callback to execute with the resulting response.</param>
- (void) sendAsyncWithRequestArgs:(FMHttpRequestArgs*)requestArgs callbackBlock:(void (^) (FMHttpResponseArgs*))callbackBlock;
/// <summary>
/// Gets the sender of the messages.
/// </summary>
- (NSObject*) sender;
/// <summary>
/// Sends a request synchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <returns>The response parameters.</returns>
- (FMHttpResponseArgs*) sendWithRequestArgs:(FMHttpRequestArgs*)requestArgs;
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
/// Initializes a new instance of the <see cref="FMWebSocketTransfer" /> class.
/// </summary>
/// <param name="url">The URL.</param>
+ (FMWebSocketTransfer*) webSocketTransferWithUrl:(NSString*)url;

@end


@class NSStringFMExtensions;
@class FMWebSocketTransfer;
@class FMCallback;

/// <summary>
/// Creates implementations of <see cref="FMWebSocketWebRequestTransfer" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketTransferFactory : NSObject 

/// <summary>
/// Gets the callback that creates a WebSocket-based transfer class.
/// </summary>
+ (FMCallback*) createWebSocketTransfer;
+ (FMWebSocketTransfer*) defaultCreateWebSocketTransferWithUrl:(NSString*)url;
/// <summary>
/// Gets an instance of the WebSocket-based transfer class.
/// </summary>
/// <returns></returns>
+ (FMWebSocketTransfer*) getWebSocketTransferWithUrl:(NSString*)url;
- (id) init;
/// <summary>
/// Sets the callback that creates a WebSocket-based transfer class.
/// </summary>
+ (void) setCreateWebSocketTransfer:(FMCallback*)value;
/// <summary>
/// Sets the callback that creates a WebSocket-based transfer class.
/// </summary>
+ (void) setCreateWebSocketTransferBlock:(FMWebSocketTransfer* (^) (NSString*))valueBlock;
+ (FMWebSocketTransferFactory*) webSocketTransferFactory;

@end


@class FMByteCollection;
@class NSMutableDataFMExtensions;
@class FMByteInputStream;
@class FMByteOutputStream;

/// <summary>
/// Writes little-endian data to a buffer.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMLittleEndianBuffer : NSObject 

/// <summary>
/// Converts a 16-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) fromBuffer16WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 24-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) fromBuffer24WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 32-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromBuffer32WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 40-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromBuffer40WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 48-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromBuffer48WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 56-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromBuffer56WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 64-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromBuffer64WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts an 8-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) fromBuffer8WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 16-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) fromData16WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 24-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) fromData24WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 32-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromData32WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 40-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromData40WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 48-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromData48WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 56-bit network representation to an integer.
/// </summary>
/// <param name="data">data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromData56WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 64-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromData64WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts an 8-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) fromData8WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 16-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (int) fromStream16WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts a 24-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (int) fromStream24WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts a 32-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) fromStream32WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts a 40-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) fromStream40WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts a 48-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) fromStream48WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts a 56-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) fromStream56WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts a 64-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) fromStream64WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts an 8-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (int) fromStream8WithStream:(FMByteInputStream*)stream;
- (id) init;
+ (FMLittleEndianBuffer*) littleEndianBuffer;
/// <summary>
/// Reads a 16-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) readBuffer16WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 16-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (int) readBuffer16WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 24-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) readBuffer24WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 24-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (int) readBuffer24WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 32-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readBuffer32WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 32-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readBuffer32WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 40-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readBuffer40WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 40-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readBuffer40WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 48-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readBuffer48WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 48-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readBuffer48WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 56-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readBuffer56WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 56-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readBuffer56WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 64-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readBuffer64WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 64-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readBuffer64WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads an 8-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) readBuffer8WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads an 8-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (int) readBuffer8WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 16-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque16WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 16-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque16WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 24-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque24WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 24-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque24WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 32-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque32WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 32-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque32WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads an 8-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque8WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads an 8-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque8WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a value from a buffer.
/// </summary>
/// <param name="length">The number of bytes to read.</param>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferWithLength:(int)length buffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a value from a buffer.
/// </summary>
/// <param name="length">The number of bytes to read.</param>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferWithLength:(int)length buffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 16-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) readData16WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 16-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (int) readData16WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 24-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) readData24WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 24-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (int) readData24WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 32-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readData32WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 32-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readData32WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 40-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readData40WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 40-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readData40WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 48-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readData48WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 48-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readData48WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 56-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readData56WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 56-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readData56WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 64-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readData64WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 64-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readData64WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads an 8-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) readData8WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads an 8-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (int) readData8WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 16-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque16WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 16-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque16WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 24-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque24WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 24-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque24WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 32-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque32WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 32-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque32WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads an 8-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque8WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads an 8-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque8WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a value from a buffer.
/// </summary>
/// <param name="length">The number of bytes to read.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readDataWithLength:(int)length data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a value from a buffer.
/// </summary>
/// <param name="length">The number of bytes to read.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readDataWithLength:(int)length data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 16-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (int) readStream16WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 24-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (int) readStream24WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 32-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) readStream32WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 40-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) readStream40WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 48-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) readStream48WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 56-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) readStream56WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 64-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) readStream64WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads an 8-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (int) readStream8WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 16-bit-length opaque value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (NSMutableData*) readStreamOpaque16WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 24-bit-length opaque value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (NSMutableData*) readStreamOpaque24WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 32-bit-length opaque value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (NSMutableData*) readStreamOpaque32WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads an 8-bit-length opaque value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (NSMutableData*) readStreamOpaque8WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a value from a stream.
/// </summary>
/// <param name="length">The number of bytes to read.</param>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (NSMutableData*) readStreamWithLength:(int)length stream:(FMByteInputStream*)stream;
/// <summary>
/// Converts an integer to it's 16-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes16WithValue:(int)value;
/// <summary>
/// Converts an integer to it's 24-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes24WithValue:(int)value;
/// <summary>
/// Converts an integer to it's 32-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes32WithValue:(long long)value;
/// <summary>
/// Converts an integer to it's 40-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes40WithValue:(long long)value;
/// <summary>
/// Converts an integer to it's 48-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes48WithValue:(long long)value;
/// <summary>
/// Converts an integer to it's 56-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes56WithValue:(long long)value;
/// <summary>
/// Converts an integer to it's 64-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes64WithValue:(long long)value;
/// <summary>
/// Converts an integer to it's 8-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes8WithValue:(int)value;
/// <summary>
/// Adds a 16-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer16WithValue:(int)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 24-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer24WithValue:(int)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 32-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer32WithValue:(long long)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 40-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer40WithValue:(long long)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 48-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer48WithValue:(long long)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 56-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer56WithValue:(long long)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 64-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer64WithValue:(long long)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds an 8-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer8WithValue:(int)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 16-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque16WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 24-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque24WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 32-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque32WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 40-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque40WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 48-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque48WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 56-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque56WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 64-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque64WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds an 8-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque8WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferWithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Copies a 16-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData16WithValue:(int)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 16-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData16WithValue:(int)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 24-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData24WithValue:(int)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 24-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData24WithValue:(int)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 32-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData32WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 32-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData32WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 40-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData40WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 40-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData40WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 48-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData48WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 48-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData48WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 56-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData56WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 56-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData56WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 64-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData64WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 64-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData64WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies an 8-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData8WithValue:(int)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies an 8-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData8WithValue:(int)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 16-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque16WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 16-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque16WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 24-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque24WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 24-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque24WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 32-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque32WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 32-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque32WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 40-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque40WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 40-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque40WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 48-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque48WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 48-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque48WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 56-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque56WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 56-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque56WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 64-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque64WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 64-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque64WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies an 8-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque8WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies an 8-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque8WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataWithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataWithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="valueIndex">The index within the value.</param>
/// <param name="valueLength">The length of the value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataWithValue:(NSMutableData*)value valueIndex:(int)valueIndex valueLength:(int)valueLength data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="valueIndex">The index within the value.</param>
/// <param name="valueLength">The length of the value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataWithValue:(NSMutableData*)value valueIndex:(int)valueIndex valueLength:(int)valueLength data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Adds a 16-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream16WithValue:(int)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 24-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream24WithValue:(int)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 32-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream32WithValue:(long long)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 40-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream40WithValue:(long long)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 48-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream48WithValue:(long long)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 56-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream56WithValue:(long long)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 64-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream64WithValue:(long long)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds an 8-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream8WithValue:(int)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 16-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque16WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 24-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque24WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 32-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque32WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 40-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque40WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 48-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque48WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 56-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque56WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 64-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque64WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds an 8-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque8WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamWithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;

@end


@class FMFile;
@class NSMutableDataFMExtensions;

/// <summary>
/// A utility class for reading/writing from/to a <see cref="FMFileStream#file" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMFileStream : NSObject 

/// <summary>
/// Gets the file.
/// </summary>
- (FMFile*) file;
/// <summary>
/// Initializes a new instance of the <see cref="FMFileStream" /> class.
/// </summary>
/// <param name="file">The file.</param>
+ (FMFileStream*) fileStreamWithFile:(FMFile*)file;
/// <summary>
/// Initializes a new instance of the <see cref="FMFileStream" /> class.
/// </summary>
/// <param name="file">The file.</param>
- (id) initWithFile:(FMFile*)file;
/// <summary>
/// Gets whether to read/write using little-endian ordering.
/// </summary>
- (bool) littleEndian;
/// <summary>
/// Converts a 16-bit network representation to an integer.
/// </summary>
/// <returns></returns>
- (int) read16;
/// <summary>
/// Converts a 24-bit network representation to an integer.
/// </summary>
/// <returns></returns>
- (int) read24;
/// <summary>
/// Converts a 32-bit network representation to an integer.
/// </summary>
/// <returns></returns>
- (long long) read32;
/// <summary>
/// Converts a 40-bit network representation to an integer.
/// </summary>
/// <returns></returns>
- (long long) read40;
/// <summary>
/// Converts a 48-bit network representation to an integer.
/// </summary>
/// <returns></returns>
- (long long) read48;
/// <summary>
/// Converts a 56-bit network representation to an integer.
/// </summary>
/// <returns></returns>
- (long long) read56;
/// <summary>
/// Converts a 64-bit network representation to an integer.
/// </summary>
/// <returns></returns>
- (long long) read64;
/// <summary>
/// Converts an 8-bit network representation to an integer.
/// </summary>
/// <returns></returns>
- (int) read8;
/// <summary>
/// Reads a 16-bit-length opaque value from a File.
/// </summary>
/// <returns></returns>
- (NSMutableData*) readOpaque16;
/// <summary>
/// Reads a 24-bit-length opaque value from a File.
/// </summary>
/// <returns></returns>
- (NSMutableData*) readOpaque24;
/// <summary>
/// Reads a 32-bit-length opaque value from a File.
/// </summary>
/// <returns></returns>
- (NSMutableData*) readOpaque32;
/// <summary>
/// Reads an 8-bit-length opaque value from a File.
/// </summary>
/// <returns></returns>
- (NSMutableData*) readOpaque8;
/// <summary>
/// Reads a value from a File.
/// </summary>
/// <param name="length">The number of bytes to read.</param>
/// <returns></returns>
- (NSMutableData*) readWithLength:(int)length;
/// <summary>
/// Sets whether to read/write using little-endian ordering.
/// </summary>
- (void) setLittleEndian:(bool)value;
/// <summary>
/// Adds a 16-bit value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) write16ToWithLocation:(int)location value:(int)value;
/// <summary>
/// Adds a 16-bit value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) write16WithValue:(int)value;
/// <summary>
/// Adds a 24-bit value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) write24ToWithLocation:(int)location value:(int)value;
/// <summary>
/// Adds a 24-bit value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) write24WithValue:(int)value;
/// <summary>
/// Adds a 32-bit value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) write32ToWithLocation:(int)location value:(long long)value;
/// <summary>
/// Adds a 32-bit value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) write32WithValue:(long long)value;
/// <summary>
/// Adds a 40-bit value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) write40ToWithLocation:(int)location value:(long long)value;
/// <summary>
/// Adds a 40-bit value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) write40WithValue:(long long)value;
/// <summary>
/// Adds a 48-bit value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) write48ToWithLocation:(int)location value:(long long)value;
/// <summary>
/// Adds a 48-bit value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) write48WithValue:(long long)value;
/// <summary>
/// Adds a 56-bit value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) write56ToWithLocation:(int)location value:(long long)value;
/// <summary>
/// Adds a 56-bit value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) write56WithValue:(long long)value;
/// <summary>
/// Adds a 64-bit value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) write64ToWithLocation:(int)location value:(long long)value;
/// <summary>
/// Adds a 64-bit value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) write64WithValue:(long long)value;
/// <summary>
/// Adds an 8-bit value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) write8ToWithLocation:(int)location value:(int)value;
/// <summary>
/// Adds an 8-bit value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) write8WithValue:(int)value;
/// <summary>
/// Adds a 16-bit-length opaque value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) writeOpaque16ToWithLocation:(int)location value:(NSMutableData*)value;
/// <summary>
/// Adds a 16-bit-length opaque value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) writeOpaque16WithValue:(NSMutableData*)value;
/// <summary>
/// Adds a 24-bit-length opaque value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) writeOpaque24ToWithLocation:(int)location value:(NSMutableData*)value;
/// <summary>
/// Adds a 24-bit-length opaque value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) writeOpaque24WithValue:(NSMutableData*)value;
/// <summary>
/// Adds a 32-bit-length opaque value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) writeOpaque32ToWithLocation:(int)location value:(NSMutableData*)value;
/// <summary>
/// Adds a 32-bit-length opaque value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) writeOpaque32WithValue:(NSMutableData*)value;
/// <summary>
/// Adds a 40-bit-length opaque value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) writeOpaque40ToWithLocation:(int)location value:(NSMutableData*)value;
/// <summary>
/// Adds a 40-bit-length opaque value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) writeOpaque40WithValue:(NSMutableData*)value;
/// <summary>
/// Adds a 48-bit-length opaque value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) writeOpaque48ToWithLocation:(int)location value:(NSMutableData*)value;
/// <summary>
/// Adds a 48-bit-length opaque value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) writeOpaque48WithValue:(NSMutableData*)value;
/// <summary>
/// Adds a 56-bit-length opaque value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) writeOpaque56ToWithLocation:(int)location value:(NSMutableData*)value;
/// <summary>
/// Adds a 56-bit-length opaque value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) writeOpaque56WithValue:(NSMutableData*)value;
/// <summary>
/// Adds a 64-bit-length opaque value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) writeOpaque64ToWithLocation:(int)location value:(NSMutableData*)value;
/// <summary>
/// Adds a 64-bit-length opaque value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) writeOpaque64WithValue:(NSMutableData*)value;
/// <summary>
/// Adds an 8-bit-length opaque value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) writeOpaque8ToWithLocation:(int)location value:(NSMutableData*)value;
/// <summary>
/// Adds an 8-bit-length opaque value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) writeOpaque8WithValue:(NSMutableData*)value;
/// <summary>
/// Adds a value to a File.
/// </summary>
/// <param name="location">The location to write to.</param>
/// <param name="value">The value.</param>
- (void) writeToWithLocation:(int)location value:(NSMutableData*)value;
/// <summary>
/// Adds a value to a File.
/// </summary>
/// <param name="value">The value.</param>
- (void) writeWithValue:(NSMutableData*)value;

@end


@class NSStringFMExtensions;
@class FMJsonProvider;

/// <summary>
/// JSON utility class.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMJson : NSObject 

/// <summary>
/// Deserializes a value from a JSON string.
/// </summary>
/// <typeparam name="T">The type the value to deserialize.</typeparam>
/// <param name="valueJson">The JSON string to deserialize.</param>
/// <returns>The deserialized value.</returns>
+ (NSObject*) deserializeWithValueJson:(NSString*)valueJson;
- (id) init;
+ (FMJson*) json;
/// <summary>
/// Gets the JSON provider to use.
/// </summary>
+ (FMJsonProvider*) provider;
/// <summary>
/// Serializes a value to a JSON string.
/// </summary>
/// <typeparam name="T">The type the value to serialize.</typeparam>
/// <param name="value">The value to serialize.</param>
/// <returns>The serialized JSON string.</returns>
+ (NSString*) serializeWithValue:(NSObject*)value;
/// <summary>
/// Sets the JSON provider to use.
/// </summary>
+ (void) setProvider:(FMJsonProvider*)value;

@end


@class NSStringFMExtensions;

/// <summary>
/// Base class for all JSON provider implementations.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMJsonProvider : NSObject 

/// <summary>
/// Deserializes a value from a JSON string.
/// </summary>
/// <typeparam name="T">The type the value to deserialize.</typeparam>
/// <param name="valueJson">The JSON string to deserialize.</param>
/// <returns>The deserialized value.</returns>
- (NSObject*) deserializeWithValueJson:(NSString*)valueJson;
- (id) init;
+ (FMJsonProvider*) jsonProvider;
/// <summary>
/// Serializes a value to a JSON string.
/// </summary>
/// <typeparam name="T">The type the value to serialize.</typeparam>
/// <param name="value">The value to serialize.</param>
/// <returns>The serialized JSON string.</returns>
- (NSString*) serializeWithValue:(NSObject*)value;

@end


@class NSStringFMExtensions;

/// <summary>
/// An implementation of a JSON provider that does nothing.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMNullJsonProvider : FMJsonProvider 

/// <summary>
/// Deserializes a value from a JSON string.
/// </summary>
/// <typeparam name="T">The type the value to deserialize.</typeparam>
/// <param name="valueJson">The JSON string to deserialize.</param>
/// <returns>
/// The deserialized value.
/// </returns>
- (NSObject*) deserializeWithValueJson:(NSString*)valueJson;
- (id) init;
+ (FMNullJsonProvider*) nullJsonProvider;
/// <summary>
/// Serializes a value to a JSON string.
/// </summary>
/// <typeparam name="T">The type the value to serialize.</typeparam>
/// <param name="value">The value to serialize.</param>
/// <returns>
/// The serialized JSON string.
/// </returns>
- (NSString*) serializeWithValue:(NSObject*)value;

@end



/// <summary>
/// Class to hold a double value passed by reference.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMDoubleHolder : NSObject 

/// <summary>
/// Initializes a new instance of the <see cref="FMDoubleHolder" /> class.
/// </summary>
+ (FMDoubleHolder*) doubleHolder;
/// <summary>
/// Initializes a new instance of the <see cref="FMDoubleHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
+ (FMDoubleHolder*) doubleHolderWithValue:(double)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMDoubleHolder" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMDoubleHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
- (id) initWithValue:(double)value;
/// <summary>
/// Sets the value.
/// </summary>
- (void) setValue:(double)value;
/// <summary>
/// Gets the value.
/// </summary>
- (double) value;

@end



/// <summary>
/// Class to hold a float value passed by reference.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMFloatHolder : NSObject 

/// <summary>
/// Initializes a new instance of the <see cref="FMFloatHolder" /> class.
/// </summary>
+ (FMFloatHolder*) floatHolder;
/// <summary>
/// Initializes a new instance of the <see cref="FMFloatHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
+ (FMFloatHolder*) floatHolderWithValue:(float)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMFloatHolder" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMFloatHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
- (id) initWithValue:(float)value;
/// <summary>
/// Sets the value.
/// </summary>
- (void) setValue:(float)value;
/// <summary>
/// Gets the value.
/// </summary>
- (float) value;

@end


@class FMHttpRequestCreatedArgs;
@class FMHttpResponseReceivedArgs;
@class FMNameValueCollection;
@class NSMutableDataFMExtensions;
@class FMCallback;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for sending an HTTP request.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMHttpRequestArgs : FMDynamic 

/// <summary>
/// Gets the binary content to transfer over HTTP.
/// Overrides <see cref="FMHttpRequestArgs#textContent" />.
/// </summary>
- (NSMutableData*) binaryContent;
/// <summary>
/// Gets the headers to transfer over HTTP.
/// </summary>
- (FMNameValueCollection*) headers;
/// <summary>
/// Initializes a new instance of the <see cref="FMHttpRequestArgs" /> class
/// with default values.
/// </summary>
+ (FMHttpRequestArgs*) httpRequestArgs;
/// <summary>
/// Initializes a new instance of the <see cref="FMHttpRequestArgs" /> class
/// with default values.
/// </summary>
- (id) init;
/// <summary>
/// Gets the HTTP method.
/// </summary>
- (FMHttpMethod) method;
/// <summary>
/// Gets the callback to invoke once the outgoing HTTP request is created.
/// See <see cref="FMHttpRequestCreatedArgs" /> for callback argument details.
/// </summary>
- (FMCallback*) onRequestCreated;
/// <summary>
/// Gets the callback to invoke once the incoming HTTP response has been
/// received. See <see cref="FMHttpResponseReceivedArgs" /> for callback argument details.
/// </summary>
- (FMCallback*) onResponseReceived;
/// <summary>
/// Gets the sender of the content, either a client or publisher.
/// </summary>
- (NSObject*) sender;
/// <summary>
/// Sets the binary content to transfer over HTTP.
/// Overrides <see cref="FMHttpRequestArgs#textContent" />.
/// </summary>
- (void) setBinaryContent:(NSMutableData*)value;
/// <summary>
/// Sets the headers to transfer over HTTP.
/// </summary>
- (void) setHeaders:(FMNameValueCollection*)value;
/// <summary>
/// Sets the HTTP method.
/// </summary>
- (void) setMethod:(FMHttpMethod)value;
/// <summary>
/// Sets the callback to invoke once the outgoing HTTP request is created.
/// See <see cref="FMHttpRequestCreatedArgs" /> for callback argument details.
/// </summary>
- (void) setOnRequestCreated:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke once the outgoing HTTP request is created.
/// See <see cref="FMHttpRequestCreatedArgs" /> for callback argument details.
/// </summary>
- (void) setOnRequestCreatedBlock:(void (^) (FMHttpRequestCreatedArgs*))valueBlock;
/// <summary>
/// Sets the callback to invoke once the incoming HTTP response has been
/// received. See <see cref="FMHttpResponseReceivedArgs" /> for callback argument details.
/// </summary>
- (void) setOnResponseReceived:(FMCallback*)value;
/// <summary>
/// Sets the callback to invoke once the incoming HTTP response has been
/// received. See <see cref="FMHttpResponseReceivedArgs" /> for callback argument details.
/// </summary>
- (void) setOnResponseReceivedBlock:(void (^) (FMHttpResponseReceivedArgs*))valueBlock;
/// <summary>
/// Sets the sender of the content, either a client or publisher.
/// </summary>
- (void) setSender:(NSObject*)value;
/// <summary>
/// Sets the text content to transfer over HTTP.
/// </summary>
- (void) setTextContent:(NSString*)value;
/// <summary>
/// Sets the number of milliseconds to wait before timing out the HTTP transfer.
/// Defaults to 15000 (15 seconds).
/// </summary>
- (void) setTimeout:(int)value;
/// <summary>
/// Sets the target URL for the HTTP request.
/// </summary>
- (void) setUrl:(NSString*)value;
/// <summary>
/// Gets the text content to transfer over HTTP.
/// </summary>
- (NSString*) textContent;
/// <summary>
/// Gets the number of milliseconds to wait before timing out the HTTP transfer.
/// Defaults to 15000 (15 seconds).
/// </summary>
- (int) timeout;
/// <summary>
/// Gets the target URL for the HTTP request.
/// </summary>
- (NSString*) url;

@end


@class FMHttpRequestArgs;

/// <summary>
/// Arguments passed into callbacks when an HTTP request is created.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMHttpRequestCreatedArgs : NSObject 

+ (FMHttpRequestCreatedArgs*) httpRequestCreatedArgs;
- (id) init;
/// <summary>
/// Gets the outgoing HTTP request about to be sent to the server.
/// </summary>
- (NSMutableURLRequest*) request;
/// <summary>
/// Gets the original request arguments.
/// </summary>
- (FMHttpRequestArgs*) requestArgs;
/// <summary>
/// Gets the sender of the request, either a client or publisher.
/// </summary>
- (NSObject*) sender;
/// <summary>
/// Sets the outgoing HTTP request about to be sent to the server.
/// </summary>
- (void) setRequest:(NSMutableURLRequest*)value;
/// <summary>
/// Sets the original request arguments.
/// </summary>
- (void) setRequestArgs:(FMHttpRequestArgs*)value;
/// <summary>
/// Sets the sender of the request, either a client or publisher.
/// </summary>
- (void) setSender:(NSObject*)value;

@end


@class NSMutableDataFMExtensions;
@class NSExceptionFMExtensions;
@class FMNameValueCollection;
@class FMHttpRequestArgs;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for receiving an HTTP response.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMHttpResponseArgs : NSObject 

/// <summary>
/// Gets the binary content read from the HTTP response.
/// </summary>
- (NSMutableData*) binaryContent;
/// <summary>
/// Gets the exception generated while completing the request.
/// </summary>
- (NSException*) exception;
/// <summary>
/// Gets the headers read from the HTTP response.
/// </summary>
- (FMNameValueCollection*) headers;
/// <summary>
/// Initializes a new instance of the <see cref="FMHttpResponseArgs" /> class.
/// </summary>
/// <param name="requestArgs">The request arguments.</param>
+ (FMHttpResponseArgs*) httpResponseArgsWithRequestArgs:(FMHttpRequestArgs*)requestArgs;
/// <summary>
/// Initializes a new instance of the <see cref="FMHttpResponseArgs" /> class.
/// </summary>
/// <param name="requestArgs">The request arguments.</param>
- (id) initWithRequestArgs:(FMHttpRequestArgs*)requestArgs;
/// <summary>
/// Gets the original <see cref="FMHttpRequestArgs" />.
/// </summary>
- (FMHttpRequestArgs*) requestArgs;
/// <summary>
/// Sets the binary content read from the HTTP response.
/// </summary>
- (void) setBinaryContent:(NSMutableData*)value;
/// <summary>
/// Sets the exception generated while completing the request.
/// </summary>
- (void) setException:(NSException*)value;
/// <summary>
/// Sets the original <see cref="FMHttpRequestArgs" />.
/// </summary>
- (void) setRequestArgs:(FMHttpRequestArgs*)value;
/// <summary>
/// Sets the status code read from the HTTP response.
/// </summary>
- (void) setStatusCode:(int)value;
/// <summary>
/// Sets the text content read from the HTTP response.
/// </summary>
- (void) setTextContent:(NSString*)value;
/// <summary>
/// Gets the status code read from the HTTP response.
/// </summary>
- (int) statusCode;
/// <summary>
/// Gets the text content read from the HTTP response.
/// </summary>
- (NSString*) textContent;

@end


@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;
@class FMNameValueCollection;

/// <summary>
/// Arguments for <see cref="FMHttpTransfer#addOnSendStart:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMHttpSendFinishArgs : NSObject 

+ (FMHttpSendFinishArgs*) httpSendFinishArgs;
- (id) init;
/// <summary>
/// Gets the binary content of the request.
/// </summary>
- (NSMutableData*) requestBinaryContent;
/// <summary>
/// Gets the text content of the request.
/// </summary>
- (NSString*) requestTextContent;
/// <summary>
/// Gets the binary content of the response.
/// </summary>
- (NSMutableData*) responseBinaryContent;
/// <summary>
/// Gets the headers of the response.
/// </summary>
- (FMNameValueCollection*) responseHeaders;
/// <summary>
/// Gets the binary content of the response.
/// </summary>
- (NSString*) responseTextContent;
/// <summary>
/// Gets the sender of the request, either a client or publisher.
/// </summary>
- (NSObject*) sender;
- (void) setRequestBinaryContent:(NSMutableData*)value;
- (void) setRequestTextContent:(NSString*)value;
- (void) setResponseBinaryContent:(NSMutableData*)value;
- (void) setResponseHeaders:(FMNameValueCollection*)value;
- (void) setResponseTextContent:(NSString*)value;
- (void) setSender:(NSObject*)value;

@end


@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Arguments for <see cref="FMHttpTransfer#addOnSendStart:" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMHttpSendStartArgs : NSObject 

+ (FMHttpSendStartArgs*) httpSendStartArgs;
- (id) init;
/// <summary>
/// Gets the binary content of the request.
/// </summary>
- (NSMutableData*) requestBinaryContent;
/// <summary>
/// Gets the text content of the request.
/// </summary>
- (NSString*) requestTextContent;
/// <summary>
/// Gets the sender of the request, either a client or publisher.
/// </summary>
- (NSObject*) sender;
- (void) setRequestBinaryContent:(NSMutableData*)value;
- (void) setRequestTextContent:(NSString*)value;
- (void) setSender:(NSObject*)value;

@end



/// <summary>
/// Class to hold an integer value passed by reference.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMIntegerHolder : NSObject 

/// <summary>
/// Initializes a new instance of the <see cref="FMIntegerHolder" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMIntegerHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
- (id) initWithValue:(int)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMIntegerHolder" /> class.
/// </summary>
+ (FMIntegerHolder*) integerHolder;
/// <summary>
/// Initializes a new instance of the <see cref="FMIntegerHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
+ (FMIntegerHolder*) integerHolderWithValue:(int)value;
/// <summary>
/// Sets the value.
/// </summary>
- (void) setValue:(int)value;
/// <summary>
/// Gets the value.
/// </summary>
- (int) value;

@end


@class NSMutableDataFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Thread-safe class providing access to a single <see cref="FMLockedRandomizerRandomizer" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMLockedRandomizer : NSObject 

/// <summary>
/// Returns a nonnegative random number.
/// </summary>
/// <returns></returns>
+ (int) next;
/// <summary>
/// Fills the elements of a specified array of bytes with random numbers.
/// </summary>
/// <param name="buffer">The array of bytes to fill.</param>
+ (void) nextBytesWithBuffer:(NSMutableData*)buffer;
/// <summary>
/// Returns a random number between 0.0 and 1.0.
/// </summary>
/// <returns></returns>
+ (double) nextDouble;
/// <summary>
/// Returns a nonnegative random number.
/// </summary>
/// <returns></returns>
+ (long long) nextLong;
/// <summary>
/// Returns a nonnegative random number less than the specified maximum.
/// </summary>
/// <param name="maxValue">The maximum value (exclusive).</param>
/// <returns></returns>
+ (int) nextWithMaxValue:(int)maxValue;
/// <summary>
/// Returns a random number within a specified range.
/// </summary>
/// <param name="minValue">The mininum value (inclusive).</param>
/// <param name="maxValue">The maximum value (exclusive).</param>
/// <returns></returns>
+ (int) nextWithMinValue:(int)minValue maxValue:(int)maxValue;
/// <summary>
/// Generates a random string of a specified size.
/// </summary>
/// <param name="size">The size of the output string.</param>
/// <returns></returns>
+ (NSString*) randomStringWithSize:(int)size;

@end


@class NSStringFMExtensions;
@class NSMutableArrayFMExtensions;
@class NSExceptionFMExtensions;
@class FMLogProvider;

/// <summary>
/// Log utility class.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMLog : NSObject 

/// <summary>
/// Logs a debug-level message.
/// </summary>
/// <param name="format">A composite format string.</param>
/// <param name="args">An array containing zero or more objects to format.</param>
+ (void) debugFormat:(NSString*)format args:(NSMutableArray*)args;
/// <summary>
/// Logs a debug-level message.
/// </summary>
/// <param name="message">The message.</param>
+ (void) debugWithMessage:(NSString*)message;
/// <summary>
/// Logs a debug-level message.
/// </summary>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
+ (void) debugWithMessage:(NSString*)message ex:(NSException*)ex;
/// <summary>
/// Logs an error-level message.
/// </summary>
/// <param name="format">A composite format string.</param>
/// <param name="args">An array containing zero or more objects to format.</param>
+ (void) errorFormat:(NSString*)format args:(NSMutableArray*)args;
/// <summary>
/// Logs an error-level message.
/// </summary>
/// <param name="message">The message.</param>
+ (void) errorWithMessage:(NSString*)message;
/// <summary>
/// Logs an error-level message.
/// </summary>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
+ (void) errorWithMessage:(NSString*)message ex:(NSException*)ex;
/// <summary>
/// Logs a fatal-level message.
/// </summary>
/// <param name="format">A composite format string.</param>
/// <param name="args">An array containing zero or more objects to format.</param>
+ (void) fatalFormat:(NSString*)format args:(NSMutableArray*)args;
/// <summary>
/// Logs a fatal-level message.
/// </summary>
/// <param name="message">The message.</param>
+ (void) fatalWithMessage:(NSString*)message;
/// <summary>
/// Logs a fatal-level message.
/// </summary>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
+ (void) fatalWithMessage:(NSString*)message ex:(NSException*)ex;
/// <summary>
/// Logs an info-level message.
/// </summary>
/// <param name="format">A composite format string.</param>
/// <param name="args">An array containing zero or more objects to format.</param>
+ (void) infoFormat:(NSString*)format args:(NSMutableArray*)args;
/// <summary>
/// Logs an info-level message.
/// </summary>
/// <param name="message">The message.</param>
+ (void) infoWithMessage:(NSString*)message;
/// <summary>
/// Logs an info-level message.
/// </summary>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
+ (void) infoWithMessage:(NSString*)message ex:(NSException*)ex;
- (id) init;
/// <summary>
/// Gets a value indicating whether logging is enabled for debug-level messages.
/// </summary>
/// <value>
/// <c>true</c> if logging is enabled for debug-level messages; otherwise, <c>false</c>.
/// </value>
+ (bool) isDebugEnabled;
/// <summary>
/// Gets a value indicating whether logging is enabled for error-level messages.
/// </summary>
/// <value>
/// <c>true</c> if logging is enabled for error-level messages; otherwise, <c>false</c>.
/// </value>
+ (bool) isErrorEnabled;
/// <summary>
/// Gets a value indicating whether logging is enabled for fatal-level messages.
/// </summary>
/// <value>
/// <c>true</c> if logging is enabled for fatal-level messages; otherwise, <c>false</c>.
/// </value>
+ (bool) isFatalEnabled;
/// <summary>
/// Gets a value indicating whether logging is enabled for info-level messages.
/// </summary>
/// <value>
/// <c>true</c> if logging is enabled for info-level messages; otherwise, <c>false</c>.
/// </value>
+ (bool) isInfoEnabled;
/// <summary>
/// Gets a value indicating whether logging is enabled for warn-level messages.
/// </summary>
/// <value>
/// <c>true</c> if logging is enabled for warn-level messages; otherwise, <c>false</c>.
/// </value>
+ (bool) isWarnEnabled;
+ (FMLog*) log;
/// <summary>
/// Gets the log provider to use.
/// </summary>
+ (FMLogProvider*) provider;
/// <summary>
/// Sets the log provider to use.
/// </summary>
+ (void) setProvider:(FMLogProvider*)value;
/// <summary>
/// Logs a warn-level message.
/// </summary>
/// <param name="format">A composite format string.</param>
/// <param name="args">An array containing zero or more objects to format.</param>
+ (void) warnFormat:(NSString*)format args:(NSMutableArray*)args;
/// <summary>
/// Logs a warn-level message.
/// </summary>
/// <param name="message">The message.</param>
+ (void) warnWithMessage:(NSString*)message;
/// <summary>
/// Logs a warn-level message.
/// </summary>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
+ (void) warnWithMessage:(NSString*)message ex:(NSException*)ex;
/// <summary>
/// Writes a line of text to the log.
/// </summary>
/// <param name="format">A composite format string.</param>
/// <param name="args">An array containing zero or more objects to format.</param>
+ (void) writeLineWithFormat:(NSString*)format args:(NSMutableArray*)args;
/// <summary>
/// Writes a line of text to the log.
/// </summary>
/// <param name="text">The text to write to the log.</param>
+ (void) writeLineWithText:(NSString*)text;

@end



/// <summary>
/// Class to hold a long value passed by reference.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMLongHolder : NSObject 

/// <summary>
/// Initializes a new instance of the <see cref="FMLongHolder" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMLongHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
- (id) initWithValue:(long long)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMLongHolder" /> class.
/// </summary>
+ (FMLongHolder*) longHolder;
/// <summary>
/// Initializes a new instance of the <see cref="FMLongHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
+ (FMLongHolder*) longHolderWithValue:(long long)value;
/// <summary>
/// Sets the value.
/// </summary>
- (void) setValue:(long long)value;
/// <summary>
/// Gets the value.
/// </summary>
- (long long) value;

@end


@class FMByteCollection;
@class NSMutableDataFMExtensions;
@class FMByteInputStream;
@class FMByteOutputStream;

/// <summary>
/// Writes network data to a buffer.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMNetworkBuffer : NSObject 

/// <summary>
/// Converts a 16-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) fromBuffer16WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 24-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) fromBuffer24WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 32-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromBuffer32WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 40-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromBuffer40WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 48-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromBuffer48WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 56-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromBuffer56WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 64-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromBuffer64WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts an 8-bit network representation to an integer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) fromBuffer8WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Converts a 16-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) fromData16WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 24-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) fromData24WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 32-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromData32WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 40-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromData40WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 48-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromData48WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 56-bit network representation to an integer.
/// </summary>
/// <param name="data">data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromData56WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 64-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) fromData64WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts an 8-bit network representation to an integer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) fromData8WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Converts a 16-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (int) fromStream16WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts a 24-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (int) fromStream24WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts a 32-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) fromStream32WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts a 40-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) fromStream40WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts a 48-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) fromStream48WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts a 56-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) fromStream56WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts a 64-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) fromStream64WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Converts an 8-bit network representation to an integer.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (int) fromStream8WithStream:(FMByteInputStream*)stream;
- (id) init;
+ (FMNetworkBuffer*) networkBuffer;
/// <summary>
/// Reads a 16-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) readBuffer16WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 16-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (int) readBuffer16WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 24-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) readBuffer24WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 24-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (int) readBuffer24WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 32-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readBuffer32WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 32-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readBuffer32WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 40-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readBuffer40WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 40-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readBuffer40WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 48-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readBuffer48WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 48-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readBuffer48WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 56-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readBuffer56WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 56-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readBuffer56WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 64-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readBuffer64WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 64-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readBuffer64WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads an 8-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) readBuffer8WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads an 8-bit value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (int) readBuffer8WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 16-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque16WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 16-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque16WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 24-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque24WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 24-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque24WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 32-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque32WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a 32-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque32WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads an 8-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque8WithBuffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads an 8-bit-length opaque value from a buffer.
/// </summary>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferOpaque8WithBuffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a value from a buffer.
/// </summary>
/// <param name="length">The number of bytes to read.</param>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferWithLength:(int)length buffer:(FMByteCollection*)buffer offset:(int)offset;
/// <summary>
/// Reads a value from a buffer.
/// </summary>
/// <param name="length">The number of bytes to read.</param>
/// <param name="buffer">The buffer.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readBufferWithLength:(int)length buffer:(FMByteCollection*)buffer offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 16-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) readData16WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 16-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (int) readData16WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 24-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) readData24WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 24-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (int) readData24WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 32-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readData32WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 32-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readData32WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 40-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readData40WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 40-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readData40WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 48-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readData48WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 48-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readData48WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 56-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readData56WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 56-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readData56WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 64-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (long long) readData64WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 64-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (long long) readData64WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads an 8-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (int) readData8WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads an 8-bit value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (int) readData8WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 16-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque16WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 16-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque16WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 24-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque24WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 24-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque24WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 32-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque32WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a 32-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque32WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads an 8-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque8WithData:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads an 8-bit-length opaque value from a buffer.
/// </summary>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readDataOpaque8WithData:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a value from a buffer.
/// </summary>
/// <param name="length">The number of bytes to read.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <returns></returns>
+ (NSMutableData*) readDataWithLength:(int)length data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Reads a value from a buffer.
/// </summary>
/// <param name="length">The number of bytes to read.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
/// <returns></returns>
+ (NSMutableData*) readDataWithLength:(int)length data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Reads a 16-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (int) readStream16WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 24-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (int) readStream24WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 32-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) readStream32WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 40-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) readStream40WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 48-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) readStream48WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 56-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) readStream56WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 64-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (long long) readStream64WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads an 8-bit value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (int) readStream8WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 16-bit-length opaque value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (NSMutableData*) readStreamOpaque16WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 24-bit-length opaque value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (NSMutableData*) readStreamOpaque24WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a 32-bit-length opaque value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (NSMutableData*) readStreamOpaque32WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads an 8-bit-length opaque value from a stream.
/// </summary>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (NSMutableData*) readStreamOpaque8WithStream:(FMByteInputStream*)stream;
/// <summary>
/// Reads a value from a stream.
/// </summary>
/// <param name="length">The number of bytes to read.</param>
/// <param name="stream">The stream.</param>
/// <returns></returns>
+ (NSMutableData*) readStreamWithLength:(int)length stream:(FMByteInputStream*)stream;
/// <summary>
/// Converts an integer to it's 16-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes16WithValue:(int)value;
/// <summary>
/// Converts an integer to it's 24-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes24WithValue:(int)value;
/// <summary>
/// Converts an integer to it's 32-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes32WithValue:(long long)value;
/// <summary>
/// Converts an integer to it's 40-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes40WithValue:(long long)value;
/// <summary>
/// Converts an integer to it's 48-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes48WithValue:(long long)value;
/// <summary>
/// Converts an integer to it's 56-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes56WithValue:(long long)value;
/// <summary>
/// Converts an integer to it's 64-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes64WithValue:(long long)value;
/// <summary>
/// Converts an integer to it's 8-bit network representation.
/// </summary>
/// <param name="value">The integer.</param>
/// <returns></returns>
+ (NSMutableData*) toBytes8WithValue:(int)value;
/// <summary>
/// Adds a 16-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer16WithValue:(int)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 24-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer24WithValue:(int)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 32-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer32WithValue:(long long)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 40-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer40WithValue:(long long)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 48-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer48WithValue:(long long)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 56-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer56WithValue:(long long)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 64-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer64WithValue:(long long)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds an 8-bit value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBuffer8WithValue:(int)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 16-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque16WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 24-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque24WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 32-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque32WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 40-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque40WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 48-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque48WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 56-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque56WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a 64-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque64WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds an 8-bit-length opaque value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferOpaque8WithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Adds a value to a buffer.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="buffer">The buffer.</param>
+ (void) writeBufferWithValue:(NSMutableData*)value buffer:(FMByteCollection*)buffer;
/// <summary>
/// Copies a 16-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData16WithValue:(int)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 16-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData16WithValue:(int)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 24-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData24WithValue:(int)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 24-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData24WithValue:(int)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 32-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData32WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 32-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData32WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 40-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData40WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 40-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData40WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 48-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData48WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 48-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData48WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 56-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData56WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 56-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData56WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 64-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData64WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 64-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData64WithValue:(long long)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies an 8-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeData8WithValue:(int)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies an 8-bit value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeData8WithValue:(int)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 16-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque16WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 16-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque16WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 24-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque24WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 24-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque24WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 32-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque32WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 32-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque32WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 40-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque40WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 40-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque40WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 48-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque48WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 48-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque48WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 56-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque56WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 56-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque56WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a 64-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque64WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a 64-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque64WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies an 8-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataOpaque8WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies an 8-bit-length opaque value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataOpaque8WithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Copies a value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
+ (void) writeDataWithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset;
/// <summary>
/// Copies a value to a buffer at a specific offset.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="data">The data.</param>
/// <param name="offset">The offset.</param>
/// <param name="offsetPlus">The offset plus the value length.</param>
+ (void) writeDataWithValue:(NSMutableData*)value data:(NSMutableData*)data offset:(int)offset offsetPlus:(int*)offsetPlus;
/// <summary>
/// Adds a 16-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream16WithValue:(int)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 24-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream24WithValue:(int)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 32-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream32WithValue:(long long)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 40-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream40WithValue:(long long)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 48-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream48WithValue:(long long)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 56-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream56WithValue:(long long)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 64-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream64WithValue:(long long)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds an 8-bit value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStream8WithValue:(int)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 16-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque16WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 24-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque24WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 32-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque32WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 40-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque40WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 48-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque48WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 56-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque56WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a 64-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque64WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds an 8-bit-length opaque value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamOpaque8WithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;
/// <summary>
/// Adds a value to a stream.
/// </summary>
/// <param name="value">The value.</param>
/// <param name="stream">The stream.</param>
+ (void) writeStreamWithValue:(NSMutableData*)value stream:(FMByteOutputStream*)stream;

@end



/// <summary>
/// Class to hold a short value passed by reference.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMShortHolder : NSObject 

/// <summary>
/// Initializes a new instance of the <see cref="FMShortHolder" /> class.
/// </summary>
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMShortHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
- (id) initWithValue:(short)value;
/// <summary>
/// Sets the value.
/// </summary>
- (void) setValue:(short)value;
/// <summary>
/// Initializes a new instance of the <see cref="FMShortHolder" /> class.
/// </summary>
+ (FMShortHolder*) shortHolder;
/// <summary>
/// Initializes a new instance of the <see cref="FMShortHolder" /> class.
/// </summary>
/// <param name="value">The value.</param>
+ (FMShortHolder*) shortHolderWithValue:(short)value;
/// <summary>
/// Gets the value.
/// </summary>
- (short) value;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;

/// <summary>
/// Utility class for splitting strings.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMSplitter : NSObject 

- (id) init;
+ (FMSplitter*) splitter;
/// <summary>
/// Splits a string using a given delimiter.
/// </summary>
/// <param name="str">The string.</param>
/// <param name="delimiter">The delimiter.</param>
/// <returns></returns>
+ (NSMutableArray*) splitWithStr:(NSString*)str delimiter:(NSString*)delimiter;

@end


@class NSStringFMExtensions;
@class FMCallback;
@class NSMutableStringFMExtensions;
@class NSExceptionFMExtensions;

/// <summary>
/// Simple log provider that writes to a local string builder.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMTextLogProvider : FMLogProvider 

/// <summary>
/// Gets a callback to invoke
/// whenever text is written to the log.
/// </summary>
- (FMCallback*) callback;
/// <summary>
/// Clears all text from the log
/// and returns the former contents.
/// </summary>
- (NSString*) clear;
/// <summary>
/// Initializes a new instance of the <see cref="FMTextLogProvider" /> class using <see cref="FMLogLevelWarn" />.
/// </summary>
- (id) init;
/// <summary>
/// Initializes a new instance of the <see cref="FMTextLogProvider" /> class.
/// </summary>
/// <param name="level">The log level.</param>
- (id) initWithLevel:(FMLogLevel)level;
/// <summary>
/// Logs a message at the specified log level.
/// </summary>
/// <param name="level">The log level.</param>
/// <param name="message">The message.</param>
- (void) logWithLevel:(FMLogLevel)level message:(NSString*)message;
/// <summary>
/// Logs a message at the specified log level.
/// </summary>
/// <param name="level">The log level.</param>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
- (void) logWithLevel:(FMLogLevel)level message:(NSString*)message ex:(NSException*)ex;
/// <summary>
/// Sets a callback to invoke
/// whenever text is written to the log.
/// </summary>
- (void) setCallback:(FMCallback*)value;
/// <summary>
/// Sets a callback to invoke
/// whenever text is written to the log.
/// </summary>
- (void) setCallbackBlock:(void (^) (NSString*))valueBlock;
/// <summary>
/// Gets the logged text.
/// </summary>
- (NSString*) text;
/// <summary>
/// Initializes a new instance of the <see cref="FMTextLogProvider" /> class using <see cref="FMLogLevelWarn" />.
/// </summary>
+ (FMTextLogProvider*) textLogProvider;
/// <summary>
/// Initializes a new instance of the <see cref="FMTextLogProvider" /> class.
/// </summary>
/// <param name="level">The log level.</param>
+ (FMTextLogProvider*) textLogProviderWithLevel:(FMLogLevel)level;
/// <summary>
/// Writes a line of text to the log.
/// </summary>
/// <param name="text">The text to write to the log.</param>
- (void) writeLineWithText:(NSString*)text;

@end


@class NSStringFMExtensions;
@class NSMutableArrayFMExtensions;

/// <summary>
/// Contains methods for string manipulation.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMStringAssistant : NSObject 

- (id) init;
/// <summary>
/// 
/// </summary>
/// <param name="s"></param>
/// <returns></returns>
+ (bool) isNullOrWhiteSpaceWithS:(NSString*)s;
+ (FMStringAssistant*) stringAssistant;
/// <summary>
/// Creates a subarray from an existing array.
/// </summary>
/// <param name="array">The source array.</param>
/// <param name="offset">The offset into the source array.</param>
/// <returns>The subarray.</returns>
+ (NSMutableArray*) subArray:(NSMutableArray*)array offset:(int)offset;
/// <summary>
/// Creates a subarray from an existing array.
/// </summary>
/// <param name="array">The source array.</param>
/// <param name="offset">The offset into the source array.</param>
/// <param name="count">The number of elements to copy into the subarray.</param>
/// <returns>The subarray.</returns>
+ (NSMutableArray*) subArray:(NSMutableArray*)array offset:(int)offset count:(int)count;

@end


@class FMHttpResponseArgs;
@class FMHttpSendStartArgs;
@class FMHttpSendFinishArgs;
@class NSStringFMExtensions;
@class FMCallback;
@class FMHttpRequestArgs;

/// <summary>
/// Base class that defines methods for transferring content over HTTP.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMHttpTransfer : NSObject 

/// <summary>
/// Adds a handler that is raised before an HTTP request is sent.
/// </summary>
/// <parameter name="args">The <see cref="FMHttpSendFinishArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSendFinish:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before an HTTP request is sent.
/// </summary>
/// <parameter name="args">The <see cref="FMHttpSendFinishArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSendFinishBlock:(void (^) (FMHttpSendFinishArgs*))valueBlock;
/// <summary>
/// Adds a handler that is raised before an HTTP request is sent.
/// </summary>
/// <parameter name="args">The <see cref="FMHttpSendStartArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSendStart:(FMCallback*)value;
/// <summary>
/// Adds a handler that is raised before an HTTP request is sent.
/// </summary>
/// <parameter name="args">The <see cref="FMHttpSendStartArgs" /> associated with the event.</parameter>
+ (FMCallback*) addOnSendStartBlock:(void (^) (FMHttpSendStartArgs*))valueBlock;
/// <summary>
/// Escapes and adds a query parameter as a key/empty-value pair to a URL.
/// </summary>
/// <param name="url">The URL with the query to which the key/value should be added.</param>
/// <param name="key">The key of the query parameter to add.</param>
/// <returns>The original URL with the query parameter added.</returns>
+ (NSString*) addQueryToUrl:(NSString*)url key:(NSString*)key;
/// <summary>
/// Escapes and adds a query parameter as a key/value pair to a URL.
/// </summary>
/// <param name="url">The URL with the query to which the key/value should be added.</param>
/// <param name="key">The key of the query parameter to add.</param>
/// <param name="value">The value of the query parameter to add.</param>
/// <returns>The original URL with the query parameter added.</returns>
+ (NSString*) addQueryToUrl:(NSString*)url key:(NSString*)key value:(NSString*)value;
/// <summary>
/// Gets a random wildcard character.
/// </summary>
/// <returns>A random wildcard character.</returns>
+ (NSString*) getRandomWildcardCharacter;
+ (FMHttpTransfer*) httpTransfer;
- (id) init;
/// <summary>
/// Removes a handler that is raised before an HTTP request is sent.
/// </summary>
/// <parameter name="args">The <see cref="FMHttpSendFinishArgs" /> associated with the event.</parameter>
+ (void) removeOnSendFinish:(FMCallback*)value;
/// <summary>
/// Removes a handler that is raised before an HTTP request is sent.
/// </summary>
/// <parameter name="args">The <see cref="FMHttpSendStartArgs" /> associated with the event.</parameter>
+ (void) removeOnSendStart:(FMCallback*)value;
/// <summary>
/// Replaces asterisks in URLs with characters from
/// WildcardCharacters.
/// </summary>
/// <param name="url">The URL with asterisks.</param>
/// <returns></returns>
+ (NSString*) replaceWildcardsWithUrl:(NSString*)url;
/// <summary>
/// Sends a request asynchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <param name="callback">The callback to execute with the resulting response.</param>
- (void) sendAsyncWithRequestArgs:(FMHttpRequestArgs*)requestArgs callback:(FMCallback*)callback;
/// <summary>
/// Sends a request asynchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <param name="callback">The callback to execute with the resulting response.</param>
- (void) sendAsyncWithRequestArgs:(FMHttpRequestArgs*)requestArgs callbackBlock:(void (^) (FMHttpResponseArgs*))callbackBlock;
/// <summary>
/// Sends binary content asynchronously using the specified arguments.
/// </summary>
/// <param name="requestArgs">The request arguments.</param>
/// <param name="callback">The callback to execute on success or failure.</param>
- (void) sendBinaryAsyncWithRequestArgs:(FMHttpRequestArgs*)requestArgs callback:(FMCallback*)callback;
/// <summary>
/// Sends binary content asynchronously using the specified arguments.
/// </summary>
/// <param name="requestArgs">The request arguments.</param>
/// <param name="callback">The callback to execute on success or failure.</param>
- (void) sendBinaryAsyncWithRequestArgs:(FMHttpRequestArgs*)requestArgs callbackBlock:(void (^) (FMHttpResponseArgs*))callbackBlock;
/// <summary>
/// Sends binary content synchronously using the specified arguments.
/// </summary>
/// <param name="requestArgs">The request arguments.</param>
/// <returns>The response arguments from the server.</returns>
- (FMHttpResponseArgs*) sendBinaryWithRequestArgs:(FMHttpRequestArgs*)requestArgs;
/// <summary>
/// Sends text content asynchronously using the specified arguments.
/// </summary>
/// <param name="requestArgs">The request arguments.</param>
/// <param name="callback">The callback to execute on success or failure.</param>
- (void) sendTextAsyncWithRequestArgs:(FMHttpRequestArgs*)requestArgs callback:(FMCallback*)callback;
/// <summary>
/// Sends text content asynchronously using the specified arguments.
/// </summary>
/// <param name="requestArgs">The request arguments.</param>
/// <param name="callback">The callback to execute on success or failure.</param>
- (void) sendTextAsyncWithRequestArgs:(FMHttpRequestArgs*)requestArgs callbackBlock:(void (^) (FMHttpResponseArgs*))callbackBlock;
/// <summary>
/// Sends text content synchronously using the specified arguments.
/// </summary>
/// <param name="requestArgs">The request arguments.</param>
/// <returns>The response arguments from the server.</returns>
- (FMHttpResponseArgs*) sendTextWithRequestArgs:(FMHttpRequestArgs*)requestArgs;
/// <summary>
/// Sends a request synchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <returns>The resulting response.</returns>
- (FMHttpResponseArgs*) sendWithRequestArgs:(FMHttpRequestArgs*)requestArgs;
/// <summary>
/// Sets the wildcard characters used
/// to replace asterisks in ReplaceWildcards.
/// </summary>
+ (void) setWildcardCharacters:(NSString*)value;
/// <summary>
/// Releases any resources and shuts down.
/// </summary>
- (void) shutdown;
/// <summary>
/// Gets the wildcard characters used
/// to replace asterisks in ReplaceWildcards.
/// </summary>
+ (NSString*) wildcardCharacters;

@end


@class FMHttpTransfer;
@class FMCallback;

/// <summary>
/// Creates implementations of <see cref="FMHttpTransfer" />.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMHttpTransferFactory : NSObject 

/// <summary>
/// Gets the callback that creates an HTTP-based transfer class.
/// </summary>
+ (FMCallback*) createHttpTransfer;
+ (FMHttpTransfer*) defaultCreateHttpTransfer;
/// <summary>
/// Gets an instance of the HTTP-based transfer class.
/// </summary>
/// <returns></returns>
+ (FMHttpTransfer*) getHttpTransfer;
+ (FMHttpTransferFactory*) httpTransferFactory;
- (id) init;
/// <summary>
/// Sets the callback that creates an HTTP-based transfer class.
/// </summary>
+ (void) setCreateHttpTransfer:(FMCallback*)value;
/// <summary>
/// Sets the callback that creates an HTTP-based transfer class.
/// </summary>
+ (void) setCreateHttpTransferBlock:(FMHttpTransfer* (^) (void))valueBlock;

@end


@class NSStringFMExtensions;
@class NSExceptionFMExtensions;

/// <summary>
/// An implementation of a logging provider that does nothing.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMNullLogProvider : FMLogProvider 

- (id) init;
/// <summary>
/// Ignores a message at the specified log level.
/// </summary>
/// <param name="level">The log level.</param>
/// <param name="message">The message.</param>
- (void) logWithLevel:(FMLogLevel)level message:(NSString*)message;
/// <summary>
/// Ignores a message at the specified log level.
/// </summary>
/// <param name="level">The log level.</param>
/// <param name="message">The message.</param>
/// <param name="ex">The exception.</param>
- (void) logWithLevel:(FMLogLevel)level message:(NSString*)message ex:(NSException*)ex;
+ (FMNullLogProvider*) nullLogProvider;
/// <summary>
/// Writes a line of text to the log.
/// </summary>
/// <param name="text">The text to write to the log.</param>
- (void) writeLineWithText:(NSString*)text;

@end


@class NSMutableArrayFMExtensions;
@class NSStringFMExtensions;
@class FMNullableBool;
@class FMNullableDecimal;
@class FMNullableDouble;
@class FMNullableFloat;
@class FMNullableGuid;
@class FMNullableInt;
@class FMNullableLong;
@class FMCallback;
@class FMSerializable;

/// <summary>
/// Provides methods for serializing/deserializing .NET value types
/// as well as facilities for converting objects and arrays if
/// appropriate callbacks are supplied to assist with the conversion.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMSerializer : NSObject 

/// <summary>
/// Deserializes a boolean array from JSON.
/// </summary>
/// <param name="arrayJson">A JSON-serialized boolean array.</param>
/// <returns>An array of boolean values.</returns>
+ (NSMutableArray*) deserializeBooleanArrayWithJson:(NSString*)arrayJson;
/// <summary>
/// Deserializes a boolean value.
/// </summary>
/// <param name="valueJson">The boolean JSON to deserialize.</param>
/// <returns>The deserialized boolean value.</returns>
+ (FMNullableBool*) deserializeBooleanWithValueJson:(NSString*)valueJson;
/// <summary>
/// Deserializes a decimal array from JSON.
/// </summary>
/// <param name="arrayJson">A JSON-serialized decimal array.</param>
/// <returns>An array of decimal values.</returns>
+ (NSMutableArray*) deserializeDecimalArrayWithJson:(NSString*)arrayJson;
/// <summary>
/// Deserializes a decimal value.
/// </summary>
/// <param name="valueJson">The decimal JSON to deserialize.</param>
/// <returns>The deserialized decimal value.</returns>
+ (FMNullableDecimal*) deserializeDecimalWithValueJson:(NSString*)valueJson;
/// <summary>
/// Deserializes a double array from JSON.
/// </summary>
/// <param name="arrayJson">A JSON-serialized double array.</param>
/// <returns>An array of double values.</returns>
+ (NSMutableArray*) deserializeDoubleArrayWithJson:(NSString*)arrayJson;
/// <summary>
/// Deserializes a double value.
/// </summary>
/// <param name="valueJson">The double JSON to deserialize.</param>
/// <returns>The deserialized double value.</returns>
+ (FMNullableDouble*) deserializeDoubleWithValueJson:(NSString*)valueJson;
/// <summary>
/// Deserializes a float array from JSON.
/// </summary>
/// <param name="arrayJson">A JSON-serialized float array.</param>
/// <returns>An array of float values.</returns>
+ (NSMutableArray*) deserializeFloatArrayWithJson:(NSString*)arrayJson;
/// <summary>
/// Deserializes a float value.
/// </summary>
/// <param name="valueJson">The float JSON to deserialize.</param>
/// <returns>The deserialized float value.</returns>
+ (FMNullableFloat*) deserializeFloatWithValueJson:(NSString*)valueJson;
/// <summary>
/// Deserializes a GUID array from JSON.
/// </summary>
/// <param name="arrayJson">A JSON-serialized GUID array.</param>
/// <returns>An array of GUID values.</returns>
+ (NSMutableArray*) deserializeGuidArrayWithJson:(NSString*)arrayJson;
/// <summary>
/// Deserializes a globally unique identifier.
/// </summary>
/// <param name="valueJson">The GUID JSON to deserialize.</param>
/// <returns>The deserialized GUID.</returns>
+ (FMNullableGuid*) deserializeGuidWithValueJson:(NSString*)valueJson;
/// <summary>
/// Deserializes a integer array from JSON.
/// </summary>
/// <param name="arrayJson">A JSON-serialized integer array.</param>
/// <returns>An array of integer values.</returns>
+ (NSMutableArray*) deserializeIntegerArrayWithJson:(NSString*)arrayJson;
/// <summary>
/// Deserializes an integer value.
/// </summary>
/// <param name="valueJson">The integer JSON to deserialize.</param>
/// <returns>The deserialized integer value.</returns>
+ (FMNullableInt*) deserializeIntegerWithValueJson:(NSString*)valueJson;
/// <summary>
/// Deserializes a long array from JSON.
/// </summary>
/// <param name="arrayJson">A JSON-serialized long array.</param>
/// <returns>An array of long values.</returns>
+ (NSMutableArray*) deserializeLongArrayWithJson:(NSString*)arrayJson;
/// <summary>
/// Deserializes a long value.
/// </summary>
/// <param name="valueJson">The long JSON to deserialize.</param>
/// <returns>The deserialized long value.</returns>
+ (FMNullableLong*) deserializeLongWithValueJson:(NSString*)valueJson;
/// <summary>
/// Deserializes a JSON string into an array of <see cref="FMSerializable" /> target object types.
/// </summary>
/// <typeparam name="T">The type of the object to deserialize.</typeparam>
/// <param name="json">The JSON-encoded string.</param>
/// <param name="creator">The method used for creating an object.</param>
/// <param name="callback">The method used for deserializing an object.</param>
/// <returns>An array of deserialized objects.</returns>
+ (NSMutableArray*) deserializeObjectArrayFastWithJson:(NSString*)json creator:(FMCallback*)creator callback:(FMCallback*)callback;
/// <summary>
/// Deserializes a JSON string into an array of target object types.
/// </summary>
/// <typeparam name="T">The type of the object to deserialize.</typeparam>
/// <param name="json">The JSON-encoded string.</param>
/// <param name="creator">The method used for creating an object.</param>
/// <param name="callback">The method used for deserializing an object.</param>
/// <returns>An array of deserialized objects.</returns>
+ (NSMutableArray*) deserializeObjectArrayWithJson:(NSString*)json creator:(FMCallback*)creator callback:(FMCallback*)callback;
/// <summary>
/// Deserializes a JSON string into a <see cref="FMSerializable" /> target object type.
/// </summary>
/// <typeparam name="T">The type of the object to deserialize.</typeparam>
/// <param name="json">The JSON-encoded string.</param>
/// <param name="creator">The method used for creating a new object.</param>
/// <param name="callback">The method used for deserializing a property.</param>
/// <returns>The deserialized object.</returns>
+ (FMSerializable*) deserializeObjectFastWithJson:(NSString*)json creator:(FMCallback*)creator callback:(FMCallback*)callback;
/// <summary>
/// Deserializes a JSON string into a target object type.
/// </summary>
/// <typeparam name="T">The type of the object to deserialize.</typeparam>
/// <param name="json">The JSON-encoded string.</param>
/// <param name="creator">The method used for creating a new object.</param>
/// <param name="callback">The method used for deserializing a property.</param>
/// <returns>The deserialized object.</returns>
+ (NSObject*) deserializeObjectWithJson:(NSString*)json creator:(FMCallback*)creator callback:(FMCallback*)callback;
/// <summary>
/// Deserializes a raw array from JSON.
/// </summary>
/// <param name="json">A JSON-serialized raw array.</param>
/// <returns>An array of raw values.</returns>
+ (NSMutableArray*) deserializeRawArrayWithJson:(NSString*)json;
/// <summary>
/// Deserializes a piece of raw JSON.
/// </summary>
/// <param name="dataJson">The raw data.</param>
/// <returns>The deserialized data.</returns>
+ (NSString*) deserializeRawWithDataJson:(NSString*)dataJson;
/// <summary>
/// Deserializes a simple string array from JSON (no commas in strings).
/// </summary>
/// <param name="arrayJson">A JSON-serialized string array.</param>
/// <returns>An array of string values.</returns>
+ (NSMutableArray*) deserializeStringArrayWithJson:(NSString*)arrayJson;
/// <summary>
/// Deserializes a string.
/// </summary>
/// <param name="valueJson">The string to deserialize.</param>
/// <returns>The deserialized string value.</returns>
+ (NSString*) deserializeStringWithValueJson:(NSString*)valueJson;
/// <summary>
/// Escapes any special characters in a string.
/// </summary>
/// <param name="text">The string without escaped characters.</param>
/// <returns>The escaped string.</returns>
+ (NSString*) escapeStringWithText:(NSString*)text;
- (id) init;
/// <summary>
/// Determines whether the specified JSON string is valid.
/// </summary>
/// <param name="json">The JSON string to validate.</param>
/// <returns>True if the JSON string is valid; false otherwise.</returns>
+ (bool) isValidJson:(NSString*)json;
/// <summary>
/// Serializes a boolean array to JSON.
/// </summary>
/// <param name="array">An array of boolean values.</param>
/// <returns>A JSON-serialized boolean array.</returns>
+ (NSString*) serializeBooleanArray:(NSMutableArray*)array;
/// <summary>
/// Serializes a boolean value.
/// </summary>
/// <param name="value">The boolean to serialize.</param>
/// <returns>The serialized boolean value.</returns>
+ (NSString*) serializeBooleanWithValue:(FMNullableBool*)value;
/// <summary>
/// Serializes a decimal array to JSON.
/// </summary>
/// <param name="array">An array of decimal values.</param>
/// <returns>A JSON-serialized decimal array.</returns>
+ (NSString*) serializeDecimalArray:(NSMutableArray*)array;
/// <summary>
/// Serializes a decimal value.
/// </summary>
/// <param name="value">The decimal to serialize.</param>
/// <returns>The serialized decimal value.</returns>
+ (NSString*) serializeDecimalWithValue:(FMNullableDecimal*)value;
/// <summary>
/// Serializes a double array to JSON.
/// </summary>
/// <param name="array">An array of double values.</param>
/// <returns>A JSON-serialized double array.</returns>
+ (NSString*) serializeDoubleArray:(NSMutableArray*)array;
/// <summary>
/// Serializes a double value.
/// </summary>
/// <param name="value">The double to serialize.</param>
/// <returns>The serialized double value.</returns>
+ (NSString*) serializeDoubleWithValue:(FMNullableDouble*)value;
/// <summary>
/// Serializes a float array to JSON.
/// </summary>
/// <param name="array">An array of float values.</param>
/// <returns>A JSON-serialized float array.</returns>
+ (NSString*) serializeFloatArray:(NSMutableArray*)array;
/// <summary>
/// Serializes a float value.
/// </summary>
/// <param name="value">The float to serialize.</param>
/// <returns>The serialized float value.</returns>
+ (NSString*) serializeFloatWithValue:(FMNullableFloat*)value;
/// <summary>
/// Serializes a GUID array to JSON.
/// </summary>
/// <param name="array">An array of GUID values.</param>
/// <returns>A JSON-serialized GUID array.</returns>
+ (NSString*) serializeGuidArray:(NSMutableArray*)array;
/// <summary>
/// Serializes a globally unique identifier.
/// </summary>
/// <param name="value">The GUID to serialize.</param>
/// <returns>The serialized GUID.</returns>
+ (NSString*) serializeGuidWithValue:(FMNullableGuid*)value;
/// <summary>
/// Serializes a integer array to JSON.
/// </summary>
/// <param name="array">An array of integer values.</param>
/// <returns>A JSON-serialized integer array.</returns>
+ (NSString*) serializeIntegerArray:(NSMutableArray*)array;
/// <summary>
/// Serializes an integer value.
/// </summary>
/// <param name="value">The integer to serialize.</param>
/// <returns>The serialized integer value.</returns>
+ (NSString*) serializeIntegerWithValue:(FMNullableInt*)value;
/// <summary>
/// Serializes a long array to JSON.
/// </summary>
/// <param name="array">An array of long values.</param>
/// <returns>A JSON-serialized long array.</returns>
+ (NSString*) serializeLongArray:(NSMutableArray*)array;
/// <summary>
/// Serializes a long value.
/// </summary>
/// <param name="value">The long to serialize.</param>
/// <returns>The serialized long value.</returns>
+ (NSString*) serializeLongWithValue:(FMNullableLong*)value;
/// <summary>
/// Serializes a <see cref="FMSerializable" /> object array into a JSON string.
/// </summary>
/// <typeparam name="T">The type of the object to serialize.</typeparam>
/// <param name="objects">The object array being serialized.</param>
/// <param name="callback">The method used for serializing objects.</param>
/// <returns>The object array as a JSON string.</returns>
+ (NSString*) serializeObjectArrayFastWithObjects:(NSMutableArray*)objects callback:(FMCallback*)callback;
/// <summary>
/// Serializes an object array into a JSON string.
/// </summary>
/// <typeparam name="T">The type of the object to serialize.</typeparam>
/// <param name="objects">The object array being serialized.</param>
/// <param name="callback">The method used for serializing objects.</param>
/// <returns>The object array as a JSON string.</returns>
+ (NSString*) serializeObjectArrayWithObjects:(NSMutableArray*)objects callback:(FMCallback*)callback;
/// <summary>
/// Serializes a <see cref="FMSerializable" /> object into a JSON string.
/// </summary>
/// <typeparam name="T">The type of the object to serialize.</typeparam>
/// <param name="source">The object being serialized.</param>
/// <param name="callback">The method used for serializing properties.</param>
/// <returns>The object as a JSON string.</returns>
+ (NSString*) serializeObjectFastWithSource:(FMSerializable*)source callback:(FMCallback*)callback;
/// <summary>
/// Serializes an object into a JSON string.
/// </summary>
/// <typeparam name="T">The type of the object to serialize.</typeparam>
/// <param name="source">The object being serialized.</param>
/// <param name="callback">The method used for serializing properties.</param>
/// <returns>The object as a JSON string.</returns>
+ (NSString*) serializeObjectWithSource:(NSObject*)source callback:(FMCallback*)callback;
+ (FMSerializer*) serializer;
/// <summary>
/// Serializes a raw array to JSON.
/// </summary>
/// <param name="jsons">An array of raw values.</param>
/// <returns>A JSON-serialized raw array.</returns>
+ (NSString*) serializeRawArrayWithJsons:(NSMutableArray*)jsons;
/// <summary>
/// Serializes a piece of raw JSON.
/// </summary>
/// <param name="dataJson">The raw data.</param>
/// <returns>The serialized data.</returns>
+ (NSString*) serializeRawWithDataJson:(NSString*)dataJson;
/// <summary>
/// Serializes a string array to JSON.
/// </summary>
/// <param name="array">An array of string values.</param>
/// <returns>A JSON-serialized string array.</returns>
+ (NSString*) serializeStringArray:(NSMutableArray*)array;
/// <summary>
/// Serializes a string.
/// </summary>
/// <param name="value">The string to serialize.</param>
/// <returns>The serialized string value.</returns>
+ (NSString*) serializeStringWithValue:(NSString*)value;
/// <summary>
/// Trims the quotes from a JavaScript string value.
/// </summary>
/// <param name="value">The JavaScript string value.</param>
/// <returns>The string without quotes.</returns>
+ (NSString*) trimQuotesWithValue:(NSString*)value;
/// <summary>
/// Unescapes any special characters from a string.
/// </summary>
/// <param name="text">The string with escaped characters.</param>
/// <returns>The unescaped string.</returns>
+ (NSString*) unescapeStringWithText:(NSString*)text;

@end


@class NSExceptionFMExtensions;
@class FMByteCollection;
@class NSMutableDataFMExtensions;
@class FMWebSocketOpenArgs;
@class NSStringFMExtensions;
@class NSURLFMExtensions;
@class FMRandom;
@class NSMutableArrayFMExtensions;
@class FMTcpSocket;
@class FMWebSocketCloseArgs;
@class FMWebSocketSendArgs;

/// <summary>
/// Implementation of the WebSocket protocol v8.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocket : FMBaseWebSocket 

/// <summary>
/// Gets the number of bytes buffered in the send queue.
/// </summary>
- (int) bufferedAmount;
/// <summary>
/// Closes the WebSocket connection.
/// </summary>
- (void) close;
/// <summary>
/// Closes the WebSocket connection.
/// </summary>
/// <param name="closeArgs">The close arguments</param>
- (void) closeWithArgs:(FMWebSocketCloseArgs*)closeArgs;
/// <summary>
/// Gets a value indicating whether WebSocket support exists on this platform.
/// </summary>
+ (bool) exists;
/// <summary>
/// Creates a new <see cref="FMWebSocket" />.
/// </summary>
/// <param name="requestUrl">The target URL for the WebSocket connection.</param>
- (id) initWithRequestUrl:(NSString*)requestUrl;
/// <summary>
/// Creates a new <see cref="FMWebSocket" />.
/// </summary>
/// <param name="requestUrl">The target URL for the WebSocket connection.</param>
/// <param name="protocol">The WebSocket protocol.</param>
- (id) initWithRequestUrl:(NSString*)requestUrl protocol:(NSString*)protocol;
/// <summary>
/// Gets a value indicating whether the WebSocket is connected.
/// </summary>
- (bool) isOpen;
/// <summary>
/// Opens the WebSocket connection.
/// </summary>
/// <param name="openArgs">The open arguments.</param>
- (void) openWithArgs:(FMWebSocketOpenArgs*)openArgs;
/// <summary>
/// Gets the WebSocket protocol.
/// </summary>
- (NSString*) protocol;
/// <summary>
/// Gets a value indicating whether the WebSocket is secure.
/// </summary>
- (bool) secure;
/// <summary>
/// Sends a message to the WebSocket server.
/// </summary>
/// <param name="sendArgs">The send arguments.</param>
- (void) sendWithArgs:(FMWebSocketSendArgs*)sendArgs;
/// <summary>
/// Creates a new <see cref="FMWebSocket" />.
/// </summary>
/// <param name="requestUrl">The target URL for the WebSocket connection.</param>
+ (FMWebSocket*) webSocketWithRequestUrl:(NSString*)requestUrl;
/// <summary>
/// Creates a new <see cref="FMWebSocket" />.
/// </summary>
/// <param name="requestUrl">The target URL for the WebSocket connection.</param>
/// <param name="protocol">The WebSocket protocol.</param>
+ (FMWebSocket*) webSocketWithRequestUrl:(NSString*)requestUrl protocol:(NSString*)protocol;

@end


@class NSMutableDataFMExtensions;
@class FMWebSocketSendArgs;

#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketSendState : NSObject 

- (id) init;
- (NSMutableData*) requestBytes;
- (FMWebSocketSendArgs*) sendArgs;
- (void) setRequestBytes:(NSMutableData*)value;
- (void) setSendArgs:(FMWebSocketSendArgs*)value;
+ (FMWebSocketSendState*) webSocketSendState;

@end


@class FMHttpResponseArgs;
@class FMHttpRequestArgs;
@class FMCallback;

#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketRequest : NSObject 

- (FMHttpRequestArgs*) args;
- (FMCallback*) callback;
- (id) init;
- (void) setArgs:(FMHttpRequestArgs*)value;
- (void) setCallback:(FMCallback*)value;
- (void) setCallbackBlock:(void (^) (FMHttpResponseArgs*))valueBlock;
+ (FMWebSocketRequest*) webSocketRequest;

@end


@class FMHttpResponseArgs;
@class FMWebSocketRequest;
@class FMWebSocket;
@class NSStringFMExtensions;
@class FMNameValueCollection;
@class FMHttpRequestArgs;
@class FMCallback;

/// <summary>
/// Defines methods for transferring messages using the WebSocket protocol.
/// </summary>
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMWebSocketWebRequestTransfer : FMWebSocketTransfer 

/// <summary>
/// Creates a new instance of <see cref="FMWebSocketWebRequestTransfer" />.
/// </summary>
/// <param name="url">The URL.</param>
- (id) initWithUrl:(NSString*)url;
/// <summary>
/// Opens the WebSocket connection.
/// </summary>
- (void) openWithHeaders:(FMNameValueCollection*)headers;
/// <summary>
/// Sends a request asynchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <param name="callback">The callback to execute with the resulting response.</param>
- (void) sendAsyncWithRequestArgs:(FMHttpRequestArgs*)requestArgs callback:(FMCallback*)callback;
/// <summary>
/// Sends a request asynchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <param name="callback">The callback to execute with the resulting response.</param>
- (void) sendAsyncWithRequestArgs:(FMHttpRequestArgs*)requestArgs callbackBlock:(void (^) (FMHttpResponseArgs*))callbackBlock;
/// <summary>
/// Sends a request synchronously.
/// </summary>
/// <param name="requestArgs">The request parameters.</param>
/// <returns>The response parameters.</returns>
- (FMHttpResponseArgs*) sendWithRequestArgs:(FMHttpRequestArgs*)requestArgs;
/// <summary>
/// Releases any resources and shuts down.
/// </summary>
- (void) shutdown;
/// <summary>
/// Creates a new instance of <see cref="FMWebSocketWebRequestTransfer" />.
/// </summary>
/// <param name="url">The URL.</param>
+ (FMWebSocketWebRequestTransfer*) webSocketWebRequestTransferWithUrl:(NSString*)url;

@end



@interface FMFile : NSObject 

- (id)initWithPath:(NSString *)path;
- (bool)exists;
- (void)openWithAccess:(FMFileAccess)access;
- (void)close;
- (void)flush;
- (bool)writeWithData:(NSMutableData *)data index:(int)index length:(int)length;
- (bool)writeToWithLocation:(int)location data:(NSMutableData *)data index:(int)index length:(int)length;
- (int)readWithData:(NSMutableData *)data index:(int)index length:(int)length;

@end


@interface FMHttpRequest : NSObject 

- (NSURL*) url;

@end



@interface FMHttpWebRequest : NSObject 

- (instancetype)initWithSession:(NSURLSession *)session;
- (FMHttpResponseArgs*)sendBinaryWithRequestArgs:(FMHttpRequestArgs*)requestArgs;
- (void)sendBinaryAsyncWithRequestArgs:(FMHttpRequestArgs*)requestArgs callback:(FMCallback*)callback;

@end




@interface FMHttpWebRequestTransfer : FMHttpTransfer 

+ (NSString*)getPlatformCode;

@end

//
//  FMAsyncSocket.h
//  
//  This class is in the public domain.
//  Originally created by Dustin Voss on Wed Jan 29 2003.
//  Updated and maintained by Deusty Designs and the Mac development community.
//
//  http://code.google.com/p/cocoaasyncsocket/
//


@class FMAsyncSocket;
@class FMAsyncReadPacket;
@class FMAsyncWritePacket;

extern NSString *const FMAsyncSocketException;
extern NSString *const FMAsyncSocketErrorDomain;

enum FMAsyncSocketError
{
	FMAsyncSocketCFSocketError = kCFSocketError,	// From CFSocketError enum.
	FMAsyncSocketNoError = 0,						// Never used.
	FMAsyncSocketCanceledError,					// onSocketWillConnect: returned NO.
	FMAsyncSocketConnectTimeoutError,
	FMAsyncSocketReadMaxedOutError,               // Reached set maxLength without completing
	FMAsyncSocketReadTimeoutError,
	FMAsyncSocketWriteTimeoutError
};
typedef enum FMAsyncSocketError FMAsyncSocketError;

@protocol FMAsyncSocketDelegate
@optional

/**
 * In the event of an error, the socket is closed.
 * You may call "unreadData" during this call-back to get the last bit of data off the socket.
 * When connecting, this delegate method may be called
 * before"onSocket:didAcceptNewSocket:" or "onSocket:didConnectToHost:".
**/
- (void)onSocket:(FMAsyncSocket *)sock willDisconnectWithError:(NSError *)err;

/**
 * Called when a socket disconnects with or without error.  If you want to release a socket after it disconnects,
 * do so here. It is not safe to do that during "onSocket:willDisconnectWithError:".
 * 
 * If you call the disconnect method, and the socket wasn't already disconnected,
 * this delegate method will be called before the disconnect method returns.
**/
- (void)onSocketDidDisconnect:(FMAsyncSocket *)sock;

/**
 * Called when a socket accepts a connection.  Another socket is spawned to handle it. The new socket will have
 * the same delegate and will call "onSocket:didConnectToHost:port:".
**/
- (void)onSocket:(FMAsyncSocket *)sock didAcceptNewSocket:(FMAsyncSocket *)newSocket;

/**
 * Called when a new socket is spawned to handle a connection.  This method should return the run-loop of the
 * thread on which the new socket and its delegate should operate. If omitted, [NSRunLoop currentRunLoop] is used.
**/
- (NSRunLoop *)onSocket:(FMAsyncSocket *)sock wantsRunLoopForNewSocket:(FMAsyncSocket *)newSocket;

/**
 * Called when a socket is about to connect. This method should return YES to continue, or NO to abort.
 * If aborted, will result in FMAsyncSocketCanceledError.
 * 
 * If the connectToHost:onPort:error: method was called, the delegate will be able to access and configure the
 * CFReadStream and CFWriteStream as desired prior to connection.
 *
 * If the connectToAddress:error: method was called, the delegate will be able to access and configure the
 * CFSocket and CFSocketNativeHandle (BSD socket) as desired prior to connection. You will be able to access and
 * configure the CFReadStream and CFWriteStream in the onSocket:didConnectToHost:port: method.
**/
- (BOOL)onSocketWillConnect:(FMAsyncSocket *)sock;

/**
 * Called when a socket connects and is ready for reading and writing.
 * The host parameter will be an IP address, not a DNS name.
**/
- (void)onSocket:(FMAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port;

/**
 * Called when a socket has completed reading the requested data into memory.
 * Not called if there is an error.
**/
- (void)onSocket:(FMAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag;

/**
 * Called when a socket has read in data, but has not yet completed the read.
 * This would occur if using readToData: or readToLength: methods.
 * It may be used to for things such as updating progress bars.
**/
- (void)onSocket:(FMAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag;

/**
 * Called when a socket has completed writing the requested data. Not called if there is an error.
**/
- (void)onSocket:(FMAsyncSocket *)sock didWriteDataWithTag:(long)tag;

/**
 * Called when a socket has written some data, but has not yet completed the entire write.
 * It may be used to for things such as updating progress bars.
**/
- (void)onSocket:(FMAsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag;

/**
 * Called if a read operation has reached its timeout without completing.
 * This method allows you to optionally extend the timeout.
 * If you return a positive time interval (> 0) the read's timeout will be extended by the given amount.
 * If you don't implement this method, or return a non-positive time interval (<= 0) the read will timeout as usual.
 * 
 * The elapsed parameter is the sum of the original timeout, plus any additions previously added via this method.
 * The length parameter is the number of bytes that have been read so far for the read operation.
 * 
 * Note that this method may be called multiple times for a single read if you return positive numbers.
**/
- (NSTimeInterval)onSocket:(FMAsyncSocket *)sock
  shouldTimeoutReadWithTag:(long)tag
                   elapsed:(NSTimeInterval)elapsed
                 bytesDone:(NSUInteger)length;

/**
 * Called if a write operation has reached its timeout without completing.
 * This method allows you to optionally extend the timeout.
 * If you return a positive time interval (> 0) the write's timeout will be extended by the given amount.
 * If you don't implement this method, or return a non-positive time interval (<= 0) the write will timeout as usual.
 * 
 * The elapsed parameter is the sum of the original timeout, plus any additions previously added via this method.
 * The length parameter is the number of bytes that have been written so far for the write operation.
 * 
 * Note that this method may be called multiple times for a single write if you return positive numbers.
**/
- (NSTimeInterval)onSocket:(FMAsyncSocket *)sock
 shouldTimeoutWriteWithTag:(long)tag
                   elapsed:(NSTimeInterval)elapsed
                 bytesDone:(NSUInteger)length;

/**
 * Called after the socket has successfully completed SSL/TLS negotiation.
 * This method is not called unless you use the provided startTLS method.
 * 
 * If a SSL/TLS negotiation fails (invalid certificate, etc) then the socket will immediately close,
 * and the onSocket:willDisconnectWithError: delegate method will be called with the specific SSL error code.
**/
- (void)onSocketDidSecure:(FMAsyncSocket *)sock;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface FMAsyncSocket : NSObject

- (id)init;
- (id)initWithDelegate:(id)delegate;
- (id)initWithDelegate:(id)delegate userData:(long)userData;

/* String representation is long but has no "\n". */
- (NSString *)description;

/**
 * Use "canSafelySetDelegate" to see if there is any pending business (reads and writes) with the current delegate
 * before changing it.  It is, of course, safe to change the delegate before connecting or accepting connections.
**/
- (id)delegate;
- (BOOL)canSafelySetDelegate;
- (void)setDelegate:(id)delegate;

/* User data can be a long, or an id or void * cast to a long. */
- (long)userData;
- (void)setUserData:(long)userData;

/* Don't use these to read or write. And don't close them either! */
- (CFSocketRef)getCFSocket;
- (CFReadStreamRef)getCFReadStream;
- (CFWriteStreamRef)getCFWriteStream;

// Once one of the accept or connect methods are called, the FMAsyncSocket instance is locked in
// and the other accept/connect methods can't be called without disconnecting the socket first.
// If the attempt fails or times out, these methods either return NO or
// call "onSocket:willDisconnectWithError:" and "onSockedDidDisconnect:".

// When an incoming connection is accepted, FMAsyncSocket invokes several delegate methods.
// These methods are (in chronological order):
// 1. onSocket:didAcceptNewSocket:
// 2. onSocket:wantsRunLoopForNewSocket:
// 3. onSocketWillConnect:
// 
// Your server code will need to retain the accepted socket (if you want to accept it).
// The best place to do this is probably in the onSocket:didAcceptNewSocket: method.
// 
// After the read and write streams have been setup for the newly accepted socket,
// the onSocket:didConnectToHost:port: method will be called on the proper run loop.
// 
// Multithreading Note: If you're going to be moving the newly accepted socket to another run
// loop by implementing onSocket:wantsRunLoopForNewSocket:, then you should wait until the
// onSocket:didConnectToHost:port: method before calling read, write, or startTLS methods.
// Otherwise read/write events are scheduled on the incorrect runloop, and chaos may ensue.

/**
 * Tells the socket to begin listening and accepting connections on the given port.
 * When a connection comes in, the FMAsyncSocket instance will call the various delegate methods (see above).
 * The socket will listen on all available interfaces (e.g. wifi, ethernet, etc)
**/
- (BOOL)acceptOnPort:(UInt16)port error:(NSError **)errPtr;

/**
 * This method is the same as acceptOnPort:error: with the additional option
 * of specifying which interface to listen on. So, for example, if you were writing code for a server that
 * has multiple IP addresses, you could specify which address you wanted to listen on.  Or you could use it
 * to specify that the socket should only accept connections over ethernet, and not other interfaces such as wifi.
 * You may also use the special strings "localhost" or "loopback" to specify that
 * the socket only accept connections from the local machine.
 * 
 * To accept connections on any interface pass nil, or simply use the acceptOnPort:error: method.
**/
- (BOOL)acceptOnInterface:(NSString *)interface port:(UInt16)port error:(NSError **)errPtr;

/**
 * Connects to the given host and port.
 * The host may be a domain name (e.g. "deusty.com") or an IP address string (e.g. "192.168.0.2")
**/
- (BOOL)connectToHost:(NSString *)hostname onPort:(UInt16)port error:(NSError **)errPtr;

/**
 * This method is the same as connectToHost:onPort:error: with an additional timeout option.
 * To not time out use a negative time interval, or simply use the connectToHost:onPort:error: method.
**/
- (BOOL)connectToHost:(NSString *)hostname
			   onPort:(UInt16)port
		  withTimeout:(NSTimeInterval)timeout
				error:(NSError **)errPtr;

/**
 * Connects to the given address, specified as a sockaddr structure wrapped in a NSData object.
 * For example, a NSData object returned from NSNetService's addresses method.
 * 
 * If you have an existing struct sockaddr you can convert it to a NSData object like so:
 * struct sockaddr sa  -> NSData *dsa = [NSData dataWithBytes:&remoteAddr length:remoteAddr.sa_len];
 * struct sockaddr *sa -> NSData *dsa = [NSData dataWithBytes:remoteAddr length:remoteAddr->sa_len];
**/
- (BOOL)connectToAddress:(NSData *)remoteAddr error:(NSError **)errPtr;

/**
 * This method is the same as connectToAddress:error: with an additional timeout option.
 * To not time out use a negative time interval, or simply use the connectToAddress:error: method.
**/
- (BOOL)connectToAddress:(NSData *)remoteAddr withTimeout:(NSTimeInterval)timeout error:(NSError **)errPtr;

- (BOOL)connectToAddress:(NSData *)remoteAddr
     viaInterfaceAddress:(NSData *)interfaceAddr
             withTimeout:(NSTimeInterval)timeout
                   error:(NSError **)errPtr;

/**
 * Disconnects immediately. Any pending reads or writes are dropped.
 * If the socket is not already disconnected, the onSocketDidDisconnect delegate method
 * will be called immediately, before this method returns.
 * 
 * Please note the recommended way of releasing an FMAsyncSocket instance (e.g. in a dealloc method)
 * [asyncSocket setDelegate:nil];
 * [asyncSocket disconnect];
 * [asyncSocket release];
**/
- (void)disconnect;

/**
 * Disconnects after all pending reads have completed.
 * After calling this, the read and write methods will do nothing.
 * The socket will disconnect even if there are still pending writes.
**/
- (void)disconnectAfterReading;

/**
 * Disconnects after all pending writes have completed.
 * After calling this, the read and write methods will do nothing.
 * The socket will disconnect even if there are still pending reads.
**/
- (void)disconnectAfterWriting;

/**
 * Disconnects after all pending reads and writes have completed.
 * After calling this, the read and write methods will do nothing.
**/
- (void)disconnectAfterReadingAndWriting;

/* Returns YES if the socket and streams are open, connected, and ready for reading and writing. */
- (BOOL)isConnected;

/**
 * Returns the local or remote host and port to which this socket is connected, or nil and 0 if not connected.
 * The host will be an IP address.
**/
- (NSString *)connectedHost;
- (UInt16)connectedPort;

- (NSString *)localHost;
- (UInt16)localPort;

/**
 * Returns the local or remote address to which this socket is connected,
 * specified as a sockaddr structure wrapped in a NSData object.
 * 
 * See also the connectedHost, connectedPort, localHost and localPort methods.
**/
- (NSData *)connectedAddress;
- (NSData *)localAddress;

/**
 * Returns whether the socket is IPv4 or IPv6.
 * An accepting socket may be both.
**/
- (BOOL)isIPv4;
- (BOOL)isIPv6;

// The readData and writeData methods won't block (they are asynchronous).
// 
// When a read is complete the onSocket:didReadData:withTag: delegate method is called.
// When a write is complete the onSocket:didWriteDataWithTag: delegate method is called.
// 
// You may optionally set a timeout for any read/write operation. (To not timeout, use a negative time interval.)
// If a read/write opertion times out, the corresponding "onSocket:shouldTimeout..." delegate method
// is called to optionally allow you to extend the timeout.
// Upon a timeout, the "onSocket:willDisconnectWithError:" method is called, followed by "onSocketDidDisconnect".
// 
// The tag is for your convenience.
// You can use it as an array index, step number, state id, pointer, etc.

/**
 * Reads the first available bytes that become available on the socket.
 * 
 * If the timeout value is negative, the read operation will not use a timeout.
**/
- (void)readDataWithTimeout:(NSTimeInterval)timeout tag:(long)tag;

/**
 * Reads the first available bytes that become available on the socket.
 * The bytes will be appended to the given byte buffer starting at the given offset.
 * The given buffer will automatically be increased in size if needed.
 * 
 * If the timeout value is negative, the read operation will not use a timeout.
 * If the buffer if nil, the socket will create a buffer for you.
 * 
 * If the bufferOffset is greater than the length of the given buffer,
 * the method will do nothing, and the delegate will not be called.
 * 
 * If you pass a buffer, you must not alter it in any way while FMAsyncSocket is using it.
 * After completion, the data returned in onSocket:didReadData:withTag: will be a subset of the given buffer.
 * That is, it will reference the bytes that were appended to the given buffer.
**/
- (void)readDataWithTimeout:(NSTimeInterval)timeout
					 buffer:(NSMutableData *)buffer
			   bufferOffset:(NSUInteger)offset
						tag:(long)tag;

/**
 * Reads the first available bytes that become available on the socket.
 * The bytes will be appended to the given byte buffer starting at the given offset.
 * The given buffer will automatically be increased in size if needed.
 * A maximum of length bytes will be read.
 * 
 * If the timeout value is negative, the read operation will not use a timeout.
 * If the buffer if nil, a buffer will automatically be created for you.
 * If maxLength is zero, no length restriction is enforced.
 * 
 * If the bufferOffset is greater than the length of the given buffer,
 * the method will do nothing, and the delegate will not be called.
 * 
 * If you pass a buffer, you must not alter it in any way while FMAsyncSocket is using it.
 * After completion, the data returned in onSocket:didReadData:withTag: will be a subset of the given buffer.
 * That is, it will reference the bytes that were appended to the given buffer.
**/
- (void)readDataWithTimeout:(NSTimeInterval)timeout
                     buffer:(NSMutableData *)buffer
               bufferOffset:(NSUInteger)offset
                  maxLength:(NSUInteger)length
                        tag:(long)tag;

/**
 * Reads the given number of bytes.
 * 
 * If the timeout value is negative, the read operation will not use a timeout.
 * 
 * If the length is 0, this method does nothing and the delegate is not called.
**/
- (void)readDataToLength:(NSUInteger)length withTimeout:(NSTimeInterval)timeout tag:(long)tag;

/**
 * Reads the given number of bytes.
 * The bytes will be appended to the given byte buffer starting at the given offset.
 * The given buffer will automatically be increased in size if needed.
 * 
 * If the timeout value is negative, the read operation will not use a timeout.
 * If the buffer if nil, a buffer will automatically be created for you.
 * 
 * If the length is 0, this method does nothing and the delegate is not called.
 * If the bufferOffset is greater than the length of the given buffer,
 * the method will do nothing, and the delegate will not be called.
 * 
 * If you pass a buffer, you must not alter it in any way while FMAsyncSocket is using it.
 * After completion, the data returned in onSocket:didReadData:withTag: will be a subset of the given buffer.
 * That is, it will reference the bytes that were appended to the given buffer.
**/
- (void)readDataToLength:(NSUInteger)length
             withTimeout:(NSTimeInterval)timeout
                  buffer:(NSMutableData *)buffer
            bufferOffset:(NSUInteger)offset
                     tag:(long)tag;

/**
 * Reads bytes until (and including) the passed "data" parameter, which acts as a separator.
 * 
 * If the timeout value is negative, the read operation will not use a timeout.
 * 
 * If you pass nil or zero-length data as the "data" parameter,
 * the method will do nothing, and the delegate will not be called.
 * 
 * To read a line from the socket, use the line separator (e.g. CRLF for HTTP, see below) as the "data" parameter.
 * Note that this method is not character-set aware, so if a separator can occur naturally as part of the encoding for
 * a character, the read will prematurely end.
**/
- (void)readDataToData:(NSData *)data withTimeout:(NSTimeInterval)timeout tag:(long)tag;

/**
 * Reads bytes until (and including) the passed "data" parameter, which acts as a separator.
 * The bytes will be appended to the given byte buffer starting at the given offset.
 * The given buffer will automatically be increased in size if needed.
 * 
 * If the timeout value is negative, the read operation will not use a timeout.
 * If the buffer if nil, a buffer will automatically be created for you.
 * 
 * If the bufferOffset is greater than the length of the given buffer,
 * the method will do nothing, and the delegate will not be called.
 * 
 * If you pass a buffer, you must not alter it in any way while FMAsyncSocket is using it.
 * After completion, the data returned in onSocket:didReadData:withTag: will be a subset of the given buffer.
 * That is, it will reference the bytes that were appended to the given buffer.
 * 
 * To read a line from the socket, use the line separator (e.g. CRLF for HTTP, see below) as the "data" parameter.
 * Note that this method is not character-set aware, so if a separator can occur naturally as part of the encoding for
 * a character, the read will prematurely end.
**/
- (void)readDataToData:(NSData *)data
           withTimeout:(NSTimeInterval)timeout
                buffer:(NSMutableData *)buffer
          bufferOffset:(NSUInteger)offset
                   tag:(long)tag;

/**
 * Reads bytes until (and including) the passed "data" parameter, which acts as a separator.
 * 
 * If the timeout value is negative, the read operation will not use a timeout.
 * 
 * If maxLength is zero, no length restriction is enforced.
 * Otherwise if maxLength bytes are read without completing the read,
 * it is treated similarly to a timeout - the socket is closed with a FMAsyncSocketReadMaxedOutError.
 * The read will complete successfully if exactly maxLength bytes are read and the given data is found at the end.
 * 
 * If you pass nil or zero-length data as the "data" parameter,
 * the method will do nothing, and the delegate will not be called.
 * If you pass a maxLength parameter that is less than the length of the data parameter,
 * the method will do nothing, and the delegate will not be called.
 * 
 * To read a line from the socket, use the line separator (e.g. CRLF for HTTP, see below) as the "data" parameter.
 * Note that this method is not character-set aware, so if a separator can occur naturally as part of the encoding for
 * a character, the read will prematurely end.
**/
- (void)readDataToData:(NSData *)data withTimeout:(NSTimeInterval)timeout maxLength:(NSUInteger)length tag:(long)tag;

/**
 * Reads bytes until (and including) the passed "data" parameter, which acts as a separator.
 * The bytes will be appended to the given byte buffer starting at the given offset.
 * The given buffer will automatically be increased in size if needed.
 * A maximum of length bytes will be read.
 * 
 * If the timeout value is negative, the read operation will not use a timeout.
 * If the buffer if nil, a buffer will automatically be created for you.
 * 
 * If maxLength is zero, no length restriction is enforced.
 * Otherwise if maxLength bytes are read without completing the read,
 * it is treated similarly to a timeout - the socket is closed with a FMAsyncSocketReadMaxedOutError.
 * The read will complete successfully if exactly maxLength bytes are read and the given data is found at the end.
 * 
 * If you pass a maxLength parameter that is less than the length of the data parameter,
 * the method will do nothing, and the delegate will not be called.
 * If the bufferOffset is greater than the length of the given buffer,
 * the method will do nothing, and the delegate will not be called.
 * 
 * If you pass a buffer, you must not alter it in any way while FMAsyncSocket is using it.
 * After completion, the data returned in onSocket:didReadData:withTag: will be a subset of the given buffer.
 * That is, it will reference the bytes that were appended to the given buffer.
 * 
 * To read a line from the socket, use the line separator (e.g. CRLF for HTTP, see below) as the "data" parameter.
 * Note that this method is not character-set aware, so if a separator can occur naturally as part of the encoding for
 * a character, the read will prematurely end.
**/
- (void)readDataToData:(NSData *)data
           withTimeout:(NSTimeInterval)timeout
                buffer:(NSMutableData *)buffer
          bufferOffset:(NSUInteger)offset
             maxLength:(NSUInteger)length
                   tag:(long)tag;

/**
 * Writes data to the socket, and calls the delegate when finished.
 * 
 * If you pass in nil or zero-length data, this method does nothing and the delegate will not be called.
 * If the timeout value is negative, the write operation will not use a timeout.
**/
- (void)writeData:(NSData *)data withTimeout:(NSTimeInterval)timeout tag:(long)tag;

/**
 * Returns progress of current read or write, from 0.0 to 1.0, or NaN if no read/write (use isnan() to check).
 * "tag", "done" and "total" will be filled in if they aren't NULL.
**/
- (float)progressOfReadReturningTag:(long *)tag bytesDone:(NSUInteger *)done total:(NSUInteger *)total;
- (float)progressOfWriteReturningTag:(long *)tag bytesDone:(NSUInteger *)done total:(NSUInteger *)total;

/**
 * Secures the connection using SSL/TLS.
 * 
 * This method may be called at any time, and the TLS handshake will occur after all pending reads and writes
 * are finished. This allows one the option of sending a protocol dependent StartTLS message, and queuing
 * the upgrade to TLS at the same time, without having to wait for the write to finish.
 * Any reads or writes scheduled after this method is called will occur over the secured connection.
 * 
 * The possible keys and values for the TLS settings are well documented.
 * Some possible keys are:
 * - kCFStreamSSLLevel
 * - kCFStreamSSLAllowsExpiredCertificates
 * - kCFStreamSSLAllowsExpiredRoots
 * - kCFStreamSSLAllowsAnyRoot
 * - kCFStreamSSLValidatesCertificateChain
 * - kCFStreamSSLPeerName
 * - kCFStreamSSLCertificates
 * - kCFStreamSSLIsServer
 * 
 * Please refer to Apple's documentation for associated values, as well as other possible keys.
 * 
 * If you pass in nil or an empty dictionary, the default settings will be used.
 * 
 * The default settings will check to make sure the remote party's certificate is signed by a
 * trusted 3rd party certificate agency (e.g. verisign) and that the certificate is not expired.
 * However it will not verify the name on the certificate unless you
 * give it a name to verify against via the kCFStreamSSLPeerName key.
 * The security implications of this are important to understand.
 * Imagine you are attempting to create a secure connection to MySecureServer.com,
 * but your socket gets directed to MaliciousServer.com because of a hacked DNS server.
 * If you simply use the default settings, and MaliciousServer.com has a valid certificate,
 * the default settings will not detect any problems since the certificate is valid.
 * To properly secure your connection in this particular scenario you
 * should set the kCFStreamSSLPeerName property to "MySecureServer.com".
 * If you do not know the peer name of the remote host in advance (for example, you're not sure
 * if it will be "domain.com" or "www.domain.com"), then you can use the default settings to validate the
 * certificate, and then use the X509Certificate class to verify the issuer after the socket has been secured.
 * The X509Certificate class is part of the CocoaFMAsyncSocket open source project.
**/
- (void)startTLS:(NSDictionary *)tlsSettings;

/**
 * For handling readDataToData requests, data is necessarily read from the socket in small increments.
 * The performance can be much improved by allowing FMAsyncSocket to read larger chunks at a time and
 * store any overflow in a small internal buffer.
 * This is termed pre-buffering, as some data may be read for you before you ask for it.
 * If you use readDataToData a lot, enabling pre-buffering will result in better performance, especially on the iPhone.
 * 
 * The default pre-buffering state is controlled by the DEFAULT_PREBUFFERING definition.
 * It is highly recommended one leave this set to YES.
 * 
 * This method exists in case pre-buffering needs to be disabled by default for some unforeseen reason.
 * In that case, this method exists to allow one to easily enable pre-buffering when ready.
**/
- (void)enablePreBuffering;

/**
 * When you create an FMAsyncSocket, it is added to the runloop of the current thread.
 * So for manually created sockets, it is easiest to simply create the socket on the thread you intend to use it.
 * 
 * If a new socket is accepted, the delegate method onSocket:wantsRunLoopForNewSocket: is called to
 * allow you to place the socket on a separate thread. This works best in conjunction with a thread pool design.
 * 
 * If, however, you need to move the socket to a separate thread at a later time, this
 * method may be used to accomplish the task.
 * 
 * This method must be called from the thread/runloop the socket is currently running on.
 * 
 * Note: After calling this method, all further method calls to this object should be done from the given runloop.
 * Also, all delegate calls will be sent on the given runloop.
**/
- (BOOL)moveToRunLoop:(NSRunLoop *)runLoop;

/**
 * Allows you to configure which run loop modes the socket uses.
 * The default set of run loop modes is NSDefaultRunLoopMode.
 * 
 * If you'd like your socket to continue operation during other modes, you may want to add modes such as
 * NSModalPanelRunLoopMode or NSEventTrackingRunLoopMode. Or you may simply want to use NSRunLoopCommonModes.
 * 
 * Accepted sockets will automatically inherit the same run loop modes as the listening socket.
 * 
 * Note: NSRunLoopCommonModes is defined in 10.5. For previous versions one can use kCFRunLoopCommonModes.
**/
- (BOOL)setRunLoopModes:(NSArray *)runLoopModes;
- (BOOL)addRunLoopMode:(NSString *)runLoopMode;
- (BOOL)removeRunLoopMode:(NSString *)runLoopMode;

/**
 * Returns the current run loop modes the FMAsyncSocket instance is operating in.
 * The default set of run loop modes is NSDefaultRunLoopMode.
**/
- (NSArray *)runLoopModes;

/**
 * In the event of an error, this method may be called during onSocket:willDisconnectWithError: to read
 * any data that's left on the socket.
**/
- (NSData *)unreadData;

/* A few common line separators, for use with the readDataToData:... methods. */
+ (NSData *)CRLFData;   // 0x0D0A
+ (NSData *)CRData;     // 0x0D
+ (NSData *)LFData;     // 0x0A
+ (NSData *)ZeroData;   // 0x00

@end




@interface FMTcpSocket : NSObject

- (id)initWithServer:(bool)server ipv6:(bool)ipv6 secure:(bool)secure;
- (bool)isServer;
- (bool)isSecure;
- (bool)ipv6;
- (bool)isClosed;
- (NSString *)localIPAddress;
- (int)localPort;
- (NSString *)remoteIPAddress;
- (int)remotePort;
- (void)bindWithIPAddress:(NSString*)ipAddress port:(int)port addressInUse:(bool*)addressInUse;
- (void)acceptAsyncWithAcceptArgs:(FMTcpAcceptArgs *)acceptArgs;
- (void)connectAsyncWithConnectArgs:(FMTcpConnectArgs*)connectArgs;
- (void)sendWithBuffer:(NSData *)buffer;
- (void)sendAsyncWithSendArgs:(FMTcpSendArgs*)sendArgs;
- (void)receiveAsyncWithReceiveArgs:(FMTcpReceiveArgs*)receiveArgs;
- (void)close;

@end



@interface FMUdpSocket : NSObject 

- (id)initWithIPv6:(bool)ipv6;
- (bool)ipv6;
- (bool)isClosed;
- (NSString *)localIPAddress;
- (int)localPort;
- (int)maxQueuedPackets;
- (void)setMaxQueuedPackets:(int)maxQueuedPackets;
- (void)bindWithIPAddress:(NSString*)ipAddress port:(int)port addressInUse:(bool*)addressInUse;
- (int)sendWithBuffer:(NSData*)buffer ipAddress:(NSString*)ipAddress port:(int)port;
- (void)sendAsyncWithSendArgs:(FMUdpSendArgs*)sendArgs;
- (bool)receiveAsyncWithReceiveArgs:(FMUdpReceiveArgs*)receiveArgs receiveSuccessArgs:(FMUdpReceiveSuccessArgs **)receiveSuccessArgs receiveFailureArgs:(FMUdpReceiveFailureArgs **)receiveFailureArgs receiveCompleteArgs:(FMUdpReceiveCompleteArgs **)receiveCompleteArgs;
- (void)close;

@end

//
//  FMNSLogProvider.h
//  FMIceLinkExample-iOS
//
//  Created by Anton Venema on 2012-09-24.
//  Copyright (c) 2012 Frozen Mountain Software. All rights reserved.
//



@interface FMNSLogProvider : FMLogProvider

+ (FMNSLogProvider *)nsLogProvider;
+ (FMNSLogProvider *)nsLogProviderWithLogLevel:(FMLogLevel)logLevel;

- (id)init;
- (id)initWithLogLevel:(FMLogLevel)logLevel;

@end


//
//  FMTextViewLogProvider.h
//  Mac.Client
//
//  Created by Anton Venema on 2013-04-17.
//  Copyright (c) 2013 Frozen Mountain Software LTD. All rights reserved.
//


#if TARGET_OS_IPHONE
#else
#endif


@interface FMTextViewLogProvider : FMLogProvider

#if TARGET_OS_IPHONE
+ (FMTextViewLogProvider *)textViewLogProviderWithTextView:(UITextView *)textView;
+ (FMTextViewLogProvider *)textViewLogProviderWithTextView:(UITextView *)textView logLevel:(FMLogLevel)logLevel;

- (id)initWithTextView:(UITextView *)textView;
- (id)initWithTextView:(UITextView *)textView logLevel:(FMLogLevel)logLevel;
#else
+ (FMTextViewLogProvider *)textViewLogProviderWithTextView:(NSTextView *)textView;
+ (FMTextViewLogProvider *)textViewLogProviderWithTextView:(NSTextView *)textView logLevel:(FMLogLevel)logLevel;

- (id)initWithTextView:(NSTextView *)textView;
- (id)initWithTextView:(NSTextView *)textView logLevel:(FMLogLevel)logLevel;
#endif

@end


