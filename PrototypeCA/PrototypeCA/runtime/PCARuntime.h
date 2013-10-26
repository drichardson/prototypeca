//
//  PCARuntime.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/24/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import Foundation;
@import QuartzCore;
@import JavaScriptCore;


/// PCARuntime provides the JavaScript runtime for PrototypeCA. This code should be
/// sharable between OS X and iOS.
@interface PCARuntime : NSObject

/// \brief The root layer used by this \c PCARuntime
@property (nonatomic, strong) CALayer* layer;

/// \brief The JSContext used to by this \c PCARuntime.
@property (atomic, strong) JSContext* context;

@end
