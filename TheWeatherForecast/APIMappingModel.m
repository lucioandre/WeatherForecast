//
//  APIMappingModel.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/16/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "APIMappingModel.h"

#pragma mark - Search Location

@implementation LocationTitle
+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}
@end

@implementation SearchResult
- (void)setAreaNameArray:(NSArray<LocationTitle *> *)areaNameArray {
    _areaNameArray = areaNameArray;
    self.areaNameDescription = [[_areaNameArray valueForKey:@"value"] componentsJoinedByString:@", "];
}
- (void)setCountryArray:(NSArray<LocationTitle *> *)countryArray {
    _countryArray = countryArray;
    self.countryDescription = [[_countryArray valueForKey:@"value"] componentsJoinedByString:@", "];
}
- (void)setRegionArray:(NSArray<LocationTitle *> *)regionArray {
    _regionArray = regionArray;
    self.regionDescription = [[_regionArray valueForKey:@"value"] componentsJoinedByString:@", "];
}
+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *mapping = [[NSDictionary mtl_identityPropertyMapWithModel:self] mutableCopy];
    mapping[@"areaNameArray"] = @"areaName";
    mapping[@"countryArray"] = @"country";
    mapping[@"regionArray"] = @"region";
    return mapping;
}
+ (NSValueTransformer *)areaNameArrayJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:LocationTitle.class];
}
+ (NSValueTransformer *)countryArrayJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:LocationTitle.class];
}
+ (NSValueTransformer *)regionArrayJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:LocationTitle.class];
}
@end

@implementation APISearchResults
+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *mapping = [[NSDictionary mtl_identityPropertyMapWithModel:self] mutableCopy];
    return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{@"results": @"search_api.result"}];
}
+ (NSValueTransformer *)resultsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:SearchResult.class];
}
@end

#pragma mark - Fore Cast

@implementation Astronomy
+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}
@end

@implementation DayConditionDetails
+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)weatherIconUrlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray *values = value;
        if ([values count]) {
            NSDictionary *dictionary = [values firstObject];
            return dictionary[@"value"];
        } else {
            return @"";
        }
    }];
}
+ (NSValueTransformer *)weatherDescJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray *values = value;
        if ([values count]) {
            NSDictionary *dictionary = [values firstObject];
            return dictionary[@"value"];
        } else {
            return @"";
        }
    }];
}
@end

@implementation DayCondition
+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *mapping = [[NSDictionary mtl_identityPropertyMapWithModel:self] mutableCopy];
    mapping[@"conditionDetails"] = @"hourly";
    return mapping;
}
+ (NSValueTransformer *)astronomyJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray *values = value;
        if ([values count]) {
            NSDictionary *astronomyDic = [values firstObject];
            return [MTLJSONAdapter modelOfClass:Astronomy.class fromJSONDictionary:astronomyDic error:nil];
        } else {
            return nil;
        }
    }];
}
+ (NSValueTransformer *)conditionDetailsJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray *values = value;
        if ([values count]) {
            NSDictionary *condition = [values firstObject];
            CurrentCondition *currentCondition = [MTLJSONAdapter modelOfClass:DayConditionDetails.class fromJSONDictionary:condition error:nil];
            return currentCondition;
        } else {
            return nil;
        }
    }];
}
@end

@implementation CurrentCondition
+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}
+ (NSValueTransformer *)weatherIconUrlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray *values = value;
        if ([values count]) {
            NSDictionary *dictionary = [values firstObject];
            return dictionary[@"value"];
        } else {
            return @"";
        }
    }];
}
+ (NSValueTransformer *)weatherDescJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray *values = value;
        if ([values count]) {
            NSDictionary *dictionary = [values firstObject];
            return dictionary[@"value"];
        } else {
            return @"";
        }
    }];
}
@end

@implementation APIWeatherCondition
+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *mapping = [[NSDictionary mtl_identityPropertyMapWithModel:self] mutableCopy];
    mapping[@"currentCondition"] = @"data.current_condition";
    mapping[@"weather"] = @"data.weather";
    return mapping;
}
+ (NSValueTransformer *)weatherJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:DayCondition.class];
}
+ (NSValueTransformer *) currentConditionJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray *values = value;
        if ([values count]) {
            NSDictionary *condition = [values firstObject];
            CurrentCondition *currentCondition = [MTLJSONAdapter modelOfClass:CurrentCondition.class fromJSONDictionary:condition error:nil];
            return currentCondition;
        } else {
            return nil;
        }
    }];
}
@end

