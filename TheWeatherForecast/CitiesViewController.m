//
//  ViewController.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/15/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "CitiesViewController.h"
#import "CityTableViewCell.h"
#import "CitySearchViewController.h"
#import "LocationModel.h"
#import "Location.h"
#import "APIClient.h"
#import "ForecastViewController.h"
#import "Settings.h"

@interface CitiesViewController ()
@property (nonatomic, weak) IBOutlet UITableView *citiesTableView;
@property (nonatomic, weak) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scaleSegmentControl;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *addCitiesButton;
@property (nonatomic, strong) NSMutableArray<Location *> *citiesArray;
@end

@implementation CitiesViewController

#pragma mark - view controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.citiesTableView.estimatedRowHeight = 60;
    self.citiesTableView.rowHeight = UITableViewAutomaticDimension;
    self.title = @"Weather";
    [self.scaleSegmentControl setSelectedSegmentIndex:([Settings getShouldUseFahrenheit] ? 1 : 0)];
}

- (void)viewWillAppear:(BOOL)animated {
    [LocationModel fetchAsyncAllLocations:^(NSArray *locations) {
        self.citiesArray = [NSMutableArray arrayWithArray:locations];
        [self.citiesTableView reloadData];
    }];
}

#pragma mark - Actions

- (IBAction)presentCitySearch:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CitySearchViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"CitySearchViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Segmented Control

- (IBAction)segmentedControlDidChange:(id)sender {
    [Settings setShouldUseFahrenheit:(self.scaleSegmentControl.selectedSegmentIndex == 1)];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.citiesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityTableViewCell *cityCell = [self.citiesTableView dequeueReusableCellWithIdentifier:@"cityTableViewCell"];
    if ([self.citiesArray count] > indexPath.row) {
        Location *location = [self.citiesArray objectAtIndex:indexPath.row];
        [cityCell setCityName:location.areaName andRegion:location.region andCountry:location.country];
    }
    return cityCell;
}

- (BOOL)tableView:(UITableView *)tableView anEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Loading View

- (void)setLoadingViewVisible:(BOOL)isVisible {
    [self.addCitiesButton setEnabled:!isVisible];
    [self.scaleSegmentControl setEnabled:!isVisible];
    [self.loadingView setHidden:!isVisible];
    if (isVisible) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
}

#pragma mark - Table View Delegate

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete && [self.citiesArray count] > indexPath.row) {
        
        Location *locationToDelete = [self.citiesArray objectAtIndex:indexPath.row];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure you want to remove this city?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [LocationModel deleteAsyncLocation:locationToDelete andCompletion:^{
                [self.citiesArray removeObjectAtIndex:indexPath.row];
                [self.citiesTableView reloadData];
            }];
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.citiesArray count] > indexPath.row) {
        Location *location = [self.citiesArray objectAtIndex:indexPath.row];
        NSString *locationDescription = [NSString stringWithFormat:@"%@, %@, %@", location.areaName, location.region, location.country];
        [self setLoadingViewVisible:YES];
        [APIClient getForecastForLocationDescription:locationDescription withCompletion:^(id response) {
            [self setLoadingViewVisible:NO];
            if ([response isKindOfClass:[APIWeatherCondition class]]) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ForecastViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ForecastViewController"];
                viewController.weatherCondition = response;
                viewController.location = location;
                [self.navigationController pushViewController:viewController animated:YES];
            } else {
                UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Opss!" message:@"A error occurred! Please try again after." preferredStyle:UIAlertControllerStyleAlert];
                [errorAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:errorAlert animated:YES completion:nil];
            }
        }];
    }
}

#pragma mark - memory warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
