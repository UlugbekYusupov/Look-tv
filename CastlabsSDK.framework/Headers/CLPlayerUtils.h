// !WARNING!
// * The source code of this class is given out to customers and referenced in our docuemntation.
//		Any change to this class must be coordinate with the rest of the team.
// * This class follows Doxygen convetions for documentation

#ifndef VTPlayerUtils_h
#define VTPlayerUtils_h

#import <AVFoundation/AVFoundation.h>
#import "CLPlayerFactory.h"

/*!
 @interface  CLPlayerUtils
 
 @brief Player utils class
 
 @discussion General utility methods that are used internally by our players but can also be used independently. 
 @author castLabs
 @copyright  Copyright © 2015 castLabs
 */
@interface CLPlayerUtils: NSObject

/*!
 @brief Translate CMTime to human-readable string
 @param time A CMTime instance
 @return NSString A human-readable string in the form 00:00:00
 */
+ (NSString*) cmTimeToString:(CMTime)time;

/*!
 @brief Check for file existence
 @param filePath An absolute file path
 @return BOOL YES if file exists, NO otherwise.
 */
+ (BOOL) checkFileExistence:(NSString*) filePath;

/*!
 @brief Translate a player state to human-readable string
 @param state A StateID instance
 @return NSString A human-readable string describing a player state
 */
+ (NSString*) playerStatusToString:(StateID)state;

/*!
 @brief Translate a player error to human-readable string
 @param state A ErrorID instance
 @return NSString A human-readable string describing a player error
 */
+ (NSString*) playerErrorToString:(ErrorID)state;

/*!
 @brief Check seek time value
 @discussion * If seek time is less than 0, a CMTime corresponding to the beginning of playback (i.e. 0) will be returned 
			* If seek time is more than playback duration, a CMTime corresponding to the playback duration will be returned
 @param seekTime A CMTime instance
 @param duration Content duration
 @return CMTime A sanitized seek time
 */
+ (CMTime) sanitizeSeekTime:(CMTime) seekTime withPlaybackDuration:(CMTime) duration;

/*!
 @brief Returns current device appication documents directory path
 @return NSString Application documents directory path or \b nil if no such directory is found
 */
+ (NSString *)applicationDocumentsDirectory;

/*!
 * @brief Returns true if a presisted license for the assed with the given remote URL (URL to the playlist) exist
 * @return True if persisted license exists
 */
+ (BOOL) persistedFairplayLicenseExists: (NSString*) remoteUrl;

/*!
 @brief Returns default DRM working directory path
 @return NSString Default DRM directory path or \b nil if no such directory is found
 */
+ (NSString *)drmWorkingDirectory;

+ (NSString *)homeDirectory;

/*!
 @brief Returns current device appication temporary directory path
 @return NSString Application temporary directory path or \b nil if no such directory is found
 */
+ (NSString *)applicationTmpDirectory;

+(bool) isHttpRespError:(long) statusCode;

+ (bool) isDASH:(NSString*) strUrl;
+ (bool) isHLS:(NSString*) strUrl;
+ (bool) isPIFF:(NSString*) strUrl;
+ (bool) isMP4:(NSString*) strUrl;
+ (bool) isRemoteMP4:(NSString*) strUrl;
+ (CLContentType) guessContentType:(NSString*) url;

@end

#endif
