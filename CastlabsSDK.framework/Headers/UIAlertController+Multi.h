//
//  UIAlertController+Multi.h
//  CastlabsSDK
//
//  Created by Guido Parente on 28/06/2017.
//  Copyright © 2017 castLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleAction : NSObject
    @property NSString* title;
    @property UIAlertActionStyle style;
    @property (nonatomic, copy) void (^handler)(void);

    +(id) initWith:(NSString*) title handler:(void (^)(void))handler;
    +(id) initWith:(NSString*) title handler:(void (^)(void))handler style:(UIAlertActionStyle)style;

@end

@interface UIAlertController (Multi)

-(void) addActions:(NSArray<SimpleAction*>*) action;

@end
