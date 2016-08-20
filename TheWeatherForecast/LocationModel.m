//
//  LocationModel.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/18/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "LocationModel.h"
#import "CoreDataManager.h"

@implementation LocationModel

//MARK: FETCH

+ (void)fetchAsyncAllLocations:(void (^)(NSArray* locations))completion {
    [[CoreDataManager sharedInstance].managedObjectContext performBlock:^{
        [LocationModel fetchAllLocations:^(NSArray *locations) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completion(locations);
            }];
        }];
    }];
}

+ (void)fetchAllLocations:(void (^)(NSArray* locations))completion {
    [[CoreDataManager sharedInstance].managedObjectContext performBlock:^{
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:[[CoreDataManager sharedInstance] managedObjectContext]];
        [fetchRequest setEntity:entity];
        
        NSError *error;
        NSArray *results = [[[CoreDataManager sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
        completion(results);
        
    }];
}

+ (void)fetchLocationsWithPredicate:(NSPredicate *)predicate andCompletion:(void (^)(NSArray* locations))completion {
    [[CoreDataManager sharedInstance].managedObjectContext performBlock:^{
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:[[CoreDataManager sharedInstance] managedObjectContext]];
        [fetchRequest setEntity:entity];
        [fetchRequest setPredicate:predicate];
        
        NSError *error;
        NSArray *results = [[[CoreDataManager sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
        completion(results);
        
    }];
}

//MARK: DELETE

+ (void)deleteAsyncLocation:(Location *)location andCompletion:(void (^)(void))completion {
    [[CoreDataManager sharedInstance].managedObjectContext performBlock:^{
        [LocationModel deleteLocation:location andCompletion:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                completion();
            }];
        }];
    }];
}

+ (void)deleteLocation:(Location *)location andCompletion:(void (^)(void))completion {
    [[[CoreDataManager sharedInstance] managedObjectContext] deleteObject:location];
    [[CoreDataManager sharedInstance] saveContext];
    completion();
}

//MARK: INSERT

+ (void)insertAsyncNewLocationForSearchResult:(SearchResult *)searchResult completion:(void (^)(Location* location))completion {
    [[CoreDataManager sharedInstance].managedObjectContext performBlock:^{
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"areaName == %@ AND country == %@ AND region == %@ AND latitude == %@ AND longitude == %@", searchResult.areaNameDescription, searchResult.countryDescription, searchResult.regionDescription, [NSNumber numberWithFloat:[searchResult.latitude floatValue]], [NSNumber numberWithFloat:[searchResult.longitude floatValue]]];
        
        //Before insert the search result we check if there's an equal entry on Core Data, this way we avoid insert duplications
        [LocationModel fetchLocationsWithPredicate:predicate andCompletion:^(NSArray *locations) {
            if ([locations count] == 0) {
                [LocationModel insertNewLocationForSearchResult:searchResult completion:^(Location *location) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        completion(location);
                    }];
                }];
            }
        }];
    }];
}
    
+ (void)insertNewLocationForSearchResult:(SearchResult *)searchResult completion:(void (^)(Location* location))completion {
    Location *newLocation = [[Location alloc] initWithEntity:[NSEntityDescription entityForName:@"Location" inManagedObjectContext:[[CoreDataManager sharedInstance] managedObjectContext]] insertIntoManagedObjectContext:[[CoreDataManager sharedInstance] managedObjectContext]];
    newLocation.areaName = searchResult.areaNameDescription;
    newLocation.country = searchResult.countryDescription;
    newLocation.region = searchResult.regionDescription;
    newLocation.latitude = [NSNumber numberWithFloat:[searchResult.latitude floatValue]];
    newLocation.longitude = [NSNumber numberWithFloat:[searchResult.longitude floatValue]];
    [[CoreDataManager sharedInstance] saveContext];
    completion(newLocation);
}

@end
