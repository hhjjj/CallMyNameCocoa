//
//  NamePlayer.h
//  CallMyNameCocoa
//
//  Created by hojun on 11/24/13.
//
//
//  Almost all copied from https://github.com/julapy/ofxiOSSoundPlayer/
//  for just tring out

#import <Foundation/Foundation.h>
#import <AVFoundation/AVAudioPlayer.h>
@protocol NamePlayerDelegate <NSObject>
@optional
- (void)soundPlayerDidChange;
- (void)soundPlayerDidFinish;
- (void)soundPlayerError:(NSError *)error;
@end

@interface NamePlayer : NSObject <AVAudioPlayerDelegate> {
    id<NamePlayerDelegate> delegate;
    NSURL *filePath;
//    AVAudioPlayer *audioPlayer;
}

@property(nonatomic, assign) id delegate;
@property(nonatomic, retain) AVAudioPlayer * player;
@property(nonatomic, retain) NSTimer * timer;

- (BOOL)setup:(NSURL*)url;

- (BOOL)loadWithFile:(NSString*)file;
- (BOOL)loadWithPath:(NSString*)path;
- (BOOL)loadWithURL:(NSURL*)url;
- (void)unloadSound;

- (void)play;
- (void)pause;
- (void)stop;

- (BOOL)isLoaded;
- (BOOL)isPlaying;

- (void)volume:(float)value;
- (float)volume;

- (void)pan:(float)value;
- (float)pan;

- (void)speed:(float)value;
- (float)speed;

- (void)loop:(BOOL)value;
- (BOOL)loop;

- (void)position:(float)value;
- (float)position;

- (void)positionMs:(int)value;
- (int)positionMs;

@end
