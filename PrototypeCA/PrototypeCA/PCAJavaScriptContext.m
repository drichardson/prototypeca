//
//  PCAJavaScriptContext.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/16/13.
//  Copyright (c) 2013 Doug Richardson. All rights reserved.
//

#import "PCAJavaScriptContext.h"
#import "NSString+PCAJavaScriptAdditions.h"
#import "NSError+PCAJavaScriptAdditions.h"
#import "PCAJSUndefinedValue.h"
#import <QuartzCore/QuartzCore.h>
#import <assert.h>

@interface PCAJavaScriptContext ()
- (void)_initializeJSContext;
@end

@implementation PCAJavaScriptContext

- (id)init
{
    self = [super init];
    if (self) {
        _layer = [CALayer layer];
        [self _initializeJSContext];
    }
    return self;
}

- (void)_initializeJSContext
{
    _globalContext = JSGlobalContextCreate(NULL);
}

- (void)runScriptAtPath:(NSString*)path error:(NSError**)errorOut
{
    NSError* error = nil;
    NSString* script = [NSString stringWithContentsOfFile:path usedEncoding:Nil error:&error];
    if (script == nil) {
        goto done;
    }
    
    JSStringRef jsScript = [script jsCopy];
    JSStringRef jsSourceURL = [path jsCopy];
    JSValueRef exception = NULL;
    JSValueRef result = JSEvaluateScript(_globalContext, jsScript, NULL, jsSourceURL, 1, &exception);
    
    if (result == NULL) {
        error = [NSError errorWithJSException:exception];
        NSLog(@"Error evaluating script at %@. %@", path, [error localizedDescription]);
    }
    
done:
    if (errorOut) {
        *errorOut = error;
    }
}

+ (id)_valueToObject:(JSValueRef)value inContext:(JSContextRef)context containerObjectsSeen:(NSMutableSet*)containersSeen
{
    switch (JSValueGetType(context, value)) {
        case kJSTypeNull:
            return nil;
        case kJSTypeBoolean:
            return [NSNumber numberWithBool:JSValueToBoolean(context, value)];
        case kJSTypeNumber:
            return [NSNumber numberWithDouble:JSValueToNumber(context, value, NULL)];
        case kJSTypeString:
        {
            JSStringRef s = JSValueToStringCopy(context, value, NULL);
            NSString* result = [NSString stringWithJSStringRef:s];
            JSStringRelease(s);
            return result;
        }
        case kJSTypeObject:
        {
            // if it's a custom object, get the private data out and that will be the backing
            // object to return.
            
            JSObjectRef object = JSValueToObject(context, value, NULL);
            void* private = JSObjectGetPrivate(object);
            if (private) {
                return (__bridge NSObject*)private;
            } else {
                // TODO: if this is a built in JavaScript object like Date then convert to NSDate.
                // if it's a dictionary or array, convert to NSDictionary or NSArray.
                NSLog(@"NOT IMPEMENTED 12312312");
                
                JSPropertyNameArrayRef propertyNames = JSObjectCopyPropertyNames(context, object);
                size_t count = JSPropertyNameArrayGetCount(propertyNames);
                NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:count];
                for(size_t i = 0; i < count; ++i) {
                    if ([containersSeen containsObject:[NSValue valueWithPointer:value]])
                    {
                        // TODO: Propagate log
                        // TODO: Create a recursive dictionary. Save the value you already converted and shove it in?
                        NSLog(@"Recursive dictionary. ")
                        NSString* key = [NSString stringWithJSStringRef:JSPropertyNameArrayGetNameAtIndex(propertyNames, i)];
                }
                    JSPropertyNameArrayRelease(propertyNames);
            }
            
            break;
        }
        case kJSTypeUndefined:
            return [[PCAJSUndefinedValue alloc] init];
    }
    
    assert(false);
    return nil;
}

+ (id)valueToObject:(JSValueRef)value inContext:(JSContextRef)context
{
    return [self _valueToObject:value inContext:context containerObjectsSeen:[NSMutableSet set]];
}

@end
