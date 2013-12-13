//
//  DoubleColorView.h
//  Wakeup
//
//  Created by frost on 13-12-12.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwipeButton;

@interface DoubleColorView : UIView

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) SwipeButton *modifyButton;
@property (nonatomic, strong) UIImageView *leftNotifyImageView;

@end
