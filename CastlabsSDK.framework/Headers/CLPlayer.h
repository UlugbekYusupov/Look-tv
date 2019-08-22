#ifndef CLPlayer_h
#define CLPlayer_h

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

#import "CLPlayerTrackDescription.h"
#import "CLPlayerListenerProtocol.h"
#import "AVPlayerExtensionPoint.h"
#import "CLPlayerVideoDescription.h"
#import "CLAnalyticsSession.h"
#import "CLThumb.h"
#import "CLSubtitlesStyle.h"
#import "CLContentMetadata.h"

@protocol PlayerListenerProtocol;
@protocol CLAdsListener;
@protocol CLImageDownloader;
@class CLAdError;
@class CLDrmConfiguration;
@class SubtitlesView;
@class CLGridThumbnail;

typedef NS_ENUM(NSUInteger, CLContentType) {
    kContentHLS = 1,
    kContentDASH = 2,
    kContentSmoothStreaming = 3,
    kContentMP4 = 4,
    kContentPIFF = 5,
    kContentRemoteMP4 = 6,
    kContentOther = 100,
    kContentUnknown = 101,
};

typedef NS_ENUM(NSUInteger, CLSubtitleFormat) {
    kSubtitleTTML = 1,
    kSubtitleWebVTT = 2,
    kSubtitleSRT = 3
};

/*!
 @protocol  CLPlayer
 
 @brief Player controller API
 
 @discussion This controller implementation allows you to control and manage the video player instance and receive feedback from it.
	An instance of this class can be obtained using the factory methods of CLPlayerFactory
 @see CLPlayerFactory
 @author castLabs
 @copyright  Copyright © 2015 castLabs
 */
@protocol CLPlayer <NSObject>
@required

/*!
	@brief Opens the given URL to the video.
	@discussion The player will start to load the resources and when it's ready
		will change the status of playback to STATE_READY
	@return true if no error occurred, false otherwise
 */
- (BOOL) open;

/*!
	@brief Start playback.
	@discussion The player must be in STATE_READY or STATE_PAUSED for this to have effect
    @remark Must be called after [open]
*/
- (void) play;

/*!
	@brief Pause playback.
	@discussion The player must be in STATE_PLAYING or STATE_STALLED for this to have effect.
 */
- (void) pause;

/*!
	@brief Stop playback and release resources
	@discussion After calling this, you need to allocate the player again if you want to restart playback
 */
- (void) stop;

/*!
	@brief Seek to desired time
	@discussion The player might not be able to seek exactly to your desired time and will choose the closest earlier frame. Once the seek operation completes the player will transition to STATE_READY.
	@param time Time to seek
 */
- (void) seek:(CMTime) time;

/*!
	@brief Returns the number of audio tracks
	@return NSUInteger Number of audio tracks
 */
- (NSUInteger) numberOfAudioOptions;

/*!
	@brief Returns a textual description of an audio track
	@param index Audio track index
	@return CLPlayerTrackDescription Description of audio track or nil if the index is not found
 */
- ( CLPlayerTrackDescription* _Nullable ) describeAudioOption:(NSUInteger)index;

/*!
	@brief Returns current audio track index
	@return NSUInteger Current audio track index
 */
- (NSUInteger) currentAudioOption;

/*!
	@brief Returns the number of subtitle tracks
	@return NSUInteger Number of subtitle tracks
 */
- (NSUInteger) numberOfSubtitleOptions;

/*!
	@brief Returns a textual description of an subtitle track
	@param index Subtitle track index
	@return CLPlayerTrackDescription Description of subtitle track or nil if the index is not found
 */
- (CLPlayerTrackDescription* _Nullable) describeSubtitleOption:(NSInteger)index;

/*!
    @brief Returns information about the video track along with the available qualities
    @remark This method works only for DASH and SmoothStreaming stream
 */
- (CLPlayerVideoDescription* _Nonnull) describeVideoTrack;

/*!
    @brief Select a fixed video quality or -1 to disable manual selection
    @discussion The list of qualities can be retrieved from [describeVideoTrack].qualities. Calling this method before [player play] forces playback to start from that quality. If the method is used throughout the playback you may experience a small delay for the change to take effect.
    @remark Works only for DASH and SmoothStreaming stream
 */
- (void) selectVideoQuality:(int) quality;

/*!
 @brief Returns the selected video track quality or -1 if no quality was selected
 @remark Works only for DASH and SmoothStreaming stream
 */
- (int) getSelectedVideoQuality;

/*!
	@brief Returns current subtitle track index
	@return NSUInteger Current subtitle track index
 */
- (NSInteger) currentSubtitleOption;

/*!
	@brief Select audio track
	@param index Adio track index
 */
- (void) selectAudioOption:(NSUInteger)index;

/*!
	@brief Select subtitle track
	@param index Subtitle track index
 */
- (void) selectSubtitleOption:(NSInteger)index;

/*!
	@brief Disable current subtitles (if any)
 */
-(void) disableSubtitles;

/*!
	@brief Side-load subtitles content from a URL.
	Downloads and parses the subtitles content (if a supported format types).
	Creates a new subtitle track appended after any existing subtitle tracks.
	@discussion  This requires the Subtitles Plug-in.
	The Subtitles Plug-in is not currently used for local files.
	Subtitle tracks exist only during playback, therefore this function
	can only create tracks during that time-frame.
	@param url location of the subtitle content file
    @param subtitleFormat Format of subtitle
    @param displayName label of a subtitle
    @param languageCode string defined in <a href="https://www.ietf.org/rfc/rfc5646.txt">RFC5646</a>
	@return Track Index or -1 if failed
    @remark The player must be at least in STATE_READY for this to have effect
 */

-(size_t) addSubtitlesTrackFromUrl:(nonnull NSURL*)url
                        withFormat:(CLSubtitleFormat)subtitleFormat
                   withDisplayName:(nullable NSString*)displayName
                  withLanguageCode:(nullable NSString*) languageCode;

/*!
     @brief Set max supported resolution.
	@param width max width supported
    @param height max height supported
    @remark Must be called before [open]
 */
-(void) setMaxResolutionWithWidth: (int) width andHeight:(int) height;

/*!
    @brief Download license for current asset
    @discussion If the license was succesfully loaded the event EVENT_LICENSE_LOADED will be triggered from callback CLPlayerListenerProtocol::onEvent:
        If an error will occur, the event ERROR_DRM_ERROR will be triggered from callback CLPlayerListenerProtocol::onError:
 */
- (void) prefetchLicense;
   
/*! Current playback position */
@property (nonatomic, assign) CMTime position;

/*! Total playback time */
@property (nonatomic, readonly) CMTime duration;

/*! Seeking ranges (for live streams) */
@property (nonatomic, readonly)  NSArray<NSValue *> * __nullable seekableTimeRanges;

/*! True if player is in STATE_PLAYING*/
@property (readonly) BOOL isPlaying;

/*! True if player is in STATE_FINISHED*/
@property (readonly) BOOL isEnded;

@property CLSubtitlesStyle* __nullable subtitleStyle;

@property NSPointerArray* _Nullable playerListeners;
- (void)addListener:(nonnull __weak id<CLPlayerListenerProtocol>)listener;
- (void)removeListener:(nonnull __weak id<CLPlayerListenerProtocol>)listener;

/*! Current player state*/
@property (readonly) StateID state;

/*! Returns player layer*/
@property (readonly) CALayer* _Nonnull playerView;

/*! Returns video content size */
- (CGSize)getVideoContentSize;

/*! Returns canvas size */
- (CGSize)getCanvasSize;

/*! @brief Indicates whether the player allows playback of HD content The default value is YES.
    @remark Must be called before [open] */
@property (nonatomic) BOOL HDenabled;

/*! @brief Indicates whether the player should seek exactly to the required seeking position (default) or to the beginning of the corresponding segment.
 @discussion Using the former will always start playback from the requested time, never rendering any samples
    before that time (but decoding if necessary). A drawback of this is that the perceived time it
    takes to seek may increase a bit from the users perspective and that it may cause buffer
    starvation under low bandwidth conditions (because the samples not rendered are read as fast as
    possible).
    
 The latter will start playback at the first frame of the corresponding segment. The drawback here is
    that the user won't get the exact requested time.
 
 @remark Works only for DASH and SmoothStreaming streams. The HLS streams are always seeked to the required position.
 @remark Must be called before [open] */
@property (nonatomic) BOOL secondPrecisionSeeking;

/*! @brief Indicates whether the player should continue the playback in the background. The default value is NO.
    @discussion Besides setting this flas to 'true' please add the UIBackgroundModes key in your app's Info.plist file. Its value is an array that contains one or more strings that identify which background tasks your application supports. Specify the string value "audio"
    @remark Works only for audio-only streams
    @remark Must be called before [open] */
@property (nonatomic) BOOL continuePlaybackInTheBackground;

/*! @brief Information about current video quality */
@property (readonly) CLVideoTrackQuality* _Nonnull quality;

/*! @brief Returns underlining AVPLayer
	@remark Works only for HLS stream
	@remark Should be used for debugging purpose mainly. Using this object to modify the playback may lead to unexpected and conflicting behaviour with our API.
 */
@property (readonly) AVPlayer* _Nullable avPlayer;

/*! @brief Returns underlining SubtitlesView
	@remark Works only for DASH and SmoothStreaming streams
	@remark Use the view if you want to try customizing the subtitles yourself but be aware that we will not provide support for this
*/
@property (readonly) SubtitlesView* _Nullable subtitlesView;

/// DRM Configuration for current item
@property (readonly) CLDrmConfiguration* _Nullable drmConfiguration;

/*! @brief Indicates whether the player should hold the STATE_READY event until the selected subtitle track is loaded. The default value is NO.
    @discussion You can use the [player selectSubtitleOption:] before calling [player open] to preselect the subtitle track
    @remark Works only for DASH/SmoothStreams streams
    @remark Must be called before [open] */
@property bool playbackWaitsUntilSubtitlesLoad;

/*! @brief Metadata for the current item. This information are used by different plugins (analytics, chromecast)
 @remark Must be called before [open]
 */
@property  CLContentMetadata* _Nullable metadata;

/*! Array of registered analytics sessions */
@property NSMutableArray<CLAnalyticsSession*>* _Nullable analyticsSessions;

/*! Optional delegate for defining extra behaviour into analytics session */
@property(nonatomic) id<CLAnalyticsDelegate> _Nullable analyticsDelegate;

/*! The player is able to start automatically the Analytics session but it must be stopped manually with this method */
-(void) stopAnalyticsSession;

@property NSPointerArray* _Nullable adsListeners;
- (void)addAdListener:(nonnull __weak id<CLAdsListener>)listener;
- (void)removeAdListener:(nonnull __weak id<CLAdsListener>)listener;

-(void) setCustomHTTPHeaders:(nonnull NSDictionary*) headers;

/*! Current url to play*/
@property (readonly) NSString* _Nonnull manifestUrl;

/*! In the case of downloaded stream, you can set with this property the original manifest url*/
@property NSString* _Nonnull originalManifestUrl;

/*!
 @discussion A value of 1.0 (default) plays the current item at its natural rate. Setting to 0.5 slow down the playback; 1.5 or 2.0 speed it up
 @remark DASH/SmoothStreaming streams mute for rates != 1
 @remark Must be called after [play] */
@property float playbackRate;

/*!
 @discussion Custom protocol scheme that is used by the player to trigger a Fairplay request. The default values is `skd` but it can be overwrtitten using this property */
@property NSString* _Nonnull fairplayScheme;

/*!
 @discussion Optional configuration for Chromecast
 @param url Stream url
 @param configuration DRM configuration
 */
-(void) setManifestUrlForChromecast:(nonnull NSString*) url
                        andDrmConfiguration:(nullable CLDrmConfiguration*) configuration
                     andContentType:(CLContentType) contentType;

/*!
 * @brief Manifest URL to be send to Chromecast device
 * @discussion This value default to manifestUrl unless a different value is specified using [setMAnifestUrlForChromecast:andDrmConfiguration]
 * @remark Fairplay streams will fail to play on Chromecat
 */
@property (readonly) NSString* _Nonnull manifestUrlForChromecast;

/*!
 * @brief DRM Configuration to be send to Chromecast device
 * @discussion This value default to drmConfiguration unless a different value is specified using [setMAnifestUrlForChromecast:andDrmConfiguration]
 * @remark Fairplay streams will fail to play on Chromecat
 */
@property (readonly) CLDrmConfiguration* _Nullable drmConfigurationForChromecast;

/*!
 * @brief Content type to be send to Chromecast device
 * @discussion This value default to contentType unless a different value is specified using [setMAnifestUrlForChromecast:andDrmConfiguration]
 * @remark Fairplay streams will fail to play on Chromecat
 */
@property  (readonly) CLContentType contentTypeForChromecast;

@optional

/*! @brief Minimum buffer required until playback begins
    @remark WARNING works only for DASH and SmoothStreamin streams
*/
-(void) setMinPrebufferTime:(double)seconds;

/// Returns Minimum buffer required until playback begins (default: 6 seconds)
-(double) minPrebufferTime;

/*! @brief Maximum buffer size allowed (default: 60 seconds). When filled to maximum, new downloads will be paused
    @remark WARNING works only for DASH and SmoothStreamin streams
*/
-(void) setMaxPrebufferTime:(double)seconds;

/// Returns Maximum buffer size allowed (default: 6 seconds)
-(double) maxPrebufferTime;

/*!
	@brief Set player view in given controller
	@param vc The ViewController where to set the player view
	@param bounds The size and position there the player view should be set
 */
- (void) setInViewController:(nonnull UIViewController*) vc inBounds:(CGRect) bounds;

/*!
	@brief Fine grain video player listener
	@discussion It triggers detailed events about video track playback. Should be mainly used for debugging purpose.
	@param listener Video player listener
 */
-(void) addVideoListener:(nonnull id<PlayerListenerProtocol>)listener;

/*!
	@brief Fine grain audio player listener
	@discussion It triggers detailed events about audio track playback. Should be mainly used for debugging purpose.
	@param listener Audio player listener
 */
-(void) addAudioListener:(nonnull id<PlayerListenerProtocol>)listener;

#if !TARGET_OS_TV
/*!
 @brief Returns an already initiliazed AVPictureInPictureController
 @remark This method works only for HLS stream
 */
-(AVPictureInPictureController* _Nullable) getPictureInPictureController;
#endif


// Thumbnails
- (void) setThumbnailsWithArray:(nonnull NSArray<CLThumb*>*) thumbs andDownloader:(nonnull __weak id<CLImageDownloader>) downloader;

/*!
 @brief Set a master thumbnails image
 @param gridThumb Master thumbnail image
 */
-(void) setThumbnailWithGridResource:(nonnull CLGridThumbnail*)gridThumb;

/*!
 @brief Retrieve thumbnails from a ROKU BIF file
 @discussion https://sdkdocs.roku.com/display/sdkdoc/Trick+Mode+Support
 @param path Either a local BIF file path or a remote URL
 */
-(void) setThumbnailWithBifFile:(nonnull NSString*)path;

/*!
 @brief Retrieve thumbnails encoded in a WebVTT format
 @param path Either a local file path or a remote URL
 */
-(void) setThumbnailWithWebVTTtrack:(nonnull NSString *)path;


/*!
 @brief Returns the corresponding thumbnail for the given timestamp
 @param timestamp Time
 @return CLThumb Thumbnail for the given timestamp or nil if the thumbnail was not found
*/
- (CLThumb * _Nullable)getThumb:(CMTime)timestamp;

@property (readonly) CLContentType contentType;

@end

#endif /* CLPlayer_h */
