//
//  PCAAppDelegate.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/16/13.
//  Copyright (c) 2013 Doug Richardson. All rights reserved.
//

#import "PCAAppDelegate.h"
#import "PCAViewerWindowController.h"

@implementation PCAAppDelegate
{
    NSMutableSet* _windowControllers;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _windowControllers = [NSMutableSet set];
    
    NSString* scriptPath = [@"~/Desktop/test.js" stringByExpandingTildeInPath];
    
    PCAViewerWindowController* controller = [[PCAViewerWindowController alloc] initWithScriptAtPath:scriptPath];
    [controller showWindow:self];
    [_windowControllers addObject:controller];
}

- (void)windowDidClose:(NSNotification*)notification
{
    NSWindowController* controller = [notification object];
    [_windowControllers removeObject:controller];
}

@end
