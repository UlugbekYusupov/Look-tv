//
//  CLContentMetadata.h
//  CastlabsSDK
//
//  Created by Guido Parente on 18/09/2017.
//  Copyright © 2017 castLabs. All rights reserved.
//

#ifndef CLContentMetadata_h
#define CLContentMetadata_h

@interface CLContentMetadata : NSObject

-(id) initWithContentAssetId:(NSString*) assetId title:(NSString*)title isLive:(BOOL)live;

-(id) initWithChannelName:(NSString*) channelName andUrl:(NSString*)url;


/** Content is streamed live. */
@property BOOL isLive;

/** Required. A unique identifier for the content. */
@property NSString* assetId;

/** A human-readable identifier for the content . */
@property NSString* title;

/** A string identifying the viewer. */
@property(nonatomic,copy) NSString *viewerId;

/** A string identifying the current application. */
@property(nonatomic,copy) NSString *applicationName;

/** The URL from where the video content will be downloaded. */
@property NSString* url;

/** An image identyifing the content.*/
@property NSString* imageUrl;
@property int imageWidht;
@property int imageHeight;

/**
 * Default video server resource to report for this content.<br>
 * Examples: EDGECAST, AKAMAI-FREE, LEVEL3-PREMIUM...
 */
@property(nonatomic,copy) NSString *defaultResource;

/** Channel name this content belongs to. */
@property NSString* channelName;

/** A string-to-string dictionary of custom metadata. */
@property NSDictionary* data;

@end

#endif /* CLContentMetadata_h */
