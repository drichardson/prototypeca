//
//  PCARuntime.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/24/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCARuntime.h"
#import "PCAConsole.h"

@implementation PCARuntime

- (instancetype)init
{
    self = [super init];
    if (self) {
        _layer = [CALayer layer];
        
        JSVirtualMachine* vm = [[JSVirtualMachine alloc] init];
        _context = [[JSContext alloc] initWithVirtualMachine:vm];
        
        [PCARuntime _setupJavaScriptContext:_context];
    }
    return self;
}

+ (void)_setupJavaScriptContext:(JSContext*)context
{
    context[@"console"] = [[PCAConsole alloc] init];
}

@end
