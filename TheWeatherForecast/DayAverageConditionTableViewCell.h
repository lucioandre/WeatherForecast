//
//  DayAverageConditionTableViewCell.h
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/20/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayAverageConditionTableViewCell : UITableViewCell
- (void)setWeekday:(NSString *)weekday minTemperature:(NSString *)minTemp andMaxTemperature:(NSString *)maxTemp;
@end
