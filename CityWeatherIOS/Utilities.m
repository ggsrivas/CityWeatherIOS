//
//  Utilities.m
//  WeatherAPIExample
//
//  Created by Ajay Thakur on 11/25/15.
//  Copyright © 2015 Ajay Thaur. All rights reserved.
//

#import "Utilities.h"
#import "Constants.h"

@implementation Utilities

+ (void) hideKeyoardOnViewController: (ViewController *) vc {
    if ([vc isFirstResponder]) {
        [vc resignFirstResponder];
    }
}

+ (void) downloadWeatherDataFromAPIForCityCountry: (NSString *) cityCountry
                                   successHandler: (void(^) (NSDictionary * data)) successHandler
                                     errorHandler: (void(^) (NSString * errorMessage)) errorHandler {
    
    if (kATDebugDelayON) [NSThread sleepForTimeInterval:2.0f]; // Artificial delay for testing
    
    // Prepare the URL.
    // http://api.openweathermap.org/data/2.5/weather?q=Albany%2C+US&APPID=YOUR_APP_ID
    NSString *urlWithString = [kATOpenWeatherURL stringByAppendingFormat:
                               @"q=%@&units=Imperial&APPID=%@",
                               cityCountry,kATOpenWeatherACCESSAPI];
    if (kATDebugDetailON) NSLog(@"getWeatherFromApiForCityCountry:urlWithString: %@", urlWithString);
    NSURL *url = [NSURL URLWithString:[urlWithString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    if (kATDebugDetailON) NSLog(@"getWeatherFromApiForCityCountry:urlWithEncodedString: %@", url); // URL
    NSURLSession *session = [NSURLSession sharedSession];
    // Fetch the data -- background task, main not run in UI thread
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // Error check 1: Network errors
        if (error && errorHandler) {
            errorHandler(@"downloadWeatherDataFromAPIForCityCountry: Network error");
            return;
        }
        
        // Error check 2: HTTP errors
        if (!response && errorHandler) {
            errorHandler(@"downloadWeatherDataFromAPIForCityCountry: No HTTP response");
            return;
        }
        
        // Error check 3: HTTP status code errors
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if ((httpResponse.statusCode != 200) && errorHandler) {
            errorHandler([NSString stringWithFormat:@"getWeatherHandler: HTTP response code: %ld", (long) httpResponse.statusCode]);
            return;
        }
        
        // Error check 4: data errors
        if (!data && errorHandler) {
            errorHandler(@"downloadWeatherDataFromAPIForCityCountry: No data received");
            return;
        }
        
        //Get the JSON object
        NSError *jsonError;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        // Error check 5: JSON parse errors
        if (jsonError && errorHandler) {
            errorHandler([NSString stringWithFormat:@"downloadWeatherDataFromAPIForCityCountry: JSON Parse Error: %@", jsonError]);
            return;
        }
        
        // Example JSON is shown in:
        if (kATDebugDetailON) NSLog(@"downloadWeatherDataFromAPIForCityCountry: %@",jsonDictionary);
        if (successHandler)
            successHandler(jsonDictionary);
    }] resume];
}
@end
