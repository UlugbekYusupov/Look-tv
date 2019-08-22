#import <Foundation/Foundation.h>

#import "CLDrmConfiguration.h"
#import "CLPlayer.h"

/*!
 @interface  CLPlayerFactory
 
 @brief Factory methods for initializing player
 
 @discussion The methods of this class must be used to get an instance of our player
 
 @author castLabs
 @copyright  Copyright © 2015 castLabs
 */
@interface CLPlayerFactory : NSObject

/*!
 @brief Control which HLS player is used, native Apple (default) or castLabs.
 @remark Needs to be set before any create-method is called to have an effect.
 */
@property BOOL useNativeAppleHLSPlayer;

/*!
 @brief Create an instance of the player
 @param url Stream url
 @return CLPlayer An instance of the player
 @remark Make sure alloc/init or new has been called previously, not just alloc.
 */
-(id<CLPlayer>) createPlayerWithStreamUrl:(NSString*) url
                    andContentType:(CLContentType) contentType;

/*!
 @brief Create an instance of the player
 @param url Stream url
 @param configuration DRM configuration
 @param contentType Stream content type
 @return CLPlayer An instance of the player
 @remark Make sure alloc/init or new has been called previously, not just alloc.
 */
-(id<CLPlayer>) createPlayerWithStreamUrl:(NSString*) url
                      andDrmConfiguration:(CLDrmConfiguration*) configuration
                           andContentType:(CLContentType) contentType;

/*!
 @brief Create an instance of the player for 360 degree playback
 @param url Stream url
 @param configuration DRM configuration
 @param output GL connection
 @param contentType Stream content type
 @return CLPlayer An instance of the player
 */
-(id<CLPlayer>) createPlayerWithStreamUrl:(NSString*) url
                andDrmConfiguration:(CLDrmConfiguration*) configuration
                and360Output:(AVPlayerItemVideoOutput*) output
                andContentType:(CLContentType) contentType;

/*!
 @brief Create an instance of the player
 @param url Stream url
 @param configuration DRM configuration
 @param metadata Content metadata will be used by analytics plugins (if present)
     @code
         @{
         @media: {
             @"title": "content title", //required
             @"isLive: @YES,            //required
         },
         @"extraParams": @{
             @"param1": @"Extra param 1 value",
             @"param2": @"Extra param 2 value"
         }
     }
 @param contentType Stream content type
 @return CLPlayer An instance of the player
 @remark Make sure alloc/init or new has been called previously, not just alloc.
 */
-(id<CLPlayer>) createPlayerWithStreamUrl:(NSString*) url
                      andDrmConfiguration:(CLDrmConfiguration*) configuration
                       andContentMetadata:(CLContentMetadata*) metadata
                           andContentType:(CLContentType) contentType;

/*!
 @brief Create an instance of the player
 @param filePath A local MP4 file path
 @param contentType Stream content type
 @return CLPlayer An instance of the player
 @remark Make sure alloc/init or new has been called previously, not just alloc.
 */
-(id<CLPlayer>) createPlayerWithLocalFilepath:(NSString*) filePath
                          andDrmConfiguration:(CLDrmConfiguration*) configuration
                            andContentType:(CLContentType) contentType;

/*!
 @brief Create an instance of the player
 @param videoPath A local video file path
 @param audioPath A local audio file path
 @param configuration DRM configuration
 @param contentType Stream content type
 @return CLPlayer An instance of the player
 @remark Make sure alloc/init or new has been called previously, not just alloc.
 */
-(id<CLPlayer>)createPlayerWithLocalVideopath:(NSString*) videoPath
                                    audioPath:(NSString*) audioPath
                          andDrmConfiguration:(CLDrmConfiguration*) configuration
                        andContentType:(CLContentType) contentType;
@end
