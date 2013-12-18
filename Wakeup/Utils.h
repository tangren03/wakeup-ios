//
//  Utils.h
//  Wakeup
//
//  Created by Ryan on 13-12-18.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

//根据颜色码取得颜色对象
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
