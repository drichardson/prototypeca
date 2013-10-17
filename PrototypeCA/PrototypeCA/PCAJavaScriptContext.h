//
//  PCAJavaScriptContext.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/16/13.
//  Copyright (c) 2013 Doug Richardson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class CALayer;
@protocol PCAJavaScriptContextDelegate;

@interface PCAJavaScriptContext : NSObject

@property (nonatomic, readonly) CALayer* layer;
@property (nonatomic, readonly) JSGlobalContextRef globalContext;
@property (nonatomic, weak) NSObject <PCAJavaScriptContextDelegate>* delegate;

- (void)runScriptAtPath:(NSString*)path error:(NSError**)error;

// Returns nil for JavaScript null
// Returns instance of PCAJSUndefinedValue if undefined.
// Otherwise, returns an object that makes sense.
+ (id)valueToObject:(JSValueRef)value inContext:(JSContextRef)context;

@end


@protocol PCAJavaScriptContextDelegate <NSObject>

@optional
- (void)javaScriptContext:(PCAJavaScriptContext*)context logMessage:(NSString*)message;

@end
