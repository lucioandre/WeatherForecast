//
//  APIMappingModel.h
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/16/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface LocationTitle : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *value;
@end

@interface SearchResult : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *areaNameDescription;
@property (nonatomic, copy) NSString *regionDescription;
@property (nonatomic, copy) NSString *countryDescription;
@property (nonatomic, copy, readonly) NSArray<LocationTitle *> *areaNameArray;
@property (nonatomic, copy, readonly) NSArray<LocationTitle *> *countryArray;
@property (nonatomic, copy, readonly) NSArray<LocationTitle *> *regionArray;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;

@end

@interface APISearchResults : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSArray *results;
@end