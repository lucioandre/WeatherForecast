//
//  APIMappingModel.h
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/16/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

#pragma mark - Search Location

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

#pragma mark - Weather Condition

@interface Astronomy : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *sunrise;
@property (nonatomic, copy) NSString *sunset;
@property (nonatomic, copy) NSString *moonrise;
@property (nonatomic, copy) NSString *moonset;
@end

@interface DayConditionDetails : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *tempC;
@property (nonatomic, copy) NSString *tempF;
@property (nonatomic, copy) NSString *windspeedMiles;
@property (nonatomic, copy) NSString *windspeedKmph;
@property (nonatomic, copy) NSString *weatherIconUrl;
@property (nonatomic, copy) NSString *weatherDesc;
@property (nonatomic, copy) NSString *precipMM;
@property (nonatomic, copy) NSString *humidity;
@property (nonatomic, copy) NSString *chanceofrain;
@property (nonatomic, copy) NSString *chanceofremdry;
@property (nonatomic, copy) NSString *chanceofwindy;
@property (nonatomic, copy) NSString *chanceofovercast;
@property (nonatomic, copy) NSString *chanceofsunshine;
@property (nonatomic, copy) NSString *chanceoffrost;
@property (nonatomic, copy) NSString *chanceofhightemp;
@property (nonatomic, copy) NSString *chanceoffog;
@property (nonatomic, copy) NSString *chanceofsnow;
@property (nonatomic, copy) NSString *chanceofthunder;
@end

@interface DayCondition : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) Astronomy *astronomy;
@property (nonatomic, copy) NSString *maxtempC;
@property (nonatomic, copy) NSString *maxtempF;
@property (nonatomic, copy) NSString *mintempC;
@property (nonatomic, copy) NSString *mintempF;
@property (nonatomic, copy) NSString *uvIndex;
@property (nonatomic, copy) DayConditionDetails *conditionDetails;
@end

@interface CurrentCondition : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) NSString *observation_time;
@property (nonatomic, copy) NSString *temp_C;
@property (nonatomic, copy) NSString *temp_F;
@property (nonatomic, copy) NSString *weatherIconUrl;
@property (nonatomic, copy) NSString *weatherDesc;
@property (nonatomic, copy) NSString *windspeedMiles;
@property (nonatomic, copy) NSString *windspeedKmph;
@property (nonatomic, copy) NSString *winddirDegree;
@property (nonatomic, copy) NSString *winddir16Point;
@property (nonatomic, copy) NSString *precipMM;
@property (nonatomic, copy) NSString *humidity;
@property (nonatomic, copy) NSString *visibility;
@property (nonatomic, copy) NSString *pressure;
@property (nonatomic, copy) NSString *cloudcover;
@property (nonatomic, copy) NSString *FeelsLikeC;
@property (nonatomic, copy) NSString *FeelsLikeF;
@end

@interface APIWeatherCondition : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy) CurrentCondition *currentCondition;
@property (nonatomic, copy) NSArray<DayCondition *> *weather;
@end