//
//  PCAViewerWindowController.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/25/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import Cocoa;
#import "PCARuntime.h"

@interface PCAViewerWindowController : NSWindowController
@property (nonatomic, strong) PCARuntime* runtime;
@end
