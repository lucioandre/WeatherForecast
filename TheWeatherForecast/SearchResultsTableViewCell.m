//
//  SearchResultsTableViewCell.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/17/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "SearchResultsTableViewCell.h"

@interface SearchResultsTableViewCell ()
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@end

@implementation SearchResultsTableViewCell

INIT_XIB

- (void)setTitle:(NSString *)title andDescription:(NSString *)description {
    [self.titleLabel setText:title];
    [self.descriptionLabel setText:description];
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
