//
//  ForecastViewControllerTests.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/21/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ForecastViewController.h"

@interface ForecastViewControllerTests : XCTestCase
@property (nonatomic, strong) ForecastViewController *forecastViewController;
@end

@interface ForecastViewController ()
- (NSString *)getWeekdayStringForDate:(NSString *)dateString;
- (NSArray *)formatDetailedConditionsInfoArrayForDayCondition:(DayCondition *)dayCondition;
@end

@implementation ForecastViewControllerTests

- (void)setUp {
    [super setUp];
    self.forecastViewController = [[ForecastViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetWeekdayStringForDate {
    XCTAssertTrue([[self.forecastViewController getWeekdayStringForDate:@"2016-08-20"] isEqualToString:@"Saturday"]);
    XCTAssertTrue([[self.forecastViewController getWeekdayStringForDate:@"2016-02-29"] isEqualToString:@"Monday"]);
    XCTAssertTrue([[self.forecastViewController getWeekdayStringForDate:@"2016-08-21"] isEqualToString:@"Sunday"]);
}

- (void)testFormatDetailedConditionsInfoArrayForDayCondition {
    DayCondition *dayCondition = [[DayCondition alloc] init];
    dayCondition.conditionDetails = [[DayConditionDetails alloc]init];
    dayCondition.astronomy = [[Astronomy alloc] init];
    
    dayCondition.conditionDetails.windspeedKmph = @"50";
    dayCondition.conditionDetails.precipMM = @"50";
    dayCondition.conditionDetails.chanceofrain = @"50";
    dayCondition.conditionDetails.chanceofwindy = @"50";
    dayCondition.conditionDetails.chanceofovercast = @"50";
    dayCondition.conditionDetails.chanceofsunshine = @"50";
    dayCondition.conditionDetails.chanceoffrost = @"50";
    dayCondition.conditionDetails.chanceofhightemp = @"50";
    dayCondition.conditionDetails.chanceoffog = @"50";
    dayCondition.conditionDetails.chanceofsnow = @"50";
    dayCondition.conditionDetails.chanceofthunder = @"50";
    dayCondition.uvIndex = @"7";
    dayCondition.astronomy.sunrise = @"6AM";
    dayCondition.astronomy.sunset = @"6PM";
    dayCondition.astronomy.moonrise = @"6PM";
    dayCondition.astronomy.moonset = @"6AM";
    
    NSArray *resultArray = [self.forecastViewController formatDetailedConditionsInfoArrayForDayCondition:dayCondition];
    XCTAssert(resultArray);
    for (NSDictionary *dic in resultArray) {
        XCTAssert(dic);
        XCTAssertNotNil([dic objectForKey:@"value"]);
        XCTAssertNotNil([dic objectForKey:@"title"]);
    }
}

@end
