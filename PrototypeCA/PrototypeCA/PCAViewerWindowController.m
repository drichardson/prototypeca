//
//  PCAViewerWindowController.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/16/13.
//  Copyright (c) 2013 Doug Richardson. All rights reserved.
//

#import "PCAViewerWindowController.h"
#import "PCAJavaScriptContext.h"

@interface PCAViewerWindowController () <PCAJavaScriptContextDelegate>

@end

@implementation PCAViewerWindowController
{
    NSString* _scriptPath;
    PCAJavaScriptContext* _jsContext;
}

- (id)initWithScriptAtPath:(NSString*)path
{
    self = [super initWithWindowNibName:@"PCAViewerWindowController" owner:self];
    if (self) {
        // Initialization code here.
        _scriptPath = [path copy];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    _jsContext = [[PCAJavaScriptContext alloc] init];
    _jsContext.delegate = self;
    [[[[self window] contentView] layer] addSublayer:_jsContext.layer];
    NSError* error = nil;
    [_jsContext runScriptAtPath:_scriptPath error:&error];
    
    if (error) {
        NSLog(@"Error while evaluating script at path %@. %@", _scriptPath, [error localizedDescription]);
        // TODO: Report error to user.
    }
}


#pragma mark PCAJavaScriptContextDelegate
- (void)javaScriptContext:(PCAJavaScriptContext *)context logMessage:(NSString *)message
{
    // TODO: Turn this into a log window easily accessible from the app.
    NSLog(@"JSLOG: %@", message);
}

@end
