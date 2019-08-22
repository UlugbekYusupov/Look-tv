//
//  CLSDKPlugin.h
//  CastlabsSDK
//
//  Created by Guido Parente on 25/01/2016.
//  Copyright © 2016 castLabs. All rights reserved.
//

#ifndef CLSDKPlugin_h
#define CLSDKPlugin_h

/*!
 @protocol  CLPlayerListenerProtocol
 
 @brief Player Listener API
 
 @discussion This is a high level listener interface that provides callbacks for events from a video player.
 
 @author castLabs
 @copyright  Copyright © 2015 castLabs
 */
@protocol CLSDKPlugin <NSObject>

- (void) initPlugin;

@optional
-(NSString*) getId;

@end

#endif /* CLSDKPlugin_h */
