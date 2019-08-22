#ifndef CLDrmConfiguration_h
#define CLDrmConfiguration_h

#import <Foundation/Foundation.h>

/*!
 @interface  CLDrmConfiguration
 
 @brief Domain class for storing DRM configuration details
 
 @author castLabs
 @copyright  Copyright © 2015 castLabs
 */
@interface CLDrmConfiguration : NSObject<NSCopying>

typedef NS_ENUM(NSUInteger, DrmEnvironment) {
	kTesting,
	kStaging,
	kProduction
};

typedef NS_ENUM(NSUInteger, DrmType) {
	kDrmOma,
	kDrmFairplay,
    kDrmWidevine,
    kDrmAutomatic   // The player will attempt to pick up the right DRM
};

/// Folder where the DRM Agent will store permament values
@property (nonatomic, retain) NSString* workingDirectory;

/// Folder where the DRM Agent  will store temporary values
@property (nonatomic, retain) NSString* tempDirectory;

/// Content Asset ID
@property (nonatomic, retain) NSString* assetId;

/// Content Variant ID
@property (nonatomic, retain) NSString* variantId;

/// User ID
@property (nonatomic, retain) NSString* userId;

/// Session ID
@property (nonatomic, retain) NSString* sessionId;

/// Merchant ID
@property (nonatomic, retain) NSString* merchantId;

/// Upfront authentication token
@property (nonatomic, retain) NSString* authToken;

/// DRMToday Environment
@property (nonatomic) DrmEnvironment environment;

/// DRM Type. Default: kDrmAutomatic
@property (nonatomic) DrmType type;
@property (nonatomic, retain) NSString* requestId;

// Fairplay Device certificate
@property (nonatomic, retain) NSData* fairplayCertificate;

/// Device certificate URL as alternative to fairplayCertificate
@property (nonatomic, retain) NSString* fairplayCertificateUrl;

/// Custom Fairplay license server absolute URL
@property (nonatomic, retain) NSString* fairplayLicenseServer;

/// Used for DRMToday Onboard. Array of Rights Objects IDs
@property (nonatomic, retain) NSArray* drmTodayMobileROIDs;

@property (nonatomic) bool persistFPSkey NS_AVAILABLE(10_11, 9_0) DEPRECATED_MSG_ATTRIBUTE("Use persistLicense instead.");

/// If this flag is set to true the DRM Agent will require a persistent license.
/// If such a license is returned, the license will be cached. Default: false.
@property (nonatomic) bool persistLicense NS_AVAILABLE(10_11, 9_0);

/// Absolute URL of the content original root manifest
@property (nonatomic, retain) NSString* originalManifestURL;

/// Custom Activation Server absolute URL.
@property (nonatomic, retain) NSString* activationServerURL;

/// Custom License Server absolute URL.
/// The omaServerEndpoint/widevineServerEndpoint will be appended for OMA/Widevine license requests
@property (nonatomic, retain) NSString* licenseServerURL;

/// Used for DRMToday Onboard. Default: cmalaoma/
@property (nonatomic, retain) NSString* omaServerEndpoint;

/// Used for DRMToday Onboard. Default: widevine/
@property (nonatomic, retain) NSString* widevineServerEndpoint;

/// Map of additional header parameters that will be added to each licensing request
@property (nonatomic, retain) NSDictionary<NSString*, NSString*>* licensingParameters;

/// Set this flag to true, if the body of your license requests must be URL-encoded
/// Default: false
@property (nonatomic) BOOL urlEncodeLicenseRequest;

- (NSData*) getDrmtodayOptData;

@end
#endif
