//
//  PlayerExtensionPoint.h
//  CastlabsSDK
//
//  Created by Guido Parente on 11/03/2016.
//  Copyright © 2016 castLabs. All rights reserved.
//

#ifndef AVPlayerExtensionPoint_h
#define AVPlayerExtensionPoint_h

#import <AVFoundation/AVFoundation.h>

@protocol AVPlayerListener
@optional
- (void) didPlayerCreate:(AVPlayer*) player;
@optional
- (void) didPlayerDestroy:(AVPlayer*) player;
@end

@protocol MediaEventListener
@optional
-(void) didPlaybackstartWithItemMetadata:(NSDictionary*) dict;
@end

@interface AVPlayerExtensionPoint : NSObject <AVPlayerListener, MediaEventListener>

typedef AVPlayerExtensionPoint* (*FactoryFunction)(void);
+(NSMutableArray*) getAVPlayerExtensions;
+(void) addFactoryFunction:(FactoryFunction) func;

@end

#endif


