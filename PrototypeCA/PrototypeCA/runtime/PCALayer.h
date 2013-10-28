//
//  PCALayer.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/27/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import JavaScriptCore;

#import "PCAMediaTimingExports.h"

@class PCALayer;

@protocol PCALayerExports <JSExport>

@property (nonatomic, assign) JSValue* bounds;
@property (nonatomic, assign) JSValue* position;
@property (nonatomic, assign) double zPosition;
@property (nonatomic, assign) JSValue* anchorPoint;
@property (nonatomic, assign) double anchorPointZ;
// TODO: @property CATransform3D transform;
//- (CGAffineTransform)affineTransform;
//- (void)setAffineTransform:(CGAffineTransform)m;
@property (nonatomic, assign) JSValue* frame;
@property (getter=isHidden, nonatomic, assign) BOOL hidden;
@property (getter=isDoubleSided, nonatomic, assign) BOOL doubleSided;
@property (getter=isGeometryFlipped, nonatomic, assign) BOOL geometryFlipped;
@property (nonatomic, readonly) BOOL contentsAreFlipped;
@property (nonatomic, readonly) PCALayer *superlayer;
- (void)removeFromSuperlayer;
@property(nonatomic, copy) NSArray* sublayers;
- (void)addSublayer:(PCALayer*)layer;
- (void)insertSublayer:(PCALayer*)layer atIndex:(unsigned)idx;
- (void)insertSublayer:(PCALayer*)layer below:(PCALayer*)sibling;
- (void)insertSublayer:(PCALayer*)layer above:(PCALayer*)sibling;
- (void)replaceSublayer:(PCALayer*)layer with:(PCALayer*)layer2;
// TODO: @property CATransform3D sublayerTransform;
@property (nonatomic, retain) PCALayer *mask;
@property (nonatomic) BOOL masksToBounds;

// TODO missing a bunch of properties in CALayer between masksToBounds and backgroundColor

@property (nonatomic, assign) JSValue* backgroundColor;
@property CGFloat cornerRadius;
@property CGFloat borderWidth;
@property (nonatomic, assign) JSValue* borderColor;
@property float opacity;

@end

@interface PCALayer : NSObject <PCALayerExports, PCAMediaTimingExports>

/// \brief initialize with an existing CALayer.
- (instancetype)initWithLayer:(CALayer*)layer;

/// \brief initialize and create a new CALayer.
- (instancetype)init;

@property (nonatomic, readonly) CALayer* layer;
@end
