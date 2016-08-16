//
//  UIView+XIB.m
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/15/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import "UIView+XIB.h"

@implementation UIView (XIB)

- (void)loadFromXIB {
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    view.frame = self.bounds;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
}

@end
