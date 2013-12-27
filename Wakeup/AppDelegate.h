//
//  AppDelegate.h
//  Wakeup
//
//  Created by Ryan on 13-12-8.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) UINavigationController *navController;

@end
