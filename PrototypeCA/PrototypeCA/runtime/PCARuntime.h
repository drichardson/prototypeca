//
//  PCARuntime.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/24/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import QuartzCore;
@import JavaScriptCore;

@protocol PCARuntimeDelegate;

@class PCARuntimeEvent;

/// \brief PCARuntime provides the JavaScript runtime for PrototypeCA. This code should be portable
/// between iOS and OS X. Non-portable code should be implemented by the delegate.
@interface PCARuntime : NSObject

/// \brief Initialize an PCARuntime object with the given delegate. The delegate implements applications
/// and OS specific parts of the runtime.
- (instancetype)initWithDelegate:(id <PCARuntimeDelegate>)delegate;

/// \brief The purpose of the delegate is to customer the PCARuntime object for a particular
/// application as well as handle OS specific tasks, such as working with windows.
@property (nonatomic, weak) id <PCARuntimeDelegate> delegate;

/// \brief The root layer used by this \c PCARuntime
@property (nonatomic, strong) CALayer* layer;

/// \brief The JSContext used to by this \c PCARuntime.
@property (atomic, strong) JSContext* context;

/// \brief Send an event to the runtime. For example, a key down event.
- (void)sendEvent:(PCARuntimeEvent*)event;

@end

@protocol PCARuntimeDelegate <NSObject>
@required
/// \brief Called when console.log() is invoked in JavaScript.
- (void)runtime:(PCARuntime*)runtime consoleLogMessage:(NSString*)msg;
@end
