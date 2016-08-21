//
//  CityTableViewCell.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/15/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "CityTableViewCell.h"
#import "UIView+XIB.h"

@interface CityTableViewCell ()
@property (nonatomic, weak) IBOutlet UILabel *cityNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *regionAndCountryLabel;
@end

@implementation CityTableViewCell

INIT_XIB

- (void)setCityName:(NSString *)cityName andRegion:(NSString *)region andCountry:(NSString *)country {
    [self.cityNameLabel setText:cityName];
    [self.regionAndCountryLabel setText:[NSString stringWithFormat:@"%@%@%@", region, ([region length] && [country length] ? @", " : @""), country]];
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
