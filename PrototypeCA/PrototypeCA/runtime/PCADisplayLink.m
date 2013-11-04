//
//  PCADisplayLink.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 11/3/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCADisplayLink.h"
@import CoreVideo;

@implementation PCADisplayLink
{
    CVDisplayLinkRef _displayLink;
}

@synthesize callback=_callback;

- (void)callCallback
{
    [_callback callWithArguments:@[]];
}

static CVReturn displayLinkCallback(CVDisplayLinkRef displayLink,
                                    const CVTimeStamp *inNow,
                                    const CVTimeStamp *inOutputTime,
                                    CVOptionFlags flagsIn,
                                    CVOptionFlags *flagsOut,
                                    void *displayLinkContext)
{
    [(__bridge PCADisplayLink *)displayLinkContext callCallback];
    return kCVReturnSuccess;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        CVReturn error = CVDisplayLinkCreateWithCGDisplay(CGMainDisplayID(), &_displayLink);
        if (error) {
            NSLog(@"DisplayLink created with error:%d", error);
            JSContext* context = [JSContext currentContext];
            if (context) {
                context.exception = [JSValue valueWithNewErrorFromMessage:@"Failed to create display link for main display" inContext:context];
            }
            _displayLink = NULL;
            return nil;
        }
        
        CVDisplayLinkSetOutputCallback(_displayLink, displayLinkCallback, (__bridge void *)(self));
    }
    return self;
}

- (void)dealloc
{
    if (_displayLink) {
        CVDisplayLinkStop(_displayLink);
        CVDisplayLinkRelease(_displayLink);
    }
}

- (void)start
{
    CVDisplayLinkStart(_displayLink);
}

- (void)stop
{
    CVDisplayLinkStop(_displayLink);
}

@end
