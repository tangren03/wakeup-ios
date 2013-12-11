//
//  StartViewController.m
//  Wakeup
//
//  Created by frost on 13-12-11.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "StartViewController.h"

#import "WeatherView.h"
#import "RNTimer.h"

#define WEATHER_VIEW_TOP_MARGIN  80

@interface StartViewController ()
@property (readwrite, strong) RNTimer *timer;
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
                               forState:UIControlStateNormal|UIControlStateHighlighted];
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

@end
