//
//  NSString+PCAJavaScriptAdditions.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/16/13.
//  Copyright (c) 2013 Doug Richardson. All rights reserved.
//

#import "NSString+PCAJavaScriptAdditions.h"

@implementation NSString (PCAJavaScriptAdditions)

+ (NSString*)stringWithJSStringRef:(JSStringRef)stringRef
{
    return (NSString*)CFBridgingRelease(JSStringCopyCFString(kCFAllocatorDefault, stringRef));
}

- (JSStringRef)jsCopy
{
    return JSStringCreateWithCFString((__bridge CFStringRef)self);
}

- (JSValueRef)jsMakeInContext:(JSContextRef)context
{
    JSStringRef string = [self jsCopy];
    JSValueRef value = JSValueMakeString(context, string);
    JSStringRelease(string);
    return value;
}

@end
