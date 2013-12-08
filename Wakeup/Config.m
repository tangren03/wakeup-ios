//
//  Config.m
//  CardBox
//
//  Created by Ryan Tang on 12-12-7.
//  Copyright (c) 2012年 Ericsson Labs. All rights reserved.
//

#import "Config.h"

@implementation Config

+(void)saveProperty:(NSString *)value forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

+(id)propertyForkey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

@end
