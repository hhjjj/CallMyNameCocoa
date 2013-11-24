//
//  AppDelegate.h
//  CallMyNameCocoa
//
//  Created by hojun on 11/24/13.
//  Copyright (c) 2013 hojun. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class NamePlayerWithView;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong) NamePlayerWithView * nameView;
@property (assign) IBOutlet NSWindow *window;

@end
