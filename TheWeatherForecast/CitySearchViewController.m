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
#import "APIMappingModel.h"
#import "SearchResultsTableViewCell.h"

@interface CitySearchViewController ()
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *resultsTableView;
@property (nonatomic, strong) NSArray<SearchResult *> *searchResults;
@end

@implementation CitySearchViewController

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resultsTableView.estimatedRowHeight = 71;
    self.resultsTableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Search Bar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [APIClient getLocationsForSearchKey:searchBar.text andCompletion:^(id response) {
        if ([response isKindOfClass:[APISearchResults class]]) {
            APISearchResults *resultsResponse = response;
            self.searchResults = [NSArray arrayWithArray:resultsResponse.results];
            [self.resultsTableView reloadData];
        }
    }];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultsTableViewCell *searchResultCell = [self.resultsTableView dequeueReusableCellWithIdentifier:@"searchResultsCell"];
    if ([self.searchResults count] > indexPath.row) {
        SearchResult *result = [self.searchResults objectAtIndex:indexPath.row];
        [searchResultCell setTitle:result.areaNameDescription andDescription:[NSString stringWithFormat:@"%@, %@", result.regionDescription, result.countryDescription]];
    }
    return searchResultCell;
}

- (BOOL)tableView:(UITableView *)tableView anEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Table View Delegate


#pragma mark - Memory management

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
