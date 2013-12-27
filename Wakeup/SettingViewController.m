//
//  SettingViewController.m
//  Wakeup
//
//  Created by Ryan on 13-12-18.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "SettingViewController.h"
#import "ShakeViewController.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize viewSize = self.view.frame.size;
    
    //background image
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_purple_iph5"]];
    
    //back button
    UIImage *imgBack = [UIImage imageNamed:@"back"];
    UIImage *imgBackClicked = [UIImage imageNamed:@"back_click"];
    _btnBack = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, imgBack.size.width, imgBack.size.height)];
    [_btnBack setImage:imgBack forState:UIControlStateNormal];
    [_btnBack setImage:imgBackClicked forState:UIControlStateHighlighted];
    [_btnBack addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnBack];
    
    //ok button
    UIImage *imgYES = [UIImage imageNamed:@"yes"];
    UIImage *imgYESClicked = [UIImage imageNamed:@"yes_click"];
    _btnYES = [[UIButton alloc] initWithFrame:CGRectMake(viewSize.width - imgYES.size.width - 20, 20, imgYES.size.width, imgYES.size.height)];
    [_btnYES setImage:imgYES forState:UIControlStateNormal];
    [_btnYES setImage:imgYESClicked forState:UIControlStateHighlighted];
    [_btnYES addTarget:self action:@selector(yesButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnYES];
    
    //title under line
    UIImage *imgLine = [UIImage imageNamed:@"titleline"];
    UIImageView *ivLine = [[UIImageView alloc] initWithFrame:CGRectMake(60, 45, 200, imgLine.size.height)];
    ivLine.image = imgLine;
    [self.view addSubview:ivLine];
    _tfTitle = [[UITextField alloc] initWithFrame:CGRectMake(60, 20, 200, 25)];
    _tfTitle.text = @"为了梦想而起床！";
    _tfTitle.textColor = [UIColor whiteColor];
    _tfTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_tfTitle];
    
    
    //choose music button
    UIImage *imgChooseMusic = [UIImage imageNamed:@"musicchoice"];
    UIImage *imgChooseMusicClick = [UIImage imageNamed:@"musicchoice_click"];
    _btnChooseMusic = [[UIButton alloc] initWithFrame:CGRectMake(30, viewSize.height - imgChooseMusic.size.height - 30, imgChooseMusic.size.width, imgChooseMusic.size.height)];
    [_btnChooseMusic setImage:imgChooseMusic forState:UIControlStateNormal];
    [_btnChooseMusic setImage:imgChooseMusicClick forState:UIControlStateHighlighted];
    [_btnChooseMusic addTarget:self action:@selector(chooseMusicButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnChooseMusic];
    
    //choose shake level button
    UIImage *imgChooseShake = [UIImage imageNamed:@"shake"];
    UIImage *imgChooseShakeClick = [UIImage imageNamed:@"shake_click"];
    _btnChooseShake = [[UIButton alloc] initWithFrame:CGRectMake(viewSize.width - imgChooseShake.size.width - 30, viewSize.height - imgChooseShake.size.height - 30, imgChooseShake.size.width, imgChooseShake.size.height)];
    [_btnChooseShake setImage:imgChooseShake forState:UIControlStateNormal];
    [_btnChooseShake setImage:imgChooseShakeClick forState:UIControlStateHighlighted];
    [_btnChooseShake addTarget:self action:@selector(chooseShakeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnChooseShake];
}

#pragma -- Button click event
-(void)backButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)yesButtonClicked
{
    //complete clock setting
    
    //TODO test shake UI
//    ShakeViewController *shakeViewCtrl = [[ShakeViewController alloc] init];
//    [self presentViewController:shakeViewCtrl animated:YES completion:nil];
    
    ShareViewController *share = [[ShareViewController alloc] init];
    [self presentViewController:share animated:YES completion:nil];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)chooseMusicButtonClicked
{
    //show music list
}

-(void)chooseShakeButtonClicked
{
    //show shake level list
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
