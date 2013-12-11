//
//  StartViewController.h
//  Wakeup
//
//  Created by frost on 13-12-11.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeatherView;

@interface StartViewController : UIViewController

@property (nonatomic, strong) WeatherView *weatherView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *addClockButton;

- (IBAction)addClock;

@end
