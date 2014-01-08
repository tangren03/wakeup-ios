//
//  StartView.m
//  Wakeup
//
//  Created by shin on 13-12-11.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "WeatherView.h"
#import "NSString+ForJava.h"

@implementation WeatherView

#define WEATHER_IMAGE_SIZE 40

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.BackgroundColor = [UIColor clearColor];
        
        _weatherImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _weatherLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [self addSubview:_weatherImageView];
        [self addSubview:_cityLabel];
        [self addSubview:_weatherLabel];
        
        [_weatherImageView setFrame:CGRectMake(30, 30, WEATHER_IMAGE_SIZE, WEATHER_IMAGE_SIZE)];
        [_cityLabel setFrame:CGRectMake(_weatherImageView.frame.origin.x + _weatherImageView.frame.size.width + 2,
                                        _weatherImageView.frame.origin.y,
                                        200,
                                        30)];
        [_weatherLabel setFrame:CGRectMake(_cityLabel.frame.origin.x,
                                           _cityLabel.frame.origin.y + _cityLabel.frame.size.height + 2,
                                           200,
                                           30)];
        
        for (id obj in self.subviews) {
            if ([obj isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)obj;
                [label setBackgroundColor:[UIColor clearColor]];
                [label setTextAlignment:NSTextAlignmentLeft];
                [label setTextColor:[UIColor whiteColor]];
                [label setNumberOfLines:0];
                [label setLineBreakMode:NSLineBreakByWordWrapping];
            }
        }
        [_cityLabel setFont:[UIFont fontWithName:@"RTWSYueGoTrial-Light" size:20]];
        [_weatherLabel setFont:[UIFont fontWithName:@"RTWSYueGoTrial-Light" size:20]];
        
        _cityLabel.text = @"城市查询中..";
        _weatherLabel.text = @"天气查询中..";
    }
    return self;
}

- (void)cityDidChanged:(NSString *)city {
    [self.cityLabel setText:city];
}

- (void)weatherDidChanged:(NSString *)weather {
    [self.weatherLabel setText:weather];
    [self weatherImageViewDidChanged:weather];
}

- (void)weatherImageViewDidChanged:(NSString *)weather {
    if ([weather length] <= 0) return;
    
    if ([weather contain:@"晴"]) {
        [self.weatherImageView setImage:[UIImage imageNamed:@"sunny.png"]];
    } else if ([weather contain:@"云"]) {
        [self.weatherImageView setImage:[UIImage imageNamed:@"cloudy.png"]];
    } else if ([weather contain:@"雨"]) {
        [self.weatherImageView setImage:[UIImage imageNamed:@"rain.png"]];
    } else if ([weather contain:@"雪"]) {
        [self.weatherImageView setImage:[UIImage imageNamed:@"snow.png"]];
    }
}


@end
