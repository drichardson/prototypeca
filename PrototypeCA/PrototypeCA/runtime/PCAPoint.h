//
//  PCAPoint.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/25/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import JavaScriptCore;
@import CoreGraphics;

@protocol PCAPointExports <JSExport>
@property (nonatomic) double x;
@property (nonatomic) double y;
@end

@interface PCAPoint : NSObject <PCAPointExports>
@property (nonatomic, readwrite) CGPoint cgPoint;
@end
