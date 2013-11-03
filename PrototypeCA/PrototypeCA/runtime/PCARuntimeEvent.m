//
//  PCARuntimeEvent.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 11/2/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCARuntimeEvent.h"

@implementation PCARuntimeEvent

@end


@implementation PCARuntimeKeyEvent
@synthesize keyCode=_keyCode;

- (instancetype)initWithKey:(NSString*)key withDirection:(PCAKeyDirection)direction withKeyCode:(unsigned short)keyCode
{
    self = [super init];
    if (self) {
        _key = key;
        _keyDirection = direction;
        _keyCode = keyCode;
    }
    return self;
}

- (NSString*)direction
{
    switch (_keyDirection) {
        case PCAKeyDown:
            return @"down";
        case PCAKeyUp:
            return @"up";
    }
    
    return nil;
}

@end

