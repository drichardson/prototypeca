//
//  PCARuntime.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/24/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCARuntime.h"
#import "PCALayer.h"

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

@end
