//
//  CLAdsManager.h
//  CastlabsSDK
//
//  Created by Guido Parente on 09/05/2016.
//  Copyright © 2016 castLabs. All rights reserved.
//

#ifndef CLAdSession_h
#define CLAdSession_h
#import <UIKit/UIKit.h>
#include "CLPlayer.h"
#include "CLAd.h"
#include "CLAdEvent.h"
#include "CLAdError.h"

@protocol CLAdsListener <NSObject>
// NSDictionary contains additional info about the loaded ads
//      {
//          "adCuePoints": [] // Array for single ads with cue time in seconds (double value)
//      }
-(void) adsLoaded:(NSDictionary*) adsData;
-(void) adStarted:(CLAdEvent*) event;
-(void) adStopped:(CLAdEvent*) event;
@optional
-(void) adEvent:(CLAdEvent*) event;
-(void) adError:(CLAdError *)error;
@end

@protocol CLAdRequestDelegate <NSObject>

- (void)didRequestContentPause;
- (void)didRequestContentResume;

@end

@interface CLAdSession : NSObject

- (id) initWithPlayer:(id<CLPlayer>) player
         forViewController:(UIViewController*) vc
                                  onView:(UIView*) view;

- (void) requestAds:(NSString*)url withDelegate:(id<CLAdRequestDelegate>) delegate;

/**
 *  Starts advertisement playback.
 */
- (void)start;

/**
 *  Pauses advertisement.
 */
- (void)pause;

/**
 *  Resumes the advertisement.
 */
- (void)resume;

/**
 *  Skips the advertisement.
 */
- (void)skip;

/**
 *  Causes the ads manager to stop the ad and clean its internal state.
 */
- (void)destroy;

/**
 *  If an ad break is currently playing, discard it and resume content.
 *  Otherwise, ignore the next scheduled ad break.
 */
- (void)discardAdBreak;

// Code for initing the plugin
typedef CLAdSession* (*CLAdSessionFactoryFunction)(void);
+(CLAdSession*) createAdSession;
+(void) setFactoryFunction:(CLAdSessionFactoryFunction) func;

@end


#endif /* CLAdsManager_h */
