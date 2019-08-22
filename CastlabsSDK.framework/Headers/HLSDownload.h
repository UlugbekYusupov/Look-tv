//
//  HLSDownload.h
//  CastlabsSDK
//
//  Created by Guido Parente on 22/08/2017.
//  Copyright © 2017 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HLSDownloadState) {
    HLSDownloadStateRunning = 0,                     /* The task is currently being serviced by the session */
    HLSDownloadStateSuspended = 1,                  /* The task is currently suspended */
    HLSDownloadStateCanceling = 2,                   /* The task has been told to cancel.*/
    HLSDownloadStateCompleted = 3,                  /* The task has completed succesfully */
    HLSDownloadStateFailed = 4                      /* The task has failed */
};

@interface HLSDownload : NSObject

/// Current download state
@property (readonly, nonatomic) HLSDownloadState state;

// Content original url
@property (readonly, nonnull) NSString* originalUrl;

/// Content local path relative to home folder.
/// This value is set to nil if the content has not completely downloaded
@property (readonly, nullable)  NSString* destinationPath;

/// Expected content duration in seconds
@property (readonly) float expectedContentDuration;

/// Downloaded content duration in seconds
@property (readonly) float downloadedContentDuration;

/// Expected content size in bytes
@property (readonly) float expectedContentSize;

/// Downloaded content size in bytes
@property (readonly) float downloadedContentSize;

/// Download average bitrate
@property (readonly) int64_t bitrate;

/// Error when download failed
@property (readonly, nullable) NSError *error;

/// Returns true if the download was completed succesfully
/// Equivalent to HLSDownloadStateCompleted state
- (bool) isSuccessful;

/// Called when download is completed but failed
- (void) downloadFailedWithError:(nonnull NSError *)error;

/// A unique identifier for this download
@property (readonly, nonnull) NSString* uuid;

@end
