//
//  StartViewController.m
//  Wakeup
//
//  Created by shin on 13-12-11.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "StartViewController.h"
#import <math.h>

// self proj
#import "CityManager.h"
#import "Config.h"
#import "DoubleColorView.h"
#import "WeatherView.h"
#import "SettingViewController.h"

// thirdparty
#import "ASIHTTPRequest.h"
#import "RNTimer.h"
#import "SBJsonParser.h"

#define WEATHER_VIEW_TOP_MARGIN  30

@interface StartViewController ()
@property (readwrite, strong) RNTimer *timer;
@property (nonatomic, strong) CLLocationManager *locManager;
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLocation];
    
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    [self.view setFrame:appFrame];

    _weatherView =
    [[WeatherView alloc] initWithFrame:
     CGRectMake(0, WEATHER_VIEW_TOP_MARGIN, appFrame.size.width, 102)];

    _timeLabel =
    [[UILabel alloc] initWithFrame:
     CGRectMake(40, _weatherView.frame.origin.y + _weatherView.frame.size.height + 10, 320, 120)];

    [_timeLabel setFont:[UIFont fontWithName:@"Roboto-Thin" size:100]];
    [_timeLabel setBackgroundColor:[UIColor clearColor]];
    [_timeLabel setTextAlignment:NSTextAlignmentLeft];
    [_timeLabel setTextColor:[UIColor whiteColor]];
    [_timeLabel setNumberOfLines:1];

    _addClockButton = [[UIButton alloc] initWithFrame:
                       CGRectMake(80,
                                  _timeLabel.frame.origin.y + _timeLabel.frame.size.height + 20,
                                  160,
                                  100)];
    
    [_addClockButton setBackgroundImage:[UIImage imageNamed:@"addnew.png"]
                               forState:UIControlStateNormal];
    
    [_addClockButton addTarget:self
                        action:@selector(addClock)
              forControlEvents:UIControlEventTouchUpInside];

    _bgImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _bgImageView.image = [UIImage imageNamed:@"bg_blue.png"];
    
    float doubleColorViewY = _addClockButton.frame.origin.y + _addClockButton.frame.size.height + 30;
    _doubleColorView = [[DoubleColorView alloc] initWithFrame:CGRectMake(0,
                                                                         doubleColorViewY,
                                                                         appFrame.size.width,
                                                                         60)];

    [self.view addSubview:_bgImageView];
    [self.view addSubview:_weatherView];
    [self.view addSubview:_timeLabel];
    [self.view addSubview:_addClockButton];
    [self.view addSubview:_doubleColorView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [self updateNow];

    __weak id weakSelf = self;
    self.timer =
    [RNTimer repeatingTimerWithTimeInterval:30
                                      block:^{
                                          [weakSelf updateNow];
                                      }];
}

- (void)updateNow {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    self.timeLabel.text = currentDateStr;
}

- (void)startLocation {
    _locManager = [[CLLocationManager alloc] init];
    [_locManager setDelegate:self];
    [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locManager setDistanceFilter:5];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH"];
    
    NSString *lastWeatherUpdateKey = [Config propertyForkey:@"LastWeatherUpdate"];
    if (lastWeatherUpdateKey == nil) {
        [_locManager startUpdatingLocation];
    } else {
        NSDate *lastUpdateDate = [dateFormatter dateFromString:lastWeatherUpdateKey];
        if ([lastUpdateDate compare:[NSDate date]] < 0) {
            [_locManager startUpdatingLocation];
        }
    }
}

- (IBAction)addClock {
    SettingViewController *settingViewCtrl = [[SettingViewController alloc] init];
    [self presentViewController:settingViewCtrl animated:YES completion:nil];
    
    
}

// Reference:
// http://hi.baidu.com/maartenyang/item/fee5d7d798d1eaa66dce3f5c
// http://blog.sina.com.cn/s/blog_bb2623410101bblx.html
// http://blog.csdn.net/learnios/article/details/8563777

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    CLLocationCoordinate2D loc = [newLocation coordinate];

    NSString *urlCity = [NSString stringWithFormat:
                         @"http://maps.google.com/maps"
                        "/api/geocode/json?latlng=%f,%f"
                        "&language=zh-CN&sensor=true",
                        loc.latitude, fabs(loc.longitude)];
    NSLog(@"lat,lng: %@", urlCity);

    __block ASIHTTPRequest *reqCity =
    [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlCity]];

    __weak id weakSelf = self;
    __weak ASIHTTPRequest *weakReqCity = reqCity;
    
    [weakReqCity setCompletionBlock:^{
        SBJsonParser* jsonParser = [[SBJsonParser alloc] init];
        NSDictionary* jsonDic = [jsonParser objectWithString:weakReqCity.responseString];
        
        NSString *cityName = nil;
        @try {
            cityName = jsonDic[@"results"][0][@"address_components"][2][@"short_name"];
        } @catch (NSException *e) {
            NSLog(@"[lat, lng] invalid: %@", e);
            [[weakSelf weatherView] performSelectorOnMainThread:@selector(cityDidChanged:)
                                                     withObject:@"定位失败"
                                                  waitUntilDone:YES];
            [[weakSelf weatherView] performSelectorOnMainThread:@selector(weatherDidChanged:)
                                                     withObject:@"天气查询失败"
                                                  waitUntilDone:YES];
        } @finally {
            NSLog(@"city name: %@", cityName);
        }
        
        if (cityName == nil) return;
        [[weakSelf weatherView] performSelectorOnMainThread:@selector(cityDidChanged:)
                                                 withObject:cityName
                                              waitUntilDone:YES];
        
        NSString *urlWeather = [NSString stringWithFormat:
                                @"http://m.weather.com.cn/data/%@.html",
                                [[CityManager sharedInstance] getCityCode:cityName]];
        
        __block ASIHTTPRequest *reqWeather =
        [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlWeather]];
        __weak ASIHTTPRequest *weakReqWeather = reqWeather;
        
        [weakReqWeather setCompletionBlock:^{
            SBJsonParser* jsonParser = [[SBJsonParser alloc] init];
            NSDictionary* jsonDic = [jsonParser objectWithString:weakReqWeather.responseString];
            NSString *part1 = jsonDic[@"weatherinfo"][@"temp1"];
            NSString *part2 = jsonDic[@"weatherinfo"][@"weather1"];
            NSString *weather = [NSString stringWithFormat:@"%@ %@", part1, part2];
            [[weakSelf weatherView] performSelectorOnMainThread:@selector(weatherDidChanged:)
                                                     withObject:weather
                                                  waitUntilDone:YES];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH"];
            [Config saveProperty:[dateFormatter stringFromDate:[NSDate date]]
                          forKey:@"LastWeatherUpdate"];
        }];
        
        [weakReqWeather setFailedBlock:^{
            [[weakSelf weatherView] performSelectorOnMainThread:@selector(weatherDidChanged:)
                                                     withObject:@"天气查询失败"
                                                  waitUntilDone:YES];
        }];
        [weakReqWeather startAsynchronous];
    }];
    
    [weakReqCity setFailedBlock:^{
        [[weakSelf weatherView] performSelectorOnMainThread:@selector(cityDidChanged:)
                                                 withObject:@"定位失败"
                                              waitUntilDone:YES];
        [[weakSelf weatherView] performSelectorOnMainThread:@selector(weatherDidChanged:)
                                                 withObject:@"天气查询失败"
                                              waitUntilDone:YES];
    }];
    
    [weakReqCity startAsynchronous];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"Get GPS info failed: %@", [error localizedDescription]);
}

#pragma mark -
#pragma mark Thirdparty Fonts

- (void)dumpFonts {
    NSArray* familys = [UIFont familyNames];
    for (int i = 0; i < [familys count]; ++i) {
        NSString* family = [familys objectAtIndex:i];
        NSLog(@"Font family:%@ =====",family);
        NSArray* fonts = [UIFont fontNamesForFamilyName:family];
        
        for (int j = 0; j < [fonts count]; ++j) {
            NSLog(@"  Font name:%@", [fonts objectAtIndex:j]);
        }
        NSLog(@"");
    }
}

@end


