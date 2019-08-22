//
//  CLSubtitlesStyle.h
//  CastlabsSDK
//
//  Created by Guido Parente on 10/05/2017.
//  Copyright © 2017 castLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaAccessibility/MediaAccessibility.h>
#import <UIKit/UIKit.h>
/*!
 * @brief The subtitles settings to customize subtitles rendering
 */
@interface CLSubtitlesStyle : NSObject

-(id _Nonnull) initWithSystemSettings;

-(id _Nullable) initWithSerializedString: (NSString* _Nonnull)serialized;

-(NSString * _Nonnull) serialize;

/*!
 * @brief Whether this object was initialized from system settings and not modified afterwards.
 * @discussion If you serialize a style that has systemSettings = true and deserialize it later, you will
 * still get a style with systemSettings = true, that will reflect the system settings at the time of deserialization
 * (which might be different from the ones at the time of original initialization).
 */
@property (readonly) BOOL systemSettings;

/*!
 * @brief The font size scaling
 * @discussion This is a number holding a percentage of the size of the calculated default font size.  A value
 * of 1.2 indicates 20% larger than the default font size. A value of 0.8
 * indicates 80% of the default font size.  The value 1 indicates no size difference and is the default.
 */
@property CGFloat fontSizeScale;

/*!
 * The primary typeface used for text. Default is kMACaptionAppearanceFontStyleDefault
 */
@property MACaptionAppearanceFontStyle typeface;

/*!
 * @brief enable auto flow
 * @discusion Enable autoflow of text. This is usefull especially when you adjust the font size scaling
 */
@property BOOL autoFlowEnabled;

/*!
 * @brief enable ignore span background color
 * @discusion Enable ignore span background color. This is usefull especially when background color is defined in region and also in nested elements (span)
 */
@property BOOL ignoreSpanBackgroundColor;

/*!
 * @brief The text foreground color. This also contains the alpha/opacity component of the color.
 */
@property UIColor* _Nullable foregroundColor;

/**
 * The text background color. This also contains the alpha/opacity component of the color.
 */
@property UIColor* _Nullable backgroundColor;

/**
 * @brief The edge color. This also contains the alpha/opacity component of the color.
 */
@property UIColor* _Nullable edgeColor;

/**
 * @brief The edge type. Default is kMACaptionAppearanceTextEdgeStyleUndefined
 */
@property MACaptionAppearanceTextEdgeStyle edgeType;

/**
 * The window color. This also contains the alpha/opacity component of the color.
 */
@property UIColor* _Nullable windowColor;

@end
