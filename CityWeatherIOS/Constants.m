//
//  Constants.m
//  WeatherAPIExample
//
//  Created by Ajay Thakur on 11/25/15.
//  Copyright © 2015 Ajay Thaur. All rights reserved.
//

#import "Constants.h"


BOOL const kATDebugON = YES; // enable debug
BOOL const kATDebugDetailON = NO; // detail debugs
BOOL const kATDebugErrorON = YES; // Show erros NSLOG
NSTimeInterval const kATDataCacheInterval20Minutes = 20*60; // 20 Minutes interval
BOOL const kATDebugDelayON = YES; // For testing

// JSON Names -- these are names of the JSOB fields in as they are fetched from the API
NSString *const kATJsonBase = @"base";

NSString *const kATJsonWind = @"wind";
NSString *const kATJsonWindSpeed = @"speed";
NSString *const kATJsonWindDeg = @"deg";

NSString *const kATJsonClouds = @"clouds";
NSString *const kATJsonCloudsAll = @"all";

NSString *const kATJsonCoord = @"coord";
NSString *const kATJsonCoordLon = @"lon";
NSString *const kATJsonCoordLat = @"lat";

NSString *const kATJsonDt = @"dt"; //
NSString *const kATJsonId = @"id"; //
NSString *const kATJsonCod = @"cod";

NSString *const kATJsonWeather = @"weather";
NSString *const kATJson0WeatherId = @"id";
NSString *const kATJson0WeatherMain = @"main";
NSString *const kATJson0WeatherIcon = @"icon";
NSString *const kATJson0WeatherDescription = @"description";
NSString *const kATJson1WeatherId = @"id";
NSString *const kATJson1WeatherMain = @"main";
NSString *const kATJson1WeatherIcon = @"icon";
NSString *const kATJson1WeatherDescription = @"description";

NSString *const kATJsonMain = @"main";
NSString *const kATJsonMainHumidity = @"humidity";
NSString *const kATJsonMainTempMin = @"temp_min";
NSString *const kATJsonMainTempMax = @"temp_max";
NSString *const kATJsonMainTemp = @"temp";
NSString *const kATJsonMainPressure = @"pressure";
NSString *const kATJsonMainGrndLevel = @"grnd_level";
NSString *const kATJsonMainSeaLevel = @"sea_level";

NSString *const kATJsonSys = @"sys";
NSString *const kATJsonSysType = @"type";
NSString *const kATJsonSysId = @"id";
NSString *const kATJsonSysMessage = @"message";
NSString *const kATJsonSysCountry = @"country";
NSString *const kATJsonSysSunset = @"sunset";
NSString *const kATJsonSysSunrise = @"sunrise";

NSString *const kATJsonRain = @"rain";
NSString *const kATJsonRain3h = @"3h";

NSString *const kATJsonSnow = @"snow";
NSString *const kATJsonSnow3h = @"3h";

NSString *const kATJsonName = @"name";

// Entity Names - names of corresponding values in the CoreData 'Entity' - Weather
NSString *const kATEntityWeather = @"Weather";
NSString *const kATEntityBase = @"base";

NSString *const kATEntityWindSpeed = @"windSpeed";
NSString *const kATEntityWindDeg = @"windDeg";

NSString *const kATEntityCloudsAll = @"cloudsAll";

NSString *const kATEntityCoordLon = @"coordLon";
NSString *const kATEntityCoordLat = @"coordLat";

NSString *const kATEntityDt = @"dateTime"; //
NSString *const kATEntityId = @"identifier"; //
NSString *const kATEntityCod = @"cod";

NSString *const kATEntity0Weather0Id = @"weather0Id";
NSString *const kATEntity0Weather0Main = @"weather0Main";
NSString *const kATEntity0Weather0Icon = @"weather0Icon";
NSString *const kATEntity0Weather0Description = @"weather0Description";
NSString *const kATEntity0Weather1Id = @"weather1Id";
NSString *const kATEntity0Weather1Main = @"weather1Main";
NSString *const kATEntity0Weather1Icon = @"weather1Icon";
NSString *const kATEntity0Weather1Description = @"weather1Description";

NSString *const kATEntityMainHumidity = @"mainHumidity";
NSString *const kATEntityMainTempMin = @"mainTempMin";
NSString *const kATEntityMainTempMax = @"mainTempMax";
NSString *const kATEntityMainTemp = @"mainTemp";
NSString *const kATEntityMainPressure = @"mainPressure";
NSString *const kATEntityMainGrndLevel = @"mainGroundLevel";
NSString *const kATEntityMainSeaLevel = @"mainSeaLevel";

NSString *const kATEntitySysType = @"sysType";
NSString *const kATEntitySysId = @"sysId";
NSString *const kATEntitySysMessage = @"sysMessage";
NSString *const kATEntitySysCountry = @"sysCountry";
NSString *const kATEntitySysSunset = @"sysSunset";
NSString *const kATEntitySysSunrise = @"sysSunrise";

NSString *const kATEntityRain3h = @"rainThreeHour";

NSString *const kATEntitySnow3h = @"snowThreeHour";

NSString *const kATEntityName = @"cityName";
NSString *const kATEntityCityAndCountry = @"cityAndCountryUser";

// Constants to see access Openweather
NSString *const kATOpenWeatherURL = @"http://api.openweathermap.org/data/2.5/weather?";
NSString *const kATOpenWeatherACCESSAPI = @"51337ba29f38cb7a5664cda04d84f4cd";



// Entity Names
