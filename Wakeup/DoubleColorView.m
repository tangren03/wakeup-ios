//
//  DoubleColorView.m
//  Wakeup
//
//  Created by frost on 13-12-12.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "DoubleColorView.h"

@implementation DoubleColorView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _closeButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _modifyButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _leftNotifyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [self addSubview:_modifyButton];
        [self addSubview:_closeButton];
        [self addSubview:_leftNotifyLabel];
        
        [_closeButton setBackgroundColor:[UIColor redColor]];
        [_closeButton setFrame:CGRectMake(0, 0, 20, frame.size.height)];
    }
    return self;
}

@end
