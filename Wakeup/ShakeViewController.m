//
//  ShakeViewController.m
//  Wakeup
//
//  Created by Ryan on 13-12-18.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "ShakeViewController.h"
#import "Utils.h"
#import "UIResponder+MotionRecognizers.h"
#import "KDGoalBar.h"
#import "Config.h"
#import "ShareViewController.h"

@interface ShakeViewController ()
{
    int percent;
    int percentStep;
}
@property(nonatomic,strong) KDGoalBar *shakeProgressBar;
@end

@implementation ShakeViewController

-(id)init
{
    if (self = [super init]) {
        NSString *shakeLevel = [Config propertyForkey:PRO_SHAKE];
        if (shakeLevel == nil) {
            percentStep = 20;
        }else{
            if ([shakeLevel isEqualToString:@"容易"]) {
                percentStep = 33;
            }else if([shakeLevel isEqualToString:@"中等"]){
                percentStep = 20;
            }else{
                percentStep = 10;
            }
        }
        
        percent = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [Utils colorWithHexString:MAIN_COLOR];
    
    UIImage *shakeTextIMG = [UIImage imageNamed:@"shake_text"];
    UIImageView *iv_shakeText = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - shakeTextIMG.size.width / 2, self.view.frame.size.height - shakeTextIMG.size.height - 10, shakeTextIMG.size.width, shakeTextIMG.size.height)];
    iv_shakeText.image = shakeTextIMG;
    [self.view addSubview:iv_shakeText];
    
    //shake progress bar
    self.shakeProgressBar = [[KDGoalBar alloc]initWithFrame:CGRectMake(0, 0, 250, 250)];
    self.shakeProgressBar.center = self.view.center;
    [self.shakeProgressBar setPercent:0 animated:YES];
    [self.view addSubview:self.shakeProgressBar];
    
    //time
    UILabel *lb_time = [[UILabel alloc] initWithFrame:CGRectMake(0, 40.0, self.view.frame.size.width, 30.0)];
    lb_time.textColor = [UIColor whiteColor];
    lb_time.textAlignment = NSTextAlignmentCenter;
    lb_time.font = [UIFont systemFontOfSize:18.0];
    lb_time.text = [Config propertyForkey:PRO_CLOCK_NAME];
    [self.view addSubview:lb_time];
}

//shake motion responder
-(void)shakeMotionWasTriggered
{
    if (percent == 100 || percent == 99) {
        percent = 0;
    
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        ShareViewController *shareViewCtrl = [[ShareViewController alloc] init];
        [self.navigationController pushViewController:shareViewCtrl animated:YES];
        
    }else{
        percent += percentStep;
        [self.shakeProgressBar setPercent:percent animated:YES];
    }
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self addMotionRecognizerWithAction:@selector(shakeMotionWasTriggered)];
}

- (void) viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
    [self removeMotionRecognizer];
}

@end
