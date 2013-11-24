//
//  AppDelegate.m
//  CallMyNameCocoa
//
//  Created by hojun on 11/24/13.
//  Copyright (c) 2013 hojun. All rights reserved.
//

#import "AppDelegate.h"
#import "NamePlayerWithView.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NamePlayerWithView *view = [[NamePlayerWithView alloc] initWithFrame:[self.window frame]];
    self.nameView = view;
    [self.window.contentView addSubview:self.nameView];
}

@end
