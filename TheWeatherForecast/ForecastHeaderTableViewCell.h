//
//  ForecastHeaderTableViewCell.h
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/20/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastHeaderTableViewCell : UITableViewCell
- (void)setCityName:(NSString *)cityName andCurrentWeather:(NSString *)currentWeather;
@end
