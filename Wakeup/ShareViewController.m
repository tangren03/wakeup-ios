//
//  ShareViewController.m
//  Wakeup
//
//  Created by Ryan on 13-12-27.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

@synthesize timeCountLabel = _timeCountLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *bgImg = [UIImage imageNamed:@"share_bg"];
    if (iphone5) {
        bgImg = [UIImage imageNamed:@"share_bg_iph5"];
    }
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImg];
    
    CGRect viewFrame = self.view.frame;
    
    UIImage *textImg = [UIImage imageNamed:@"share_text"];
    UIImageView *textImageView = [[UIImageView alloc] initWithImage:textImg];
    textImageView.frame = CGRectMake(0, 0, textImg.size.width, textImg.size.height);
    textImageView.center = self.view.center;
    [self.view addSubview:textImageView];
    
    UIImage *friendImg = [UIImage imageNamed:@"sharefriends_btn"];
    UIButton *btn_shareToFriends = [[UIButton alloc] initWithFrame:CGRectMake(viewFrame.size.width / 2 - friendImg.size.width / 2, viewFrame.size.height - 200, friendImg.size.width, friendImg.size.height)];
    [btn_shareToFriends setImage:friendImg forState:UIControlStateNormal];
    [btn_shareToFriends setImage:[UIImage imageNamed:@"sharefriends_btn_click"] forState:UIControlStateHighlighted];
    [btn_shareToFriends addTarget:self action:@selector(sendToWeChatButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_shareToFriends];
    
    UIImage *challengeImg = [UIImage imageNamed:@"tiaozhan_btn"];
    UIButton *btn_challengeFriends = [[UIButton alloc] initWithFrame:CGRectMake(btn_shareToFriends.frame.origin.x, viewFrame.size.height - 140, challengeImg.size.width, challengeImg.size.height)];
    [btn_challengeFriends setImage:challengeImg forState:UIControlStateNormal];
    [btn_challengeFriends setImage:[UIImage imageNamed:@"tiaozhan_btn_click"] forState:UIControlStateHighlighted];
    [btn_challengeFriends addTarget:self action:@selector(challengeFriendButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_challengeFriends];
    
    UIImage *jumpImg = [UIImage imageNamed:@"jumpnext_btn"];
    UIButton *btn_jump = [[UIButton alloc] initWithFrame:CGRectMake(viewFrame.size.width - jumpImg.size.width - 30, viewFrame.size.height - 60, jumpImg.size.width, jumpImg.size.height)];
    [btn_jump setImage:jumpImg forState:UIControlStateNormal];
    [btn_jump setImage:[UIImage imageNamed:@"jumpnext_btn_click"] forState:UIControlStateHighlighted];
    [btn_jump addTarget:self action:@selector(jumpButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_jump];
    
    UILabel *timeLabel =
    [[UILabel alloc] initWithFrame:
     CGRectMake(0, 50 , viewFrame.size.width, 60)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [timeLabel setFont:[UIFont fontWithName:@"Roboto-Thin" size:75]];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    [timeLabel setTextColor:[UIColor whiteColor]];
    [timeLabel setNumberOfLines:1];
    timeLabel.text = @"06:30";
    [self.view addSubview:timeLabel];
    
    _timeCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, viewFrame.size.width, 40)];
    _timeCountLabel.textAlignment = NSTextAlignmentCenter;
    [_timeCountLabel setTextColor:[UIColor whiteColor]];
    [_timeCountLabel setBackgroundColor:[UIColor clearColor]];
    _timeCountLabel.text = @"本次起床用时：00:12.0";
    [self.view addSubview:_timeCountLabel];
}

//分享微信朋友圈
-(void)sendToWeChatButtonClicked
{
//    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
//    req.text = @"test from wakeup demo";
//    req.bText = YES;
//    req.scene = WXSceneTimeline;
//    
//    [WXApi sendReq:req];
    
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"bg_purple_iph5.png"]];
    
    WXImageObject *ext = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bg_purple_iph5" ofType:@"png"];
    UIImage* image = [UIImage imageWithContentsOfFile:filePath];
    ext.imageData = UIImagePNGRepresentation(image);
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

//挑战微信好友
-(void)challengeFriendButtonClicked
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"起床闹钟";
    message.description = @"为了梦想，起床吧，少年！";
    [message setThumbImage:[UIImage imageNamed:@"share_text.png"]];
    
    WXVideoObject *ext = [WXVideoObject object];
    ext.videoUrl = @"http://v.youku.com/v_show/id_XNTUxNDY1NDY4.html";
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

//跳过
-(void)jumpButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
