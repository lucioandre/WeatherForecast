//
//  ForecastViewController.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/15/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "ForecastViewController.h"
#import "ForecastHeaderTableViewCell.h"
#import "CurrentTemperatureTableViewCell.h"
#import "DayAverageConditionTableViewCell.h"
#import "ConditionDetailsTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Settings.h"

@interface ForecastViewController ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *arrayOfDetailedInfo;
@property (nonatomic, strong) NSDateFormatter *inputDateFormatter;
@property (nonatomic, strong) NSDateFormatter *outputDateFormatter;
@end

@implementation ForecastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 96;

    self.arrayOfDetailedInfo = [NSArray arrayWithArray:[self formatDetailedConditionsInfoArrayForDayCondition:[self.weatherCondition.weather firstObject]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - prepare information

- (NSString *)getWeekdayStringForDate:(NSString *)dateString {
    if ([dateString length]) {
        if (!self.inputDateFormatter) {
            self.inputDateFormatter = [[NSDateFormatter alloc] init];
            [self.inputDateFormatter setDateFormat:@"YYYY-MM-dd"];
        }
        if (!self.outputDateFormatter) {
            self.outputDateFormatter = [[NSDateFormatter alloc] init];
            [self.outputDateFormatter setDateFormat:@"EEEE"];
        }
        
        NSDate *date = [self.inputDateFormatter dateFromString:dateString];
        if (date) {
            return [[self.outputDateFormatter stringFromDate:date] capitalizedString];
        }
    }
    
    return @"";
}

- (NSArray *)formatDetailedConditionsInfoArrayForDayCondition:(DayCondition *)dayCondition {
    if (dayCondition) {
        return @[
                 @{@"title" : @"Wind Speed:", @"value" : dayCondition.conditionDetails.windspeedKmph},
                 @{@"title" : @"Precipitation:", @"value" : [dayCondition.conditionDetails.precipMM stringByAppendingString:@"mm"]},
                 @{@"title" : @"Chance of Rain:", @"value" : [dayCondition.conditionDetails.chanceofrain stringByAppendingString:@"%"]},
                 @{@"title" : @"Chance of Windy:", @"value" : [dayCondition.conditionDetails.chanceofwindy stringByAppendingString:@"%"]},
                 @{@"title" : @"Chance of being cloudy:", @"value" : [dayCondition.conditionDetails.chanceofovercast stringByAppendingString:@"%"]},
                 @{@"title" : @"Chance of Sunshine:", @"value" : [dayCondition.conditionDetails.chanceofsunshine stringByAppendingString:@"%"]},
                 @{@"title" : @"Chance of Rost:", @"value" : [dayCondition.conditionDetails.chanceoffrost stringByAppendingString:@"%"]},
                 @{@"title" : @"Chance of High Temperature:", @"value" : [dayCondition.conditionDetails.chanceofhightemp stringByAppendingString:@"%"]},
                 @{@"title" : @"Chance of Fog:", @"value" : [dayCondition.conditionDetails.chanceoffog stringByAppendingString:@"%"]},
                 @{@"title" : @"Chance of Snow:", @"value" : [dayCondition.conditionDetails.chanceofsnow stringByAppendingString:@"%"]},
                 @{@"title" : @"Chance of Thunder:", @"value" : [dayCondition.conditionDetails.chanceofthunder stringByAppendingString:@"%"]},
                 @{@"title" : @"UV Index:", @"value" : dayCondition.uvIndex},
                 @{@"title" : @"Sunrise time:", @"value" : dayCondition.astronomy.sunrise},
                 @{@"title" : @"Sunset time:", @"value" : dayCondition.astronomy.sunset},
                 @{@"title" : @"Moonrise time:", @"value" : dayCondition.astronomy.moonrise},
                 @{@"title" : @"Moonset time:", @"value" : dayCondition.astronomy.moonset}
                 ];
    }
    return @[];

}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 + [self.weatherCondition.weather count] + [self.arrayOfDetailedInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CurrentTemperatureTableViewCell *currentTemperatureTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"currentTemperatureTableViewCell"];
        NSString *temperatureValue = [Settings getShouldUseFahrenheit] ? self.weatherCondition.currentCondition.temp_F : self.weatherCondition.currentCondition.temp_C;
        [currentTemperatureTableViewCell setTemperatureValue:temperatureValue];
        return currentTemperatureTableViewCell;
    } else if (indexPath.row > 0 && indexPath.row <= [self.weatherCondition.weather count]) {
        DayAverageConditionTableViewCell *dayAverageCell = [self.tableView dequeueReusableCellWithIdentifier:@"dayAverageConditionTableViewCell"];
        DayCondition *dayCondition = [self.weatherCondition.weather objectAtIndex:(indexPath.row-1)];
        [dayAverageCell.conditionIcon sd_setImageWithURL:[NSURL URLWithString:dayCondition.conditionDetails.weatherIconUrl]];
        BOOL presentFahrenheit = [Settings getShouldUseFahrenheit];
        NSString *minTemp = presentFahrenheit ? dayCondition.mintempF : dayCondition.mintempC;
        NSString *maxTemp = presentFahrenheit ? dayCondition.maxtempF : dayCondition.maxtempC;
        [dayAverageCell setWeekday:[self getWeekdayStringForDate:dayCondition.date] minTemperature:minTemp andMaxTemperature:maxTemp];
        return dayAverageCell;
    } else if (indexPath.row > 5) {
        ConditionDetailsTableViewCell *conditionDetailCell = [self.tableView dequeueReusableCellWithIdentifier:@"conditionDetailsTableViewCell"];
        if (self.arrayOfDetailedInfo.count > (indexPath.row - [self.weatherCondition.weather count] - 1)) {
            NSDictionary *dic = [self.arrayOfDetailedInfo objectAtIndex:(indexPath.row-[self.weatherCondition.weather count]-1)];
            [conditionDetailCell setTitle:[dic objectForKey:@"title"] andValue:[dic objectForKey:@"value"]];
        }
        return conditionDetailCell;
    }
    
    return nil;
}

#pragma mark - Table View Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ForecastHeaderTableViewCell *forecastHeaderCell = [self.tableView dequeueReusableCellWithIdentifier:@"forecastHeaderTableViewCell"];
    [forecastHeaderCell setCityName:self.location.areaName andCurrentWeather:self.weatherCondition.currentCondition.weatherDesc];
    return forecastHeaderCell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 96;
    } else if (indexPath.row == 1) {
        return 100;
    } else if (indexPath.row > 1 && indexPath.row < 7) {
        return 37;
    }
    return 28;
}

@end
