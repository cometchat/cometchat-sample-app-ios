//
// Title: IceLink VPX Extension for Cocoa
// Version: 0.0.0.0
// Copyright Frozen Mountain Software 2011+
//

#import <Foundation/Foundation.h>

#import "FMIceLink.swift3.h"

@class FMIceLinkVpxNative;
@class FMIceLinkVpxTemporalLayerMode;
@class FMIceLinkVpxCodecWrapper;
@class FMIceLinkVpxDecoder;
@class FMIceLinkVpxEncoder;
@class FMIceLinkVpxBitDepth;
@class FMIceLinkVpxEndUsageMode;
@class FMIceLinkVpxKeyframeMode;
@class FMIceLinkVpxEncoderConfig;
@class FMIceLinkVpxErrorResilientType;
@class FMIceLinkVpxUtility;
@class FMIceLinkVp8Decoder;
@class FMIceLinkVp8Encoder;
@class FMIceLinkVp9Decoder;
@class FMIceLinkVp9Encoder;
/*!
 * <div>
 * A libvpx-based codec.
 * </div>
 */
typedef NS_ENUM(NSInteger, FMIceLinkVpxCodec) {
    /*!
     * <div>
     * Indicates the VP8 codec.
     * </div>
     */
    FMIceLinkVpxCodecVp8 = 1,
    /*!
     * <div>
     * Indicates the VP9 codec.
     * </div>
     */
    FMIceLinkVpxCodecVp9 = 2
};

/*!
 * <div>
 * Temporal layer modes for VPX output.
 * </div>
 */
@interface FMIceLinkVpxTemporalLayerMode : NSObject

/*!
 * <div>
 * Gets a the temporal layering mode VP9E_TEMPORAL_LAYERING_MODE_BYPASS.
 * </div>
 */
+ (FMIceLinkVpxTemporalLayerMode*) bypass;
/*!
 * <div>
 * Gets a the temporal layering mode VP9E_TEMPORAL_LAYERING_MODE_0101.
 * </div>
 */
+ (FMIceLinkVpxTemporalLayerMode*) mode0101;
/*!
 * <div>
 * Gets a the temporal layering mode VP9E_TEMPORAL_LAYERING_MODE_0212.
 * </div>
 */
+ (FMIceLinkVpxTemporalLayerMode*) mode0212;
/*!
 * <div>
 * Gets a the temporal layering mode VP9E_TEMPORAL_LAYERING_MODE_NOLAYERING.
 * </div>
 */
+ (FMIceLinkVpxTemporalLayerMode*) noLayering;
/*!
 * <div>
 * Gets the internal integer value representation of this temporal layer mode.
 * </div>
 */
- (int) value;

@end

@interface FMIceLinkVpxCodecWrapper : NSObject

- (NSString*) description;
- (instancetype) initWithValue:(FMIceLinkVpxCodec)value;

@end

/*!
 * <div>
 * A libvpx-based decoder.
 * </div>
 */
@interface FMIceLinkVpxDecoder : FMIceLinkVideoDecoder

/*!
 * <div>
 * Gets the current codec.
 * </div>
 */
- (FMIceLinkVpxCodec) codec;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVpxDecoder class.
 * </div>
 * @param inputFormat The input format.
 */
+ (FMIceLinkVpxDecoder*) decoderWithInputFormat:(FMIceLinkVideoFormat*)inputFormat;
/*!
 * <div>
 * Destroys this instance.
 * </div>
 */
- (void) doDestroy;
/*!
 * <div>
 * Processes a frame.
 * </div>
 * @param frame The frame.
 * @param inputBuffer The input buffer.
 */
- (void) doProcessFrame:(FMIceLinkVideoFrame*)frame inputBuffer:(FMIceLinkVideoBuffer*)inputBuffer;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVpxDecoder class.
 * </div>
 * @param inputFormat The input format.
 */
- (instancetype) initWithInputFormat:(FMIceLinkVideoFormat*)inputFormat;
/*!
 * <div>
 * Gets a value indicating whether the decoder needs a keyframe.
 * </div><value>
 * <code>true</code> if [needs key frame]; otherwise, <code>false</code>.
 * </value>
 */
- (bool) needsKeyFrame;

@end

/*!
 * <div>
 * A libvpx-based encoder.
 * </div>
 */
@interface FMIceLinkVpxEncoder : FMIceLinkVideoEncoder

/*!
 * <div>
 * Gets encoder bitrate.  Getting this value retrieves the current bitrate, whereas
 * setting it sets the target bitrate for the encoder.
 * </div><value>
 * The bitrate in kbps.
 * </value>
 */
- (int) bitrate;
/*!
 * <div>
 * Gets the current codec.
 * </div>
 */
- (FMIceLinkVpxCodec) codec;
/*!
 * <div>
 * Gets the encoder configuration.
 * </div>
 */
- (FMIceLinkVpxEncoderConfig*) codecConfig;
/*!
 * <div>
 * Destroys this instance.
 * </div>
 */
- (void) doDestroy;
/*!
 * <div>
 * Processes a frame.
 * </div>
 * @param frame The frame.
 * @param inputBuffer The input buffer.
 */
- (void) doProcessFrame:(FMIceLinkVideoFrame*)frame inputBuffer:(FMIceLinkVideoBuffer*)inputBuffer;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVpxEncoder class.
 * </div>
 * @param outputFormat The output format.
 */
+ (FMIceLinkVpxEncoder*) encoderWithOutputFormat:(FMIceLinkVideoFormat*)outputFormat;
/*!
 * <div>
 * Gets a value indicating whether a keyframe should be forced.
 * </div>
 */
- (bool) forceKeyFrame;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVpxEncoder class.
 * </div>
 * @param outputFormat The output format.
 */
- (instancetype) initWithOutputFormat:(FMIceLinkVideoFormat*)outputFormat;
/*!
 * <div>
 * Determines whether the [buffer] contains a Key Frame.
 * </div>
 * @param buffer The buffer.
 */
- (bool) isKeyFrameWithBuffer:(FMIceLinkDataBuffer*)buffer;
/*!
 * <div>
 * Gets the maximum bitrate this encoder will produce, based on the
 * encoder's target bitrate and the MaxInputBitrate of its' sinks.
 * </div>
 */
- (int) maxOutputBitrate;
/*!
 * <div>
 * Gets the target output quality.
 * </div><value>
 * The quality.
 * </value>
 */
- (double) quality;
/*!
 * <div>
 * Sets encoder bitrate.  Getting this value retrieves the current bitrate, whereas
 * setting it sets the target bitrate for the encoder.
 * </div><value>
 * The bitrate in kbps.
 * </value>
 */
- (void) setBitrate:(int)value;
/*!
 * <div>
 * Sets the encoder configuration.
 * </div>
 * @return 0 on success, non-zero on failure.
 */
- (int) setCodecConfig:(FMIceLinkVpxEncoderConfig*)config;
/*!
 * <div>
 * Sets a value indicating whether a keyframe should be forced.
 * </div>
 */
- (void) setForceKeyFrame:(bool)value;
/*!
 * <div>
 * Sets the target output quality.
 * </div><value>
 * The quality.
 * </value>
 */
- (void) setQuality:(double)value;

@end

/*!
 * <div>
 * Bit depths for VPX output.
 * </div>
 */
@interface FMIceLinkVpxBitDepth : NSObject

/*!
 * <div>
 * Gets a bit depth of 10 bits.
 * </div>
 */
+ (FMIceLinkVpxBitDepth*) bits10;
/*!
 * <div>
 * Gets a bit depth of 12 bits.
 * </div>
 */
+ (FMIceLinkVpxBitDepth*) bits12;
/*!
 * <div>
 * Gets a bit depth of 8 bits.
 * </div>
 */
+ (FMIceLinkVpxBitDepth*) bits8;
/*!
 * <div>
 * Gets the internal integer value representation of this end usage mode.
 * </div>
 */
- (int) value;

@end

/*!
 * <div>
 * End usage modes for VPX.
 * </div>
 */
@interface FMIceLinkVpxEndUsageMode : NSObject

/*!
 * <div>
 * Gets a KeyframeMode of type VPX_CBR.
 * </div>
 */
+ (FMIceLinkVpxEndUsageMode*) cbr;
/*!
 * <div>
 * Gets a KeyframeMode of type VPX_CQ.
 * </div>
 */
+ (FMIceLinkVpxEndUsageMode*) cq;
/*!
 * <div>
 * Gets a KeyframeMode of type VPX_Q.
 * </div>
 */
+ (FMIceLinkVpxEndUsageMode*) q;
/*!
 * <div>
 * Gets the internal integer value representation of this end usage mode.
 * </div>
 */
- (int) value;
/*!
 * <div>
 * Gets a KeyframeMode of type VPX_VBR.
 * </div>
 */
+ (FMIceLinkVpxEndUsageMode*) vbr;

@end

/*!
 * <div>
 * Keyframe modes for VPX.
 * </div>
 */
@interface FMIceLinkVpxKeyframeMode : NSObject

/*!
 * <div>
 * Gets a KeyframeMode of type Auto.
 * </div>
 */
+ (FMIceLinkVpxKeyframeMode*) auto;
/*!
 * <div>
 * Gets a KeyframeMode of type Disabled.
 * </div>
 */
+ (FMIceLinkVpxKeyframeMode*) disabled;
/*!
 * <div>
 * Gets a KeyframeMode of type Fixed. This is deprecated by VPX and is equivalent
 * to KeyframeMode.Disabled.  To generate keyframes at fixed intervals, set the
 * EncoderConfig.KeyframeMinDistance = EncoderConfig.KeyframeMaxDistance.
 * </div>
 */
+ (FMIceLinkVpxKeyframeMode*) fixed;
/*!
 * <div>
 * Gets the internal integer value representation of this keyframe mode.
 * </div>
 */
- (int) value;

@end

/*!
 * <div>
 * Config for the Vp8/Vp9 encoders. Properties map to VPX properties.
 * http://www.webmproject.org/docs/webm-sdk/structvpx__codec__enc__cfg.html
 * </div>
 */
@interface FMIceLinkVpxEncoderConfig : NSObject

/*!
 * <div>
 * Gets a value that maps to "g_bit_depth".
 * </div>
 */
- (FMIceLinkVpxBitDepth*) bitDepth;
/*!
 * <div>
 * Gets a value that maps to "rc_buf_initial_sz".
 * </div>
 */
- (int) bufferInitialSize;
/*!
 * <div>
 * Gets a value that maps to "rc_buf_optimal_sz".
 * </div>
 */
- (int) bufferOptimalSize;
/*!
 * <div>
 * Gets a value that maps to "rc_buf_sz".
 * </div>
 */
- (int) bufferSize;
/*!
 * <div>
 * Gets a value used for "VP8E_SET_CPUUSED". Range is [-16, 16] for VP8 and [-8, 8] for VP9.
 * </div>
 */
- (int) cpu;
/*!
 * <div>
 * Gets a deep copy of this configuration.
 * </div>
 */
- (FMIceLinkVpxEncoderConfig*) deepCopy;
/*!
 * <div>
 * Gets a value that maps to "rc_dropframe_thresh".
 * </div>
 */
- (int) dropFrameThreshold;
/*!
 * <div>
 * Creates a new copy of the VPX encoder configurations with default values.
 * </div>
 */
+ (FMIceLinkVpxEncoderConfig*) encoderConfig;
/*!
 * <div>
 * Gets a value that maps to "rc_end_usage".
 * </div>
 */
- (FMIceLinkVpxEndUsageMode*) endUsageMode;
/*!
 * <div>
 * Gets a value that maps to g_error_resilient
 * </div>
 */
- (int) errorResilient;
/*!
 * <div>
 * Creates a new copy of the VPX encoder configurations with default values.
 * </div>
 */
- (instancetype) init;
/*!
 * <div>
 * Gets a value that maps to "g_input_bit_depth".
 * </div>
 */
- (int) inputBitDepth;
/*!
 * <div>
 * Gets a value that maps to "kf_max_dist".
 * </div>
 */
- (int) keyframeMaxDistance;
/*!
 * <div>
 * Gets a value that maps to "kf_min_dist".
 * </div>
 */
- (int) keyframeMinDistance;
/*!
 * <div>
 * Gets a value that makes to "kf_mode".
 * </div>
 */
- (FMIceLinkVpxKeyframeMode*) keyframeMode;
/*!
 * <div>
 * Gets a value that maps to "g_lag_in_frames".
 * </div>
 */
- (int) lagInFrames;
/*!
 * <div>
 * Gets a value that maps to "layer_trget_bitrater".
 * </div>
 */
- (NSMutableArray*) layerTargetBitrate;
/*!
 * <div>
 * Gets a value that maps to "rc_max_quantizer". If -1, then Quality field used.
 * </div>
 */
- (int) maxQuantizer;
/*!
 * <div>
 * Gets a value that maps to "rc_min_quantizer".
 * </div>
 */
- (int) minQuantizer;
/*!
 * <div>
 * Gets a value that maps to "rc_overshoot_pct".
 * </div>
 */
- (int) overshootPercentage;
/*!
 * <div>
 * Gets a value that maps to "g_profile".
 * </div>
 */
- (int) profile;
/*!
 * <div>
 * Gets a value that maps to "rc_resize_allowed".
 * </div>
 */
- (bool) resizeAllowed;
/*!
 * <div>
 * Gets a value that maps to "rc_resize_down_thresh".
 * </div>
 */
- (int) resizeDownThreshold;
/*!
 * <div>
 * Gets a value that maps to "rc_resize_up_thresh".
 * </div>
 */
- (int) resizeUpThreshold;
/*!
 * <div>
 * Gets a value that maps to "rc_scaled_height".
 * </div>
 */
- (int) scaledHeight;
/*!
 * <div>
 * Gets a value that maps to "rc_scaled_width".
 * </div>
 */
- (int) scaledWidth;
/*!
 * <div>
 * Sets a value that maps to "g_bit_depth".
 * </div>
 */
- (void) setBitDepth:(FMIceLinkVpxBitDepth*)value;
/*!
 * <div>
 * Sets a value that maps to "rc_buf_initial_sz".
 * </div>
 */
- (void) setBufferInitialSize:(int)value;
/*!
 * <div>
 * Sets a value that maps to "rc_buf_optimal_sz".
 * </div>
 */
- (void) setBufferOptimalSize:(int)value;
/*!
 * <div>
 * Sets a value that maps to "rc_buf_sz".
 * </div>
 */
- (void) setBufferSize:(int)value;
/*!
 * <div>
 * Sets a value used for "VP8E_SET_CPUUSED". Range is [-16, 16] for VP8 and [-8, 8] for VP9.
 * </div>
 */
- (void) setCpu:(int)value;
/*!
 * <div>
 * Sets a value that maps to "rc_dropframe_thresh".
 * </div>
 */
- (void) setDropFrameThreshold:(int)value;
/*!
 * <div>
 * Sets a value that maps to "rc_end_usage".
 * </div>
 */
- (void) setEndUsageMode:(FMIceLinkVpxEndUsageMode*)value;
/*!
 * <div>
 * Sets a value that maps to g_error_resilient
 * </div>
 */
- (void) setErrorResilient:(int)value;
/*!
 * <div>
 * Sets a value that maps to "g_input_bit_depth".
 * </div>
 */
- (void) setInputBitDepth:(int)value;
/*!
 * <div>
 * Sets a value that maps to "kf_max_dist".
 * </div>
 */
- (void) setKeyframeMaxDistance:(int)value;
/*!
 * <div>
 * Sets a value that maps to "kf_min_dist".
 * </div>
 */
- (void) setKeyframeMinDistance:(int)value;
/*!
 * <div>
 * Sets a value that makes to "kf_mode".
 * </div>
 */
- (void) setKeyframeMode:(FMIceLinkVpxKeyframeMode*)value;
/*!
 * <div>
 * Sets a value that maps to "g_lag_in_frames".
 * </div>
 */
- (void) setLagInFrames:(int)value;
/*!
 * <div>
 * Sets a value that maps to "layer_trget_bitrater".
 * </div>
 */
- (void) setLayerTargetBitrate:(NSMutableArray*)value;
/*!
 * <div>
 * Sets a value that maps to "rc_max_quantizer". If -1, then Quality field used.
 * </div>
 */
- (void) setMaxQuantizer:(int)value;
/*!
 * <div>
 * Sets a value that maps to "rc_min_quantizer".
 * </div>
 */
- (void) setMinQuantizer:(int)value;
/*!
 * <div>
 * Sets a value that maps to "rc_overshoot_pct".
 * </div>
 */
- (void) setOvershootPercentage:(int)value;
/*!
 * <div>
 * Sets a value that maps to "g_profile".
 * </div>
 */
- (void) setProfile:(int)value;
/*!
 * <div>
 * Sets a value that maps to "rc_resize_allowed".
 * </div>
 */
- (void) setResizeAllowed:(bool)value;
/*!
 * <div>
 * Sets a value that maps to "rc_resize_down_thresh".
 * </div>
 */
- (void) setResizeDownThreshold:(int)value;
/*!
 * <div>
 * Sets a value that maps to "rc_resize_up_thresh".
 * </div>
 */
- (void) setResizeUpThreshold:(int)value;
/*!
 * <div>
 * Sets a value that maps to "rc_scaled_height".
 * </div>
 */
- (void) setScaledHeight:(int)value;
/*!
 * <div>
 * Sets a value that maps to "rc_scaled_width".
 * </div>
 */
- (void) setScaledWidth:(int)value;
/*!
 * <div>
 * Sets a value that maps to "ss_enable_auto_alt_ref".
 * </div>
 */
- (void) setSpatialEnableAutoAltRef:(NSMutableArray*)value;
/*!
 * <div>
 * Sets a value that maps to "ss_number_layers".
 * </div>
 */
- (void) setSpatialLayers:(int)value;
/*!
 * <div>
 * Sets a value that maps to "ss_target_bitrate".
 * </div>
 */
- (void) setSpatialTargetBitrate:(NSMutableArray*)value;
/*!
 * <div>
 * Sets a value that maps to "temporal_layering_mode".
 * </div>
 */
- (void) setTemporalLayerMode:(FMIceLinkVpxTemporalLayerMode*)value;
/*!
 * <div>
 * Sets a value that maps to "ts_number_layers".
 * </div>
 */
- (void) setTemporalLayers:(int)value;
/*!
 * <div>
 * Sets a value that maps to "ts_layer_id".
 * </div>
 */
- (void) setTemporalPattern:(NSMutableArray*)value;
/*!
 * <div>
 * Sets a value that maps to "ts_periodicity".
 * </div>
 */
- (void) setTemporalPeriodicity:(int)value;
/*!
 * <div>
 * Sets a value that maps to "ts_rate_decimator".
 * </div>
 */
- (void) setTemporalRateDecimator:(NSMutableArray*)value;
/*!
 * <div>
 * Sets a value that maps to "ts_target_bitrate".
 * </div>
 */
- (void) setTemporalTargetBitrate:(NSMutableArray*)value;
/*!
 * <div>
 * Sets a value that maps to "g_threads".
 * </div>
 */
- (void) setThreads:(int)value;
/*!
 * <div>
 * Sets a value that maps to "g_timebase.den".
 * </div>
 */
- (void) setTimebaseDenominator:(int)value;
/*!
 * <div>
 * Sets a value that maps to "g_timebase.num".
 * </div>
 */
- (void) setTimebaseNumerator:(int)value;
/*!
 * <div>
 * Sets a value that maps to "rc_undershoot_pct".
 * </div>
 */
- (void) setUndershootPercentage:(int)value;
/*!
 * <div>
 * Sets a value that maps to "g_usage".
 * </div>
 */
- (void) setUsage:(int)value;
/*!
 * <div>
 * Gets a value that maps to "ss_enable_auto_alt_ref".
 * </div>
 */
- (NSMutableArray*) spatialEnableAutoAltRef;
/*!
 * <div>
 * Gets a value that maps to "ss_number_layers".
 * </div>
 */
- (int) spatialLayers;
/*!
 * <div>
 * Gets a value that maps to "ss_target_bitrate".
 * </div>
 */
- (NSMutableArray*) spatialTargetBitrate;
/*!
 * <div>
 * Gets a value that maps to "temporal_layering_mode".
 * </div>
 */
- (FMIceLinkVpxTemporalLayerMode*) temporalLayerMode;
/*!
 * <div>
 * Gets a value that maps to "ts_number_layers".
 * </div>
 */
- (int) temporalLayers;
/*!
 * <div>
 * Gets a value that maps to "ts_layer_id".
 * </div>
 */
- (NSMutableArray*) temporalPattern;
/*!
 * <div>
 * Gets a value that maps to "ts_periodicity".
 * </div>
 */
- (int) temporalPeriodicity;
/*!
 * <div>
 * Gets a value that maps to "ts_rate_decimator".
 * </div>
 */
- (NSMutableArray*) temporalRateDecimator;
/*!
 * <div>
 * Gets a value that maps to "ts_target_bitrate".
 * </div>
 */
- (NSMutableArray*) temporalTargetBitrate;
/*!
 * <div>
 * Gets a value that maps to "g_threads".
 * </div>
 */
- (int) threads;
/*!
 * <div>
 * Gets a value that maps to "g_timebase.den".
 * </div>
 */
- (int) timebaseDenominator;
/*!
 * <div>
 * Gets a value that maps to "g_timebase.num".
 * </div>
 */
- (int) timebaseNumerator;
/*!
 * <div>
 * Gets a value that maps to "rc_undershoot_pct".
 * </div>
 */
- (int) undershootPercentage;
/*!
 * <div>
 * Gets a value that maps to "g_usage".
 * </div>
 */
- (int) usage;

@end

/*!
 * <div>
 * Error resiliency flags for VPX.
 * </div>
 */
@interface FMIceLinkVpxErrorResilientType : NSObject

/*!
 * <div>
 * Gets the flag position for VPX_ERROR_RESILIENT_DEFAULT.
 * </div>
 */
+ (int) default;
/*!
 * <div>
 * Gets the flag position for VPX_ERROR_RESILIENT_PARTITIONS.
 * </div>
 */
+ (int) partitions;

@end

/*!
 * <div>
 * VPX-related utility functions.
 * </div>
 */
@interface FMIceLinkVpxUtility : NSObject

- (instancetype) init;
/*!
 * <div>
 * Initializes VPX native libraries.
 * </div>
 */
+ (FMIceLinkFuture*) initialize;
+ (FMIceLinkVpxUtility*) utility;

@end

/*!
 * <div>
 * A libvpx-based VP8 decoder.
 * </div>
 */
@interface FMIceLinkVp8Decoder : FMIceLinkVpxDecoder

/*!
 * <div>
 * Gets the current codec.
 * </div>
 */
- (FMIceLinkVpxCodec) codec;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp8Decoder class.
 * </div>
 */
+ (FMIceLinkVp8Decoder*) decoder;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp8Decoder class.
 * </div>
 * @param input The input.
 */
+ (FMIceLinkVp8Decoder*) decoderWithInput:(NSObject<FMIceLinkIVideoOutput>*)input;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp8Decoder class.
 * </div>
 */
- (instancetype) init;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp8Decoder class.
 * </div>
 * @param input The input.
 */
- (instancetype) initWithInput:(NSObject<FMIceLinkIVideoOutput>*)input;
/*!
 * <div>
 * Determines whether a data buffer represents a keyframe.
 * </div>
 * @param dataBuffer The data buffer.
 */
- (bool) isKeyFrameWithDataBuffer:(FMIceLinkDataBuffer*)dataBuffer;
/*!
 * <div>
 * Gets a label that identifies this class.
 * </div>
 */
- (NSString*) label;

@end

/*!
 * <div>
 * A libvpx-based VP8 encoder.
 * </div>
 */
@interface FMIceLinkVp8Encoder : FMIceLinkVpxEncoder

/*!
 * <div>
 * Gets the current codec.
 * </div>
 */
- (FMIceLinkVpxCodec) codec;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp8Encoder class.
 * </div>
 */
+ (FMIceLinkVp8Encoder*) encoder;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp8Encoder class.
 * </div>
 * @param input The input.
 */
+ (FMIceLinkVp8Encoder*) encoderWithInput:(NSObject<FMIceLinkIVideoOutput>*)input;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp8Encoder class.
 * </div>
 */
- (instancetype) init;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp8Encoder class.
 * </div>
 * @param input The input.
 */
- (instancetype) initWithInput:(NSObject<FMIceLinkIVideoOutput>*)input;
/*!
 * <div>
 * Determines whether the [buffer] contains a Key Frame.
 * </div>
 * @param buffer The buffer.
 */
- (bool) isKeyFrameWithBuffer:(FMIceLinkDataBuffer*)buffer;
/*!
 * <div>
 * Gets a label that identifies this class.
 * </div>
 */
- (NSString*) label;

@end

/*!
 * <div>
 * A libvpx-based VP9 decoder.
 * </div>
 */
@interface FMIceLinkVp9Decoder : FMIceLinkVpxDecoder

/*!
 * <div>
 * Gets the current codec.
 * </div>
 */
- (FMIceLinkVpxCodec) codec;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp9Decoder class.
 * </div>
 */
+ (FMIceLinkVp9Decoder*) decoder;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp9Decoder class.
 * </div>
 * @param input The input.
 */
+ (FMIceLinkVp9Decoder*) decoderWithInput:(NSObject<FMIceLinkIVideoOutput>*)input;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp9Decoder class.
 * </div>
 */
- (instancetype) init;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp9Decoder class.
 * </div>
 * @param input The input.
 */
- (instancetype) initWithInput:(NSObject<FMIceLinkIVideoOutput>*)input;
/*!
 * <div>
 * Determines whether a data buffer represents a keyframe.
 * </div>
 * @param dataBuffer The data buffer.
 */
- (bool) isKeyFrameWithDataBuffer:(FMIceLinkDataBuffer*)dataBuffer;
/*!
 * <div>
 * Gets a label that identifies this class.
 * </div>
 */
- (NSString*) label;

@end

/*!
 * <div>
 * A libvpx-based VP9 encoder.
 * </div>
 */
@interface FMIceLinkVp9Encoder : FMIceLinkVpxEncoder

/*!
 * <div>
 * Gets the current codec.
 * </div>
 */
- (FMIceLinkVpxCodec) codec;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp9Encoder class.
 * </div>
 */
+ (FMIceLinkVp9Encoder*) encoder;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp9Encoder class.
 * </div>
 * @param input The input.
 */
+ (FMIceLinkVp9Encoder*) encoderWithInput:(NSObject<FMIceLinkIVideoOutput>*)input;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp9Encoder class.
 * </div>
 */
- (instancetype) init;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkVp9Encoder class.
 * </div>
 * @param input The input.
 */
- (instancetype) initWithInput:(NSObject<FMIceLinkIVideoOutput>*)input;
/*!
 * <div>
 * Determines whether the [buffer] contains a Key Frame.
 * </div>
 * @param buffer The buffer.
 */
- (bool) isKeyFrameWithBuffer:(FMIceLinkDataBuffer*)buffer;
/*!
 * <div>
 * Gets a label that identifies this class.
 * </div>
 */
- (NSString*) label;

@end

