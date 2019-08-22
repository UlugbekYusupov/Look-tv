#ifndef CLPlayerTrackDescription_h
#define CLPlayerTrackDescription_h

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, CLPlayerTrackType) {
	/** Unknown track type. */
	CLPlayerTrackTypeUnknown = 0,
	/** Text. */
	CLPlayerTrackTypeText = 1,
	/** Audio. */
	CLPlayerTrackTypeAudio = 2,
	/** Video. */
	CLPlayerTrackTypeVideo = 3,
};

/*!
 @interface  CLPlayerTrackDescription
 
 @brief Player track description
 
 @discussion Provides information about the loaded tracks
 
 @author castLabs
 @copyright  Copyright © 2015 castLabs
 */
@interface CLPlayerTrackDescription : NSObject

/// Track type
@property (nonatomic) CLPlayerTrackType type;

/// FourCC describing track format. May be 0 if unset.
@property (nonatomic) FourCharCode formatCode;

/// String describing track format. Automatic if formatCode is set.
@property (nonatomic, nullable)  NSString* format;

/// String with track title.
@property (nonatomic, nullable) NSString* title;

/// RFC 5646 language code.
@property (nonatomic, nullable) NSString* languageCode;

/// String describing language.
// If the languageCode property is set, this property gives a text representation of the language code
// using the default Locale
@property (nonatomic, nullable) NSString* language;

/// Indicates a Forced subtile track.
/// This attribute is always false for all types different than CLPlayerTrackTypeText
@property (nonatomic) BOOL forced;

/// The index is derived from the order in which they appear in the manifest
@property (nonatomic) NSInteger trackIndex;

@end

#endif /* CLPlayerTrackDescription_h */
