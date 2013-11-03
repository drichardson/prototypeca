//
//  PCARuntimeEvent.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 11/2/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import JavaScriptCore;

@interface PCARuntimeEvent : NSObject
@end

typedef NS_ENUM(NSUInteger, PCAKeyDirection) {
    PCAKeyUp,
    PCAKeyDown
};

@protocol PCARuntimeKeyEventExports <JSExport>
@property (nonatomic, readonly) NSString* key;
@property (nonatomic, readonly) NSString* direction;
@property (nonatomic, readonly) unsigned short keyCode;
@end

@interface PCARuntimeKeyEvent : PCARuntimeEvent <PCARuntimeKeyEventExports>
@property (nonatomic, readonly) NSString* key;
@property (nonatomic, readonly) PCAKeyDirection keyDirection;
- (instancetype)initWithKey:(NSString*)key withDirection:(PCAKeyDirection)direction withKeyCode:(unsigned short)keyCode;
@end

