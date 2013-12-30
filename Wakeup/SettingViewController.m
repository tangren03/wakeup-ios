//
//  SettingViewController.m
//  Wakeup
//
//  Created by Ryan on 13-12-18.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "SettingViewController.h"
#import "ShakeViewController.h"
#import "Utils.h"
#import "Config.h"

@interface SettingViewController ()
{
    UIView *primaryView;
    UIView *hiddenView;
    UIView *shadeView;
    
    UILabel *lbLayerTitle;
    UITableView *choiceTableView;
    NSArray *musicArray;
    NSArray *shakeArray;
    
    BOOL IS_MUSIC_ITEM;
}
@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    IS_MUSIC_ITEM = YES;
    
    musicArray = @[@"震动",@"经典铃声",@"舒缓音乐"];
    shakeArray = @[@"容易",@"中等",@"困难"];
    
    self.view.backgroundColor = [Utils colorWithHexString:MAIN_COLOR];
    
    //background image
    primaryView = [[UIView alloc] initWithFrame:self.view.frame];
    primaryView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_purple_iph5"]];
    [self.view addSubview:primaryView];
    shadeView = [[UIView alloc] initWithFrame:primaryView.frame];
    shadeView.backgroundColor = [UIColor whiteColor];
    shadeView.alpha = 0.5;
    shadeView.hidden = YES;
    [self.view addSubview:shadeView];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeItemLayer)];
    [shadeView addGestureRecognizer:gesture];
    
    CGSize viewSize = primaryView.frame.size;
    
    //back button
    UIImage *imgBack = [UIImage imageNamed:@"back"];
    UIImage *imgBackClicked = [UIImage imageNamed:@"back_click"];
    _btnBack = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, imgBack.size.width, imgBack.size.height)];
    [_btnBack setImage:imgBack forState:UIControlStateNormal];
    [_btnBack setImage:imgBackClicked forState:UIControlStateHighlighted];
    [_btnBack addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [primaryView addSubview:_btnBack];
    
    //ok button
    UIImage *imgYES = [UIImage imageNamed:@"yes"];
    UIImage *imgYESClicked = [UIImage imageNamed:@"yes_click"];
    _btnYES = [[UIButton alloc] initWithFrame:CGRectMake(viewSize.width - imgYES.size.width - 20, 20, imgYES.size.width, imgYES.size.height)];
    [_btnYES setImage:imgYES forState:UIControlStateNormal];
    [_btnYES setImage:imgYESClicked forState:UIControlStateHighlighted];
    [_btnYES addTarget:self action:@selector(yesButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [primaryView addSubview:_btnYES];
    
    //title under line
    UIImage *imgLine = [UIImage imageNamed:@"titleline"];
    UIImageView *ivLine = [[UIImageView alloc] initWithFrame:CGRectMake(60, 45, 200, imgLine.size.height)];
    ivLine.image = imgLine;
    [primaryView addSubview:ivLine];
    _tfTitle = [[UITextField alloc] initWithFrame:CGRectMake(60, 20, 200, 25)];
    _tfTitle.text = @"为了梦想而起床！";
    _tfTitle.textColor = [UIColor whiteColor];
    _tfTitle.textAlignment = NSTextAlignmentCenter;
    [primaryView addSubview:_tfTitle];
    
    
    //time picker view
    
    
    
    //choose music button
    UIImage *imgChooseMusic = [UIImage imageNamed:@"musicchoice"];
    UIImage *imgChooseMusicClick = [UIImage imageNamed:@"musicchoice_click"];
    _btnChooseMusic = [[UIButton alloc] initWithFrame:CGRectMake(30, viewSize.height - imgChooseMusic.size.height - 30, imgChooseMusic.size.width, imgChooseMusic.size.height)];
    [_btnChooseMusic setImage:imgChooseMusic forState:UIControlStateNormal];
    [_btnChooseMusic setImage:imgChooseMusicClick forState:UIControlStateHighlighted];
    [_btnChooseMusic addTarget:self action:@selector(chooseMusicButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [primaryView addSubview:_btnChooseMusic];
    
    //choose shake level button
    UIImage *imgChooseShake = [UIImage imageNamed:@"shake"];
    UIImage *imgChooseShakeClick = [UIImage imageNamed:@"shake_click"];
    _btnChooseShake = [[UIButton alloc] initWithFrame:CGRectMake(viewSize.width - imgChooseShake.size.width - 30, viewSize.height - imgChooseShake.size.height - 30, imgChooseShake.size.width, imgChooseShake.size.height)];
    [_btnChooseShake setImage:imgChooseShake forState:UIControlStateNormal];
    [_btnChooseShake setImage:imgChooseShakeClick forState:UIControlStateHighlighted];
    [_btnChooseShake addTarget:self action:@selector(chooseShakeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [primaryView addSubview:_btnChooseShake];
    
    
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
    IS_MUSIC_ITEM = YES;
    NSString *music = [Config propertyForkey:PRO_MUSIC];
    if (music == nil) {
        music = @"";
    }
    [self openItemLayer:[@"闹钟铃声：" stringByAppendingString:music]];
}

-(void)chooseShakeButtonClicked
{
    IS_MUSIC_ITEM = NO;
    NSString *shake = [Config propertyForkey:PRO_SHAKE];
    if (shake == nil) {
        shake = @"";
    }
    [self openItemLayer:[@"摇力等级：" stringByAppendingString:shake]];
}

-(void)openItemLayer:(NSString *)title
{
    //选项弹出层
    hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, primaryView.frame.size.height, primaryView.frame.size.width, 160)];
    hiddenView.backgroundColor = [UIColor blackColor];
    hiddenView.alpha = 0.9;
    [self.view addSubview:hiddenView];
    
    //标题
    lbLayerTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 230, 30)];
    lbLayerTitle.backgroundColor = [UIColor clearColor];
    lbLayerTitle.textColor = [UIColor whiteColor];
    lbLayerTitle.text = title;
    lbLayerTitle.font = [UIFont boldSystemFontOfSize:16.0];
    [hiddenView addSubview:lbLayerTitle];
    
    //选项列表
    choiceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, lbLayerTitle.frame.size.height + 10,hiddenView.frame.size.width, hiddenView.frame.size.height - lbLayerTitle.frame.size.height + 15) style:UITableViewStylePlain];
    choiceTableView.delegate = self;
    choiceTableView.dataSource = self;
    choiceTableView.backgroundColor = [UIColor clearColor];
    choiceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [choiceTableView reloadData];
    [hiddenView addSubview:choiceTableView];
    
    shadeView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        hiddenView.frame = CGRectMake(0, primaryView.frame.size.height - hiddenView.frame.size.height, hiddenView.frame.size.width, hiddenView.frame.size.height);
        
        CALayer *layer = primaryView.layer;
        layer.zPosition = -3000;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -300;
        layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, 10.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            primaryView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        }];
    }];
}

-(void)closeItemLayer
{
    shadeView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        CALayer *layer = primaryView.layer;
        layer.zPosition = -4000;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / 300;
        layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, -10.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            primaryView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
            hiddenView.frame = CGRectMake(0, primaryView.frame.size.height, hiddenView.frame.size.width, hiddenView.frame.size.height);
        }];
    }];
    
    choiceTableView = nil;
    lbLayerTitle = nil;
}

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [Utils colorWithHexString:@"#6f6f6f"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (IS_MUSIC_ITEM) {
        cell.textLabel.text = [musicArray objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [shakeArray objectAtIndex:indexPath.row];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    NSInteger row = indexPath.row;
    NSString *selectedItem;
    NSString *title;
    if (IS_MUSIC_ITEM) {
        title = @"闹钟铃声：";
        selectedItem = [musicArray objectAtIndex:row];
        [Config saveProperty:selectedItem forKey:PRO_MUSIC];
    }else{
        title = @"摇力等级：";
        selectedItem = [shakeArray objectAtIndex:row];
        [Config saveProperty:selectedItem forKey:PRO_SHAKE];
    }
    lbLayerTitle.text = @"";
    lbLayerTitle.text = [title stringByAppendingString:selectedItem];
    
    //close layer
    [self performSelector:@selector(closeItemLayer) withObject:nil afterDelay:0.5];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35.0;
}

@end
