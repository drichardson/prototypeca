//
//  PCADocument.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/30/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCADocument.h"
#import "PCARuntime.h"

@interface PCADocument () <PCARuntimeDelegate>
@end

@implementation PCADocument
{
    PCARuntime* _runtime;
    NSString* _javaScript;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"PCADocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    
    _runtime = [[PCARuntime alloc] initWithDelegate:self];
    
    CALayer* contentLayer = ((NSView*)aController.window.contentView).layer;
    _runtime.layer.frame = contentLayer.bounds;
    _runtime.layer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
    [contentLayer addSublayer:_runtime.layer];
    
    [_runtime.context evaluateScript:_javaScript];
    
    // TODO: Log in window
    JSValue* exception = _runtime.context.exception;
    if (exception) {
        NSLog(@"EXCEPTION: %@", exception);
    }
}

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
    _javaScript = [NSString stringWithContentsOfURL:url usedEncoding:NULL error:outError];
    
    if (_javaScript == nil) {
        return NO;
    }
    
    return YES;
}

#pragma mark PCARuntimeDelegate

- (void)runtime:(PCARuntime *)runtime consoleLogMessage:(NSString *)msg
{
    NSLog(@"RUNTIME: %@", msg);
}

@end
