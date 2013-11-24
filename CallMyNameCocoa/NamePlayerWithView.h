//
//  NamePlayerWithView.h
//  CallMyNameCocoa
//
//  Created by hojun on 11/24/13.
//  Copyright (c) 2013 hojun. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class AppController;

@interface NamePlayerWithView : NSView

@property AppController *controller;
@property (strong) NSMutableArray *drawList;

@end
