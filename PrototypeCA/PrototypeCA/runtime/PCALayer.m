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

- (instancetype)initWithLayer:(CALayer*)layer
{
    if (layer == nil) return nil;
    
    self = [super init];
    if (self) {
        _layer = layer;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithLayer:[CALayer layer]];
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[PCALayer class]])
    {
        PCALayer* otherLayer = (PCALayer*)object;
        return [_layer isEqual:[otherLayer layer]];
    }
    
    return NO;
}

- (NSUInteger)hash
{
    return [_layer hash];
}

#pragma mark PCAMediaTimingExports

- (CFTimeInterval)beginTime
{
    return [_layer beginTime];
}

- (void)setBeginTime:(CFTimeInterval)beginTime
{
    [_layer setBeginTime:beginTime];
}

- (CFTimeInterval)duration
{
    return [_layer duration];
}

- (void)setDuration:(CFTimeInterval)duration
{
    [_layer setDuration:duration];
}

- (float)speed
{
    return [_layer speed];
}

- (void)setSpeed:(float)speed
{
    [_layer setSpeed:speed];
}

- (CFTimeInterval)timeOffset
{
    return [_layer timeOffset];
}

- (void)setTimeOffset:(CFTimeInterval)timeOffset
{
    [_layer setTimeOffset:timeOffset];
}

- (float)repeatCount
{
    return [_layer repeatCount];
}

- (void)setRepeatCount:(float)repeatCount
{
    [_layer setRepeatCount:repeatCount];
}

- (CFTimeInterval)repeatDuration
{
    return [_layer repeatDuration];
}

- (void)setRepeatDuration:(CFTimeInterval)repeatDuration
{
    [_layer setRepeatDuration:repeatDuration];
}

- (BOOL)autoreverses
{
    return [_layer autoreverses];
}

- (void)setAutoreverses:(BOOL)autoreverses
{
    [_layer setAutoreverses:autoreverses];
}

- (NSString*)fillMode
{
    return [_layer fillMode];
}

- (void)setFillMode:(NSString *)fillMode
{
    [_layer setFillMode:fillMode];
}


#pragma mark PCALayerExports

- (JSValue*)bounds
{
    return [JSValue valueWithRect:[_layer bounds] inContext:[JSContext currentContext]];
}

- (void)setBounds:(JSValue*)bounds
{
    [_layer setBounds:[bounds toRect]];
}

- (JSValue*)position
{
    return [JSValue valueWithPoint:[_layer position] inContext:[JSContext currentContext]];
}

- (void)setPosition:(JSValue*)position
{
    [_layer setPosition:[position toPoint]];
}

- (double)zPosition
{
    return [_layer zPosition];
}

- (void)setZPosition:(double)zPosition
{
    [_layer setZPosition:zPosition];
}

- (JSValue*)anchorPoint
{
    return [JSValue valueWithPoint:[_layer anchorPoint] inContext:[JSContext currentContext]];
}

- (void)setAnchorPoint:(JSValue *)anchorPoint
{
    [_layer setAnchorPoint:[anchorPoint toPoint]];
}

- (double)anchorPointZ
{
    return [_layer anchorPointZ];
}

- (void)setAnchorPointZ:(double)anchorPointZ
{
    [_layer setAnchorPointZ:anchorPointZ];
}

- (JSValue*)frame
{
    return [JSValue valueWithRect:[_layer frame] inContext:[JSContext currentContext]];
}

- (void)setFrame:(JSValue *)frame
{
    [_layer setFrame:[frame toRect]];
}

- (BOOL)isHidden
{
    return [_layer isHidden];
}

- (void)setHidden:(BOOL)hidden
{
    [_layer setHidden:hidden];
}

- (BOOL)isDoubleSided
{
    return [_layer isDoubleSided];
}

- (void)setDoubleSided:(BOOL)doubleSided
{
    [_layer setDoubleSided:doubleSided];
}

- (BOOL)isGeometryFlipped
{
    return [_layer isGeometryFlipped];
}

- (void)setGeometryFlipped:(BOOL)geometryFlipped
{
    [_layer setGeometryFlipped:geometryFlipped];
}

- (BOOL)contentsAreFlipped
{
    return [_layer contentsAreFlipped];
}

- (PCALayer*)superlayer
{
    PCALayer* result = nil;
    CALayer* superCALayer = [_layer superlayer];
    if (superCALayer) {
        result = [[PCALayer alloc] initWithLayer:superCALayer];
    }
    return result;
}

- (void)removeFromSuperlayer
{
    [_layer removeFromSuperlayer];
}

- (NSArray*)sublayers
{
    NSArray* subCALayers = [_layer sublayers];
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:[subCALayers count]];
    for(CALayer* caLayer in subCALayers) {
        PCALayer* pcaLayer = [[PCALayer alloc] initWithLayer:caLayer];
        [result addObject:pcaLayer];
    }
    return result;
}

- (void)setSublayers:(NSArray *)sublayers
{
    NSMutableArray* caSublayers = [NSMutableArray arrayWithCapacity:[sublayers count]];
    for(PCALayer* pcaLayer in sublayers) {
        [caSublayers addObject:[pcaLayer layer]];
    }
    [[self layer] setSublayers:caSublayers];
}

- (void)addSublayer:(PCALayer*)layer
{
    [_layer addSublayer:layer.layer];
}

- (void)insertSublayer:(PCALayer*)layer atIndex:(unsigned)idx
{
    [_layer insertSublayer:[layer layer] atIndex:idx];
}

- (void)insertSublayer:(PCALayer*)layer below:(PCALayer*)sibling
{
    [_layer insertSublayer:[layer layer] below:[sibling layer]];
}

- (void)insertSublayer:(PCALayer*)layer above:(PCALayer*)sibling
{
    [_layer insertSublayer:[layer layer] above:[sibling layer]];
}

- (void)replaceSublayer:(PCALayer*)layer with:(PCALayer*)layer2
{
    [_layer replaceSublayer:[layer layer] with:[layer2 layer]];
}

- (PCALayer*)mask
{
    CALayer* caMask = [_layer mask];
    PCALayer* result = nil;
    if (caMask) {
        result = [[PCALayer alloc] initWithLayer:caMask];
    }
    return result;
}

- (void)setMask:(PCALayer*)mask
{
    [_layer setMask:[mask layer]];
}

- (BOOL)masksToBounds
{
    return [_layer masksToBounds];
}

- (void)setMasksToBounds:(BOOL)masksToBounds
{
    [_layer setMasksToBounds:masksToBounds];
}

- (JSValue*)backgroundColor
{
    return [JSValue valueWithCGColor:_layer.backgroundColor inContext:[JSContext currentContext]];
}

- (void)setBackgroundColor:(JSValue *)backgroundColor
{
    [_layer setBackgroundColor:[backgroundColor toCGColor]];
}

- (CGFloat)cornerRadius
{
    return [_layer cornerRadius];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    [_layer setCornerRadius:cornerRadius];
}

- (CGFloat)borderWidth
{
    return [_layer borderWidth];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    [_layer setBorderWidth:borderWidth];
}

- (void)setBorderColor:(JSValue *)borderColor
{
    [_layer setBorderColor:[borderColor toCGColor]];
}

- (JSValue*)borderColor
{
    return [JSValue valueWithCGColor:[_layer borderColor] inContext:[JSContext currentContext]];
}

- (float)opacity
{
    return [_layer opacity];
}

- (void)setOpacity:(float)opacity
{
    [_layer setOpacity:opacity];
}

@end
