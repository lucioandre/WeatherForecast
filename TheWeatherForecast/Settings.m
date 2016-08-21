//
//  Settings.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/21/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "Settings.h"

@implementation Settings

static NSString * const SettingsShouldUseFahrenheit = @"kShouldUseFahrenheit";

#pragma mark - Settings for Temperature Scale

+(void)setShouldUseFahrenheit:(BOOL)value {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:SettingsShouldUseFahrenheit];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)getShouldUseFahrenheit {
    return [[NSUserDefaults standardUserDefaults] boolForKey:SettingsShouldUseFahrenheit];
}

@end
