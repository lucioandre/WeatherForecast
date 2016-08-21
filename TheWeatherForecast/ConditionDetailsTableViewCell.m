//
//  ConditionDetailsTableViewCell.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/20/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "ConditionDetailsTableViewCell.h"
#import "UIView+XIB.h"

@interface ConditionDetailsTableViewCell ()
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *valueLabel;
@end

@implementation ConditionDetailsTableViewCell

INIT_XIB

- (void)setTitle:(NSString *)title andValue:(NSString *)value {
    [self.titleLabel setText:title];
    [self.valueLabel setText:value];
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
