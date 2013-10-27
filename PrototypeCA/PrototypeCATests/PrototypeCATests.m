//
//  PrototypeCATests.m
//  PrototypeCATests
//
//  Created by Douglas Richardson on 10/24/13.
//  Copyright (c) 2013 PrototypeCA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PCARuntime.h"
#import "JSValue+ColorAdditions.h"

@interface PrototypeCATests : XCTestCase
@end

@implementation PrototypeCATests
{
    PCARuntime* runtime;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    runtime = [[PCARuntime alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRuntimeColor
{
    JSValue* v = [runtime.context evaluateScript:@"rgb(1,0.5,0.25)"];
    CGColorRef color = [v toCGColor];
    CGFloat const* comps = CGColorGetComponents(color);
    XCTAssertEqual(CGColorGetNumberOfComponents(color), (size_t)4, @"");
    XCTAssertEqualWithAccuracy(comps[0], 1.0, 0.0001, @"");
    XCTAssertEqualWithAccuracy(comps[1], 0.5, 0.0001, @"");
    XCTAssertEqualWithAccuracy(comps[2], 0.25, 0.0001, @"");
    XCTAssertEqualWithAccuracy(comps[3], 1, 0.0001, @"");
    
    v = [runtime.context evaluateScript:@"rgba(0,0.1,0.01,0.5)"];
    color = [v toCGColor];
    comps = CGColorGetComponents(color);
    XCTAssertEqualWithAccuracy(comps[0], 0.0, 0.0001, @"");
    XCTAssertEqualWithAccuracy(comps[1], 0.1, 0.0001, @"");
    XCTAssertEqualWithAccuracy(comps[2], 0.01, 0.0001, @"");
    XCTAssertEqualWithAccuracy(comps[3], 0.5, 0.0001, @"");
}

@end
