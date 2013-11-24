//
//  AppController.m
//  CallMyNameCocoa
//
//  Created by hojun on 11/24/13.
//  Copyright (c) 2013 hojun. All rights reserved.
//

#import "AppController.h"
#import "AVFoundation/AVAudioPlayer.h"
#import "AVFoundation/AVAudioSettings.h"
#import "NamePlayer.h"

@implementation AppController

- (IBAction)selectFolder:(id)sender {
    
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:NO];
    [panel setCanChooseDirectories:YES];
    [panel setCanCreateDirectories:NO];
    [panel setPrompt:@"Select"];
    
    [panel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            folder = [panel URL];
//            NSLog(@"%@",[folder path]);
            NSError *error = nil;
            NSArray *properties = [NSArray arrayWithObjects: NSURLLocalizedNameKey,
                                   NSURLCreationDateKey, nil];
            
            NSArray *array = [[NSFileManager defaultManager]
                              contentsOfDirectoryAtURL:folder
                              includingPropertiesForKeys:properties
                              options:(NSDirectoryEnumerationSkipsHiddenFiles)
                              error:&error];
//            NSArray *array = [[NSFileManager defaultManager]
//                              contentsOfDirectoryAtPath:[folder path] error:&error];
//            for (int i = 0 ; i < [array count]; i++) {
//                NSLog([[array objectAtIndex:i] path]);
//            }
            
            NSMutableArray *unsorted = [NSMutableArray arrayWithCapacity:[array count]];
            
            for (NSString * f in array){
                NSString *fileName = [f lastPathComponent];
                NSArray *fileSplit = [fileName componentsSeparatedByString:@"."];
                NSString *filenameWithoutExtension = [fileSplit objectAtIndex:0];
                [unsorted addObject:filenameWithoutExtension];
            }
            
            NSArray *sorted = [unsorted sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
//            for (int i = 0 ; i < [sorted count]; i++) {
//                NSLog([sorted objectAtIndex:i]);
//            }
            
            
            playerList = [[NSMutableArray alloc] init];
            
            for (int i = 0 ; i < [sorted count]; i++) {
                
                NSString *folderPath = [[folder path] stringByAppendingString:@"/"];
                NSString *filePath = [folderPath stringByAppendingString:[sorted objectAtIndex:i]];
                NSString *path = [filePath stringByAppendingString:@".wav"];
//                NSLog(path);
                NSURL *url = [NSURL fileURLWithPath:path];
                
                NamePlayer *p = [[NamePlayer alloc] init];
                [p setup:url];
                [playerList addObject:p];
                
                
            
            }
            if (array == nil) {
                // Handle the error
            }

        }
    }];
    
}

- (IBAction)playAll:(id)sender {
    for (int i = 0; i < [playerList count]; i++) {
        NamePlayer * p = [playerList objectAtIndex:i];
        [p play];
    }

    
}

- (NSInteger)getCount{
    return [playerList count];
}

- (NamePlayer*)getNamePlayerAt:(int)index{
    
    return [playerList objectAtIndex:index];
}

@end
