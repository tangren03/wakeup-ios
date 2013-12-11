//
//  UIScreenEx.m
//  Wakeup
//
//  Created by shin on 13-12-11.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#include "UIScreenEx.h"

static int static_statusbarHeight = 0;

int getScreenWidth()
{
    static int s_scrWidth = 0;
    if (s_scrWidth == 0){
        CGRect screenFrame = [UIScreen mainScreen].bounds;
        s_scrWidth = screenFrame.size.width;
    }
    return s_scrWidth;
}

int getScreenHeight()
{
    static int s_scrHeight = 0;
    if (s_scrHeight == 0){
        CGRect screenFrame = [UIScreen mainScreen].bounds;
        s_scrHeight = screenFrame.size.height;
    }
    return s_scrHeight;
}

int getStatusBarHeight()
{
    if (static_statusbarHeight == 0) {
        CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
        static_statusbarHeight = MIN(statusBarFrame.size.width, statusBarFrame.size.height);
    }
    return static_statusbarHeight;
}

void setStatusBarHeight(int newH)
{
    static_statusbarHeight = newH;
}
