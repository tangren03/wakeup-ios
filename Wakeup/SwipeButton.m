//
//  SwipeButton.m
//  Wakeup
//
//  Created by frost on 13-12-13.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "SwipeButton.h"

@implementation SwipeButton

#define CLOSE_BTN_WIDTH 80

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UISwipeGestureRecognizer *leftGestureRecog =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe)];
        leftGestureRecog.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:leftGestureRecog];
        
        UISwipeGestureRecognizer *rightGestureRecog =
        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe)];
        rightGestureRecog.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:rightGestureRecog];
        
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)leftSwipe {
    if (!self.isRightSwiped) return;
    
    [UIView animateWithDuration:0.1 animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x - CLOSE_BTN_WIDTH,
                                  self.frame.origin.y,
                                  self.frame.size.width,
                                  self.frame.size.height)];
    } completion:^(BOOL finished) {
        self.isRightSwiped = NO;
    }];
}

- (void)rightSwipe {
    if (self.isRightSwiped) return;
    
    [UIView animateWithDuration:0.1 animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x + CLOSE_BTN_WIDTH,
                                  self.frame.origin.y,
                                  self.frame.size.width,
                                  self.frame.size.height)];
    } completion:^(BOOL finished) {
        self.isRightSwiped = YES;
    }];
}

- (void)click {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"modify clock"
                                                    message:@"add modify clock"
                                                   delegate:nil
                                          cancelButtonTitle:@"cancel"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
