//
//  CLAdEvent.h
//  CastlabsSDK
//
//  Created by Guido Parente on 11/05/2016.
//  Copyright © 2016 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLAd.h"

/**
 *  Different event types sent by the IMAAdsManager to its delegate.
 */
typedef NS_ENUM(NSInteger, AdEventType){
    /**
     *  Ad break ready.
     */
    kAdEvent_AD_BREAK_READY,
    /**
     *  Ad break ended (only used for server side ad insertion).
     */
    kAdEvent_AD_BREAK_ENDED,
    /**
     *  Ad break started (only used for server side ad insertion).
     */
    kAdEvent_AD_BREAK_STARTED,
    /**
     *  All ads managed by the ads manager have completed.
     */
    kAdEvent_ALL_ADS_COMPLETED,
    /**
     *  Ad clicked.
     */
    kAdEvent_CLICKED,
    /**
     *  Single ad has finished.
     */
    kAdEvent_COMPLETE,
    /**
     *  Cuepoints changed for VOD stream (only used for server side ad insertion).
     */
    kAdEvent_CUEPOINTS_CHANGED,
    /**
     *  First quartile of a linear ad was reached.
     */
    kAdEvent_FIRST_QUARTILE,
    /**
     *  An ad was loaded.
     */
    kAdEvent_LOADED,
    /**
     *  Midpoint of a linear ad was reached.
     */
    kAdEvent_MIDPOINT,
    /**
     *  Ad paused.
     */
    kAdEvent_PAUSE,
    /**
     *  Ad resumed.
     */
    kAdEvent_RESUME,
    /**
     *  Ad has skipped.
     */
    kAdEvent_SKIPPED,
    /**
     *  Ad has started.
     */
    kAdEvent_STARTED,
    /**
     *  Ad tapped.
     */
    kAdEvent_TAPPED,
    /**
     *  Third quartile of a linear ad was reached.
     */
    kAdEvent_THIRD_QUARTILE,
    /**
     *  Ad playback position in ms
     */
    kAdEvent_POSITION_MS
};

@interface CLAdEvent : NSObject

-(id) initWithType:(AdEventType) type andAd:(CLAd*)ad;

/**
 *  Type of the event.
 */
@property(nonatomic) AdEventType type;

/**
 *  Stringified type of the event.
 */
@property(nonatomic, copy) NSString *typeString;

/**
 *  The current ad that is playing or just played. Can be nil.
 */
@property(nonatomic, strong) CLAd *ad;

/**
 *  Extra data about the ad. Can be nil.
 */
@property(nonatomic, copy) NSDictionary *adData;

/**
 *  Current playback position in ms
 */
@property(nonatomic) long long position_ms;

@end
