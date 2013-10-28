//
//  PCALayer.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/27/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import JavaScriptCore;

@protocol PCALayerExports <JSExport>

@property (nonatomic, assign) JSValue* bounds;

#if 0
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

@property (nonatomic, assign) JSValue* backgroundColor;

@end

@interface PCALayer : NSObject <PCALayerExports>
@property (nonatomic, readonly) CALayer* layer;
@end
