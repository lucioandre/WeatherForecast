//
//  APIMappingModel.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/16/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "APIMappingModel.h"

@implementation LocationTitle
+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}
@end
//
//@interface SearchResult ()
//@property (nonatomic, copy) NSString *areaNameDescription;
//@property (nonatomic, copy) NSString *regionDescription;
//@property (nonatomic, copy) NSString *countryDescription;
//@end
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