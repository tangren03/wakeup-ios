//
//  UIScreenEx.h
//  Wakeup
//
//  Created by shin on 13-12-11.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#ifndef __UIScreenEx__
#define __UIScreenEx__

#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif
    int getScreenWidth();
    
    int getScreenHeight();
    
    // 获取状态栏竖边高度
    int getStatusBarHeight();
    
    void setStatusBarHeight(int newH);
#ifdef __cplusplus
}
#endif

#define SCREEN_WIDTH            getScreenWidth()
#define SCREEN_HEIGHT           getScreenHeight()
#define SCREEN_WIDTH_2          (SCREEN_WIDTH << 1)
#define SCREEN_HEIGHT_2         (SCREEN_HEIGHT << 1)

#define STATUSBAR_HEIGHT        getStatusBarHeight()
#define APPLICATION_WIDTH       (SCREEN_WIDTH)
#define APPLICATION_HEIGHT      (SCREEN_HEIGHT - STATUSBAR_HEIGHT)

#define IS_IPHONE5   (SCREEN_HEIGHT > 480 ? TRUE:FALSE)

#endif