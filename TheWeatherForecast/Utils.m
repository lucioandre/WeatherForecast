//
//  Utils.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/16/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+ (NSString *)getEndPointForKey:(NSString *)key {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"APIEndPoints" ofType:@"plist"];
    NSDictionary *plistDictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    return [plistDictionary valueForKey:key];
}
@end
