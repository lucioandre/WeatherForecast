//
//  APIClientTests.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/21/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APIClient.h"
#import "APIMappingModel.h"
#import "Utils.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>

@interface APIClientTests : XCTestCase
@property (nonatomic, strong) NSString *testEndpoint;
@property (nonatomic, strong) NSArray *jsonFiles;
@property (nonatomic, assign) NSInteger requestCount;
@end

@implementation APIClientTests

- (void)setUp {
    [super setUp];
    [OHHTTPStubs setEnabled:YES];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return [request.URL.absoluteString hasPrefix:self.testEndpoint];
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        NSString *jsonFile = self.jsonFiles[self.requestCount];
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(jsonFile, self.class) statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
}

- (void)tearDown {
    [OHHTTPStubs removeAllStubs];
    [super tearDown];
}

/*!
 * @discussion Execute the unit test for all JSON files that you've added into "jsonFiles" property.
 * @param unitTest A function that will be executed as unit test.
 */
- (void)executeUnitTest:(void (^)())unitTest {
    for (self.requestCount = 0; self.requestCount < self.jsonFiles.count; self.requestCount++) {
        unitTest();
    }
}

- (void)testGetLocationsForSearchKey {
    self.testEndpoint = [NSString stringWithFormat:@"%@%@", @"https://api.worldweatheronline.com", [Utils getEndPointForKey:@"Search"]];
    self.jsonFiles = @[@"GetLocationsForSearchKey.json"];
    
    [self executeUnitTest:^{
        XCTestExpectation *expectation = [self expectationWithDescription:@"Mapping is correct!"];
        [APIClient getLocationsForSearchKey:@"Campinas" andCompletion:^(id response) {
            XCTAssertNotNil(response);
            XCTAssert([response isKindOfClass:[APISearchResults class]]);
            APISearchResults *searchResults = response;
            XCTAssertTrue([searchResults.results count] == 10);
            for (SearchResult *searchRes in searchResults.results) {
                XCTAssertTrue([searchRes.areaNameDescription length]);
                XCTAssertTrue([searchRes.areaNameArray count]);
                XCTAssertTrue([searchRes.regionDescription length]);
                XCTAssertTrue([searchRes.regionArray count]);
                XCTAssertTrue([searchRes.countryDescription length]);
                XCTAssertTrue([searchRes.countryArray count]);
            }
            [expectation fulfill];
        }];
        
        [self waitForExpectations];
    }];

}

- (void)testGetForecastForLocationDescription {
    self.testEndpoint = [NSString stringWithFormat:@"%@%@", @"https://api.worldweatheronline.com", [Utils getEndPointForKey:@"Weather"]];
    self.jsonFiles = @[@"GetForecastForLocationDescription.json"];
    
    [self executeUnitTest:^{
        XCTestExpectation *expectation = [self expectationWithDescription:@"Mapping is correct!"];
        [APIClient getForecastForLocationDescription:@"Campinas" withCompletion:^(id response) {
            XCTAssertNotNil(response);
            XCTAssert([response isKindOfClass:[APIWeatherCondition class]]);
            APIWeatherCondition *weatherCondition = response;
            XCTAssertNotNil(weatherCondition.currentCondition);
            XCTAssertNotNil(weatherCondition.weather);
            XCTAssertTrue([weatherCondition.weather count] == 5);
            for (DayCondition *dayCondition in weatherCondition.weather) {
                XCTAssertNotNil(dayCondition.astronomy);
                XCTAssertNotNil(dayCondition.conditionDetails);
            }
            
            [expectation fulfill];
        }];
        
        [self waitForExpectations];
    }];
}

- (void)waitForExpectations {
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout error: %@", error);
        }
    }];
}

@end
