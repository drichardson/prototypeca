//
//  PCAConsole.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/25/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import Foundation;
@import JavaScriptCore;

@protocol PCAConsoleExports <JSExport>
@required
- (void)log:(NSString*)message;
@end

@interface PCAConsole : NSObject <PCAConsoleExports>
@end
