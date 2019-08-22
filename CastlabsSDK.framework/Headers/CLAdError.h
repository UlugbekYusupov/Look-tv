//
//  CLAdError.h
//  CastlabsSDK
//
//  Created by Guido Parente on 11/05/2016.
//  Copyright © 2016 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark AdErrorType

/**
 *  Possible error types while loading or playing ads.
 */
typedef NS_ENUM(NSInteger, CLAdErrorType){
    /**
     *  An unexpected error occured while loading or playing the ads.
     *  This may mean that the SDK wasn't loaded properly.
     */
    kAdUnknownErrorType,
    /**
     *  An error occured while loading the ads.
     */
    kAdLoadingFailed,
    /**
     *  An error occured while playing the ads.
     */
    kAdPlayingFailed,
};

#pragma mark - ErrorCode

/**
 *  Possible error codes raised while loading or playing ads.
 */
typedef NS_ENUM(NSInteger, CLAdErrorCode){
    /**
     *  The ad response was not recognized as a valid VAST ad.
     */
    kError_VAST_MALFORMED_RESPONSE = 100,
    /**
     *  The ad response was not understood and cannot be parsed.
     */
    kError_UNKNOWN_AD_RESPONSE = 200,
    /**
     *  The VAST URI provided, or a VAST URI provided in a subsequent Wrapper
     *  element, was either unavailable or reached a timeout, as defined by the
     *  video player. The timeout is 8 seconds for initial VAST requests and 4
     *  seconds for each subsequent Wrapper.
     */
    kError_VAST_LOAD_TIMEOUT = 301,
    /**
     *  The maximum number of VAST wrapper redirects has been reached.
     */
    kError_VAST_TOO_MANY_REDIRECTS = 302,
    /**
     *  At least one VAST wrapper loaded and a subsequent wrapper or inline ad
     *  load has resulted in a 404 response code.
     */
    kError_VAST_INVALID_URL = 303,
    /**
     *   There was an error playing the video ad.
     */
    kError_VIDEO_PLAY_ERROR = 400,
    
    /**
     *  Failed to load media assets from a VAST response.
     *  The default timeout for media loading is 15 seconds.
     */
    kError_VAST_MEDIA_LOAD_TIMEOUT = 402,
    /**
     *  Assets were found in the VAST ad response for linear ad, but none of them
     *  matched the video player's capabilities.
     */
    kError_VAST_LINEAR_ASSET_MISMATCH = 403,
    /**
     *  A companion ad failed to load or render.
     */
    kError_COMPANION_AD_LOADING_FAILED = 603,
    /**
     *  An unexpected error occurred and the cause is not known. Refer to the
     *  inner error for more information.
     */
    kError_UNKNOWN_ERROR = 900,
    /**
     *  Ads list response was malformed.
     */
    kError_PLAYLIST_MALFORMED_RESPONSE = 1004,
    /**
     *  There was a problem requesting ads from the server.
     */
    kError_FAILED_TO_REQUEST_ADS = 1005,
    /**
     *  Listener for at least one of the required vast events was not added.
     */
    kError_REQUIRED_LISTENERS_NOT_ADDED = 1006,
    /**
     *  No assets were found in the VAST ad response.
     */
    kError_VAST_ASSET_NOT_FOUND = 1007,
    /**
     *  The ad slot is not visible on the page.
     */
    kError_ADSLOT_NOT_VISIBLE = 1008,
    /**
     *  Empty VAST response.
     */
    kError_VAST_EMPTY_RESPONSE = 1009,
    /**
     *  There was an error loading the ad.
     */
    kError_FAILED_LOADING_AD = 1010,
    /**
     *  There was an error initializing the stream.
     */
    kError_STREAM_INITIALIZATION_FAILED = 1020,
    /**
     *  Invalid arguments were provided to SDK methods.
     */
    kError_INVALID_ARGUMENTS = 1101,
    /**
     *  Generic invalid usage of the API.
     */
    kError_API_ERROR = 1102,
    /**
     *  The version of the runtime is too old.
     */
    kError_IOS_RUNTIME_TOO_OLD = 1103,
    /**
     *  Another VideoAdsManager is still using the video. It must be unloaded
     *  before another ad can play on the same element.
     */
    kError_VIDEO_ELEMENT_USED = 1201,
    /**
     *  A video element was not specified where it was required.
     */
    kError_VIDEO_ELEMENT_REQUIRED = 1202,
    /**
     *  Content playhead was not passed in, but list of ads has been returned
     *  from the server.
     */
    kError_CONTENT_PLAYHEAD_MISSING = 1205,
};

@interface CLAdError : NSObject

/// The type of error that occured during ad loading or ad playing.
@property(nonatomic) CLAdErrorType type;

/// The error code for obtaining more specific information about the error.
@property(nonatomic) CLAdErrorCode code;

///A brief description about the error.
@property(nonatomic, copy) NSString *message;

@end
