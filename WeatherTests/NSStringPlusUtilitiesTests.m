//
//  NSStringPlusUtilitiesTests.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/21/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Utilities.h"

@interface NSStringPlusUtilitiesTests : XCTestCase

@end

@implementation NSStringPlusUtilitiesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMilimetersString {
    NSString *milimeter1 = @"23";
    NSString *milimeter2 = @"44mm";
    XCTAssert([milimeter1 milimeterString]);
    XCTAssertTrue([[milimeter1 milimeterString] isEqualToString:@"23mm"]);
    XCTAssert([milimeter2 milimeterString]);
    XCTAssertTrue([[milimeter2 milimeterString] isEqualToString:milimeter2]);
}

- (void)testTemperatureDegreeString {
    NSString *temperatureDegree1 = @"72";
    NSString *temperatureDegree2 = @"54º";
    XCTAssert([temperatureDegree1 temperatureDegreeString]);
    XCTAssertTrue([[temperatureDegree1 temperatureDegreeString] isEqualToString:@"72º"]);
    XCTAssert([temperatureDegree2 temperatureDegreeString]);
    XCTAssertTrue([[temperatureDegree2 temperatureDegreeString] isEqualToString:temperatureDegree2]);
}

- (void)testPercentageString {
    NSString *percentage1 = @"93";
    NSString *percentage2 = @"22%";
    XCTAssert([percentage1 percentageString]);
    XCTAssertTrue([[percentage1 percentageString] isEqualToString:@"93%"]);
    XCTAssert([percentage2 percentageString]);
    XCTAssertTrue([[percentage2 percentageString] isEqualToString:percentage2]);
}

@end
