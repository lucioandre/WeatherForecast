//
//  Settings.h
//  TheWeatherForecast
//
//  Created by Avenue Brazil on 8/21/16.
//  Copyright © 2016 Lucio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject
+(void)setShouldUseFahrenheit:(BOOL)value;
+(BOOL)getShouldUseFahrenheit;
@end
