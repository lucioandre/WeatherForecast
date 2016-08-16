//
//  UIView+XIB.h
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/15/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <UIKit/UIKit.h>

#define INIT_XIB \
- (instancetype)init { \
        self = [super init]; \
        if (self) { \
        [self loadFromXIB]; \
    } \
    return self; \
} \
- (instancetype)initWithCoder:(NSCoder *)aDecoder {   \
    self = [super initWithCoder:aDecoder]; \
    if (self) { \
    [self loadFromXIB]; \
    } \
    return self; \
} \

@interface UIView (XIB)

- (void)loadFromXIB;

@end
