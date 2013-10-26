//
//  PCASize.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/26/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import JavaScriptCore;
@import CoreGraphics;

@class PCASize;

@protocol PCASizeExports <JSExport>
@property (nonatomic) double width;
@property (nonatomic) double height;
- (NSString*)description;
+ (PCASize*)makeSizeWidth:(double)width height:(double)height;
@end

@interface PCASize : NSObject <PCASizeExports>
@property (nonatomic, readwrite) CGSize cgSize;
@end
