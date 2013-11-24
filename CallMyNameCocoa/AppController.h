//
//  AppController.h
//  CallMyNameCocoa
//
//  Created by hojun on 11/24/13.
//  Copyright (c) 2013 hojun. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class NamePlayer;

@interface AppController : NSObject  {
    NSURL *folder;
    NSMutableArray *playerList;
}

- (IBAction)selectFolder:(id)sender;
- (IBAction)playAll:(id)sender;

@end
