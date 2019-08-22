//
//  CLChromecastInterface
//  CastlabsSDK
//
//  Created by Guido Parente on 14/09/2017.
//  Copyright © 2017 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CastlabsSDK.h"

typedef NS_ENUM(NSInteger, ChromecastPlayerState) {
    /** Constant indicating unknown player state. */
    ChromecastPlayerStateUnknown = 0,
    /** Constant indicating that the media player is idle. */
    ChromecastPlayerStateIdle = 1,
    /** Constant indicating that the media player is playing. */
    ChromecastPlayerStatePlaying = 2,
    /** Constant indicating that the media player is paused. */
    ChromecastPlayerStatePaused = 3,
    /** Constant indicating that the media player is buffering. */
    ChromecastPlayerStateBuffering = 4,
    /** Constant indicating that the media player is loading media. */
    ChromecastPlayerStateLoading = 5,
};

@protocol CLChromecastDelegate

@required

/// Delegate implementation are responsible for adding the Chromecast button to current ViewController
- (void) addChromecastButton:(UIButton*) btn;
/// Delegate implementation are responsible for adding the Chromecast Mini Media Controller
/// ad a child view controller to current ViewController
- (void) addChromecastMiniController:(UIViewController*) vc;
/// Notifies about a change in the active state of Chromecast Mini Controller
- (void) chromecastMiniControllerShouldAppear:(BOOL)shouldAppear;
/// Notifies about a change in the active state of a Chromecast connection
- (void) onChromecastConnection:(bool) active;

@end

@interface CLChromecast : NSObject

typedef CLChromecast* (*ChromecastFactoryFunction)(void);
+(CLChromecast*) createChromecast;
+(void) setFactoryFunction:(ChromecastFactoryFunction) func;

/// Init the Chromecast instance with your app receiver ID
- (instancetype) initWithReceiverId:(NSString*)receiverId;

/// Connect an already instatiated player with the Chromecast instance
-(void) connectWithPlayer:(id<CLPlayer>) player andDelegate:(id<CLChromecastDelegate>) delegate;

/// Returns true if there is a media being casted
-(BOOL) isCastingActive;

/// Start to cast the item connected to the player
-(void) playItemRemotely;

/// Return the remote player state
-(ChromecastPlayerState) getState;

/// Return the last know remote player playback position
-(CMTime) getLastKnownPositionInSeconds;

@end
