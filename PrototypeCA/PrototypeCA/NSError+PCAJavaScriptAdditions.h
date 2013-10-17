//
//  NSError+PCAJavaScriptAdditions.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/16/13.
//  Copyright (c) 2013 Doug Richardson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

extern NSString* const PCAJSErrorDomain;

@interface NSError (PCAJavaScriptAdditions)

+ (NSError*)errorWithJSException:(JSValueRef)exception;

@end
