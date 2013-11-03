//
//  PCADocumentView.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 11/2/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import Cocoa;

@protocol PCADocumentViewDelegate;

@interface PCADocumentView : NSView
@property (nonatomic, weak) IBOutlet id <PCADocumentViewDelegate> delegate;
@end


@protocol PCADocumentViewDelegate <NSObject>
@required
- (void)documentView:(PCADocumentView*)view didReceiveKeyDownEvent:(NSEvent*)event;
- (void)documentView:(PCADocumentView*)view didReceiveKeyUpEvent:(NSEvent*)event;
@end
