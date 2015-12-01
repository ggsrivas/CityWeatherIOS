//
//  Weather+OpenWeather.h
//  WeatherAPIExample
//
//  Created by Ajay Thakur on 11/24/15.
//  Copyright © 2015 Ajay Thaur. All rights reserved.
//

#import "Weather.h"
#import "AppDelegate.h"

@interface Weather (OpenWeather)

+ (Weather *) weatherWithOpenWeatherInfo: (NSDictionary *) weatherDataDictionary
                           inCityCountry: (NSString *) cityCountry
                           inAppDelegate: (AppDelegate *) appDelegate;

+ (Weather *) weatherWithCityCountry: (NSString *) cityCountry
                    inAppDelegate: (AppDelegate *) appDelegate;

+ (NSString *) weatherIconImageName: (NSString *) iconName;

+ (NSString *) weatherWindSpeedIconNameForWindDegrees: (NSNumber *) windDegree;

+ (NSString *) weatherWindDirectionForWindDegrees: (NSNumber *) windDegrees;

@end
