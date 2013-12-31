//
//  SettingViewController.h
//  Wakeup
//  闹钟设置UI
//  Created by Ryan on 13-12-18.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ShareViewController.h"
#import "IZValueSelectorView.h"

@interface SettingViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,IZValueSelectorViewDataSource,IZValueSelectorViewDelegate>{
    
}

@property(nonatomic,strong) UIButton * btnBack;
@property(nonatomic,strong) UIButton * btnYES;
@property(nonatomic,strong) UITextField * tfTitle;
@property(nonatomic,strong) UIButton * btnChooseMusic;
@property(nonatomic,strong) UIButton * btnChooseShake;
@end
