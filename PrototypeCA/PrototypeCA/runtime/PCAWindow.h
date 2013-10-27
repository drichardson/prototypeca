//
//  PCAWindow.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/25/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import JavaScriptCore;

@protocol PCAWindowExports <JSExport>
@end

@interface PCAWindow : NSObject
@property (nonatomic, strong) NSWindow* window;
@end
