//
//  PCAViewerWindowController.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/25/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCAViewerWindowController.h"

@interface PCAViewerWindowController () <PCARuntimeDelegate>

@end

@implementation PCAViewerWindowController

- (id)init
{
    return [self initWithWindowNibName:@"PCAViewerWindowController" owner:self];
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    _runtime = [[PCARuntime alloc] initWithDelegate:self];
    
    CALayer* contentLayer = ((NSView*)self.window.contentView).layer;
    _runtime.layer.frame = contentLayer.bounds;
    _runtime.layer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
    [contentLayer addSublayer:_runtime.layer];
}

- (void)runtime:(PCARuntime *)runtime consoleLogMessage:(NSString *)msg
{
    NSLog(@"RUNTIME: %@", msg);
}

@end
