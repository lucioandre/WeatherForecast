//
//  APIClient.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/16/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "APIClient.h"
#import "APISignalManager.h"
#import <ReactiveCocoa.h>
#import "Mantle.h"
#import "APIMappingModel.h"

static NSString * const baseURL = @"https://api.worldweatheronline.com";

@interface APIClient ()
@property (nonatomic, strong) APISignalManager *manager;
@end

@implementation APIClient

+ (APIClient *)instance {
    static APIClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.manager = [[APISignalManager alloc] initWithBaseURL:baseURL];
    }
    return self;
}

+ (void)getLocationsForSearchKey:(NSString *)searchKey andCompletion:(void (^)(id response))completion {
    [[[self instance].manager rac_getLocationsForSearchKey:searchKey] subscribeNext:^(id x) {
        APISearchResults *response = [MTLJSONAdapter modelOfClass:[APISearchResults class] fromJSONDictionary:x error:nil];
        if (completion) {
            completion(response);
        }
    } error:^(NSError *error) {
        completion(error);
    }];
}

+ (void)getForecastForLocationDescription:(NSString *)locationDescription withCompletion:(void (^)(id response))completion {
    [[[self instance].manager rac_getForecastForLocationDescription:locationDescription] subscribeNext:^(id x) {
        APISearchResults *response = [MTLJSONAdapter modelOfClass:[APIWeatherCondition class] fromJSONDictionary:x error:nil];
        if (completion) {
            completion(response);
        }
    } error:^(NSError *error) {
        completion(error);
    }];
}

@end
