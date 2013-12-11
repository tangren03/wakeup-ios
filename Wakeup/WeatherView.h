//
//  StartView.h
//  Wakeup
//
//  Created by shin on 13-12-11.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeatherChangedDelegate <NSObject>

- (void)cityDidChanged:(NSString *)city;
- (void)weatherDidChanged:(NSString *)weather;

@end


@interface WeatherView : UIView <WeatherChangedDelegate>

@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) UIImageView *weatherImageView;

@end
