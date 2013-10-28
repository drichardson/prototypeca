//
//  PCALayer.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/27/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCALayer.h"
#import "JSValue+ColorAdditions.h"

@implementation PCALayer

#if 0
@property (nonatomic, assign) JSValue* bounds;
@property (nonatomic, assign) JSValue* position;
@property (nonatomic, assign) double zPosition;
@property (nonatomic, assign) JSValue* anchorPoint;
@property (nonatomic, assign) double anchorPointZ;
// TODO: @property CATransform3D transform;
//- (CGAffineTransform)affineTransform;
//- (void)setAffineTransform:(CGAffineTransform)m;
@property (nonatomic, assign) JSValue* frame;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign) BOOL doubleSided;
@property (nonatomic, assign) BOOL geometryFlipped;
#endif

- (instancetype)init
{
    self = [super init];
    if (self) {
        _layer = [CALayer layer];
    }
    return self;
}

- (JSValue*)bounds
{
    return [JSValue valueWithRect:[_layer bounds] inContext:[JSContext currentContext]];
}

- (void)setBounds:(JSValue*)bounds
{
    [_layer setBounds:[bounds toRect]];
}

- (JSValue*)backgroundColor
{
    return [JSValue valueWithCGColor:_layer.backgroundColor inContext:[JSContext currentContext]];
}

- (void)setBackgroundColor:(JSValue *)backgroundColor
{
    [_layer setBackgroundColor:[backgroundColor toCGColor]];
}

@end
