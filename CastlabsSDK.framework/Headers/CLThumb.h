//
//  CLThumb.h
//  CastlabsSDK
//
//  Created by Guido Parente on 17/01/2017.
//  Copyright © 2017 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CLThumb : NSObject

/// Remote or local image path
@property NSURL* url;

@property NSData* imageData;

@property double timestamp;

@property double duration;


@end
