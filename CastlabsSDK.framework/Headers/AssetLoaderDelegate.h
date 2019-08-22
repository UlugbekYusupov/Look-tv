//
//  AssetLoaderDelegate.h
//  CastlabsSDK
//
//  Created by Iskandar Safarov on 26/11/2015.
//  Copyright © 2015 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "CLDrmConfiguration.h"

@protocol FairplayLicenseLoaderListener <NSObject>
- (void) onFairplayLicenseLoaded:(bool)res withError:(NSError*_Nullable) err;
@optional
- (nonnull NSString*) onAuthTokenRequired;
@end

@interface AssetLoaderDelegate : NSObject <AVAssetResourceLoaderDelegate>

@property (nullable) CLDrmConfiguration* drmConfig;
@property (nullable) AVAssetResourceLoadingRequest * loadingRequest;
@property (nullable) NSURL *contentUrl;
@property (nullable) id<FairplayLicenseLoaderListener> licenseLoaderListener;
@property (nonnull) NSString* fairplayScheme;

-(nullable instancetype)initWithDrmConfiguration:(nullable CLDrmConfiguration*) drmConfig;
-(BOOL) prefetchOMAKeyWithError:(NSError* _Nullable * _Nullable)error;

@end
