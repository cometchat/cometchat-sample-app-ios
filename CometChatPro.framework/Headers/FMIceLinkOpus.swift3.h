//
// Title: IceLink Opus Extension for Cocoa
// Version: 0.0.0.0
// Copyright Frozen Mountain Software 2011+
//

#import <Foundation/Foundation.h>

#import "FMIceLink.swift3.h"

@class FMIceLinkOpusNative;
@class FMIceLinkOpusExpertFrameDuration;
@class FMIceLinkOpusSignal;
@class FMIceLinkOpusBandwidth;
@class FMIceLinkOpusDecoder;
@class FMIceLinkOpusEncoder;
@class FMIceLinkOpusApplicationType;
@class FMIceLinkOpusEncoderConfig;
@class FMIceLinkOpusUtility;
/*!
 * <div>
 * Frame durations for Opus, used when updating the "OPUS_SET_EXPERT_FRAME_DURATION_REQUEST"
 * (EncoderConfig.ExpertFrameDuration) configuration.
 * </div>
 */
@interface FMIceLinkOpusExpertFrameDuration : NSObject

/*!
 * <div>
 * Gets a frame duration of Opus "OPUS_FRAMESIZE_ARG".
 * </div>
 */
+ (FMIceLinkOpusExpertFrameDuration*) argument;
/*!
 * <div>
 * Gets a frame duration of Opus "OPUS_FRAMESIZE_10_MS".
 * </div>
 */
+ (FMIceLinkOpusExpertFrameDuration*) size10ms;
/*!
 * <div>
 * Gets a frame duration of Opus "OPUS_FRAMESIZE_2_5_MS".
 * </div>
 */
+ (FMIceLinkOpusExpertFrameDuration*) size2_5ms;
/*!
 * <div>
 * Gets a frame duration of Opus "OPUS_FRAMESIZE_20_MS".
 * </div>
 */
+ (FMIceLinkOpusExpertFrameDuration*) size20ms;
/*!
 * <div>
 * Gets a frame duration of Opus "OPUS_FRAMESIZE_40_MS".
 * </div>
 */
+ (FMIceLinkOpusExpertFrameDuration*) size40ms;
/*!
 * <div>
 * Gets a frame duration of Opus "OPUS_FRAMESIZE_5_MS".
 * </div>
 */
+ (FMIceLinkOpusExpertFrameDuration*) size5ms;
/*!
 * <div>
 * Gets a frame duration of Opus "OPUS_FRAMESIZE_60_MS".
 * </div>
 */
+ (FMIceLinkOpusExpertFrameDuration*) size60ms;
/*!
 * <div>
 * Gets the internal integer value representation of this frame duration.
 * </div>
 */
- (int) value;
/*!
 * <div>
 * Gets a frame duration of Opus "OPUS_FRAMESIZE_VARIABLE".
 * </div>
 */
+ (FMIceLinkOpusExpertFrameDuration*) variable;

@end

/*!
 * <div>
 * Signal types for Opus, used when updating the "OPUS_SET_SIGNAL_REQUEST" (EncoderConfig.Signal) configuration.
 * </div>
 */
@interface FMIceLinkOpusSignal : NSObject

/*!
 * <div>
 * Gets an signal type of Opus "OPUS_AUTO".
 * </div>
 */
+ (FMIceLinkOpusSignal*) auto;
/*!
 * <div>
 * Gets an signal type of Opus "OPUS_SIGNAL_MUSIC".
 * </div>
 */
+ (FMIceLinkOpusSignal*) music;
/*!
 * <div>
 * Gets the internal integer value representation of this signal.
 * </div>
 */
- (int) value;
/*!
 * <div>
 * Gets an signal type of Opus "OPUS_SIGNAL_VOICE".
 * </div>
 */
+ (FMIceLinkOpusSignal*) voice;

@end

/*!
 * <div>
 * Audio bandwidths for Opus, used when updating the "OPUS_SET_BANDWIDTH" (EncoderConfig.Bandwidth) or
 * "OPUS_SET_MAX_BANDWIDTH" (EncoderConfig.MaxBandwidth) configuration.
 * </div>
 */
@interface FMIceLinkOpusBandwidth : NSObject

/*!
 * <div>
 * Gets a bandwidth of Opus "OPUS_AUTO".
 * </div>
 */
+ (FMIceLinkOpusBandwidth*) auto;
/*!
 * <div>
 * Gets a bandwidth of Opus "OPUS_BANDWIDTH_FULLBAND".
 * </div>
 */
+ (FMIceLinkOpusBandwidth*) fullBand;
/*!
 * <div>
 * Gets a bandwidth of Opus "OPUS_BANDWIDTH_MEDIUMBAND".
 * </div>
 */
+ (FMIceLinkOpusBandwidth*) mediumBand;
/*!
 * <div>
 * Gets a bandwidth of Opus "OPUS_BANDWIDTH_NARROWBAND".
 * </div>
 */
+ (FMIceLinkOpusBandwidth*) narrowBand;
/*!
 * <div>
 * Gets a bandwidth of Opus "OPUS_BANDWIDTH_SUPERWIDEBAND".
 * </div>
 */
+ (FMIceLinkOpusBandwidth*) superWideBand;
/*!
 * <div>
 * Gets the internal integer value representation of this signal.
 * </div>
 */
- (int) value;
/*!
 * <div>
 * Gets a bandwidth of Opus "OPUS_BANDWIDTH_WIDEBAND".
 * </div>
 */
+ (FMIceLinkOpusBandwidth*) wideBand;

@end

/*!
 * <div>
 * A libopus-based decoder.
 * </div>
 */
@interface FMIceLinkOpusDecoder : FMIceLinkAudioDecoder

/*!
 * <div>
 * Initializes a new instance of the FMIceLinkOpusDecoder class.
 * </div>
 */
+ (FMIceLinkOpusDecoder*) decoder;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkOpusDecoder class.
 * </div>
 * @param config The configuration.
 */
+ (FMIceLinkOpusDecoder*) decoderWithConfig:(FMIceLinkAudioConfig*)config;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkOpusDecoder class.
 * </div>
 * @param input The input.
 */
+ (FMIceLinkOpusDecoder*) decoderWithInput:(NSObject<FMIceLinkIAudioOutput>*)input;
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
- (void) doProcessFrame:(FMIceLinkAudioFrame*)frame inputBuffer:(FMIceLinkAudioBuffer*)inputBuffer;
/*!
 * <div>
 * Processes a SDP media description.
 * </div>
 * @param mediaDescription The media description.
 * @param isOffer if set to true [is offer].
 * @param isLocalDescription if set to true [is local description].
 */
- (FMIceLinkError*) doProcessSdpMediaDescription:(FMIceLinkSdpMediaDescription*)mediaDescription isOffer:(bool)isOffer isLocalDescription:(bool)isLocalDescription;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkOpusDecoder class.
 * </div>
 */
- (instancetype) init;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkOpusDecoder class.
 * </div>
 * @param config The configuration.
 */
- (instancetype) initWithConfig:(FMIceLinkAudioConfig*)config;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkOpusDecoder class.
 * </div>
 * @param input The input.
 */
- (instancetype) initWithInput:(NSObject<FMIceLinkIAudioOutput>*)input;
/*!
 * <div>
 * Gets a label that identifies this class.
 * </div>
 */
- (NSString*) label;

@end

/*!
 * <div>
 * A libopus-based encoder.
 * </div>
 */
@interface FMIceLinkOpusEncoder : FMIceLinkAudioEncoder

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
 * Gets a copy of the encoder codec's config.
 * </div>
 */
- (FMIceLinkOpusEncoderConfig*) codecConfig;
/*!
 * <div>
 * Gets a value indicating whether FEC is disabled.
 * </div>
 */
- (bool) disableFec;
/*!
 * <div>
 * Destroys this instance.
 * </div>
 */
- (void) doDestroy;
/*!
 * <div>
 * Processes the control frames.
 * </div>
 * @param controlFrames The control frames.
 */
- (void) doProcessControlFrames:(NSMutableArray*)controlFrames;
/*!
 * <div>
 * Processes a frame.
 * </div>
 * @param frame The frame.
 * @param inputBuffer The input buffer.
 */
- (void) doProcessFrame:(FMIceLinkAudioFrame*)frame inputBuffer:(FMIceLinkAudioBuffer*)inputBuffer;
/*!
 * <div>
 * Processes a SDP media description.
 * </div>
 * @param mediaDescription The media description.
 * @param isOffer if set to true [is offer].
 * @param isLocalDescription if set to true [is local description].
 */
- (FMIceLinkError*) doProcessSdpMediaDescription:(FMIceLinkSdpMediaDescription*)mediaDescription isOffer:(bool)isOffer isLocalDescription:(bool)isLocalDescription;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkOpusEncoder class.
 * </div>
 */
+ (FMIceLinkOpusEncoder*) encoder;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkOpusEncoder class.
 * </div>
 * @param config The configuration.
 */
+ (FMIceLinkOpusEncoder*) encoderWithConfig:(FMIceLinkAudioConfig*)config;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkOpusEncoder class.
 * </div>
 * @param input The input.
 */
+ (FMIceLinkOpusEncoder*) encoderWithInput:(NSObject<FMIceLinkIAudioOutput>*)input;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkOpusEncoder class.
 * </div>
 */
- (instancetype) init;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkOpusEncoder class.
 * </div>
 * @param config The configuration.
 */
- (instancetype) initWithConfig:(FMIceLinkAudioConfig*)config;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkOpusEncoder class.
 * </div>
 * @param input The input.
 */
- (instancetype) initWithInput:(NSObject<FMIceLinkIAudioOutput>*)input;
/*!
 * <div>
 * Gets a label that identifies this class.
 * </div>
 */
- (NSString*) label;
/*!
 * <div>
 * Gets the maximum bitrate this encoder will produce, based on the
 * encoder's target bitrate and the MaxInputBitrate of its' sinks.
 * </div>
 */
- (int) maxOutputBitrate;
/*!
 * <div>
 * Gets the loss percentage (0-100)
 * before forward error correction (FEC) is
 * activated (only if supported by the remote peer).
 * Affects encoded data only.
 * </div>
 */
- (int) percentLossToTriggerFEC;
/*!
 * <div>
 * Gets the quality.
 * </div>
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
- (int) setCodecConfig:(FMIceLinkOpusEncoderConfig*)config;
/*!
 * <div>
 * Sets a value indicating whether FEC is disabled.
 * </div>
 */
- (void) setDisableFec:(bool)value;
/*!
 * <div>
 * Sets the loss percentage (0-100)
 * before forward error correction (FEC) is
 * activated (only if supported by the remote peer).
 * Affects encoded data only.
 * </div>
 */
- (void) setPercentLossToTriggerFEC:(int)value;
/*!
 * <div>
 * Sets the quality.
 * </div>
 */
- (void) setQuality:(double)value;

@end

/*!
 * <div>
 * Application types for Opus, used when updating the "OPUS_SET_APPLICATION" (EncoderConfig.Application) configuration.
 * </div>
 */
@interface FMIceLinkOpusApplicationType : NSObject

/*!
 * <div>
 * Gets an application type of Opus "OPUS_APPLICATION_AUDIO".
 * </div>
 */
+ (FMIceLinkOpusApplicationType*) audio;
/*!
 * <div>
 * Gets an application type of Opus "OPUS_APPLICATION_RESTRICTED_LOWDELAY".
 * </div>
 */
+ (FMIceLinkOpusApplicationType*) restrictedLowDelay;
/*!
 * <div>
 * Gets the internal integer value representation of this application type.
 * </div>
 */
- (int) value;
/*!
 * <div>
 * Gets an application type of Opus "OPUS_APPLICATION_VOIP".
 * </div>
 */
+ (FMIceLinkOpusApplicationType*) voip;

@end

/*!
 * <div>
 * Configuration for the Opus encoder. Properties map to Opus controls.
 * http://www.opus-codec.org/
 * </div>
 */
@interface FMIceLinkOpusEncoderConfig : NSObject

/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_APPLICATION".
 * </div>
 */
- (FMIceLinkOpusApplicationType*) application;
/*!
 * <div>
 * Gets the integral value that maps to the Opus "OPUS_AUTO" constant. Several int configuration
 * properties can be set to this value.
 * </div>
 */
+ (int) auto;
/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_BANDWIDTH".
 * </div>
 */
- (FMIceLinkOpusBandwidth*) bandwidth;
/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_COMPLEXITY".
 * </div>
 */
- (int) complexity;
/*!
 * <div>
 * Gets a deep copy of this configuration.
 * </div>
 */
- (FMIceLinkOpusEncoderConfig*) deepCopy;
/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_DTX".
 * </div>
 */
- (int) dtx;
/*!
 * <div>
 * Creates a new copy of the Opus encoder configurations with default values.
 * </div>
 */
+ (FMIceLinkOpusEncoderConfig*) encoderConfig;
/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_EXPERT_FRAME_DURATION".
 * </div>
 */
- (FMIceLinkOpusExpertFrameDuration*) expertFrameDuration;
/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_FORCE_CHANNELS".
 * </div>
 */
- (int) forceChannels;
/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_INBAND_FEC".
 * </div>
 */
- (bool) forwardErrorCorrection;
/*!
 * <div>
 * Creates a new copy of the Opus encoder configurations with default values.
 * </div>
 */
- (instancetype) init;
/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_PREDICTION_DISABLED".
 * </div>
 */
- (bool) isPredictionDisabled;
/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_VBR".
 * </div>
 */
- (bool) isVbr;
/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_MAX_BANDWIDTH".
 * </div>
 */
- (FMIceLinkOpusBandwidth*) maxBandwidth;
/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_PACKET_LOSS_PERC".
 * </div>
 */
- (int) packetLossPercent;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_APPLICATION".
 * </div>
 */
- (void) setApplication:(FMIceLinkOpusApplicationType*)value;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_BANDWIDTH".
 * </div>
 */
- (void) setBandwidth:(FMIceLinkOpusBandwidth*)value;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_COMPLEXITY".
 * </div>
 */
- (void) setComplexity:(int)value;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_DTX".
 * </div>
 */
- (void) setDtx:(int)value;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_EXPERT_FRAME_DURATION".
 * </div>
 */
- (void) setExpertFrameDuration:(FMIceLinkOpusExpertFrameDuration*)value;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_FORCE_CHANNELS".
 * </div>
 */
- (void) setForceChannels:(int)value;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_INBAND_FEC".
 * </div>
 */
- (void) setForwardErrorCorrection:(bool)value;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_PREDICTION_DISABLED".
 * </div>
 */
- (void) setIsPredictionDisabled:(bool)value;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_VBR".
 * </div>
 */
- (void) setIsVbr:(bool)value;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_MAX_BANDWIDTH".
 * </div>
 */
- (void) setMaxBandwidth:(FMIceLinkOpusBandwidth*)value;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_PACKET_LOSS_PERC".
 * </div>
 */
- (void) setPacketLossPercent:(int)value;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_SIGNAL".
 * </div>
 */
- (void) setSignal:(FMIceLinkOpusSignal*)value;
/*!
 * <div>
 * Sets a value that maps to "OPUS_SET_VBR_CONSTRAINT".
 * </div>
 */
- (void) setUseConstrainedVBR:(bool)value;
/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_SIGNAL".
 * </div>
 */
- (FMIceLinkOpusSignal*) signal;
/*!
 * <div>
 * Gets a value that maps to "OPUS_SET_VBR_CONSTRAINT".
 * </div>
 */
- (bool) useConstrainedVBR;

@end

/*!
 * <div>
 * Opus-related utility functions.
 * </div>
 */
@interface FMIceLinkOpusUtility : NSObject

- (instancetype) init;
/*!
 * <div>
 * Initializes Opus native libraries.
 * </div>
 */
+ (FMIceLinkFuture*) initialize;
+ (FMIceLinkOpusUtility*) utility;

@end

