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

static NSString * const baseEndPoint = @"/premium/v1/weather.ashx";
static NSString * const worldWeatherOnlineAPIKey = @"6199285363b948979fa31009161608&";


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
    NSDictionary *dic = @{@"key":worldWeatherOnlineAPIKey, @"q":searchKey, @"format":@"json", @"num_of_days":@"5"};
    //Once we are using only one endPoint in this app, it is okay to keep a constant, but if we have more than one is better to use a PList file.
    return [self.manager rac_GET:baseEndPoint parameters:dic];
}

@end
