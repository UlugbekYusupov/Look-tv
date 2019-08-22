//
//  CLAd.h
//  CastlabsSDK
//
//  Copyright © 2016 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLPodInfo : NSObject

/**
 *  Total number of ads in the pod this ad belongs to. Will be 1 for standalone ads.
 */
@property(nonatomic) int totalAds;

/**
 *  The position of this ad within an ad pod. Will be 1 for standalone ads.
 */
@property(nonatomic) int adPosition;

/**
 *  Specifies whether the ad is a bumper. Bumpers are short videos used to open
 *  and close ad breaks.
 */
@property(nonatomic) BOOL isBumper;

/**
 *  The index of the pod, where pre-roll pod is 0, mid-roll pods are 1 .. N
 *  and the post-roll is -1.
 */
@property(nonatomic) int podIndex;

/**
 *  The position of the pod in the content in seconds. Pre-roll returns 0,
 *  post-roll returns -1 and mid-rolls return the scheduled time of the pod.
 */
@property(nonatomic) NSTimeInterval timeOffset;

/**
 *  The maximum duration of the pod in seconds. For unknown duration, -1 is returned.
 */
@property(nonatomic) NSTimeInterval maxDuration;

@end

@interface CLAd : NSObject

-(id) initWithIdentifier:(NSString*) identifier;

/**
 *  The ad ID as specified in the VAST response.
 */
@property(nonatomic, copy) NSString *adId;

/**
 *  The ad title from the VAST response.
 */
@property(nonatomic, copy) NSString *adTitle;

/**
 *  The ad description.
 */
@property(nonatomic, copy) NSString *adDescription;

/**
 *  Content type of the currently selected creative. For linear creatives
 *  returns the content type of the currently selected media file. Returns
 *  empty string if no creative or media file is selected on this ad.
 */
@property(nonatomic, copy) NSString *contentType;

/**
 *  The duration of the ad from the VAST response.
 */
@property(nonatomic) NSTimeInterval duration;

/**
 *  The width of the ad asset. For non-linear ads, this is the actual width
 *  of the ad representation. For linear ads, since they scale seamlessly, we
 *  currently return 0 for width.
 */
@property(nonatomic) int width;

/**
 *  The height of the ad asset. For non-linear ads, this is the actual height
 *  of the ad representation. For linear ads, since they scale seamlessly, we
 *  currently return 0 for height.
 */
@property(nonatomic) int height;

/**
 *  Specifies whether the ad is linear or non-linear.
 */
@property(nonatomic, getter=isLinear) BOOL linear;

/**
 *  Specifies whether the ad is skippable.
 */
@property(nonatomic, getter=isSkippable) BOOL skippable;


/**
 *  String representing custom trafficking parameters from the VAST response.
 */
@property(nonatomic, copy) NSString *traffickingParameters;

/**
 *  Set of ad podding properties.
 */
@property(nonatomic, strong) CLPodInfo *podInfo;

- (instancetype)init NS_UNAVAILABLE;

@end

