//
//  PCARuntime.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/24/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCARuntime.h"
#import "PCAConsole.h"
#import "PCAPoint.h"

@interface PCARuntime ()
- (BOOL)initializeJavaScriptRuntime:(JSContext*)context error:(NSError**)error;
@end

@implementation PCARuntime

- (instancetype)init
{
    self = [super init];
    if (self) {
        _layer = [CALayer layer];
        
        JSVirtualMachine* vm = [[JSVirtualMachine alloc] init];
        JSContext* context = [[JSContext alloc] initWithVirtualMachine:vm];
        
        NSError* error = nil;
        if (![self initializeJavaScriptRuntime:context error:&error]) {
            NSLog(@"Couldn't initialize JavaScript runtime: %@", error);
            return nil;
        }
        
        _context = context;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"here");
}

- (BOOL)initializeJavaScriptRuntime:(JSContext*)context error:(NSError**)error
{
    context[@"console"] = [[PCAConsole alloc] init];
    context[@"point"] = [PCAPoint class];
    
    // Run the runtime.js script to setup the JavaScript runtime convenience functions and objects.
    NSString* runtimeJSPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"runtime" ofType:@"js"];
    NSString* runtimeScript = [NSString stringWithContentsOfFile:runtimeJSPath usedEncoding:NULL error:error];
    if (runtimeScript == nil) {
        return NO;
    }
    
//    [context setExceptionHandler:^(JSContext *c, JSValue *v) {
//        NSLog(@"Got exception");
//    }];
    
    [context evaluateScript:runtimeScript];
    JSValue* exception = [context exception];
    if (exception) {
        NSLog(@"Error evaluating %@. Exception: %@", runtimeJSPath, exception);
        return NO;
    }
    
    return YES;
}

@end
