//
//  HLSDownloader.h
//  CastlabsSDK
//
//  Created by Guido Parente on 01/08/2017.
//  Copyright © 2017 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "HLSDownloadRequest.h"

/// Error domain for HLS Downloader
FOUNDATION_EXPORT const NSErrorDomain _Nonnull HLSDownloaderErrorDomain; // @"CLHLSDownloaderErrorDomain"

/// Error codes for HLS Downloader
FOUNDATION_EXPORT const NSInteger HLSDownloaderDownloadCreationFailed;

@class CLDrmConfiguration;
@class HLSDownload;

static NSString* _Nonnull const HLS_DOWNLOAD_CONFIGURATION = @"CLAssetDownloadConfigurationn";

/**
 * The HLSDownloader wraps the native HLS download API (AVAssetDownloadTask)
 *
 */
@interface HLSDownloader : NSObject

#pragma mark Properties

/**
 * If YES will suspend all the tasks when receive UIApplicationDidEnterBackgroundNotification
 * and then resume on application enters foreground (UIApplicationWillEnterForegroundNotification)
 *
 * Default value is NO
 *
 */
@property BOOL suspendDownloadsOnEnterBackground;

/**
* Retrieve the globally shared downloader instance. This downloader instance is configured to run
* without using cellular access for transfers equivalent to a
* downloader created using:
*
*   [[HLSDownloader alloc] initWithCellularAccess:NO];
*
* If you need a downloader with different characteristics it will need to be manually created and
* maintained using the other initializers available in this class.
*
* Must be called in didFinishLaunchingWithOptions to handle task recreation
*
*/
+ (nonnull HLSDownloader*)sharedDownloader NS_CLASS_AVAILABLE_IOS(10_0);

/**
 * Initialize a downloader instance with the given characteristics.
 *
 * @param[in] allowCellular Indicates if cellular access is allowed for the downloads.
 *
 */
- (nullable instancetype)initWithCellularAccess:(bool) allowCellular NS_CLASS_AVAILABLE_IOS(10_0);

/**
 * Default init is unavailable. See other initialization methods in this class
 *
 */
-(nonnull instancetype) init NS_UNAVAILABLE;

/**
 * Retrieve the dictionary <DownloadIdentifier, HLSDownload> of ongoing and completed downloads.
 *
 * @param[in] handler The completion handler to call.
 */
- (void) getAllDownloads:(void (^_Nullable)(NSDictionary<NSString*, HLSDownload*>* _Nonnull downloads))handler NS_CLASS_AVAILABLE_IOS(10_0);


/**
 * Retrieve the dictionary <Manifest, HLSDownload> of completed downloads.
 *
 * @param[in] handler The completion handler to call.
 */
- (void)getCompletedDownloads:(void (^_Nullable)(NSDictionary<NSString*, HLSDownload*>* _Nonnull completedDownloads))handler NS_CLASS_AVAILABLE_IOS(10_0);

/**
 * Create a download request. This method loads an Asset to allow the selection of audio and subtitle tracks before starting the download.
 *
 * @param[in] url An URL for a stream manifest.
 * @param[in] config A DRM Configuration for a stream.
 * @param[in] handler The completion handler to call.
 */
-(void) createDownloadRequest:(nonnull NSURL*)url
          andDrmConfiguration:(nullable CLDrmConfiguration *)config
            completionHandler:(void (^_Nonnull)(HLSDownloadRequest* _Nullable request))handler NS_CLASS_AVAILABLE_IOS(10_0);

/**
 * Start a download.
 *
 * @param[in] request An download request.
 */
-(void) startDownload:(nonnull HLSDownloadRequest*) request
          withHandler:(void (^_Nullable)(HLSDownload* _Nullable download, NSError* _Nullable error))handler NS_CLASS_AVAILABLE_IOS(10_0);

/**
 * Pause a given download
 *
 * @remark This method may throw an exception.
 */
- (void) suspend:(nonnull HLSDownload*) download NS_CLASS_AVAILABLE_IOS(10_0);

/**
 * Resume a given download
 *
 * @remark This method may throw an exception.
 */
- (void) resume:(nonnull HLSDownload*) download NS_CLASS_AVAILABLE_IOS(10_0);

/**
 * Cancel a given download
 *
 * @remark This method may throw an exception.
 */
- (void) cancel:(nonnull HLSDownload*) download NS_CLASS_AVAILABLE_IOS(10_0);

/**
 * Removes all local files related to a given download. If the download is running it will be cancelled before
 * removal.
 * @remark This method may throw an exception.
 */
- (bool) remove:(nonnull HLSDownload*) download NS_CLASS_AVAILABLE_IOS(10_0);

/**
 * Attempts an estimation of download size for selected renditions
 * @param handler An handler called with estimated size in bytes or -1 in case the calculation is not possible
 */
- (void) estimateDownloadSize:(HLSDownloadRequest*_Nonnull) request
        withCompletionHandler:(void (^_Nonnull)(int64_t))handler NS_CLASS_AVAILABLE_IOS(10_0);

/**
 * Returns an array of available stream quality descriptions
 */
- (void) getStreamQualities:(HLSDownloadRequest* _Nonnull)request
      withCompletionHandler:(void (^ _Nonnull)( NSArray<HLSStreamQuality*>* _Nonnull))handler;

#pragma mark Background Event Handling

/**
 * Calls the given completion handler once all queued events from a background session has been
 * processed. This API MUST be called from the application delegate
 * -[NSApplication application:handleEventsForBackgroundURLSession:completionHandler:] for
 * background downloads to work reliably.
 *
 * @param[in] completionHandler The completion handler to call.
 */
- (void)handleBackgroundEventsWithCompletionHandler:(void (^ _Nullable)(void))completionHandler;

@end
