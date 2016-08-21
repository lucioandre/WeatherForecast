//
//  ForecastViewController.h
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/15/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIMappingModel.h"
#import "Location.h"

@interface ForecastViewController : UIViewController
@property (nonatomic, strong) APIWeatherCondition *weatherCondition;
@property (nonatomic, strong) Location *location;
@end
