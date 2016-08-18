//
//  APIClient.h
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/16/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIClient : NSObject
+ (void)getLocationsForSearchKey:(NSString *)searchKey andCompletion:(void (^)(id response))completion;
@end
