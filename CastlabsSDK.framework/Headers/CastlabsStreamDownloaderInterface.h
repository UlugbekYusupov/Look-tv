//
//  LicenceExtensionPoint.h
//  CastlabsSDK
//
//  Created by Guido Parente on 21/04/2016.
//  Copyright © 2016 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CastlabsStreamDownloaderInterface : NSObject

typedef CastlabsStreamDownloaderInterface* (*l_FactoryFunction)(void);
+(CastlabsStreamDownloaderInterface*) createDownloader;
+(void) addFactoryFunction:(l_FactoryFunction) func;

- (NSArray*) getDownloadedQualityIds:(NSString*) downloadedPath;

@end
