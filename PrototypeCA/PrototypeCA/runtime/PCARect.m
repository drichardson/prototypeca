//
//  PCARect.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/26/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCARect.h"

@implementation PCARect
@synthesize origin=_origin, size=_size, cgRect=_cgRect;

+ (PCARect*)makeRectX:(double)x y:(double)y width:(double)width height:(double)height
{
    PCARect* result = [[PCARect alloc] init];
    result.origin.x = x;
    result.origin.y = y;
    result.size.width = width;
    result.size.height = height;
    return result;
}

- (PCARect*)init
{
    self = [super init];
    if (self) {
        _origin = [[PCAPoint alloc] init];
        _size = [[PCASize alloc] init];
    }
    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@,%@", _origin, _size];
}

@end
