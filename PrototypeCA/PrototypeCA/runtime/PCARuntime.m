//
//  PCARuntime.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/24/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCARuntime.h"
#import "PCALayer.h"
#import "PCADisplayLink.h"

@interface PCARuntime ()
- (BOOL)initializeJavaScriptRuntime:(JSContext*)context error:(NSError**)error;
@end

@implementation PCARuntime

- (id)init
{
    [[NSException exceptionWithName:@"Not implemented" reason:@"Use initWithDelegate: instead" userInfo:nil] raise];
    return nil;
}

- (instancetype)initWithDelegate:(id <PCARuntimeDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate  = delegate;
        
        JSContext* context = [[JSContext alloc] init];
        
        NSError* error = nil;
        if (![self initializeJavaScriptRuntime:context error:&error]) {
            NSLog(@"Couldn't initialize JavaScript runtime: %@", error);
            return nil;
        }
        
        _context = context;
    }
    
    return self;
}

- (BOOL)initializeJavaScriptRuntime:(JSContext*)context error:(NSError**)error
{
    __weak PCARuntime* weakSelf = self;
    
    context[@"console"] = @{ @"log" : ^(NSString* msg){ [_delegate runtime:weakSelf consoleLogMessage:msg]; }};
    
    PCALayer* layer = [[PCALayer alloc] init];
    _layer = layer.layer;
    context[@"rootLayer"] = layer;
    
    // CA constants
    context[@"kCAFillModeForwards"] = kCAFillModeForwards;
    context[@"kCAFillModeBackwards"] = kCAFillModeBackwards;
    context[@"kCAFillModeBoth"] = kCAFillModeBoth;
    context[@"kCAFillModeRemoved"] = kCAFillModeRemoved;
    
    context[@"Layer"] = ^{ return [[PCALayer alloc] init]; };
    context[@"DisplayLink"] = ^{ return [[PCADisplayLink alloc] init]; };
    
    // JavaScript portion of the runtime. This should run after the native portion of the runtime is complete.
    NSString* runtimeJSPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"runtime" ofType:@"js"];
    NSString* runtimeJavaScript = [NSString stringWithContentsOfFile:runtimeJSPath encoding:NSUTF8StringEncoding error:error];
    if (runtimeJavaScript) {
        [context evaluateScript:runtimeJavaScript];
        JSValue* exception = [context exception];
        if (exception) {
            NSLog(@"Error loading JavaScript portion of the runtime. %@", exception);
            return NO;
        }
    }
    
    return YES;
}

- (void)sendEvent:(PCARuntimeEvent*)event
{
    JSValue* handler = _context[@"eventHandler"];
    
    if (handler == nil || [handler isUndefined]) {
        return;
    }
    
    [handler callWithArguments:@[event]];
    JSValue* exception = _context.exception;
    if (exception) {
        NSLog(@"Exception while processing event handler. %@", exception);
    }
}

- (BOOL)evaluateScriptAtURL:(NSURL*)url
{
    NSError* error = nil;
    NSString* javaScript = [[NSString alloc] initWithContentsOfURL:url usedEncoding:NULL error:&error];
    if (javaScript == nil) {
        NSLog(@"Couldn't load string from URL %@. %@", url, error);
        return NO;
    }
    
    JSStringRef script = JSStringCreateWithCFString((__bridge CFStringRef)javaScript);
    JSStringRef sourceURL = JSStringCreateWithCFString((__bridge CFStringRef)[url absoluteString]);
    JSValueRef exception = NULL;
    
    JSValueRef result = JSEvaluateScript([_context JSGlobalContextRef], script, NULL, sourceURL, 1, &exception);
    
    JSStringRelease(script);
    JSStringRelease(sourceURL);
    
    if (result == NULL) {
        // exception thrown.
        JSValue* e = [JSValue valueWithJSValueRef:exception inContext:_context];
        NSLog(@"Exception %@ line %@: %@", e[@"sourceURL"], e[@"line"], e[@"message"]);
        return NO;
    }
    
    return YES;
}

@end
