//
//  JSONWebTokensUtils.h
//  CastlabsSDK
//
//  Created by Guido Parente on 10/01/2018.
//  Copyright © 2018 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONWebTokensUtils : NSObject

+ (NSDictionary*) getPayload:(NSString*) token;
+ (long long) getTimestamp:(NSString*) token;
+ (bool) isTokenExpired:(NSString*) token;

@end
