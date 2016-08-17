//
//  PlaceSearchViewController.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/15/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "CitySearchViewController.h"
#import "AFNetworking.h"
#import "RACAFNetworking.h"
#import "APIClient.h"

@interface CitySearchViewController ()
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation CitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.dimsBackgroundDuringPresentation = YES;
    self.searchController.definesPresentationContext = YES;
    self.searchController.delegate = self;
    self.resultsTableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.placeholder = @"Search for new places";
    [self.searchController setActive:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    [searchController.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
