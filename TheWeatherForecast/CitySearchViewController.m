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
#import "LocationModel.h"

@interface CitySearchViewController ()
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *resultsTableView;
@property (nonatomic, weak) IBOutlet UIView *loadingView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSArray<SearchResult *> *searchResults;
@end

@implementation CitySearchViewController

#pragma mark - View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resultsTableView.estimatedRowHeight = 71;
    self.resultsTableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Loading View

- (void)setLoadingViewVisible:(BOOL)isVisible {
    [self.loadingView setHidden:!isVisible];
    if (isVisible) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
}

#pragma mark - Search Bar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self setLoadingViewVisible:YES];
    [APIClient getLocationsForSearchKey:searchBar.text andCompletion:^(id response) {
        [self setLoadingViewVisible:NO];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.searchResults count] > indexPath.row) {
        SearchResult *searchResult = [self.searchResults objectAtIndex:indexPath.row];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Would you like to add this city to your city list?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [LocationModel insertAsyncNewLocationForSearchResult:searchResult completion:^(Location *location) {
                UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:@"This city has been added to your list!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                [successAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:successAlert animated:YES completion:nil];
            }];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

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
