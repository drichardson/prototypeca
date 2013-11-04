//
//  PCADisplayLink.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 11/3/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import JavaScriptCore;

@protocol PCADisplayLinkExports <JSExport>
- (void)start;
- (void)stop;
@property (nonatomic, strong) JSValue* callback;
@end

@interface PCADisplayLink : NSObject <PCADisplayLinkExports>
@end
