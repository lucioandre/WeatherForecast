//
//  PlaceSearchViewController.h
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/15/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitySearchViewController : UIViewController <UISearchControllerDelegate>
@property (nonatomic, weak) IBOutlet UITableView *resultsTableView;
@end
