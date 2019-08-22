// !WARNING!
// * The source code of this class is given out to customers and referenced in our docuemntation.
//		Any change to this class must be coordinate with the rest of the team.
// * This class follows Doxygen convetions for documentation

#ifndef CLPlayerViewController_h
#define CLPlayerViewController_h

#import <UIKit/UIKit.h>
#import <CastlabsSDK/CLPlayer.h>
#import <CastlabsSDK/CLAnalyticsSession.h>


typedef NS_ENUM(NSUInteger, CLSubtitlesDisplayMode) {
    kSubtitleDisplayModeNone,               // Do not make any automatic subtitle selection
    kSubtitleDisplayModeOnlyForced,         // Automatically show only forced subtitle for the preferred text language
    kSubtitleDisplayModePreferredLanguage,  // Automatically show subtitles for the preferred text language
};

@class CLDrmConfiguration;

@protocol CLPlayerViewControllerDelegate <NSObject>
- (void) didDismissPlayerViewController:(nonnull UIViewController*)vc;
- (void) onViewWillTransitionToSize:(CGSize)size;
- (void) onShareButton:(nonnull id)sender;
- (void) onViewDidAppear;
- (void) onToggleControlsVisibility:(bool) controlVisible;
- (nullable NSString*) onAuthTokenRequired;
@end

/*!
 @interface  CLPlayerViewController
 
 @brief Sample ViewController using castLabs player
 
 @discussion It can be used to launch the player in full-screen mode. The source code of this class is provided to SDK customer as part of the bundle.
 
 @author castLabs
 @copyright  Copyright © 2015 castLabs
 */
@interface CLPlayerViewController : UIViewController

/// Stream url to be played
@property(nullable, nonatomic) NSString* streamUrl;

/// DRM configuration should be provied for encrypted files
@property(nullable, nonatomic) CLDrmConfiguration* drmConfiguration;

/// The player can guess the protocol type from the stream URL but you can also set it explicitely with this property
@property(nonatomic) CLContentType contentType;

/// Text to be displayed on a upper-left overlay (besides the logo). Hidden by default.
@property(nullable, nonatomic) NSString* debugText;

/// Enable loop playback
@property(nonatomic) bool loopEnabled;

/// Automatically hide controls
@property(nonatomic) bool autoHideControls;

/// Use native player for HLS and MP4 playback (default: true)
@property(nonatomic) bool useNativePlayer;

/// Define automatic subtitle selection. Default: kSubtitleDisplayModeOnlyForced
@property(nonatomic) CLSubtitlesDisplayMode subtitleMode;

/// Preferred language for subtitle and closed-captions track
// Value expressed as language codes defined in RFC 5646
@property(nullable, nonatomic) NSString* preferredTextLanguage;

/// Enable ads playback
@property(nullable, nonatomic) NSString* adsServer;

/// Playback start position in milliseconds
@property(nonatomic) long startPosition;

/// Logo (150x32) to be displayed in the upper-left corner. Hidden by default
@property(nullable, nonatomic) UIImage* logoImage;

/// castLabs cms ID
@property(nullable, nonatomic) NSString* cmsId;

/// Optional delegate for defining extra behaviour into analytics session
@property(nullable, nonatomic) id<CLAnalyticsDelegate> analyticsDelegate;

@property(nullable, nonatomic) id<CLPlayer> player;

/// Custom protocol scheme that is used by the player to trigger a Fairplay request. The default values is `skd` but it can be overwrtitten using this property
@property(nullable) NSString* fairplayScheme;

/// Show an Airplay button besides the player controls. Hidden by default
@property bool showAirplayButton;
/*!
	@brief Side-load subtitles content from a URL.
	Downloads and parses the subtitles content (if a supported format types).
	Creates a new subtitle track appended after any existing subtitle tracks.
	@discussion  This requires the Subtitles Plug-in.
	The Subtitles Plug-in is not currently used for local files.
	Subtitle tracks exist only during playback, therefore this function
	can only create tracks during that time-frame.
	@param url Location of the subtitle content file
    @param format The subtitle format
    @param displayName The name displayed for subtitle track
    @param languageCode The language code
 */
- (void) addSubtitlesTrackFromUrl:(nonnull NSURL*)url
                       withFormat:(CLSubtitleFormat)format
                  withDisplayName:(nullable NSString*)displayName
                 withLanguageCode:(nullable NSString*)languageCode;

/*! @brief Indicates whether the player should continue the playback in the background. The default value is NO.
 @discussion Besides setting this flas to 'true' please add the UIBackgroundModes key in your app's Info.plist file. Its value is an array that contains one or more strings that identify which background tasks your application supports. Specify the string value "audio"
 @remark Works only for audio-only streams
 @remark Must be called before [open] */
@property (nonatomic) BOOL continuePlaybackInTheBackground;

/*!
 @discussion Optional configuration for Chromecast
 @param url Stream url
 @param configuration DRM configuration
 */
-(void) setManifestUrlForChromecast:(nonnull NSString*) url
                andDrmConfiguration:(nullable CLDrmConfiguration*) configuration
                     andContentType:(CLContentType) contentType;

@property (nullable, weak, nonatomic) IBOutlet UIView *bottomControls;
@property (nullable, weak, nonatomic) IBOutlet UIView *topControls;
@property (nullable, weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nullable, weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (nullable, weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (nullable, weak, nonatomic) IBOutlet UISlider *timeSeekbar;
@property (nullable, weak, nonatomic) IBOutlet UILabel *bottomRightTextArea;
@property (nullable, weak, nonatomic) IBOutlet UILabel *upperLeftTextArea;
@property (nullable, weak, nonatomic) IBOutlet UIImageView *logo;
@property (nullable, weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (nullable, weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nullable, weak, nonatomic) IBOutlet NSLayoutConstraint *bottomControllsConstraint;
@property (nullable, weak, nonatomic) IBOutlet NSLayoutConstraint *topControllsConstraint;
@property (nullable, weak, nonatomic) IBOutlet NSLayoutConstraint *logoConstraint;
@property (nullable, weak, nonatomic) IBOutlet NSLayoutConstraint *bottomTextConstraint;
@property (nullable, weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (nullable, weak, nonatomic) IBOutlet UIButton *pipButton;
@property (nullable, weak, nonatomic) IBOutlet UIView *airPlayView;
@property (nullable, weak, nonatomic) IBOutlet UIView *chromecastButtonParent;
@property (nullable, weak, nonatomic) IBOutlet UIView *chromecastMinicontrollerParent;
@property (nullable, weak, nonatomic) IBOutlet UILabel *playbackRateLabel;

@property (nullable, nonatomic) CLSubtitlesStyle* subtitleStyle;

- (IBAction)onPlayButton:(nonnull id)sender;
- (IBAction)onCloseButton:(nonnull id)sender;
- (IBAction)onTracksButton:(nonnull id)sender;
- (IBAction)onSeekBarTouchUp:(nonnull id)sender;
- (IBAction)onSeekBarValueChanged:(nonnull id)sender;
- (IBAction)onForwardButton:(nonnull id)sender;
- (IBAction)onRewindButton:(nonnull id)sender;
- (IBAction)onRestartButton:(nonnull id)sender;
- (IBAction)onShareButton:(nonnull id)sender;
- (void)closeController;
- (IBAction)onPiPButton:(nonnull id)sender;
- (IBAction)onFastForward:(nonnull id)sender;
- (IBAction)onSlowForward:(nonnull id)sender;

@property (nullable, nonatomic, weak) id<CLPlayerViewControllerDelegate> delegate;

/*! @brief Metadata for the current item. This information are used by different plugins (analytics, chromecast)
 @remark Must be called before [open]
 */
@property (nullable) CLContentMetadata* metadata;

- (void)showWarningAlertWhilePlayerLoads;
- (CGRect)calculateTrackTableSizeForItemsCount:(NSUInteger) count;

- (void)setThumbnailWithGridResource:(nonnull CLGridThumbnail*) gridThumb;
- (void)setThumbnailWithBifFile:(nonnull NSString*)bifFilepath;
- (void)setThumbnailWithWebVTTFile:(nonnull NSString*)vttFilepath;


@end

#endif
