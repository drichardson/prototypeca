//
//  PCAMediaTimingExports.h
//  PrototypeCA
//
//  Created by Douglas Richardson on 10/27/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

@import JavaScriptCore;

@protocol PCAMediaTimingExports <JSExport>
@property (nonatomic) CFTimeInterval beginTime;
@property (nonatomic) CFTimeInterval duration;
@property (nonatomic) float speed;
@property (nonatomic) CFTimeInterval timeOffset;
@property (nonatomic) float repeatCount;
@property (nonatomic) CFTimeInterval repeatDuration;
@property (nonatomic) BOOL autoreverses;
@property (nonatomic, copy) NSString* fillMode;
@end
