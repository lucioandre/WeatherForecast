//
//  APISignalManager.h
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/16/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface APISignalManager : NSObject
- (id)initWithBaseURL:(NSString *)baseURL;
- (RACSignal *)rac_getLocationsForSearchKey:(NSString *)searchKey;
- (RACSignal *)rac_getForecastForLocationDescription:(NSString *)locationDescription;
@end
