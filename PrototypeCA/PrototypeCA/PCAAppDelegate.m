//
//  PCAAppDelegate.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/24/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCAAppDelegate.h"
#import "PCAViewerWindowController.h"

@implementation PCAAppDelegate
{
    NSMutableSet* _windows;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _windows = [NSMutableSet set];
    
    PCAViewerWindowController* viewer = [[PCAViewerWindowController alloc] init];
    [viewer showWindow:self];
    [_windows addObject:viewer];
    
    NSString* path = [[NSBundle bundleForClass:[self class]] pathForResource:@"test" ofType:@"js"];
    NSError* error = nil;
    NSString* javascript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (javascript == nil) {
        NSLog(@"Error opening %@. %@", path, [error localizedDescription]);
        return;
    }
    
    [viewer.runtime.context evaluateScript:javascript];
    
}

@end
