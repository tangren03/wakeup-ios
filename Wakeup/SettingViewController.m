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
#import "AMBlurView.h"

@interface SettingViewController ()
{
    UIView *primaryView;
    UIView *hiddenView;
    AMBlurView *shadeView;
    
    UILabel *lbLayerTitle;
    UITableView *choiceTableView;
    NSArray *musicArray;
    NSArray *shakeArray;
    
    BOOL IS_MUSIC_ITEM;
    
    NSArray *hourArray;
    NSMutableArray *minArray;
    
    IZValueSelectorView *hourPicker;
    IZValueSelectorView *minPicker;
    
    NSString *hour;
    NSString *min;
    
    UILabel *timeLabel;
}
@end

@implementation SettingViewController

-(id)init
{
    self = [super init];
    if (self) {
        hour = @"05";
        min = @"00";
        
        IS_MUSIC_ITEM = YES;
        
        musicArray = @[@"清晨脆音",@"晨曦阳光",@"律动朝霞"];
        shakeArray = @[@"容易",@"中等",@"困难"];
        hourArray = @[@"05",@"06",@"07",@"08",@"09"];
        minArray = [NSMutableArray array];
        for (int i = 0; i < 60; i ++) {
            if (i < 10) {
                [minArray addObject:[@"0" stringByAppendingFormat:@"%d",i]];
            }else{
                [minArray addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //background image
    primaryView = [[UIView alloc] initWithFrame:self.view.frame];
    primaryView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_purple_iph5"]];
    [self.view addSubview:primaryView];
    shadeView = [[AMBlurView alloc] initWithFrame:primaryView.frame];
    shadeView.alpha = 0.8;
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
    _tfTitle = [[UITextField alloc] initWithFrame:CGRectMake(60, 20, 200, 30)];
    
    NSString *saveClockName = [Config propertyForkey:PRO_CLOCK_NAME];
    if (saveClockName == nil) {
        _tfTitle.text = @"为了梦想，起床吧少年！";
    }else{
        _tfTitle.text = saveClockName;
    }
    _tfTitle.textColor = [UIColor whiteColor];
    _tfTitle.textAlignment = NSTextAlignmentCenter;
    _tfTitle.font = [UIFont systemFontOfSize:16.0];
    [primaryView addSubview:_tfTitle];
    
    
    //time picker view
    hourPicker = [[IZValueSelectorView alloc] initWithFrame:CGRectMake(35, 75, 120, 200)];
    hourPicker.delegate = self;
    hourPicker.dataSource = self;

    hourPicker.shouldBeTransparent = YES;
    hourPicker.horizontalScrolling = NO;
    hourPicker.backgroundColor = [Utils colorWithHexString:MAIN_COLOR];
    [primaryView addSubview:hourPicker];
    
    minPicker = [[IZValueSelectorView alloc] initWithFrame:CGRectMake(viewSize.width - 155, 75, 120, 200)];
    minPicker.delegate = self;
    minPicker.dataSource = self;
    minPicker.shouldBeTransparent = YES;
    minPicker.horizontalScrolling = NO;
    minPicker.backgroundColor = [Utils colorWithHexString:MAIN_COLOR];//@"#fde756"
    [primaryView addSubview:minPicker];
    
    //clock repeat setting
    
    //time
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 295, 320, 30)];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:16.0];
    [primaryView addSubview:timeLabel];
    
    NSString *setHour = [Config propertyForkey:PRO_HOUR];
    NSString *setMin = [Config propertyForkey:PRO_MIN];
    
    NSString *setTimeText = @"早上 ";
    if (setHour == nil || setMin == nil) {
        setTimeText = @"早上 05:00 叫你起床";
    }else{
        setTimeText = [[[[setTimeText stringByAppendingString:setHour] stringByAppendingString:@":"] stringByAppendingString:setMin] stringByAppendingString:@" 叫你起床"];
    }
    timeLabel.text = setTimeText;
    
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
    
    
    //tap action for close keyboard
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(hiddenKeyboard)];
//    tapRecognizer.cancelsTouchesInView = NO;
    [primaryView addGestureRecognizer:tapRecognizer];
}

#pragma -- Button click event
-(void)backButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)yesButtonClicked
{
    //TODO test shake UI
//    ShakeViewController *shakeViewCtrl = [[ShakeViewController alloc] init];
//    
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:shakeViewCtrl];
//    navi.navigationBarHidden = YES;
//    [self presentViewController:navi animated:YES completion:nil];

    [self hiddenKeyboard];
    
    //save clock name
    [Config saveProperty:_tfTitle.text forKey:PRO_CLOCK_NAME];
    
    //tag clock status
    [Config saveProperty:PRO_YES forKey:PRO_IS_CLOCK_OPEN];
    
    //cancel all notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    //触发通知的时间
    NSString *time = [[[[hour stringByAppendingString:@":"] stringByAppendingString:min] stringByAppendingString:@":"] stringByAppendingString:@"00"];
    
    [Config saveProperty:hour forKey:PRO_HOUR];
    [Config saveProperty:min forKey:PRO_MIN];
    
    NSLog(@"Time:%@",time);
//    time = @"14:40:00";
    NSDate *now = [formatter dateFromString:time];
    notification.fireDate = now;
    
    //时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    
    //通知重复提示的单位，可以是天、周、月
    notification.repeatInterval = NSDayCalendarUnit;
    
    //通知内容
    notification.alertBody = _tfTitle.text;
    notification.alertAction = @"起床";
    
    //通知被触发时播放的声音
    NSString *music = [Config propertyForkey:PRO_MUSIC];
    if (music != nil) {
        if ([music isEqualToString:@"清晨脆音"]) {
            notification.soundName = @"music.aac";
        }else if([music isEqualToString:@"晨曦阳光"]){
            notification.soundName = UILocalNotificationDefaultSoundName;
        }else{
            notification.soundName = UILocalNotificationDefaultSoundName;
        }
    }else{
        notification.soundName = @"music.aac";
    }
    
    
    
    //执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [self openItemLayer:[@"摇力强度：" stringByAppendingString:shake]];
}

#pragma IZValueSelector dataSource
- (NSInteger)numberOfRowsInSelector:(IZValueSelectorView *)valueSelector {
    if (valueSelector == hourPicker) {
        return hourArray.count;
    }else{
        return minArray.count;
    }
}

//ONLY ONE OF THESE WILL GET CALLED (DEPENDING ON the horizontalScrolling property Value)
- (CGFloat)rowHeightInSelector:(IZValueSelectorView *)valueSelector {
    return 70.0;
}

- (CGFloat)rowWidthInSelector:(IZValueSelectorView *)valueSelector {
    return 70.0;
}


- (UIView *)selector:(IZValueSelectorView *)valueSelector viewForRowAtIndex:(NSInteger)index {
    UILabel * label = nil;
    NSString *value;
    if (valueSelector == hourPicker) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, hourPicker.frame.size.width, 70)];
        value = [hourArray objectAtIndex:index];
    }
    else {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, minPicker.frame.size.width, 70)];
        value = [minArray objectAtIndex:index];
    }
    label.text = value;
    label.textAlignment =  NSTextAlignmentCenter;
//    label.textColor = [Utils colorWithHexString:@"#c5c5c5"];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [Utils colorWithHexString:MAIN_COLOR];
    label.font = [UIFont fontWithName:@"Roboto-Thin" size:60.0];
    
    return label;
}

- (CGRect)rectForSelectionInSelector:(IZValueSelectorView *)valueSelector {
    //Just return a rect in which you want the selector image to appear
    //Use the IZValueSelector coordinates
    //Basically the x will be 0
    //y will be the origin of your image
    //width and height will be the same as in your selector image
    
    return CGRectMake(0.0, minPicker.frame.size.height / 2 - 35.0, 120.0, 70.0);
    
}

#pragma IZValueSelector delegate
- (void)selector:(IZValueSelectorView *)valueSelector didSelectRowAtIndex:(NSInteger)index {
    if (valueSelector == hourPicker) {
        NSLog(@"hour:%@",[hourArray objectAtIndex:index]);
        hour = [hourArray objectAtIndex:index];
    }else{
        NSLog(@"min:%@",[minArray objectAtIndex:index]);
        min = [minArray objectAtIndex:index];
    }
    
    //update time
    timeLabel.text = [[[[@"早上 " stringByAppendingString:hour] stringByAppendingString:@":"] stringByAppendingString:min] stringByAppendingString:@" 叫你起床"];

}

#pragma mark - Layer operation
-(void)openItemLayer:(NSString *)title
{
    //选项弹出层
    hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, primaryView.frame.size.height, primaryView.frame.size.width, 160)];
    hiddenView.backgroundColor = [UIColor blackColor];
    hiddenView.alpha = 0.85;
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
    if (IS_MUSIC_ITEM) {
        return musicArray.count;
    }else{
        return shakeArray.count;
    }
    
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
    NSLog(@"111111");
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

-(void)hiddenKeyboard
{
    [_tfTitle resignFirstResponder];
}

@end
