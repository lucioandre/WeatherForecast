//
//  ForecastHeaderTableViewCell.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/20/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "ForecastHeaderTableViewCell.h"

@interface ForecastHeaderTableViewCell ()
@property (nonatomic, weak) IBOutlet UILabel *cityName;
@property (nonatomic, weak) IBOutlet UILabel *currentWeather;
@end

@implementation ForecastHeaderTableViewCell

INIT_XIB

- (void)setCityName:(NSString *)cityName andCurrentWeather:(NSString *)currentWeather {
    [self.cityName setText:cityName];
    [self.currentWeather setText:currentWeather];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
