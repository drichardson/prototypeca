//
//  PCARect.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/26/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCAPoint.h"
#import "PCASize.h"

@import JavaScriptCore;
@import CoreGraphics;

@class PCARect;

@protocol PCARectExports <JSExport>
@property (nonatomic, strong) PCAPoint* origin;
@property (nonatomic, strong) PCASize* size;
- (NSString*)description;
+ (PCARect*)makeRectX:(double)x y:(double)y width:(double)width height:(double)height;
@end

@interface PCARect : NSObject <PCARectExports>
@property (nonatomic, readwrite) CGRect cgRect;
@end

