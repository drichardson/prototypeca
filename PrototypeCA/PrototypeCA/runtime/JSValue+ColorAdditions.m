//
//  JSValue+ColorAdditions.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/26/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "JSValue+ColorAdditions.h"

@implementation JSValue (ColorAdditions)

+ (JSValue*)valueWithCGColor:(CGColorRef)color inContext:(JSContext *)context
{
    CGFloat const* components = CGColorGetComponents(color);
    size_t count = CGColorGetNumberOfComponents(color);
    JSValue* result = nil;
    
    if (count == 3 || count == 4) {
        result = [JSValue valueWithNewObjectInContext:context];
        result[@"red"] = [JSValue valueWithDouble:components[0] inContext:context];
        result[@"green"] = [JSValue valueWithDouble:components[1] inContext:context];
        result[@"blue"] = [JSValue valueWithDouble:components[2] inContext:context];
        
        if (count == 4) {
            result[@"alpha"] = [JSValue valueWithDouble:components[3] inContext:context];
        }
    } else {
        context.exception = [JSValue valueWithNewErrorFromMessage:@"Expected 3 or 4 color components" inContext:context];
    }
    
    return result;
}

static inline double clamp(double x) {
    return fmin(1, fmax(0, x));
}

- (CGColorRef)toCGColor
{
    double red = clamp([self[@"red"] toDouble]);
    double green = clamp([self[@"green"] toDouble]);
    double blue = clamp([self[@"blue"] toDouble]);
    double alpha = 1;
    
    JSValue* alphaValue = self[@"alpha"];
    if (alphaValue) {
        alpha = clamp([alphaValue toDouble]);
    }
    
    return CGColorCreateGenericRGB(red, green, blue, alpha);
}
@end
