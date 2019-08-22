//
//  CastlabsSDKDASH.h
//  CastlabsSDK
//
//  Created by Guido Parente on 22/01/2016.
//  Copyright © 2016 castLabs. All rights reserved.
//

// Umbrella header

#ifndef CastlabsDASH_h
#define CastlabsDASH_h

#import "CastlabsSDK/CastlabsSDK.h"

/*!
 @interface  CLDashInit
 
 @brief Umbrella header for DASH playback
 
 @discussion Use this class to enable DASH playback support for castLabs SDK
 
 @copyright  Copyright © 2015 castLabs
 */
@interface CastlabsDASH : NSObject <CLSDKPlugin>

-(void) initPlugin;

@end

#endif /* CastlabsSDKDASH_h */
