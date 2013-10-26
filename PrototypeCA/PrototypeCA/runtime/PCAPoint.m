//
//  PCAPoint.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/25/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCAPoint.h"

@implementation PCAPoint

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

@end
