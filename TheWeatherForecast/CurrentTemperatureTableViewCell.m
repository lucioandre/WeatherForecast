//
//  CurrentTemperatureTableViewCell.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/20/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "CurrentTemperatureTableViewCell.h"
#import "Utils.h"

@interface CurrentTemperatureTableViewCell ()
@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;
@end

@implementation CurrentTemperatureTableViewCell

INIT_XIB

- (void)setTemperatureValue:(NSString *)temperature {
    [self.temperatureLabel setText:[temperature temperatureDegreeString]];
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
