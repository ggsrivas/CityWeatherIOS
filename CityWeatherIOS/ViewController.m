//
//  ViewController.m
//  WeatherAPIExample
//
//  Created by Ajay Thakur on 11/24/15.
//  Copyright © 2015 Ajay Thaur. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "Weather.h"
#import "Weather/Weather+OpenWeather.h"
#include "Utilities.h"
#import "Social/Social.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cityCountryTV;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressBar;
@property (weak, nonatomic) IBOutlet UIButton *getWeatherButton;
@property (weak, nonatomic) IBOutlet UILabel *cityCountryUserUIL;
@property (weak, nonatomic) IBOutlet UILabel *cityCountryFetchedUIL;
@property (weak, nonatomic) IBOutlet UILabel *tempMaxUIL;
@property (weak, nonatomic) IBOutlet UILabel *tempMinUIL;
@property (weak, nonatomic) IBOutlet UILabel *tempNowUIL;
@property (weak, nonatomic) IBOutlet UILabel *cloudsAllUIL;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedMphUIL;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionDegUIL;
@property (weak, nonatomic) IBOutlet UIButton *latlonUIB;
@property (weak, nonatomic) IBOutlet UILabel *openweatherCityIdUIL;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionUIL;
@property (weak, nonatomic) IBOutlet UILabel *weatherMainUIL;
@property (weak, nonatomic) IBOutlet UILabel *dateSunriseUIL;
@property (weak, nonatomic) IBOutlet UILabel *dateSunsetUIL;
@property (weak, nonatomic) IBOutlet UILabel *rain3hUIL;
@property (weak, nonatomic) IBOutlet UILabel *snow3hUIL;
@property (weak, nonatomic) IBOutlet UILabel *humidityPercentUIL;
@property (weak, nonatomic) IBOutlet UILabel *pressureHpaUIL;
@property (weak, nonatomic) IBOutlet UILabel *pressureSeaLevelHpaUIL;
@property (weak, nonatomic) IBOutlet UILabel *dateFetchedUIL;
@property (weak, nonatomic) IBOutlet UILabel *secondsAgoUIL;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIconUII;
@property (weak, nonatomic) IBOutlet UIButton *tweetThisUIB;

@property (nonatomic) AppDelegate *appDelegate;


- (void) showAlertPopupWithMessage: (NSString *) message inViewController: (ViewController *) vc;
- (void) enableButtonsWithViewController: (ViewController *) vc;
- (void) refreshUIWithWeatherData: (Weather *) weatherData inViewController: (ViewController *) vc;
- (void) initUI;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.progressBar.hidesWhenStopped = YES;
    [self.progressBar stopAnimating];
    self.progressBar.color = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    [self initUI]; // At start
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
}


// Utility to show alert popup
- (void) showAlertPopupWithMessage: (NSString *) message
                  inViewController: (ViewController *) vc {
    // All well got the image
    if (!vc) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController  *aVC = [UIAlertController alertControllerWithTitle:@"Weather API" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [aVC addAction:ac];
        [vc presentViewController:aVC animated:YES completion:nil];
    });
}

- (void) enableButtonsWithViewController: (ViewController *) vc {
    if (!vc) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        vc.getWeatherButton.enabled = YES;
        [vc.progressBar stopAnimating];
    });
}

- (void) initUI {
    self.cityCountryUserUIL.text = @"";
    self.cityCountryFetchedUIL.text = @"";
    self.tempMaxUIL.text = @"";
    self.tempMinUIL.text = @"";
    self.tempNowUIL.text = @"";
    self.cloudsAllUIL.text = @"";
    self.windSpeedMphUIL.text = @"";
    self.windDirectionDegUIL.text = @"";
    self.latlonUIB.enabled = NO;
    [self.latlonUIB setTitle:@"" forState:UIControlStateDisabled];
    self.openweatherCityIdUIL.text = @"";
    self.weatherDescriptionUIL.text = @"";
    self.weatherMainUIL.text = @"";
    self.dateSunriseUIL.text = @"";
    self.dateSunsetUIL.text = @"";
    self.rain3hUIL.text = @"";
    self.snow3hUIL.text = @"";
    self.humidityPercentUIL.text = @"";
    self.pressureHpaUIL.text = @"";
    self.pressureSeaLevelHpaUIL.text = @"";
    self.dateFetchedUIL.text = @"";
    self.secondsAgoUIL.text = @"";
    [self.weatherIconUII setImage:[UIImage imageNamed:@"icon_default"]];
    self.tweetThisUIB.hidden=YES;
}

- (void) refreshUIWithWeatherData: (Weather *) weatherData
                 inViewController: (ViewController *) vc {
    if (!vc) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weatherData.cityAndCountryUser) {
            vc.cityCountryUserUIL.text = [@"City asked:" stringByAppendingString:weatherData.cityAndCountryUser];
            vc.cityCountryFetchedUIL.text = [NSString stringWithFormat:@"City: %@,%@", weatherData.cityName, weatherData.sysCountry];
        }
        else {
            vc.cityCountryUserUIL.text = @"";
            vc.cityCountryFetchedUIL.text = @"";
        }
        if (weatherData.mainTemp) {
            vc.tempMaxUIL.text = [NSString stringWithFormat:@"%.0f ℉",[weatherData.mainTempMax doubleValue]];
            vc.tempMinUIL.text = [NSString stringWithFormat:@"%.0f ℉",[weatherData.mainTempMin doubleValue]];
            vc.tempNowUIL.text = [NSString stringWithFormat:@"%.0f℉",[weatherData.mainTemp doubleValue]];
        } else {
            vc.tempMaxUIL.text = @"";
            vc.tempMinUIL.text = @"";
            vc.tempNowUIL.text = @"";
        }
        if (weatherData.cloudsAll) {
            vc.cloudsAllUIL.text = [NSString stringWithFormat:@"Clouds: %.0f%%",[weatherData.cloudsAll doubleValue]];
        } else {
            vc.cloudsAllUIL.text = @"";
        }
        if (weatherData.windSpeed) {
            vc.windSpeedMphUIL.text = [NSString stringWithFormat:@"Wind speed: %.0f mph",[weatherData.windSpeed doubleValue]];
        } else {
            vc.windSpeedMphUIL.text = @"";
        }
        if (weatherData.windDeg) {
            vc.windDirectionDegUIL.text = [NSString stringWithFormat:@"Wind direction: %.0f° %@",[weatherData.windDeg doubleValue], [Weather weatherWindDirectionForWindDegrees:weatherData.windDeg]];
        } else {
            vc.windDirectionDegUIL.text = @"";
        }
        if (weatherData.coordLat || weatherData.coordLon) {
            NSString *latLon = [NSString stringWithFormat:@"%0.4f,%0.4f",[weatherData.coordLat doubleValue], [weatherData.coordLon doubleValue]];
            [vc.latlonUIB setTitle:latLon forState:UIControlStateNormal];
            vc.self.latlonUIB.enabled = YES;
            
        } else {
            vc.self.latlonUIB.enabled = NO;
        }
        if (weatherData.identifier) {
            vc.openweatherCityIdUIL.text = [NSString stringWithFormat:@"City ID: %@",weatherData.identifier];
        } else {
            vc.openweatherCityIdUIL.text = @"";
        }
        if (weatherData.weather0Description) {
            vc.weatherDescriptionUIL.text = weatherData.weather0Description;
        } else {
            vc.weatherDescriptionUIL.text = @"";
        }
        if (weatherData.weather0Main) {
            vc.weatherMainUIL.text = weatherData.weather0Main;
        } else {
            vc.weatherMainUIL.text = @"";
        }
        if (weatherData.sysSunrise) {
            NSString *localSunriseDate = [NSDateFormatter localizedStringFromDate:weatherData.sysSunrise dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
            vc.dateSunriseUIL.text = [@"Sunrise at: " stringByAppendingString:localSunriseDate];
        } else {
            vc.dateSunriseUIL.text = @"";
        }
        if (weatherData.sysSunset) {
            NSString *localSunsetDate = [NSDateFormatter localizedStringFromDate:weatherData.sysSunset dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];

            vc.dateSunsetUIL.text = [@"Sunset at: " stringByAppendingString:localSunsetDate];
            
        } else {
            vc.dateSunsetUIL.text = @"";
        }
        if (weatherData.rainThreeHour) {
            vc.rain3hUIL.text = [NSString stringWithFormat:@"Rain: %0.2f",[weatherData.rainThreeHour doubleValue]];
        } else {
            vc.rain3hUIL.text = @"";
        }
        
        if (weatherData.snowThreeHour) {
            vc.snow3hUIL.text = [NSString stringWithFormat:@"Snow: %0.2f",[weatherData.snowThreeHour doubleValue]];
        } else {
            vc.snow3hUIL.text = @"";
        }
        
        if (weatherData.mainHumidity) {
            vc.humidityPercentUIL.text = [NSString stringWithFormat:@"Humidity: %.0f%%",[weatherData.mainHumidity doubleValue]];
        } else {
            vc.humidityPercentUIL.text = @"";
        }
        if (weatherData.mainPressure) {
            vc.pressureHpaUIL.text = [NSString stringWithFormat:@"Pressure: %.0f hPa",[weatherData.mainPressure doubleValue]];
        } else {
            vc.pressureHpaUIL.text = @"";
        }
        if (weatherData.mainSeaLevel) {
            vc.pressureSeaLevelHpaUIL.text = [NSString stringWithFormat:@"Pressure at Sea Level: %.0f hPa",[weatherData.mainSeaLevel doubleValue]];
        } else {
            vc.pressureSeaLevelHpaUIL.text = @"";
        }

        if (weatherData.serverFetchDate) {
            NSString *serverFetchData = [NSDateFormatter localizedStringFromDate:weatherData.serverFetchDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
            vc.dateFetchedUIL.text = [@"Last fetch: " stringByAppendingString:serverFetchData];
            
            NSDate *now = [NSDate date];
            NSTimeInterval interval = [now timeIntervalSinceDate:weatherData.serverFetchDate];
            int seconds = (int)interval % 60;
            int minutes = ((int)interval / 60) % 60;
            vc.secondsAgoUIL.text = [NSString stringWithFormat:@"\t\t%d minutes and %d seconds ago", minutes,seconds];
        } else {
            vc.dateFetchedUIL.text = @"";
            vc.secondsAgoUIL.text = @"";
        }
        
        [vc.weatherIconUII setImage:[UIImage imageNamed:[Weather weatherIconImageName:weatherData.weather0Icon]]];
        self.tweetThisUIB.hidden=NO;
    });
    
}

- (IBAction)tweetThisHandler:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        NSString *composeTweetText = [NSString stringWithFormat:@"#CityWeather: %@ %@ %@ %@ %@ %@ %@ %@",
                                      self.cityCountryFetchedUIL.text, self.tempNowUIL.text, self.cloudsAllUIL.text,
                                      self.windSpeedMphUIL.text, self.rain3hUIL.text, self.snow3hUIL.text,
                                      self.dateSunsetUIL.text, self.humidityPercentUIL.text ];
        NSString *tweetText = [composeTweetText length] > 140 ? [composeTweetText substringToIndex:140] : composeTweetText;
        [twitterVC setInitialText:tweetText];
        [self presentViewController:twitterVC animated:YES completion:nil];
        
    } else {
        [self showAlertPopupWithMessage:@"Login into twitter first" inViewController:self];
    }
}

- (IBAction)latLonMapsHandler:(id)sender {
    // http://maps.apple.com/?ll=50.894967,4.341626
    // https://developer.apple.com/library/iad/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html

    NSString *appUrlString =[NSString stringWithFormat: @"http://maps.apple.com/?q=%@", self.latlonUIB.titleLabel.text];
    NSURL *url = [NSURL URLWithString:[appUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    [[UIApplication sharedApplication] openURL:url];
    if(kATDebugDetailON) NSLog(@"latLonMapsHandler: URL=%@",appUrlString);
}

// Handler when Get Weather Button is pressed
- (IBAction)getWeatherHandler:(id)sender {
    self.getWeatherButton.enabled = NO;
    
    // Get the City and state text
    NSString *cityCountry = self.cityCountryTV.text;
    if ([cityCountry compare:@""] == NSOrderedSame) {
        [self showAlertPopupWithMessage:@"Enter a City, Country"
                       inViewController:self];
        self.getWeatherButton.enabled = YES;
        return;
    }
    // Start progress bar
    [self.progressBar startAnimating];
    [Utilities hideKeyoardOnViewController:(ViewController *)self.cityCountryTV];
    
    Weather *cityWeather = [Weather weatherWithCityCountry:cityCountry inAppDelegate:self.appDelegate];
    __weak ViewController *weakSelf = self;
    if (!cityWeather) {
        [Utilities downloadWeatherDataFromAPIForCityCountry:cityCountry
                                             successHandler:^(NSDictionary *data) {
                                                 __strong ViewController * strongSelf = weakSelf;
                                                 if (strongSelf && data) {
                                                     Weather *weather = [Weather weatherWithOpenWeatherInfo:data inCityCountry:cityCountry inAppDelegate:strongSelf.appDelegate];
                                                     [strongSelf refreshUIWithWeatherData:weather inViewController:strongSelf];
                                                     [strongSelf enableButtonsWithViewController:strongSelf];
                                                 }
                                             } errorHandler:^(NSString *errorMessage) {
                                                 __strong ViewController * strongSelf = weakSelf;
                                                 if (strongSelf) {
                                                     [strongSelf showAlertPopupWithMessage:errorMessage inViewController:strongSelf];
                                                 }
                                                 if (kATDebugErrorON) NSLog(@"getWeatherHandler-errorHandler:%@",errorMessage);
                                                 [self enableButtonsWithViewController:self];
                                             }];
    } else {
        [self refreshUIWithWeatherData:cityWeather inViewController:self];
        [self enableButtonsWithViewController:self];
    }
    
    
}



@end
