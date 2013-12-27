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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"share_bg"]];
    
    UIButton *btn_shareToTimeline =
    [UIButton buttonWithType:UIButtonTypeSystem];
    btn_shareToTimeline.frame = CGRectMake(0, self.view.frame.size.height - 100, 100, 30);
    [btn_shareToTimeline setTitle:@"btn" forState:UIControlStateNormal];
    [btn_shareToTimeline setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_shareToTimeline addTarget:self action:@selector(sendToWeChatButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_shareToTimeline];
    
    
}

//** Send message to WeChat **//
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
