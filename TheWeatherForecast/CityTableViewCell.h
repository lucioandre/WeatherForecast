//
//  CityTableViewCell.h
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/15/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTableViewCell : UITableViewCell
- (void)setCityName:(NSString *)cityName andRegion:(NSString *)region andCountry:(NSString *)country;
@end
