//
//  PCADocumentView.m
//  PrototypeCA
//
//  Created by Douglas Richardson on 11/2/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import "PCADocumentView.h"

@implementation PCADocumentView

- (BOOL)acceptsFirstResponder
{
    return YES;
}

- (void)keyDown:(NSEvent *)theEvent
{
    [_delegate documentView:self didReceiveKeyDownEvent:theEvent];
}

- (void)keyUp:(NSEvent *)theEvent
{
    [_delegate documentView:self didReceiveKeyUpEvent:theEvent];
}

@end
