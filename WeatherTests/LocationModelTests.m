//
//  LocationModelTests.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/21/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LocationModel.h"
#import "Location.h"
#import "APIMappingModel.h"

@interface LocationModelTests : XCTestCase
@property (nonatomic, strong) SearchResult *searchResultMock;
@end

@implementation LocationModelTests

- (void)setUp {
    [super setUp];
    
    if (!self.searchResultMock) {
        self.searchResultMock = [[SearchResult alloc] init];
        self.searchResultMock.areaNameDescription = @"Santa Rita de Caldas";
        self.searchResultMock.regionDescription = @"Minas Gerais";
        self.searchResultMock.countryDescription = @"Brazil";
        self.searchResultMock.latitude = @"-40.0023";
        self.searchResultMock.longitude = @"-23.4555";
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)waitForExpectations {
    [self waitForExpectationsWithTimeout:3.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout error: %@", error);
        }
    }];
}

- (void)test_1_InsertAsyncNewLocationForSearchResult {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Insert was successful!"];
    [LocationModel insertAsyncNewLocationForSearchResult:self.searchResultMock completion:^(Location *location) {
        XCTAssert(location);
        XCTAssertTrue([location.areaName isEqualToString:self.searchResultMock.areaNameDescription]);
        XCTAssertTrue([location.region isEqualToString:self.searchResultMock.regionDescription]);
        XCTAssertTrue([location.country isEqualToString:self.searchResultMock.countryDescription]);
        XCTAssertTrue([location.latitude floatValue] == [self.searchResultMock.latitude floatValue]);
        XCTAssertTrue([location.longitude floatValue] == [self.searchResultMock.longitude floatValue]);
        
        [expectation fulfill];
    }];

    [self waitForExpectations];
}

- (void)test_2_FetchAsyncAllLocations {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetch brought object with success!"];
    [LocationModel fetchAsyncAllLocations:^(NSArray *locations) {
        XCTAssert(locations);
        XCTAssert([locations count]);
        for (Location *location in locations) {
            if ([location.areaName isEqualToString:self.searchResultMock.areaNameDescription] &&
                [location.region isEqualToString:self.searchResultMock.regionDescription] &&
                [location.country isEqualToString:self.searchResultMock.countryDescription] &&
                [location.latitude floatValue] == [self.searchResultMock.latitude floatValue] &&
                [location.longitude floatValue] == [self.searchResultMock.longitude floatValue]) {
                //We found the object just added
                [expectation fulfill];
                break;
            }
        }
    }];
    [self waitForExpectations];
}

- (void)test_3_DeleteAsyncLocation {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Delete ocurred with success!"];
    [LocationModel fetchAsyncAllLocations:^(NSArray *locationsBeforeDeletion) {
        XCTAssert(locationsBeforeDeletion);
        NSInteger countBeforeDelete = [locationsBeforeDeletion count];
        XCTAssert(countBeforeDelete);
        Location *locationToDelete;
        for (Location *location in locationsBeforeDeletion) {
            if ([location.areaName isEqualToString:self.searchResultMock.areaNameDescription] &&
                [location.region isEqualToString:self.searchResultMock.regionDescription] &&
                [location.country isEqualToString:self.searchResultMock.countryDescription] &&
                [location.latitude floatValue] == [self.searchResultMock.latitude floatValue] &&
                [location.longitude floatValue] == [self.searchResultMock.longitude floatValue]) {
                
                locationToDelete = location;
                break;
            }
        }
        XCTAssert(locationToDelete, "Delete object invalid. Load fecth async test before");
        [LocationModel deleteAsyncLocation:locationToDelete andCompletion:^{
            [LocationModel fetchAsyncAllLocations:^(NSArray *locationsAfterDeletion) {
                XCTAssert(locationsAfterDeletion);
                XCTAssertTrue([locationsAfterDeletion count] < countBeforeDelete);
                for (Location *location in locationsAfterDeletion) {
                    XCTAssertFalse([location.areaName isEqualToString:self.searchResultMock.areaNameDescription] &&
                                   [location.region isEqualToString:self.searchResultMock.regionDescription] &&
                                   [location.country isEqualToString:self.searchResultMock.countryDescription] &&
                                   [location.latitude floatValue] == [self.searchResultMock.latitude floatValue] &&
                                   [location.longitude floatValue] == [self.searchResultMock.longitude floatValue]);
                }
                [expectation fulfill];
            }];
        }];
    }];
    
    [self waitForExpectations];
}

@end
