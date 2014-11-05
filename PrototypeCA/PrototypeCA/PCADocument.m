//
//  PCADocument.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/30/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCADocument.h"
#import "PCARuntime.h"
#import "PCARuntimeEvent.h"
#import "PCADocumentView.h"
#import <CoreServices/CoreServices.h>

@interface PCADocument () <PCARuntimeDelegate, PCADocumentViewDelegate>
@end

@implementation PCADocument
{
    PCARuntime* _runtime;
    NSURL* _javaScriptURL;
    FSEventStreamRef _fsEvents;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (void)dealloc
{
    [self stopWatchingJavaScriptFile];
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"PCADocument";
}

- (void)reload:(id)sender
{
    [self runJavaScript];
}

- (void)runJavaScript
{
    [_runtime evaluateScriptAtURL:_javaScriptURL];
    
    // TODO: Log in window
    JSValue* exception = _runtime.context.exception;
    if (exception) {
        NSLog(@"EXCEPTION: %@", exception);
    }
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
    
    [self runJavaScript];
    
    // Monitor file for changes.
}

static void fsevent_callback(ConstFSEventStreamRef streamRef,
                             void *clientCallBackInfo,
                             size_t numEvents,
                             void *eventPaths,
                             const FSEventStreamEventFlags eventFlags[],
                             const FSEventStreamEventId eventIds[])
{
    bool needsReload = false;
    for(int i = 0; i < numEvents; ++i) {
        if (eventFlags[i] & kFSEventStreamEventFlagItemModified) {
            needsReload = true;
            break;
        }
    }
    
    if (needsReload) {
        PCADocument* doc = (__bridge PCADocument*)clientCallBackInfo;
        dispatch_async(dispatch_get_main_queue(), ^{
            [doc runJavaScript];
        });
    }
}

- (void)stopWatchingJavaScriptFile
{
    if (_fsEvents) {
        FSEventStreamStop(_fsEvents);
        FSEventStreamInvalidate(_fsEvents);
        FSEventStreamRelease(_fsEvents);
        _fsEvents = NULL;
    }
}

- (void)watchJavaScriptFile
{
    [self stopWatchingJavaScriptFile];
    
    if (_javaScriptURL) {
        FSEventStreamContext context;
        context.version = 0;
        context.info = (__bridge void*)self;
        context.retain = NULL;
        context.release = NULL;
        context.copyDescription = NULL;
        
        _fsEvents = FSEventStreamCreate(NULL,
                            fsevent_callback,
                            &context, // context
                            (__bridge  CFArrayRef)@[_javaScriptURL.path], // paths to observe
                            kFSEventStreamEventIdSinceNow,
                            0, // minimize latency
                            kFSEventStreamCreateFlagFileEvents | kFSEventStreamCreateFlagNoDefer);
        FSEventStreamSetDispatchQueue(_fsEvents, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        FSEventStreamStart(_fsEvents);
    }
}

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
    _javaScriptURL = url;
    [self watchJavaScriptFile];
    return YES;
}

#pragma mark PCARuntimeDelegate

- (void)runtime:(PCARuntime *)runtime consoleLogMessage:(NSString *)msg
{
    NSLog(@"RUNTIME: %@", msg);
}

#pragma mark PCADocumentViewDelegate

- (void)documentView:(PCADocumentView*)view didReceiveKeyDownEvent:(NSEvent*)event
{
    PCARuntimeEvent* pcaEvent = [[PCARuntimeKeyEvent alloc] initWithKey:[event characters] withDirection:PCAKeyDown withKeyCode:[event keyCode]];
    [_runtime sendEvent:pcaEvent];
}

- (void)documentView:(PCADocumentView*)view didReceiveKeyUpEvent:(NSEvent*)event
{
    PCARuntimeEvent* pcaEdfvent = [[PCARuntimeKeyEvent alloc] initWithKey:[event characters] withDirection:PCAKeyUp withKeyCode:[event keyCode]];
    [_runtime sendEvent:pcaEdfvent];
}

@end

