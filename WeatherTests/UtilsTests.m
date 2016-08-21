//
//  UtilsTests.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/21/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Utils.h"

@interface UtilsTests : XCTestCase

@end

@implementation UtilsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetEndPointForKey {
    NSString *endPoint = [Utils getEndPointForKey:@"Search"];
    XCTAssertTrue(endPoint && [endPoint length]);
    XCTAssertTrue([Utils getEndPointForKey:nil]);
    XCTAssertTrue([Utils getEndPointForKey:@""]);
}

@end
