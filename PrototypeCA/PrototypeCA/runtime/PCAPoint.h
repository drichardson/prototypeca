//
//  PCAPoint.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/25/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import JavaScriptCore;
@import CoreGraphics;

@class PCAPoint;

@protocol PCAPointExports <JSExport>
@property (nonatomic) double x;
@property (nonatomic) double y;
- (NSString*)description;
+ (PCAPoint*)makePointX:(double)x y:(double)y;
@end

@interface PCAPoint : NSObject <PCAPointExports>
@property (nonatomic, readwrite) CGPoint cgPoint;
@end
