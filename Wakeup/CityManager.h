//
//  CityManager.h
//  Wakeup
//
//  Created by frost on 13-12-12.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityManager : NSObject

+ (CityManager *)sharedInstance;

- (NSString *)getCityCode:(NSString *)cityName;

@end
