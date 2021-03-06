//
//  APISignalManager.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/16/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "APISignalManager.h"
#import "AFNetworking.h"
#import "RACAFNetworking.h"
#import "Utils.h"

static NSString * const worldWeatherOnlineAPIKey = @"80407676a49b4c94b66161329171407";


@interface APISignalManager ()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end

@implementation APISignalManager

- (id)initWithBaseURL:(NSString *)baseURL {
    self = [super init];
    if (self == nil)
        return nil;
    NSURL *url = [NSURL URLWithString:baseURL];
    self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return self;
}

- (RACSignal *)rac_getLocationsForSearchKey:(NSString *)searchKey {
    NSDictionary *dic = @{@"key":worldWeatherOnlineAPIKey, @"q":searchKey, @"format":@"json"};
    NSString *endPoint = [Utils getEndPointForKey:@"Search"];
    return [[self.manager rac_GET:endPoint parameters:dic] map:^id(RACTuple *tuple) {
        return [tuple first];
    }];
}

- (RACSignal *)rac_getForecastForLocationDescription:(NSString *)locationDescription {
    NSDictionary *dic = @{@"key":worldWeatherOnlineAPIKey, @"q":locationDescription, @"format":@"json", @"num_of_days":@"5", @"tp":@"24"};
    NSString *endPoint = [Utils getEndPointForKey:@"Weather"];
    return [[self.manager rac_GET:endPoint parameters:dic] map:^id(RACTuple *tuple) {
        return [tuple first];
    }];
}

@end
