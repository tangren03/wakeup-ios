//
//  StartViewController.m
//  Wakeup
//
//  Created by frost on 13-12-11.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "StartViewController.h"
#import <math.h>

// self proj
#import "WeatherView.h"

// thirdparty
#import "ASIHTTPRequest.h"
#import "RNTimer.h"
#import "SBJsonParser.h"

#define WEATHER_VIEW_TOP_MARGIN  80

@interface StartViewController ()
@property (readwrite, strong) RNTimer *timer;
@property (nonatomic, strong) CLLocationManager *locManager;
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locManager = [[CLLocationManager alloc] init];
    [_locManager setDelegate:self];
    [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [_locManager setDistanceFilter:5];
    [_locManager startUpdatingLocation];
    
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    [self.view setFrame:appFrame];
    
    _weatherView =
    [[WeatherView alloc] initWithFrame:
     CGRectMake(0, WEATHER_VIEW_TOP_MARGIN, appFrame.size.width, 102)];
    
    _timeLabel =
    [[UILabel alloc] initWithFrame:
     CGRectMake(60, _weatherView.frame.origin.y + 60, 320, 150)];
    
    [_timeLabel setFont:[UIFont fontWithName:@"Arial" size:80]];
    [_timeLabel setBackgroundColor:[UIColor clearColor]];
    [_timeLabel setTextAlignment:NSTextAlignmentLeft];
    [_timeLabel setTextColor:[UIColor whiteColor]];
    [_timeLabel setNumberOfLines:1];
    
    _addClockButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_addClockButton setBackgroundImage:[UIImage imageNamed:@"addnew.png"]
                               forState:UIControlStateNormal
                                        |UIControlStateHighlighted];
    [_addClockButton addTarget:self
                        action:@selector(addClock)
              forControlEvents:UIControlEventTouchUpInside];
    
    _bgImageView = [[UIImageView alloc] initWithFrame:appFrame];
    _bgImageView.image = [UIImage imageNamed:@"bg_blue.png"];
    
    [self.view addSubview:_bgImageView];
    [self.view addSubview:_weatherView];
    [self.view addSubview:_timeLabel];
    [self.view addSubview:_addClockButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self updateNow];
    
    __weak id weakSelf = self;
    self.timer =
    [RNTimer repeatingTimerWithTimeInterval:1
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

- (IBAction)addClock {
    
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
    
    NSString *urlStr = [NSString stringWithFormat:@"http://maps.google.com/maps"
                        "/api/geocode/json?latlng=%f,%f"
                        "&language=zh-CN&sensor=true",
                        loc.latitude, fabs(loc.longitude)];
    NSLog(@"lat,lng: %@", urlStr);
    
    [self.weatherView cityDidChanged:@"查询中.."];
    
    __block __weak ASIHTTPRequest *req =
    [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    __weak id weakSelf = self;
    [req setCompletionBlock:^{
        SBJsonParser* jsonObj = [[SBJsonParser alloc] init];
        NSDictionary* jsonDic = [jsonObj objectWithString:req.responseString];
        NSLog(@"location json: %@", jsonDic);
        NSString *cityName = jsonDic[@"results"][0][@"address_components"][2][@"short_name"];
        NSLog(@"city name: %@", cityName);
        [[weakSelf weatherView] cityDidChanged:cityName];
    }];
    
    [req setFailedBlock:^{
        [[weakSelf weatherView] cityDidChanged:@"查询失败"];
    }];
    [req startAsynchronous];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"Get GPS info failed: %@", [error localizedDescription]);
}


@end
