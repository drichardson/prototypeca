//
//  NSString+PCAJavaScriptAdditions.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/16/13.
//  Copyright (c) 2013 Doug Richardson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface NSString (PCAJavaScriptAdditions)

+ (NSString*)stringWithJSStringRef:(JSStringRef)stringRef;
- (JSStringRef)jsCopy;
- (JSValueRef)jsMakeInContext:(JSContextRef)context;

@end
