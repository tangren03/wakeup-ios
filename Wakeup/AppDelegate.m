//
//  AppDelegate.m
//  Wakeup
//
//  Created by Ryan on 13-12-8.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "AppDelegate.h"
#import "StartViewController.h"
#import "CPMotionRecognizingWindow.h"
#import "ShakeViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[CPMotionRecognizingWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    StartViewController *startViewController = [[StartViewController alloc] init];
    
//    self.navController = [[UINavigationController alloc] initWithRootViewController:startViewController];
    
//    [self.window addSubview: self.navController.view];
    self.window.rootViewController = startViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    
    sleep(1);
    
    [self.window makeKeyAndVisible];
    
    //Register weixin id
    [WXApi registerApp:@"wxa3b3bc276f01e94a"];
    
    NSLog(@"didFinishLaunchingWithOptions");
    
    
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"didReceiveLocalNotification");
    NSString *isClockOpen = [Config propertyForkey:PRO_IS_CLOCK_OPEN];
    if (isClockOpen != nil && [isClockOpen isEqualToString:PRO_YES]) {
        NSLog(@"is open");

        ShakeViewController *shakeViewCtrl = [[ShakeViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:shakeViewCtrl];
        navi.navigationBarHidden = YES;
        [self.window.rootViewController presentViewController:navi animated:YES completion:nil];
    }
}


#pragma WX Delegate
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strMsg;
        if (resp.errCode == 0) {
            strMsg = @"恭喜，发送成功！";
        }else{
            strMsg = @"发送失败";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//override
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
