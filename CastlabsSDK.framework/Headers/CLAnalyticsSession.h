//
//  CLAnalyticsSession.h
//  CastlabsSDK
//
//  Created by Guido Parente on 14/06/2016.
//  Copyright © 2016 castLabs. All rights reserved.
//

#ifndef CLAnalyticsSession_h
#define CLAnalyticsSession_h

@class CLAdEvent;
@protocol CLPlayer;
@class CLContentMetadata;

@protocol CLAnalyticsDelegate <NSObject>

// You can add specific metadata for the current AD before the analytics plugin send the information
// to the analytics backend
- (NSDictionary*)getMetadataForAd:(CLAdEvent*) ad;

@end

@interface CLAnalyticsSession : NSObject 

- (instancetype) initWithKeys:(NSDictionary*)keys;

/*!
* Start Analytics monitoring
* @remark the metadata structure depends on your analytics plugin. Use the -data parameter of CLContentMetadata to pass along the required values
*/
 - (void) start:(id<CLPlayer>)player withMetadata:(CLContentMetadata*)metadata;

/*!
 * Stop analytics monitoring
 */
- (void) stop;

- (long) getReportedMediaDuration;
- (long) getJoinTime;

/**
 * Send a custom event to the Analytics Backend.
 * @param eventName Name of the custom event.
 * @param attributes A dictionary of key-value pairs associated with the event.
 */
-(void) sendCustomEvent:(NSString *)eventName withAttributes:(NSDictionary *)attributes;

@property id<CLAnalyticsDelegate> delegate;

typedef CLAnalyticsSession* (*as_FactoryFunction)(void);
+(NSMutableArray*) getAnalyticsSession;
+(void) addFactoryFunction:(as_FactoryFunction) func;

@end

#endif /* CLAnalyticsSession_h */
