//
//  SettingsTests.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/21/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Settings.h"

@interface SettingsTests : XCTestCase

@end

@implementation SettingsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetShouldUseFahrenheit {
    [Settings setShouldUseFahrenheit:YES];
    XCTAssert([Settings getShouldUseFahrenheit]);
    [Settings setShouldUseFahrenheit:NO];
    XCTAssert(![Settings getShouldUseFahrenheit]);
}

@end
