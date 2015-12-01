//
//  Constants.h
//  WeatherAPIExample
//
//  Created by Ajay Thakur on 11/25/15.
//  Copyright © 2015 Ajay Thaur. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef Constants_h
#define Constants_h

/**
 *  Documentation: http://openweathermap.org/current
 *  Parameters:
 *
 *  coord:
 *      coord.lon City geo location, longitude
 *      coord.lat City geo location, latitude
 *  weather: (more info Weather condition codes)
 *      weather.id Weather condition id
 *      weather.main Group of weather parameters (Rain, Snow, Extreme etc.)
 *      weather.description Weather condition within the group
 *      weather.icon Weather icon id
 *  base: Internal parameter
 *  main:
 *      main.temp Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
 *      main.pressure Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
 *      main.humidity Humidity, %
 *      main.temp_min Minimum temperature at the moment. This is deviation from current
 *          temp that is possible for large cities and megalopolises geographically expanded
 *          (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
 *      main.temp_max Maximum temperature at the moment. This is deviation from current
 *          temp that is possible for large cities and megalopolises geographically expanded
 *          (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
 *      main.sea_level Atmospheric pressure on the sea level, hPa
 *      main.grnd_level Atmospheric pressure on the ground level, hPa
 *  wind:
 *      wind.speed Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
 *      wind.deg Wind direction, degrees (meteorological)
 *  clouds:
 *      clouds.all Cloudiness, %
 *  rain:
 *      rain.3h Rain volume for the last 3 hours
 *  snow:
 *      snow.3h Snow volume for the last 3 hours
 *      dt Time of data calculation, unix, UTC
 *  sys:
 *      sys.type Internal parameter
 *      sys.id Internal parameter
 *      sys.message Internal parameter
 *      sys.country Country code (GB, JP etc.)
 *      sys.sunrise Sunrise time, unix, UTC
 *      sys.sunset Sunset time, unix, UTC
 *  id: City ID
 *  name: City name
 *  cod: Internal parameter
 *
 * -------------------------------------------------------------------------------------------------------
 *
 *   JSON: Object returned by weather API.
 *         http://api.openweathermap.org/data/2.5/weather?q=Albany%2C+US&APPID=51337ba29f38cb7a5664cda04d84f4cd
 *
 *   {
 *       "base" : "cmc stations",
 *       "wind" : {
 *           "speed" : 1.01,
 *           "deg" : 268.505
 *       },
 *       "clouds" : {
 *           "all" : 20
 *       },
 *       "coord" : {
 *           "lon" : -73.76000000000001,
 *           "lat" : 42.65
 *       },
 *       "dt" : 1448398280,
 *       "id" : 5106834,
 *       "cod" : 200,
 *       "weather" : [
 *       	{
 *           "id" : 801,
 *           "main" : "Clouds",
 *           "icon" : "02d",
 *           "description" : "few clouds"
 *       	}
 *       ],
 *       "main" : {
 *           "humidity" : 52,
 *           "temp_min" : 275.976,
 *           "temp_max" : 275.976,
 *           "temp" : 275.976,
 *           "pressure" : 1013.54,
 *           "sea_level" : 1041.51,
 *           "grnd_level" : 1013.54
 *       },
 *       "sys" : {
 *			 "type":1,
 *			 "id":8166,
 *           "message" : 0.0031,
 *           "country" : "US",
 *           "sunset" : 1448400317,
 *           "sunrise" : 1448366295
 *       },
 *   	 "rain" : {
 *           "3h" : 0.64
 *		 },
 *       "snow" : {
 * 			 ”3h" : 0.64
 *		 },
 *       "name" : "Albany"
 *   }
 */


FOUNDATION_EXPORT BOOL const kATDebugON;
FOUNDATION_EXPORT BOOL const kATDebugDetailON;
FOUNDATION_EXPORT BOOL const kATDebugErrorON;
FOUNDATION_EXPORT BOOL const kATDebugDelayON;



// JSON Names from 'openweathermap'
FOUNDATION_EXPORT NSString *const kATJsonBase ; //@"base";

FOUNDATION_EXPORT NSString *const kATJsonWind ; //@"wind";
FOUNDATION_EXPORT NSString *const kATJsonWindSpeed ; //@"speed";
FOUNDATION_EXPORT NSString *const kATJsonWindDeg ; //@"deg";

FOUNDATION_EXPORT NSString *const kATJsonClouds ; //@"clouds";
FOUNDATION_EXPORT NSString *const kATJsonCloudsAll ; //@"all";

FOUNDATION_EXPORT NSString *const kATJsonCoord ; //@"coord";
FOUNDATION_EXPORT NSString *const kATJsonCoordLon ; //@"lon";
FOUNDATION_EXPORT NSString *const kATJsonCoordLat ; //@"lat";

FOUNDATION_EXPORT NSString *const kATJsonDt ; //@"dt"; //
FOUNDATION_EXPORT NSString *const kATJsonId ; //@"id"; //
FOUNDATION_EXPORT NSString *const kATJsonCod ; //@"cod";

FOUNDATION_EXPORT NSString *const kATJsonWeather ; //@"weather";
FOUNDATION_EXPORT NSString *const kATJson0WeatherId ; //@"id";
FOUNDATION_EXPORT NSString *const kATJson0WeatherMain ; //@"main";
FOUNDATION_EXPORT NSString *const kATJson0WeatherIcon ; //@"icon";
FOUNDATION_EXPORT NSString *const kATJson0WeatherDescription ; //@"description";
FOUNDATION_EXPORT NSString *const kATJson1WeatherId ; //@"id";
FOUNDATION_EXPORT NSString *const kATJson1WeatherMain ; //@"main";
FOUNDATION_EXPORT NSString *const kATJson1WeatherIcon ; //@"icon";
FOUNDATION_EXPORT NSString *const kATJson1WeatherDescription ; //@"description";

FOUNDATION_EXPORT NSString *const kATJsonMain ; //@"main";
FOUNDATION_EXPORT NSString *const kATJsonMainHumidity ; //@"humidity";
FOUNDATION_EXPORT NSString *const kATJsonMainTempMin ; //@"temp_min";
FOUNDATION_EXPORT NSString *const kATJsonMainTempMax ; //@"temp_max";
FOUNDATION_EXPORT NSString *const kATJsonMainTemp ; //@"temp";
FOUNDATION_EXPORT NSString *const kATJsonMainPressure ; //@"pressure";
FOUNDATION_EXPORT NSString *const kATJsonMainGrndLevel ; //@"grnd_level";
FOUNDATION_EXPORT NSString *const kATJsonMainSeaLevel ; //@"sea_level";

FOUNDATION_EXPORT NSString *const kATJsonSys ; //@"sys";
FOUNDATION_EXPORT NSString *const kATJsonSysType ; //@"type";
FOUNDATION_EXPORT NSString *const kATJsonSysId ; //@"id";
FOUNDATION_EXPORT NSString *const kATJsonSysMessage ; //@"message";
FOUNDATION_EXPORT NSString *const kATJsonSysCountry ; //@"country";
FOUNDATION_EXPORT NSString *const kATJsonSysSunset ; //@"sunset";
FOUNDATION_EXPORT NSString *const kATJsonSysSunrise ; //@"sunrise";

FOUNDATION_EXPORT NSString *const kATJsonRain ; //@"rain";
FOUNDATION_EXPORT NSString *const kATJsonRain3h ; //@"3h";

FOUNDATION_EXPORT NSString *const kATJsonSnow ; //@"snow";
FOUNDATION_EXPORT NSString *const kATJsonSnow3h ; //@"3h";

FOUNDATION_EXPORT NSString *const kATJsonName ; //@"name";

// Entity Names - names of corresponding values in the CoreData table

FOUNDATION_EXPORT NSString *const kATEntityWeather ; // @"Weather";

FOUNDATION_EXPORT NSString *const kATEntityBase ; // @"base";

FOUNDATION_EXPORT NSString *const kATEntityWindSpeed ; // @"windSpeed";
FOUNDATION_EXPORT NSString *const kATEntityWindDeg ; // @"windDeg";

FOUNDATION_EXPORT NSString *const kATEntityCloudsAll ; // @"cloudsAll";

FOUNDATION_EXPORT NSString *const kATEntityCoordLon ; // @"coordLon";
FOUNDATION_EXPORT NSString *const kATEntityCoordLat ; // @"coordLat";

FOUNDATION_EXPORT NSString *const kATEntityDt ; // @"dateTime"; //
FOUNDATION_EXPORT NSString *const kATEntityId ; // @"identifier"; //
FOUNDATION_EXPORT NSString *const kATEntityCod ; // @"cod";

FOUNDATION_EXPORT NSString *const kATEntity0Weather0Id ; // @"weather0Id";
FOUNDATION_EXPORT NSString *const kATEntity0Weather0Main ; // @"weather0Main";
FOUNDATION_EXPORT NSString *const kATEntity0Weather0Icon ; // @"weather0Icon";
FOUNDATION_EXPORT NSString *const kATEntity0Weather0Description ; // @"weather0Description";
FOUNDATION_EXPORT NSString *const kATEntity0Weather1Id ; // @"weather1Id";
FOUNDATION_EXPORT NSString *const kATEntity0Weather1Main ; // @"weather1Main";
FOUNDATION_EXPORT NSString *const kATEntity0Weather1Icon ; // @"weather1Icon";
FOUNDATION_EXPORT NSString *const kATEntity0Weather1Description ; // @"weather1Description";

FOUNDATION_EXPORT NSString *const kATEntityMainHumidity ; // @"mainHumidity";
FOUNDATION_EXPORT NSString *const kATEntityMainTempMin ; // @"mainTempMin";
FOUNDATION_EXPORT NSString *const kATEntityMainTempMax ; // @"mainTempMax";
FOUNDATION_EXPORT NSString *const kATEntityMainTemp ; // @"mainTemp";
FOUNDATION_EXPORT NSString *const kATEntityMainPressure ; // @"mainPressure";
FOUNDATION_EXPORT NSString *const kATEntityMainGrndLevel ; // @"mainGroundLevel";
FOUNDATION_EXPORT NSString *const kATEntityMainSeaLevel ; // @"mainSeaLevel";

FOUNDATION_EXPORT NSString *const kATEntitySysType ; // @"sysType";
FOUNDATION_EXPORT NSString *const kATEntitySysId ; // @"sysId";
FOUNDATION_EXPORT NSString *const kATEntitySysMessage ; // @"sysMessage";
FOUNDATION_EXPORT NSString *const kATEntitySysCountry ; // @"sysCountry";
FOUNDATION_EXPORT NSString *const kATEntitySysSunset ; // @"sysSunset";
FOUNDATION_EXPORT NSString *const kATEntitySysSunrise ; // @"sysSunrise";

FOUNDATION_EXPORT NSString *const kATEntityRain3h ; // @"rainThreeHour";

FOUNDATION_EXPORT NSString *const kATEntitySnow3h ; // @"snowThreeHour";

FOUNDATION_EXPORT NSString *const kATEntityName ; // @"cityName";
FOUNDATION_EXPORT NSString *const kATEntityCityAndCountry ; // @"cityAndCountryUser";

// Strings.
FOUNDATION_EXPORT NSString *const kATOpenWeatherURL; // @"http://api.openweathermap.org"
FOUNDATION_EXPORT NSString *const kATOpenWeatherACCESSAPI; // API Access Value

// Constants
FOUNDATION_EXPORT NSTimeInterval const kATDataCacheInterval20Minutes;

#endif /* Constants_h */
