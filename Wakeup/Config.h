//
//  Config.h
//  Tools for NSUserDefalut
//
//  Created by Ryan Tang on 12-12-7.
//  Copyright (c) 2012年 Ericsson Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

+(void)saveProperty:(id)value forKey:(NSString *)key;
+(id)propertyForkey:(NSString *)key;

@end
