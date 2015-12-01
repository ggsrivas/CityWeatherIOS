# CityWeatherIOS
IOS Weather App
Example app showing how to work wtih API, CoreData and blocks.
Components:

# Program Structure
The program has three parts:
+ Weather class, manages _Core Data_
+ Utilities class, provides accessors for API call.
+ ViewController, manages the view and data. Uses GCD to update UX in main thread.

## Global
+ _Constants.h_ defines all the constants used globall. To control the debug output set the appropriate flags. 

## CoreData
There is only one Entity in _Core Data_ called **Weather**. You can see it in file _WeatherAPIExample.xcdatamodeld_ on file navigator menu. It is a basic one tabular representation of the data provided by [OpenWeather API](http://bugs.openweathermap.org/projects/api/wiki/Api_2_5_weather). To use your own API you would need to get you own API Key called APPID from your settings.
The public interface from Core Data Weather class is managed by Weather class extension _Weather+OpenWeather_ The interface methods are:
+ (Weather *) weatherWithOpenWeatherInfo: (NSDictionary *) weatherDataDictionary
inCityCountry: (NSString *) cityCountry
inAppDelegate: (AppDelegate *) appDelegate;

+ (Weather *) weatherWithCityCountry: (NSString *) cityCountry
inAppDelegate: (AppDelegate *) appDelegate;

+ (NSString *) weatherIconImageName: (NSString *) iconName; 

## API
The data is fetched from OpenWeather Map servers. The call is using HTTP. By default IOS9 turns off HTTP so we need to make an exception in info.plist
- NSAppTransportSecurity _App Transport Security Settings - Dictionary_
- NSAllowsArbitraryLoad _Allow Arbitray Loads = YES_ 

The Utilities class method is used to downlaod the weather data in background. The method used is:
+ (void) downloadWeatherDataFromAPIForCityCountry: (NSString *) cityCountry
successHandler: (void(^) (NSDictionary * data)) successHandler
errorHandler: (void(^) (NSString * errorMessage)) errorHandler;

- _successHandler_ is called by _downloadWeatherDataFromAPIForCityCountry_ and is passed yje JSON data dictionary fecthed from the server. The successHandler saves the data in dictionary to the _Core Data Entity Weather_ and also updates the UX in the UI thread.
- _errorHandler_ is invoked if there is an error with a _error message_ passed in arguments.
* Note: Check for how self is handled in the _successHandler_ and _errorHandler_ callback blocks to avoid memory leakage.


## UX
The UX manages starts the program. The steps are:
- The user enters a _city,country_ in the text field
- The user then presses the _Get Weather_ button
- The button handler then checks for the _city,country_ data in the _Weather Entity in Core Data_. If there us less than 20 minutes old weather data avaialble then it it shown to the user.
- If the data is not there or is older than 20 minutes in _Core Data_ then a fresh fetch is initiated to the server.
- When data is received then it saved in _Core Data_ with _timestamp_ and then UI is updated.
- If not data is received or there is an error error message alert box is shown.


