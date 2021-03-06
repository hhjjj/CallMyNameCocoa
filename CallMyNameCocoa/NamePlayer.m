//
//  NamePlayer.m
//  CallMyNameCocoa
//
//  Created by hojun on 11/24/13.
//  Copyright (c) 2013 hojun. All rights reserved.
//

#import "NamePlayer.h"

@implementation NamePlayer

- (id)init {
    self = [super init];
    if(self) {

    }
    return self;
}

- (void)dealloc {
    [self unloadSound];
}

- (BOOL)setup:(NSURL*)url{
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if([self.player respondsToSelector:@selector(setEnableRate:)]) {
        [self.player setEnableRate:YES];
    }
    [self.player prepareToPlay];
    if(error) {
        if([self.delegate respondsToSelector:@selector(soundPlayerError:)]) {
            [self.delegate soundPlayerError:error];
        }
        return NO;
    }
    
    self.player.delegate = self;
    return YES;
}


- (void)unloadSound {
    [self stop];
    self.player.delegate = nil;
    self.player = nil;
}

//----------------------------------------------------------- play / pause / stop.
- (void)play {
    if([self isPlaying]) {
        [self position:0];
        return;
    }
    BOOL bOk = [self.player play];
    if(bOk) {
        [self startTimer];
    }
}

- (void)pause {
    [self.player pause];
    [self stopTimer];
}

- (void)stop {
    [self.player stop];
    [self stopTimer];
}

//----------------------------------------------------------- states.
- (BOOL)isLoaded {
    return (self.player != nil);
}

- (BOOL)isPlaying {
    if(self.player == nil) {
        return NO;
    }
    return self.player.isPlaying;
}

//----------------------------------------------------------- properties.
- (void)volume:(float)value {
    self.player.volume = value;
}

- (float)volume {
    if(self.player == nil) {
        return 0;
    }
    return self.player.volume;
}

- (void)pan:(float)value {
    self.player.pan = value;
}

- (float)pan {
    if(self.player == nil) {
        return 0;
    }
    return self.player.pan;
}

- (void)speed:(float)value {
    if(value < 0.5) { // min play speed is 0.5 and max speed is 2.0 as per apple docs.
        value = 0.5;
    } else if(value > 2.0) {
        value = 2.0;
    }
    self.player.rate = value;
}

- (float)speed {
    if(self.player == nil) {
        return 0;
    }
    return self.player.rate;
}

- (void)loop:(BOOL)bLoop {
    if(bLoop) {
        self.player.numberOfLoops = -1;
    } else {
        self.player.numberOfLoops = 0;
    }
}

- (BOOL)loop {
    return self.player.numberOfLoops < 0;
}


- (void)position:(float)value {
    self.player.currentTime = value * self.player.duration;
}

- (float)position {
    if(self.player == nil) {
        return 0;
    }
    return self.player.currentTime / (float)self.player.duration;
}

- (void)positionMs:(int)value {
    self.player.currentTime = value / 1000.0;
}

- (int)positionMs {
    if(self.player == nil) {
        return 0;
    }
    return self.player.currentTime * 1000;
}

//----------------------------------------------------------- timer.
- (void)updateTimer {
    if([self.delegate respondsToSelector:@selector(soundPlayerDidChange)]) {
        [self.delegate soundPlayerDidChange];
    }
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)startTimer {
    [self stopTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/30.0
                                                  target:self
                                                selector:@selector(updateTimer)
                                                userInfo:nil
                                                 repeats:YES];
}

//----------------------------------------------------------- audio player events.
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player
                                 error:(NSError *)error {
    if([self.delegate respondsToSelector:@selector(soundPlayerError:)]) {
        [self.delegate soundPlayerError:error];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag {
    [self stopTimer];
    
    if([self.delegate respondsToSelector:@selector(soundPlayerDidFinish)]) {
        [self.delegate soundPlayerDidFinish];
    }
}

@end
