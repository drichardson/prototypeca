//
//  NSError+PCAJavaScriptAdditions.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/16/13.
//  Copyright (c) 2013 Doug Richardson. All rights reserved.
//

#import "NSError+PCAJavaScriptAdditions.h"

NSString* const PCAJSErrorDomain = @"PCAJSErrorDomain";

@implementation NSError (PCAJavaScriptAdditions)

+ (NSError*)errorWithJSException:(JSValueRef)exception
{
    // TODO:DOUG Get exception information from JSValueRef
    return [NSError errorWithDomain:PCAJSErrorDomain code:1 userInfo:nil];
}

@end
