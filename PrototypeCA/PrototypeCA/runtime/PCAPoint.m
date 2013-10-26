//
//  PCAPoint.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/25/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCAPoint.h"

@implementation PCAPoint

+ (PCAPoint*)makePointX:(double)x y:(double)y
{
    PCAPoint* result = [[PCAPoint alloc] init];
    result.x = x;
    result.y = y;
    return result;
}

- (double)x
{
    return _cgPoint.x;
}

- (void)setX:(double)x
{
    _cgPoint.x = x;
}

- (double)y
{
    return _cgPoint.y;
}

- (void)setY:(double)y
{
    _cgPoint.y = y;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"{%f, %f}", _cgPoint.x, _cgPoint.y];
}

@end
