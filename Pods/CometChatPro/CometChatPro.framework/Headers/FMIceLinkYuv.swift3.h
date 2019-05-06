//
// Title: IceLink YUV Extension for Cocoa
// Version: 0.0.0.0
// Copyright Frozen Mountain Software 2011+
//

#import <Foundation/Foundation.h>

#import "FMIceLink.swift3.h"

@class FMIceLinkYuvNative;
@class FMIceLinkYuvFilterMode;
@class FMIceLinkYuvImageConverter;
@class FMIceLinkYuvImageScaler;
@class FMIceLinkYuvUtility;
/*!
 * <div>
 * A filter mode.
 * </div>
 */
@interface FMIceLinkYuvFilterMode : NSObject

/*!
 * <div>
 * Gets the value indicating bilinear.
 * This is faster than box, but produces lower quality.
 * </div>
 */
+ (int) bilinear;
/*!
 * <div>
 * Gets the value indicating box.
 * This is the slowest option, but produces the highest quality.
 * </div>
 */
+ (int) box;
+ (FMIceLinkYuvFilterMode*) filterMode;
- (instancetype) init;
/*!
 * <div>
 * Gets the value indicating linear (horizontal only).
 * This is faster than bilinear, but produces lower quality.
 * </div>
 */
+ (int) linear;
/*!
 * <div>
 * Gets the value indicating no filter (point sample).
 * This is the fastest option, but produces the lowest quality.
 * </div>
 */
+ (int) none;

@end

/*!
 * <div>
 * A libyuv-based image converter.
 * </div>
 */
@interface FMIceLinkYuvImageConverter : FMIceLinkVideoPipe

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
 * Gets the filter mode.
 * </div>
 */
- (int) filterMode;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageConverter class.
 * </div>
 * @param input The input.
 * @param outputFormat The output format.
 */
+ (FMIceLinkYuvImageConverter*) imageConverterWithInput:(NSObject<FMIceLinkIVideoOutput>*)input outputFormat:(FMIceLinkVideoFormat*)outputFormat;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageConverter class.
 * </div>
 * @param inputFormat The input format.
 * @param outputFormat The output format.
 */
+ (FMIceLinkYuvImageConverter*) imageConverterWithInputFormat:(FMIceLinkVideoFormat*)inputFormat outputFormat:(FMIceLinkVideoFormat*)outputFormat;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageConverter class.
 * </div>
 * @param inputs The inputs.
 * @param outputFormat The output format.
 */
+ (FMIceLinkYuvImageConverter*) imageConverterWithInputs:(NSMutableArray*)inputs outputFormat:(FMIceLinkVideoFormat*)outputFormat;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageConverter class.
 * </div>
 * @param outputFormat The output format.
 */
+ (FMIceLinkYuvImageConverter*) imageConverterWithOutputFormat:(FMIceLinkVideoFormat*)outputFormat;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageConverter class.
 * </div>
 * @param input The input.
 * @param outputFormat The output format.
 */
- (instancetype) initWithInput:(NSObject<FMIceLinkIVideoOutput>*)input outputFormat:(FMIceLinkVideoFormat*)outputFormat;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageConverter class.
 * </div>
 * @param inputFormat The input format.
 * @param outputFormat The output format.
 */
- (instancetype) initWithInputFormat:(FMIceLinkVideoFormat*)inputFormat outputFormat:(FMIceLinkVideoFormat*)outputFormat;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageConverter class.
 * </div>
 * @param inputs The inputs.
 * @param outputFormat The output format.
 */
- (instancetype) initWithInputs:(NSMutableArray*)inputs outputFormat:(FMIceLinkVideoFormat*)outputFormat;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageConverter class.
 * </div>
 * @param outputFormat The output format.
 */
- (instancetype) initWithOutputFormat:(FMIceLinkVideoFormat*)outputFormat;
/*!
 * <div>
 * Gets a label that identifies this class.
 * </div>
 */
- (NSString*) label;
/*!
 * <div>
 * Gets the scale.
 * </div>
 */
- (double) scale;
/*!
 * <div>
 * Sets the filter mode.
 * </div>
 */
- (void) setFilterMode:(int)value;
/*!
 * <div>
 * Sets the scale.
 * </div>
 */
- (void) setScale:(double)value;

@end

/*!
 * <div>
 * A libyuv-based image scaler.
 * </div>
 */
@interface FMIceLinkYuvImageScaler : FMIceLinkVideoPipe

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
 * Gets the filter mode.
 * </div>
 */
- (int) filterMode;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageScaler class.
 * </div>
 * @param scale The scale.
 */
+ (FMIceLinkYuvImageScaler*) imageScalerWithScale:(double)scale;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageScaler class.
 * </div>
 * @param scale The scale.
 * @param input The input.
 */
+ (FMIceLinkYuvImageScaler*) imageScalerWithScale:(double)scale input:(NSObject<FMIceLinkIVideoOutput>*)input;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageScaler class.
 * </div>
 * @param scale The scale.
 * @param inputs The inputs.
 */
+ (FMIceLinkYuvImageScaler*) imageScalerWithScale:(double)scale inputs:(NSMutableArray*)inputs;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageScaler class.
 * </div>
 * @param scale The scale.
 */
- (instancetype) initWithScale:(double)scale;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageScaler class.
 * </div>
 * @param scale The scale.
 * @param input The input.
 */
- (instancetype) initWithScale:(double)scale input:(NSObject<FMIceLinkIVideoOutput>*)input;
/*!
 * <div>
 * Initializes a new instance of the FMIceLinkYuvImageScaler class.
 * </div>
 * @param scale The scale.
 * @param inputs The inputs.
 */
- (instancetype) initWithScale:(double)scale inputs:(NSMutableArray*)inputs;
/*!
 * <div>
 * Gets a label that identifies this class.
 * </div>
 */
- (NSString*) label;
/*!
 * <div>
 * Gets the scale.
 * </div>
 */
- (double) scale;
/*!
 * <div>
 * Sets the filter mode.
 * </div>
 */
- (void) setFilterMode:(int)value;
/*!
 * <div>
 * Sets the scale.
 * </div>
 */
- (void) setScale:(double)value;

@end

/*!
 * <div>
 * YUV-related utility functions.
 * </div>
 */
@interface FMIceLinkYuvUtility : NSObject

- (instancetype) init;
/*!
 * <div>
 * Initializes YUV native libraries.
 * </div>
 */
+ (FMIceLinkFuture*) initialize;
+ (FMIceLinkYuvUtility*) utility;

@end

