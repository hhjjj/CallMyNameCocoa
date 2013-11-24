//
//  NamePlayerWithView.m
//  CallMyNameCocoa
//
//  Created by hojun on 11/24/13.
//  Copyright (c) 2013 hojun. All rights reserved.
//

#import "NamePlayerWithView.h"
#import "AppController.h"
#import "NamePlayer.h"

@implementation NamePlayerWithView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self setController:[[AppController alloc]init]];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect:[self bounds]];
    // Drawing code here.

//    NSLog(@"%i",[[self controller] getCount]);
    
    for (int i = 0; i < [self.controller getCount]; i++) {
        NamePlayer *p = [self.controller getNamePlayerAt:i];
        if ([p isPlaying]) {
            NSLog(@"playing");
        }
    }
}

@end
