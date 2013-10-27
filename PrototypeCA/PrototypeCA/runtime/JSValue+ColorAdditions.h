//
//  JSValue+ColorAdditions.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/26/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import JavaScriptCore;

@interface JSValue (ColorAdditions)
+ (JSValue*)valueWithCGColor:(CGColorRef)color inContext:(JSContext *)context;
- (CGColorRef)toCGColor;
@end
