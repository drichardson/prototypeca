//
//  PCASize.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/26/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCASize.h"

@implementation PCASize
{
    CGSize _cgSize;
}

+ (PCASize*)makeSizeWidth:(double)width height:(double)height
{
    PCASize* result = [[PCASize alloc] init];
    result.width = width;
    result.height = height;
    return result;
}

- (double)width
{
    return _cgSize.width;
}

- (void)setWidth:(double)width
{
    _cgSize.width = width;
}

- (double)height
{
    return _cgSize.height;
}

- (void)setHeight:(double)height
{
    _cgSize.height = height;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"{%f, %f}", _cgSize.width, _cgSize.height];
}

@end
