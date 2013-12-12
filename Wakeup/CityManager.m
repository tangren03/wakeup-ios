//
//  CityManager.m
//  Wakeup
//
//  Created by frost on 13-12-12.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import "CityManager.h"

@interface CityManager ()
@property (nonatomic, strong) NSDictionary *cityDict;
@end

@implementation CityManager

+ (CityManager *)sharedInstance {
    static CityManager *sharedCityManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedCityManager = [[self alloc] init];
    });
    return sharedCityManager;
}

- (id)init {
    if (self = [super init]) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        _cityDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    return self;
}

- (NSString *)getCityCode:(NSString *)cityName {
    if ([cityName length] <= 0) return nil;
    return [self.cityDict objectForKey:cityName];
}

@end
