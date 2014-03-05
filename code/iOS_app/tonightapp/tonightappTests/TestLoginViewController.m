//
//  TestLoginViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginViewControler.h"

@interface TestLoginViewController : XCTestCase

@end

@implementation TestLoginViewController

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testLoginPass
{
    //Code here to test a users login
    LoginViewControler *LoginController = [[LoginViewControler alloc]init];
    BOOL result = [LoginController loginUser:@"clarkie.ryan@gmail.com" withPassword:@"P4ssw0rd"];
    XCTAssertTrue(result);
}

-(void)testLoginFail
{
    LoginViewControler *LoginController = [[LoginViewControler alloc]init];
    BOOL result = [LoginController loginUser:@"test@test.com" withPassword:@"test"];
    XCTAssertFalse(result);
}

@end
