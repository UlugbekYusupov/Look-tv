//
//  HLSDownloadRequest.h
//  CastlabsSDK
//
//  Created by Guido Parente on 28/08/2017.
//  Copyright © 2017 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class CLDrmConfiguration;

@interface HLSStreamQuality: NSObject

/**
 * Corresponds to the AVERAGE-BANDWIDTH attribute off the #EXT-X-STREAM-INF Master playlist tag
 * It represents the average segment bit rate of the Variant Stream.
 */
@property (nonatomic) int64_t averageBitrate;

/**
 * Corresponds to the BANDWIDTH attribute if the #EXT-X-STREAM-INF Master playlist tag
 */
@property (nonatomic) int64_t bitrate;

/** Resolution width */
@property (nonatomic) int64_t resolutionWidth;

/** Resolution height */
@property (nonatomic) int64_t resolutionHeight;

@end

@interface HLSDownloadRequest : NSObject

/** Stream master playlist URL */
@property (nonnull, readonly) NSURL* streamUrl;

/** Stream DRM configuration (optional) */
@property (nullable, readonly) CLDrmConfiguration* drmConfig;

/** Stream audio tracks available for download */
@property (nullable, readonly) AVMediaSelectionGroup* audioTracks;

/** Stream subtitle tracks available for download */
@property (nullable, readonly) AVMediaSelectionGroup* subtitleTracks;

/*!
 * A human readable title for this asset. Will show up in the usage pane of the settings app.
 * If not set, we fall-back to the content url
 *
 * @remark We found that having a forward slash in assetTitle causes download to fail with error
 *         "Error Domain=AVFoundationErrorDomain Code=-11800 "The operation could not be completed"
 *         This is a native bug still present in iOS 11.2.6
 *         Since we don't know if other chars can cause the same error, we play it safe and replace with a space all chars
 *         except these ones https://developer.apple.com/documentation/foundation/nscharacterset/1407466-alphanumericcharacterset
 */
@property (nonnull) NSString* assetTitle;

/*!
* NSData representing artwork data for this asset. Optional. Will show up in the usage pane of the settings app.
* Must work with +[UIImage imageWithData:].
*/
@property (nullable) NSData* assetArtworkData;

/**
 * Set your preferred video bitrate to be downloaded.
 * The lowest media bitrate greater than or equal to this value will be selected for download
 * If no suitable media bitrate is found, the highest media bitrate will be selected.
 * Value is expressed in bps.
 */
@property int64_t preferredBitrate;

/** Current tracks selected for download */
@property (nullable, readonly) AVMutableMediaSelection* mediaSelection;

/** Select an audio track to be downloaded */
-(void) selectAudioOption:(nonnull AVMediaSelectionOption*) option;

/** Select a subtitle track to be downloaded */
-(void) selectSubtitleOption:(nonnull AVMediaSelectionOption*) option;

/**
 * Utility method that returs a track description that matches one of the user's preferred system languages.
 * If no preferred language is found, the default one is used
 */
+ (nullable NSString*)localizedDescriptionForTrackOption:(nonnull AVMediaSelectionOption*)option;

/**
 * @remark Do not use this method directly. Use [HLSDownloader createDownloadRequest] instead
 */
-(nullable instancetype) initWithUrl:(nonnull NSURL*) url andDrmConfiguration:(nullable CLDrmConfiguration*)config;

@end
