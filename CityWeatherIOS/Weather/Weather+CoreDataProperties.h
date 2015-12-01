//
//  Weather+CoreDataProperties.h
//  CityWeatherIOS
//
//  Created by Ajay Thakur on 11/30/15.
//  Copyright © 2015 Ajay Thaur. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Weather.h"

NS_ASSUME_NONNULL_BEGIN

@interface Weather (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *base;
@property (nullable, nonatomic, retain) NSString *cityAndCountryUser;
@property (nullable, nonatomic, retain) NSString *cityName;
@property (nullable, nonatomic, retain) NSNumber *cloudsAll;
@property (nullable, nonatomic, retain) NSNumber *cod;
@property (nullable, nonatomic, retain) NSNumber *coordLat;
@property (nullable, nonatomic, retain) NSNumber *coordLon;
@property (nullable, nonatomic, retain) NSDate *dateTime;
@property (nullable, nonatomic, retain) NSNumber *identifier;
@property (nullable, nonatomic, retain) NSNumber *mainGroundLevel;
@property (nullable, nonatomic, retain) NSNumber *mainHumidity;
@property (nullable, nonatomic, retain) NSNumber *mainPressure;
@property (nullable, nonatomic, retain) NSNumber *mainSeaLevel;
@property (nullable, nonatomic, retain) NSNumber *mainTemp;
@property (nullable, nonatomic, retain) NSNumber *mainTempMax;
@property (nullable, nonatomic, retain) NSNumber *mainTempMin;
@property (nullable, nonatomic, retain) NSNumber *rainThreeHour;
@property (nullable, nonatomic, retain) NSDate *serverFetchDate;
@property (nullable, nonatomic, retain) NSNumber *snowThreeHour;
@property (nullable, nonatomic, retain) NSString *sysCountry;
@property (nullable, nonatomic, retain) NSNumber *sysId;
@property (nullable, nonatomic, retain) NSNumber *sysMessage;
@property (nullable, nonatomic, retain) NSDate *sysSunrise;
@property (nullable, nonatomic, retain) NSDate *sysSunset;
@property (nullable, nonatomic, retain) NSNumber *sysType;
@property (nullable, nonatomic, retain) NSString *weather0Description;
@property (nullable, nonatomic, retain) NSString *weather0Icon;
@property (nullable, nonatomic, retain) NSNumber *weather0Id;
@property (nullable, nonatomic, retain) NSString *weather0Main;
@property (nullable, nonatomic, retain) NSString *weather1Description;
@property (nullable, nonatomic, retain) NSString *weather1Icon;
@property (nullable, nonatomic, retain) NSNumber *weather1Id;
@property (nullable, nonatomic, retain) NSString *weather1Main;
@property (nullable, nonatomic, retain) NSNumber *windDeg;
@property (nullable, nonatomic, retain) NSNumber *windSpeed;

@end

NS_ASSUME_NONNULL_END
