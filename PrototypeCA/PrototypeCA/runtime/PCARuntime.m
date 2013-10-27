//
//  PCARuntime.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/24/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCARuntime.h"
#import "PCAConsole.h"

@interface PCARuntime ()
- (BOOL)initializeJavaScriptRuntime:(JSContext*)context error:(NSError**)error;
@end

@implementation PCARuntime

- (instancetype)init
{
    self = [super init];
    if (self) {
        _layer = [CALayer layer];
        
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
    context[@"console"] = [[PCAConsole alloc] init];
    
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
