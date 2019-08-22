//
//  CLPlayerVideoDescription.h
//  CastlabsSDK
//
//  Created by Guido Parente on 30/06/2016.
//  Copyright © 2016 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLVideoTrackQuality: NSObject
    @property long long bitrate;
    @property int width;
    @property int height;
@end

@interface CLPlayerVideoDescription: NSObject

@property NSMutableArray* qualities;

@end
