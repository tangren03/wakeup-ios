//
//  DoubleColorView.m
//  Wakeup
//
//  Created by frost on 13-12-12.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "DoubleColorView.h"
#import <math.h>
#import "SwipeButton.h"

@implementation DoubleColorView

#define LEFT_NOTIFY_WIDTH 10
#define CLOSE_BTN_WIDTH 80

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        _closeButton = [[UIButton alloc] init];
        _modifyButton = [[SwipeButton alloc] initWithFrame:CGRectZero];
        _leftNotifyImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:_leftNotifyImageView];
        [self addSubview:_closeButton];
        [self addSubview:_modifyButton];
        
        UIColor *leftNotifyColor = [UIColor greenColor];
//        [UIColor colorWithRed:243.0/255 green:243.0/255 blue:243.0/255 alpha:1];
        
        [_leftNotifyImageView setBackgroundColor:leftNotifyColor];
        
        UIColor *closeButtonColor = [UIColor redColor];
//        [UIColor colorWithRed:233.0/255 green:111.0/255 blue:111.0/255 alpha:1];
        
        [_closeButton setBackgroundColor:closeButtonColor];
        
        UIColor *modifyButtonColor = [UIColor yellowColor];
//        [UIColor colorWithRed:124.0/255 green:105.0/255 blue:97.0/255 alpha:1];
        
        [_modifyButton setBackgroundColor:modifyButtonColor];
        
        
        [_leftNotifyImageView setFrame:CGRectMake(0, 0, LEFT_NOTIFY_WIDTH, frame.size.height)];
        [_closeButton setFrame:CGRectMake(_leftNotifyImageView.frame.origin.x + _leftNotifyImageView.frame.size.width,
                                          0,
                                          CLOSE_BTN_WIDTH,
                                          frame.size.height)];
        [_modifyButton setFrame:CGRectMake(_leftNotifyImageView.frame.origin.x + _leftNotifyImageView.frame.size.width,
                                           0,
                                           320 - _leftNotifyImageView.frame.size.width,
                                           frame.size.height)];
        
        [_closeButton setTitle:@"Close" forState:UIControlStateNormal];
        [_modifyButton setTitle:@"6:10 为梦想而起" forState:UIControlStateNormal];
    }
    return self;
}


@end
