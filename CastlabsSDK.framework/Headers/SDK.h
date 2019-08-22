#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SDKEvent)  {
    /// Suspected Jailbroken detected
    SDK_ERROR_JAILBROKEN = -1,
    SDK_ERROR_UNKNOWN = -1000,
};

/* See the enum SDKEvent above for the events thrown by this delegate*/
@protocol CastlabsSDKDelegate  <NSObject>
    -(void) onError:(SDKEvent)error withDetails:(NSData*) data;
@end

/*!
 @interface  CastlabsSDK
 
 @brief castLabs SDK API
 @discussion Initialization methods and other utilies
 
 @author castLabs
 @copyright  Copyright © 2015 castLabs
 */
@interface CastlabsSDK : NSObject

/*!
	@brief Init the SDK
	@discussion This function should be called before any other.\n Only the first call to this method is honored. Subsequent calls are no-ops.

	@param licenseKey License key as a string
	@return BOOL if no error occurred, false otherwise
 */
+ (BOOL) init:(NSString*) licenseKey;

/*!
	@brief Init the SDK
	@discussion This function should be called before any other.\n Only the first call to this method is honored. Subsequent calls are no-ops.
	@param plugins Array of plugin to be enabled
	@param licenseKey License key as a string
    @param delegate (optional) listener for asynch SDK messages. Keep the delegate instance for the entire app lifecycle
	@return BOOL if no error occurred, false otherwise
 */
+ (BOOL) with:(NSArray*)plugins andLicenseKey:(NSString*) licenseKey andDelegate: (id<CastlabsSDKDelegate>) delegate;
	
/*! True if the SDK was initialized correctly */
+ (BOOL) isInitialized;

/*! Returns a human readable SDK version string */
+(NSString*) version;

/*! Returns a human readable SDK player name string */
+(NSString*) playerName;

/* WARNING experimental feature */
+(void) enableM3U8protocolHandler;

/*! Remove all cached licenses */
+(void) clearCache;

@end
