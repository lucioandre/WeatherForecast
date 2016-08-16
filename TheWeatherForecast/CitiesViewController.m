//
//  ViewController.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/15/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "CitiesViewController.h"
#import "CityTableViewCell.h"

@interface CitiesViewController ()
@property (nonatomic, weak) IBOutlet UITableView *citiesTableView;
@end

@implementation CitiesViewController

#pragma mark - view controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.citiesTableView.estimatedRowHeight = 60;
    self.citiesTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.title = @"Weather Forecast";
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityTableViewCell *cityCell = [self.citiesTableView dequeueReusableCellWithIdentifier:@"cityTableViewCell"];
    return cityCell;
}

- (BOOL)tableView:(UITableView *)tableView anEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Table View Delegate

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"");
    }
}

#pragma mark - memory warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
