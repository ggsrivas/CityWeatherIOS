//
//  Weather+OpenWeather.m
//  WeatherAPIExample
//
//  Created by Ajay Thakur on 11/24/15.
//  Copyright © 2015 Ajay Thaur. All rights reserved.
//

#import "Weather+OpenWeather.h"
#import "Constants.h"

@implementation Weather (OpenWeather)

+ (NSString *) weatherIconImageName: (NSString *) iconName {
    NSSet *iconNameSet = [ NSSet setWithObjects:@"01d",  @"01n", @"02d", @"02n",@"03d", @"03n", @"04d", @"04n", @"09d",
                           @"09n", @"10d", @"10n", @"11d", @"11n", @"13d", @"13n", @"50d", @"50n",nil];
    if ([iconNameSet containsObject:iconName]) {
        return iconName;
    } else
        return @"icon_default";
}

+ (NSString *) weatherWindSpeedIconNameForWindDegrees: (NSNumber *) windDegrees {
    NSArray *iconNames = @[@"dir_N",@"dir_NNE",@"dir_NE",@"dir_ENE",
                           @"dir_E",@"dir_ESE",@"dir_SE",@"dir_SSE",
                           @"dir_S",@"dir_SSW",@"dir_SW",@"dir_WSW",
                           @"dir_W",@"dir_WNW",@"dir_NW",@"dir_NNW"];
    int index = ((int)floor(([windDegrees doubleValue] + 11.25)/22.5))%16;
    if (kATDebugDetailON) NSLog(@"%0.4f,index=%d,icon=%@", [windDegrees doubleValue],index,iconNames[index]);
    if (index < iconNames.count)
        return iconNames[index];
    else return @"dir_N"; // Should never fall to here
}

+ (NSString *) weatherWindDirectionForWindDegrees: (NSNumber *) windDegrees {
    NSArray *iconNames = @[@"N",@"NNE",@"NE",@"ENE",
                           @"E",@"dir_ESE",@"SE",@"SSE",
                           @"",@"SSW",@"SW",@"WSW",
                           @"",@"WNW",@"NW",@"NNW"];
    int index = ((int)floor(([windDegrees doubleValue] + 11.25)/22.5))%16;
    if (kATDebugDetailON) NSLog(@"%0.4f,index=%d,icon=%@", [windDegrees doubleValue],index,iconNames[index]);
    if (index < iconNames.count)
        return iconNames[index];
    else return @"N"; // Should never fall to here
}


+ (Weather *) weatherWithCityCountry: (NSString *) cityCountry
                    inAppDelegate: (AppDelegate *) appDelegate {
    Weather *weather = nil;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kATEntityWeather];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == [cdw] %@",
                              kATEntityCityAndCountry, cityCountry];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:fetchRequest error:&error];
    // If no matches or error or more than one city record
    if (!matches || error) {
        if (kATDebugON && error) NSLog(@"weatherWithCityCountry: Error %@", error);
        if ([matches count] > 1){
            if (kATDebugON) NSLog(@"weatherWithCityCountry: %lu, city not unique", (unsigned long)[matches count]);
            // Delete stored cities data
            for (Weather *city in matches) {
                [context deleteObject:city];
            }
            [appDelegate saveContext];
        }
        weather = nil;
    } else if (matches && ([matches count] == 1)) { // Found one1
        weather = [matches firstObject];
        NSDate *now = [NSDate date];
        NSTimeInterval interval = [now timeIntervalSinceDate:weather.serverFetchDate];
        if (kATDebugDetailON) NSLog(@"Current time:%@, server time=%@, interval=%f", now, weather.serverFetchDate, interval);
        if (interval < kATDataCacheInterval20Minutes) {
            // data was fetched in past 10 minutes. return it.
            if (kATDebugDetailON) NSLog(@"weatherWithCityCountry: Retrieveing weather data from CoreData: %@", weather);
        } else {
            // Data is older than 10 minutes, remove from database
            [context deleteObject:weather];
            [appDelegate saveContext];
            if (kATDebugDetailON) NSLog(@"weatherWithCityCountry: Deleting old weather data from CoreData: %@", weather);
            weather = nil;
        }
    } else if (matches && (matches.count == 0)) {
        if (kATDebugON) NSLog(@"weatherWithCityCountry: No matches found, count = 0");
        weather = nil;
    } else {
        if (kATDebugON) NSLog(@"weatherWithCityCountry: matches - nil");
    }
    
    return weather;
}

+ (Weather *) weatherWithOpenWeatherInfo: (NSDictionary *) weatherDataDictionary
                           inCityCountry: (NSString *) cityCountry
                           inAppDelegate: (AppDelegate *) appDelegate {
    // Can not access any instance variables of object Weather.
    // Reference: https://www.youtube.com/watch?v=N2sZ9IjDBzs
    //    "Stanford University Developing iOS 7 Apps: Lecture 13 - Core Data and Table View"
    //
    if ((weatherDataDictionary == nil) || (appDelegate == nil))
        return nil;
    
    Weather *weather = nil;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kATEntityWeather];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(%K = %@)", kATEntityId, weatherDataDictionary[kATJsonId]];
    if (kATDebugDetailON )
        NSLog(@"weatherWithOpenWeatherInfo: predicate: %@ == %@", kATEntityId, weatherDataDictionary[kATJsonId]);
    NSError *error;
    NSArray *matches = [context executeFetchRequest:fetchRequest error:&error];
    
    if (!matches || error) { // Found matched
        if (kATDebugErrorON && error) NSLog(@"weatherWithOpenWeatherInfo - Error: %@", error);
        if (kATDebugErrorON) NSLog(@"weatherWithOpenWeatherInfo: %ld, city not " \
                                   "unique, deleting all citities", (long) [matches count]);
        
    }
    if (matches) {
        if (kATDebugDetailON ) NSLog(@"weatherWithOpenWeatherInfo: deleting old %ld item(s) in database", (long)[matches count]);
        
        // Delete old  data for same city
        for (Weather *city in matches) {
            [context deleteObject:city];
        }
    }
    
    // Save the new fetched city daata
    weather = [NSEntityDescription insertNewObjectForEntityForName:kATEntityWeather inManagedObjectContext:context];
    
    if (weatherDataDictionary[kATJsonBase]) // 'Base'
        weather.base = weatherDataDictionary[kATJsonBase];
    if (weatherDataDictionary[kATJsonWind]) { // "Wind" data
        if (weatherDataDictionary[kATJsonWind][kATJsonWindSpeed]) // 'Wind' "speed"
            weather.windSpeed = weatherDataDictionary[kATJsonWind][kATJsonWindSpeed];
        
        if (weatherDataDictionary[kATJsonWind][kATJsonWindDeg]) // 'Wind' "deg"
            weather.windDeg = weatherDataDictionary[kATJsonWind][kATJsonWindDeg];
    }
    
    if (weatherDataDictionary[kATJsonClouds] && weatherDataDictionary[kATJsonClouds][kATJsonCloudsAll]) {
        weather.cloudsAll = weatherDataDictionary[kATJsonClouds][kATJsonCloudsAll];
    }
    
    if (weatherDataDictionary[kATJsonCoord]) { // "Coord" data
        if (weatherDataDictionary[kATJsonCoord][kATJsonCoordLon]) // Long.
            weather.coordLon = weatherDataDictionary[kATJsonCoord][kATJsonCoordLon];
        
        if (weatherDataDictionary[kATJsonCoord][kATJsonCoordLat]) // Lat.
            weather.coordLat = weatherDataDictionary[kATJsonCoord][kATJsonCoordLat];
    }
    
    if (weatherDataDictionary[kATJsonDt]) // Set date time
        weather.dateTime = [NSDate dateWithTimeIntervalSince1970:[weatherDataDictionary[kATJsonDt] doubleValue]];
    
    if (weatherDataDictionary[kATJsonId]) // 'id'
        weather.identifier = weatherDataDictionary[kATJsonId];
    
    if (weatherDataDictionary[kATJsonCod]) // 'cod'
        weather.cod = weatherDataDictionary[kATJsonCod];
    
    if ((weatherDataDictionary[kATJsonWeather]) && ([weatherDataDictionary[kATJsonWeather] count])) { // "Weather" [0] data
        if (weatherDataDictionary[kATJsonWeather][0][kATJson0WeatherId]) // Weather array
            weather.weather0Id = weatherDataDictionary[kATJsonWeather][0][kATJson0WeatherId];
        
        if (weatherDataDictionary[kATJsonWeather][0][kATJson0WeatherMain])
            weather.weather0Main = weatherDataDictionary[kATJsonWeather][0][kATJson0WeatherMain];
        
        if (weatherDataDictionary[kATJsonWeather][0][kATJson0WeatherIcon])
            weather.weather0Icon = weatherDataDictionary[kATJsonWeather][0][kATJson0WeatherIcon];
        
        if (weatherDataDictionary[kATJsonWeather][0][kATJson0WeatherDescription])
            weather.weather0Description = weatherDataDictionary[kATJsonWeather][0][kATJson0WeatherDescription];
    }
    
    if ((weatherDataDictionary[kATJsonWeather]) &&  ([weatherDataDictionary[kATJsonWeather] count] > 1)) { // "Weather" [1] data
        if (weatherDataDictionary[kATJsonWeather][1][kATJson0WeatherId])
            weather.weather1Id = weatherDataDictionary[kATJsonWeather][1][kATJson0WeatherId];
        
        if (weatherDataDictionary[kATJsonWeather][1][kATJson0WeatherMain])
            weather.weather1Main = weatherDataDictionary[kATJsonWeather][1][kATJson0WeatherMain];
        
        if (weatherDataDictionary[kATJsonWeather][1][kATJson0WeatherIcon])
            weather.weather1Icon = weatherDataDictionary[kATJsonWeather][1][kATJson0WeatherIcon];
        
        if (weatherDataDictionary[kATJsonWeather][1][kATJson0WeatherDescription])
            weather.weather1Description = weatherDataDictionary[kATJsonWeather][1][kATJson0WeatherDescription];
    }
    
    if (weatherDataDictionary[kATJsonMain]) { // "Main" object
        if (weatherDataDictionary[kATJsonMain][kATJsonMainHumidity]) // Humidity.
            weather.mainHumidity = weatherDataDictionary[kATJsonMain][kATJsonMainHumidity];
        
        if (weatherDataDictionary[kATJsonMain][kATJsonMainTempMin]) // main temp minimum.
            weather.mainTempMin = weatherDataDictionary[kATJsonMain][kATJsonMainTempMin];
        
        if (weatherDataDictionary[kATJsonMain][kATJsonMainTempMax]) // main temp max.
            weather.mainTempMax = weatherDataDictionary[kATJsonMain][kATJsonMainTempMax];
        
        if (weatherDataDictionary[kATJsonMain][kATJsonMainTemp]) // main temp
            weather.mainTemp = weatherDataDictionary[kATJsonMain][kATJsonMainTemp];
        
        if (weatherDataDictionary[kATJsonMain][kATJsonMainPressure]) // Main - pressure
            weather.mainPressure = weatherDataDictionary[kATJsonMain][kATJsonMainPressure];
        
        if (weatherDataDictionary[kATJsonMain][kATJsonMainGrndLevel]) // Main - ground level
            weather.mainGroundLevel = weatherDataDictionary[kATJsonMain][kATJsonMainGrndLevel];
        
        if (weatherDataDictionary[kATJsonMain][kATJsonMainSeaLevel]) // Main - sea level
            weather.mainSeaLevel = weatherDataDictionary[kATJsonMain][kATJsonMainSeaLevel];
    }
    
    if (weatherDataDictionary[kATJsonSys]) { // "Sys" object
        if (weatherDataDictionary[kATJsonSys][kATJsonSysType]) // Sys - sys type
            weather.sysType = weatherDataDictionary[kATJsonSys][kATJsonSysType];
        
        if (weatherDataDictionary[kATJsonSys][kATJsonSysId]) // Sys - sys id
            weather.sysId = weatherDataDictionary[kATJsonSys][kATJsonSysId];
        
        if (weatherDataDictionary[kATJsonSys][kATJsonSysMessage]) // Sys - sys message
            weather.sysMessage = weatherDataDictionary[kATJsonSys][kATJsonSysMessage];
        
        if (weatherDataDictionary[kATJsonSys][kATJsonSysCountry]) // Sys - sys Country
            weather.sysCountry = weatherDataDictionary[kATJsonSys][kATJsonSysCountry];
        
        if (weatherDataDictionary[kATJsonSys][kATJsonSysSunset]) // Sys - sys sunset
            weather.sysSunset = [NSDate dateWithTimeIntervalSince1970:[weatherDataDictionary[kATJsonSys][kATJsonSysSunset] doubleValue]];
        
        if (weatherDataDictionary[kATJsonSys][kATJsonSysSunrise]) // Sys - sys sunset
            weather.sysSunrise = [NSDate dateWithTimeIntervalSince1970:[weatherDataDictionary[kATJsonSys][kATJsonSysSunrise] doubleValue]];
    }
    
    if (weatherDataDictionary[kATJsonRain] && weatherDataDictionary[kATJsonRain][kATJsonRain3h]) // Rain - past 3 hours message
        weather.rainThreeHour = weatherDataDictionary[kATJsonRain][kATJsonRain3h];
    
    if (weatherDataDictionary[kATJsonSnow] && weatherDataDictionary[kATJsonSnow][kATJsonSnow3h]) // Snow - past 3 hours message
        weather.snowThreeHour = weatherDataDictionary[kATJsonSnow][kATJsonSnow3h];
    
    
    if (weatherDataDictionary[kATJsonName]) // City name
        weather.cityName = weatherDataDictionary[kATJsonName];
    
    weather.serverFetchDate = [NSDate date]; // Save the store time.
    weather.cityAndCountryUser = cityCountry; // Save the user entered city and country
    
    [appDelegate saveContext];
    
    if (kATDebugDetailON) NSLog(@"Saving a weather data to CoreData: %@", weather);
    
    return weather;
    
}
@end
