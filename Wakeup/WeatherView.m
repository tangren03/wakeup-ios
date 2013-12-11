//
//  StartView.m
//  Wakeup
//
//  Created by shin on 13-12-11.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView

#define WEATHER_IMAGE_SIZE 50

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.BackgroundColor = [UIColor clearColor];
        
        _weatherImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _weatherLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [self addSubview:_weatherLabel];
        [self addSubview:_cityLabel];
        [self addSubview:_weatherImageView];
        
        [_weatherImageView setFrame:CGRectMake(74, 0, WEATHER_IMAGE_SIZE, WEATHER_IMAGE_SIZE)];
        [_cityLabel setFrame:CGRectMake(_weatherImageView.frame.origin.x + 2,
                                        _weatherImageView.frame.origin.y,
                                        100,
                                        40)];
        [_weatherLabel setFrame:CGRectMake(_cityLabel.frame.origin.x,
                                           _cityLabel.frame.origin.y + _cityLabel.frame.size.height + 2,
                                           100,
                                           40)];
        
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
        [_cityLabel setFont:[UIFont fontWithName:@"Arial" size:30]];
        [_weatherLabel setFont:[UIFont fontWithName:@"Arial" size:26]];
        
        _cityLabel.text = @"Beijing";
        _weatherLabel.text = @"多云转晴";
    }
    return self;
}

#pragma mark WeatherChangedDelegate

- (void)cityDidChanged:(NSString *)city {
    [self.cityLabel setText:city];
}

- (void)weatherDidChanged:(NSString *)weather {
    [self.weatherLabel setText:weather];
    
    // TODO(shin): add weather image changed
    // [self.weatherImageView setImage:<#(UIImage *)#>];
}



@end
