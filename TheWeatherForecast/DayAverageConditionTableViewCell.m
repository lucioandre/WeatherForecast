//
//  DayAverageConditionTableViewCell.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/20/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "DayAverageConditionTableViewCell.h"
#import "UIView+XIB.h"

@interface DayAverageConditionTableViewCell ()
@property (nonatomic, weak) IBOutlet UILabel *weekdayLabel;
@property (nonatomic, weak) IBOutlet UIImageView *conditionIcon;
@property (nonatomic, weak) IBOutlet UILabel *minTemperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *maxTemperatureLabel;
@end

@implementation DayAverageConditionTableViewCell

INIT_XIB

- (void)setWeekday:(NSString *)weekday minTemperature:(NSString *)minTemp andMaxTemperature:(NSString *)maxTemp {
    [self.weekdayLabel setText:weekday];
    [self.minTemperatureLabel setText:minTemp];
    [self.maxTemperatureLabel setText:maxTemp];
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
