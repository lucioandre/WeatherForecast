//
//  NSString+Utilities.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/21/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "NSString+Utilities.h"

@implementation NSString (Utilities)

- (NSString *)percentageString {
    NSString *percentageString = @"%";
    if (![self hasSuffix:percentageString]) {
        return [self stringByAppendingString:@"%"];
    }
    return self;
}

- (NSString *)temperatureDegreeString {
    NSString *degreeCaracther = @"º";
    if (![self hasSuffix:degreeCaracther]) {
        return [self stringByAppendingString:degreeCaracther];
    }
    return self;
}

- (NSString *)milimeterString {
    NSString *milimeterString = @"mm";
    if (![self hasSuffix:milimeterString]) {
        return [self stringByAppendingString:milimeterString];
    }
    return self;
}

@end
