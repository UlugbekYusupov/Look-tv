//
//  ListenerProtocol.h
//  CastlabsSDK
//
//  Created by Iskandar Safarov on 2/07/2015.
//  Copyright (c) 2015 Iskandar Safarov. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "CLPlayerListenerProtocol.h"

@protocol PlayerListenerProtocol <NSObject>
@optional

/// Called when stall is detected
- (void)onUnderbuffer:(nonnull id)caller;

/// Called when video stall is resolved
- (void)onUnderbufferFinishes:(nonnull id)caller;

/// Called when video stall reaches timeout limit
- (void)onTimedOut:(nonnull id)caller;

/// Called when video data runs out
- (void)onContentEnded:(nonnull id)caller;

/// Called when video playback stops
- (void)onStop:(nonnull id)caller;

/// Called when video playback pauses
- (void)onPause:(nonnull id)caller;

/// Called when video playback starts
- (void)onPlay:(nonnull id)caller;

// Called when a new audio or video sample is queued for playback
- (void)onEnqueuedSample:(nullable void*)sample
                 withPTS:(CMTime)pts
                duration:(CMTime)duration
               andCaller:(nonnull id)caller;

/// Called when an error occurs
- (void)onVideoError:(ErrorID) error;

@end
