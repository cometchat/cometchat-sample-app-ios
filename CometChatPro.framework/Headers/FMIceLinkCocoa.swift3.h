//
// Title: IceLink Cocoa Extension for Cocoa
// Version: 0.0.0.0
// Copyright Frozen Mountain Software 2011+
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#if !TARGET_OS_TV
#import <VideoToolbox/VideoToolbox.h>
#endif
#if TARGET_OS_IPHONE
#import <GLKit/GLKit.h>
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

#import "FMIceLink.swift3.h"

@class FMIceLinkCocoaAudioUnitSink;
@class FMIceLinkCocoaAudioUnitSource;
@class FMIceLinkCocoaAVCapturePreview;
@class FMIceLinkCocoaAVCaptureSource;
@class FMIceLinkCocoaImageUtility;
@class FMIceLinkCocoaImageViewSink;
@class FMIceLinkCocoaLayoutContainer;
@class FMIceLinkCocoaLayoutManager;
@class FMIceLinkCocoaOpenGLSink;
@class FMIceLinkCocoaOpenGLView;
@class FMIceLinkCocoaScreenSource;
@class FMIceLinkCocoaUtility;
@class FMIceLinkCocoaVideoToolboxH264Decoder;
@class FMIceLinkCocoaVideoToolboxH264Encoder;

#if TARGET_OS_IPHONE


@interface FMIceLinkVideoConfig (FMIceLinkCocoaExtensions)

- (instancetype)initWithPreset:(NSString *)preset frameRate:(int)frameRate;
- (instancetype)initWithPreset:(NSString *)preset frameRate:(int)frameRate clockRate:(int)clockRate;
- (NSString *)preset;
@end

#endif



#if TARGET_OS_IPHONE
#else
#endif

#if TARGET_OS_IPHONE
#define FM_VIEW UIView
#define FM_IMAGE UIImage
#define FM_IMAGE_VIEW UIImageView
#define FM_RECT CGRect
#else
#define FM_VIEW NSView
#define FM_IMAGE NSImage
#define FM_IMAGE_VIEW NSImageView
#define FM_RECT NSRect
#endif


@interface FMIceLinkCocoaImageUtility : NSObject

+ (FMIceLinkVideoBuffer *)imageToBuffer:(FM_IMAGE *)image;
+ (FM_IMAGE *)bufferToImage:(FMIceLinkVideoBuffer *)buffer;
+ (FMIceLinkVideoBuffer *)cgImageToBuffer:(CGImageRef)cgImage;
+ (CGImageRef)bufferToCGImage:(FMIceLinkVideoBuffer *)buffer;

@end



@interface FMIceLinkCocoaAudioUnitSource : FMIceLinkAudioSource

- (bool)useVoiceProcessingIO;
- (void)setUseVoiceProcessingIO:(bool)useVoiceProcessingIO;
- (bool)bypassVoiceProcessing;
- (void)setBypassVoiceProcessing:(bool)bypassVoiceProcessing;
- (bool)voiceProcessingEnableAGC;
- (void)setVoiceProcessingEnableAGC:(bool)voiceProcessingEnableAGC;
#if TARGET_OS_IPHONE
- (bool)observeInterruptions;
- (void)setObserveInterruptions:(bool)observeInterruptions;
#endif

/* static init */ + (instancetype)audioUnitSourceWithConfig:(FMIceLinkAudioConfig *)config;
- (instancetype)initWithConfig:(FMIceLinkAudioConfig *)config;

@end




@interface FMIceLinkCocoaAudioUnitSink : FMIceLinkAudioSink

- (bool)useVoiceProcessingIO;
- (void)setUseVoiceProcessingIO:(bool)useVoiceProcessingIO;

/* static init */ + (instancetype)audioUnitSinkWithConfig:(FMIceLinkAudioConfig *)config;
- (instancetype)initWithConfig:(FMIceLinkAudioConfig *)config;
/* static init */ + (instancetype)audioUnitSinkWithInput:(NSObject *)input;
- (instancetype)initWithInput:(NSObject *)input;
/* static init */ + (instancetype)audioUnitSinkWithInputs:(NSMutableArray *)inputs;
- (instancetype)initWithInputs:(NSMutableArray *)inputs;

@end


#if !TARGET_OS_TV

#if TARGET_OS_IPHONE



@interface FMIceLinkCocoaAVCapturePreview : UIView

@property FMIceLinkLayoutScale scale;
@property bool mirror;
@property bool muted;

/* static init */ + (instancetype)avCapturePreview;
- (instancetype)init;
/* static init */ + (instancetype)avCapturePreviewWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame;

@end

#endif

#endif


#if !TARGET_OS_TV

#if TARGET_OS_IPHONE
#endif


@interface FMIceLinkCocoaAVCaptureSource : FMIceLinkVideoSource

- (FMIceLinkVideoConfig*)config;
- (void)setConfig:(FMIceLinkVideoConfig*)config;
- (AVCaptureSession *)session;
- (AVCaptureDevice *)device;

#if TARGET_OS_IPHONE
- (FMIceLinkSourceInput *)frontInput;
- (FMIceLinkSourceInput *)backInput;
#endif

#if TARGET_OS_IPHONE
/* static init */ + (instancetype)avCaptureSourceWithPreview:(FMIceLinkCocoaAVCapturePreview *)preview config:(FMIceLinkVideoConfig *)config;
- (instancetype)initWithPreview:(FMIceLinkCocoaAVCapturePreview *)preview config:(FMIceLinkVideoConfig *)config;
#else
/* static init */ + (instancetype)avCaptureSourceWithConfig:(FMIceLinkVideoConfig *)config;
- (instancetype)initWithConfig:(FMIceLinkVideoConfig *)config;
#endif

@end

#endif




@interface FMIceLinkCocoaImageViewSink : FMIceLinkViewSink

/* static init */ + (instancetype)imageViewSink;
- (instancetype)init;
/* static init */ + (instancetype)imageViewSinkWithInput:(NSObject *)input;
- (instancetype)initWithInput:(NSObject *)input;
/* static init */ + (instancetype)imageViewSinkWithInputs:(NSMutableArray *)inputs;
- (instancetype)initWithInputs:(NSMutableArray *)inputs;
/* static init */ + (instancetype)imageViewSinkWithView:(FM_IMAGE_VIEW *)view;
- (instancetype)initWithView:(FM_IMAGE_VIEW *)view;
/* static init */ + (instancetype)imageViewSinkWithView:(FM_IMAGE_VIEW *)view input:(NSObject *)input;
- (instancetype)initWithView:(FM_IMAGE_VIEW *)view input:(NSObject *)input;
/* static init */ + (instancetype)imageViewSinkWithView:(FM_IMAGE_VIEW *)view inputs:(NSMutableArray *)inputs;
- (instancetype)initWithView:(FM_IMAGE_VIEW *)view inputs:(NSMutableArray *)inputs;

- (void)renderBufferWithInputBuffer:(FMIceLinkVideoBuffer *)buffer;
- (void)renderImage:(FM_IMAGE *)image;

@end




@protocol FMIceLinkCocoaLayoutContainerDelegate;

@interface FMIceLinkCocoaLayoutContainer : FM_VIEW

@property (nonatomic, assign) id delegate;

@end

@protocol FMIceLinkCocoaLayoutContainerDelegate

- (void)layoutContainer:(FMIceLinkCocoaLayoutContainer *)layoutContainer didSetFrame:(FM_RECT)frame;

@end



@interface FMIceLinkCocoaLayoutManager : FMIceLinkLayoutManager

- (FM_VIEW *)container;

/* static init */ + (instancetype)layoutManagerWithContainer:(FM_VIEW *)container;
- (instancetype)initWithContainer:(FM_VIEW *)container;
/* static init */ + (instancetype)layoutManagerWithContainer:(FM_VIEW *)container preset:(FMIceLinkLayoutPreset *)preset;
- (instancetype)initWithContainer:(FM_VIEW *)container preset:(FMIceLinkLayoutPreset *)preset;

@end


#if TARGET_OS_IPHONE



@interface FMIceLinkCocoaOpenGLView : UIView

- (FMIceLinkLayoutScale)scale;

/* static init */ + (instancetype)openGLView;
- (instancetype)init;
/* static init */ + (instancetype)openGLViewWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame;
/* static init */ + (instancetype)openGLViewWithFrame:(CGRect)frame scale:(FMIceLinkLayoutScale)scale;
- (instancetype)initWithFrame:(CGRect)frame scale:(FMIceLinkLayoutScale)scale;
/* static init */ + (instancetype)openGLViewWithScale:(FMIceLinkLayoutScale)scale;
- (instancetype)initWithScale:(FMIceLinkLayoutScale)scale;

@end

#endif




#if TARGET_OS_IPHONE



@interface FMIceLinkCocoaOpenGLSink : FMIceLinkViewSink

/* static init */ + (instancetype)openGLSink;
- (instancetype)init;
/* static init */ + (instancetype)openGLSinkWithInput:(NSObject *)input;
- (instancetype)initWithInput:(NSObject *)input;
/* static init */ + (instancetype)openGLSinkWithInputs:(NSMutableArray *)inputs;
- (instancetype)initWithInputs:(NSMutableArray *)inputs;
/* static init */ + (instancetype)openGLSinkWithViewScale:(FMIceLinkLayoutScale)viewScale;
- (instancetype)initWithViewScale:(FMIceLinkLayoutScale)viewScale;
/* static init */ + (instancetype)openGLSinkWithViewScale:(FMIceLinkLayoutScale)viewScale input:(NSObject *)input;
- (instancetype)initWithViewScale:(FMIceLinkLayoutScale)viewScale input:(NSObject *)input;
/* static init */ + (instancetype)openGLSinkWithViewScale:(FMIceLinkLayoutScale)viewScale inputs:(NSMutableArray *)inputs;
- (instancetype)initWithViewScale:(FMIceLinkLayoutScale)viewScale inputs:(NSMutableArray *)inputs;
/* static init */ + (instancetype)openGLSinkWithView:(FMIceLinkCocoaOpenGLView *)view;
- (instancetype)initWithView:(FMIceLinkCocoaOpenGLView *)view;
/* static init */ + (instancetype)openGLSinkWithView:(FMIceLinkCocoaOpenGLView *)view input:(NSObject *)input;
- (instancetype)initWithView:(FMIceLinkCocoaOpenGLView *)view input:(NSObject *)input;
/* static init */ + (instancetype)openGLSinkWithView:(FMIceLinkCocoaOpenGLView *)view inputs:(NSMutableArray *)inputs;
- (instancetype)initWithView:(FMIceLinkCocoaOpenGLView *)view inputs:(NSMutableArray *)inputs;

- (void)renderBufferWithInputBuffer:(FMIceLinkVideoBuffer *)buffer;

@end

#endif



#if TARGET_OS_IPHONE
#endif


@interface FMIceLinkCocoaScreenSource : FMIceLinkVideoSource

/* static init */ + (instancetype)screenSourceWithFrameRate:(int)frameRate;
- (instancetype)initWithFrameRate:(int)frameRate;
#if TARGET_OS_IPHONE
/* static init */ + (instancetype)screenSourceWithFrameRate:(int)frameRate view:(UIView *)view;
- (instancetype)initWithFrameRate:(int)frameRate view:(UIView *)view;
#endif

@end

#if !TARGET_OS_TV
#if TARGET_OS_IPHONE
#endif


@class FMIceLinkVideoEncoder;
@class FMIceLinkVideoFrame;
@class FMIceLinkVideoBuffer;
@class FMIceLinkVideoFormat;
@protocol FMIceLinkIVideoOutput;
@class NSStringFMIceLinkExtensions;

@interface FMIceLinkCocoaVideoToolboxH264Encoder : FMIceLinkVideoEncoder

/*!
 * 
 * Gets the target output bitrate.
 * 
 * The bitrate.
 * 
 */
- (int) bitrate;
/*!
 * 
 * Destroys this instance.
 * 
 */
- (void) doDestroy;
/*!
 * 
 * Processes a frame.
 * 
 * @param frame The frame.
 * @param inputBuffer The input buffer.
 * @param outputFormat The output format.
 */
- (void) doProcessFrame:(FMIceLinkVideoFrame*)frame inputBuffer:(FMIceLinkVideoBuffer*)inputBuffer;
/*!
 * 
 * Processes an SDP media description.
 * 
 * @param mediaDescription The media description.
 * @param isOffer if set to true [is offer].
 * @param isLocalDescription if set to true [is local description].
 */
- (FMIceLinkError*) doProcessSdpMediaDescription:(FMIceLinkSdpMediaDescription*)mediaDescription isOffer:(bool)isOffer isLocalDescription:(bool)isLocalDescription;
/*!
 * 
 * Gets a value indicating whether a keyframe should be forced.
 * 
 */
- (bool) forceKeyFrame;
/*!
 * 
 * Initializes a new instance of the FMIceLinkOpenH264Encoder class.
 * 
 * @param input The input.
 */
/* static init */ + (instancetype) videoToolboxH264EncoderWithInput:(NSObject*)input;
- (instancetype) initWithInput:(NSObject*)input;
/*!
 * 
 * Gets a label that identifies this class.
 * 
 */
- (NSString*) label;
/*!
 * 
 * Gets the profile level identifier.
 * 
 * The profile level identifier.
 * 
 */
- (FMIceLinkH264ProfileLevelId*) profileLevelId;
/*!
 * 
 * Gets the target output quality.
 * 
 * The quality.
 * 
 */
- (double) quality;
/*!
 * 
 * Sets the target output bitrate.
 * 
 * The bitrate.
 * 
 */
- (void) setBitrate:(int)value;
/*!
 * 
 * Sets a value indicating whether a keyframe should be forced.
 * 
 */
- (void) setForceKeyFrame:(bool)value;
/*!
 * 
 * Sets the target output quality.
 * 
 * The quality.
 * 
 */
- (void) setQuality:(double)value;
/*!
 * 
 * Gets the max payload size.
 * 
 * The max payload size.
 * 
 */
- (int) maxPayloadSize;
/*!
 * 
 * Sets the max payload size.
 * 
 * The max payload size.
 * 
 */
- (void) setMaxPayloadSize:(int)value;
/*!
 * 
 * Gets the supported profile idcs. Currently, only baseline is supported.
 * 
 * The supported profile idcs.
 * 
 */
- (NSMutableArray*) supportedProfileIdcs;


- (void)encodeWithBuffer:(FMIceLinkVideoBuffer*)buffer frame:(FMIceLinkVideoFrame*)frame outputFormat:(FMIceLinkVideoFormat*)outputFormat;

- (void)receiveCompressSampleBuffer:(CMSampleBufferRef)sampleBuffer outputFormat:(FMIceLinkVideoFormat*)outputFormat frame:(FMIceLinkVideoFrame*)frame width:(int)width height:(int)height;
- (void)receiveCompressFailure:(OSStatus)status;

/* static init */ + (instancetype) videoToolboxH264Encoder;
- (instancetype) init;
@end

#endif


#if !TARGET_OS_TV
#if TARGET_OS_IPHONE
#endif


@protocol FMIceLinkIVideoOutput;
@class FMIceLinkVideoFrame;
@class FMIceLinkVideoBuffer;
@class FMIceLinkVideoFormat;
@class FMIceLinkError;
@class FMIceLinkSdpMediaDescription;
@class NSStringFMIceLinkExtensions;

/// 
/// An VideoToolbox-based decoder.
/// 
#pragma clang diagnostic ignored "-Wshorten-64-to-32"
#pragma clang diagnostic ignored "-Wint-to-pointer-cast"

@interface FMIceLinkCocoaVideoToolboxH264Decoder : FMIceLinkVideoDecoder

@property bool debugMode;
@property bool needsKeyFrame;


- (void)decodeWithEncodedFrame:(FMIceLinkVideoBuffer*)buffer frame:(FMIceLinkVideoFrame*)frame outputFormat:(FMIceLinkVideoFormat*)outputFormat;
- (void)destroy;

- (void)receiveDecompressImageBuffer:(CVImageBufferRef)imageBuffer outputFormat:(FMIceLinkVideoFormat*)outputFormat frame:(FMIceLinkVideoFrame*)frame;
- (void)receiveDecompressFailure:(OSStatus)status infoFlags:(VTDecodeInfoFlags)infoFlags;

/// 
/// Initializes a new instance of the  class.
/// 
/* static init */ + (instancetype) videoToolboxH264Decoder;
- (instancetype) init;
/// 
/// Initializes a new instance of the  class.
/// 
/// The input.
/* static init */ + (instancetype) videoToolboxH264DecoderWithInput:(NSObject*)input;
- (instancetype) initWithInput:(NSObject*)input;
/// 
/// Gets a label that identifies this class.
/// 
- (NSString*) label;
@end
#endif


