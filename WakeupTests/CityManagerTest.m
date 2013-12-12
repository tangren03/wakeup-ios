//
//  CityManagerTest.m
//  Wakeup
//
//  Created by frost on 13-12-12.
//  Copyright (c) 2013年 EricssonLabs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CityManager.h"

@interface CityManagerTest : XCTestCase

@end

@implementation CityManagerTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetCode
{
    CityManager *cityManager = [CityManager sharedInstance];
    NSString *code = [cityManager getCityCode:@"北京"];
    XCTAssertEqualObjects(code, @"101010100", @"北京 code should be 101010100.");
    
    NSString *code2 = [cityManager getCityCode:@"Not Exists"];
    XCTAssertEqualObjects(code2, nil, @"Not Exits code should be nil.");
}


@end
