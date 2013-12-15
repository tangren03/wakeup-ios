//
//  StartViewController.h
//  Wakeup
//
//  Created by shin on 13-12-11.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class WeatherView;
@class DoubleColorView;

@interface StartViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) WeatherView *weatherView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *addClockButton;
@property (nonatomic, strong) DoubleColorView *doubleColorView;

- (IBAction)addClock;

@end
