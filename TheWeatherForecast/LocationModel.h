//
//  LocationModel.h
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/18/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIMappingModel.h"
#import "Location.h"

@interface LocationModel : NSObject

+ (void)fetchAsyncAllLocations:(void (^)(NSArray* locations))completion;
+ (void)deleteAsyncLocation:(Location *)location andCompletion:(void (^)(void))completion;
+ (void)insertAsyncNewLocationForSearchResult:(SearchResult *)searchResult completion:(void (^)(Location* location))completion;

@end
