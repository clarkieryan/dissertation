//
//  User.m
//  tonightapp
//
//  Created by Ryan Clarke on 31/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "User.h"
#import <UICKeyChainStore.h>

@implementation User{
}

-(id)initWithUser {
    return self;
}


//Login user
//Returns either true, or error
- (NSString *)loginUser:(NSString *)inputEmail withPassword:(NSString *)inputPassword
{
    NSDictionary* headers = @{@"accept": @"application/json"};
    NSDictionary* parameters = @{@"grant_type": @"password", @"client_key": CLIENT_KEY, @"client_secret": CLIENT_KEY, @"email":inputEmail, @"password":inputPassword};
    
    UNIHTTPJsonResponse* response = [[UNIRest post:^(UNISimpleRequest* request) {
        [request setUrl:LOGIN_URL];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJson];
    
    NSString *accessToken = [response.body.object valueForKey:@"access_token"];
    NSString *expiresIn = [response.body.object valueForKey:@"expires_in"];
    //Create a timestamp of when the token will expire
    float expiresOn = [expiresIn floatValue] + [[NSDate date]timeIntervalSince1970];
    
    if([response.body.object valueForKey:@"access_token"] == NULL){
        return @"Username/Password incorrect";
    } else {
        //Set the details into the keychain
        [UICKeyChainStore setString:inputEmail forKey:@"email"];
        [UICKeyChainStore setString:inputPassword forKey:@"password"];
        [UICKeyChainStore setString:accessToken forKey:@"access_token"];
        [UICKeyChainStore setString:[NSString stringWithFormat:@"%f", expiresOn] forKey:@"expires_on"];
        return @"true";
    }
}

//Registers a new user
-(NSString *)registerUser:(NSString *)email withPassword:(NSString *)password withName:(NSString *)name
{
    //Break up the name field
    NSArray *names = [name componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    NSDictionary* headers = @{@"accept": @"application/json"};
    NSDictionary* parameters = @{@"user[first_name]": names[0], @"user[last_name]": names[1], @"user[email]":email, @"user[password]": password};
    
    UNIHTTPJsonResponse* response = [[UNIRest post:^(UNISimpleRequest* request) {
        [request setUrl:REGISTER_URL];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJson];
    
    //If the response is a created user use username/password and get an access token -> move to the main screen
    if([[response.body.object objectForKey:@"message"] isEqualToString:@"User created"]) {
        return [self loginUser:email withPassword:password];
    } else {
        return [response.body.object objectForKey:@"message"];
    }
}

//Checks for an active token, if not one then it grabs a new one.
-(NSString *)checkToken
{
    //Get current details
    NSString *email = [UICKeyChainStore stringForKey:@"email"];
    NSString *password = [UICKeyChainStore stringForKey:@"password"];
    NSString *access_token = [UICKeyChainStore stringForKey:@"access_token"];
    float expiresOn = [[UICKeyChainStore stringForKey:@"expires_on"] floatValue];
    float currentTime =[[NSDate date]timeIntervalSince1970];
    
    if(expiresOn > currentTime && ![email length] == 0 && ![password length] == 0 && ![access_token length] == 0) {
        return @"true";
        //Else check if there is a valid username/password if so log them in with these.
    } else if( ![email length] == 0 && ![password length] == 0) {
        NSString *response = [self loginUser:email withPassword:password];
        return response;
    } else {
        //If none of these work return false
        return @"";
    }
    
}

-(void)logoutUser
{
    [UICKeyChainStore setString:@"" forKey:@"email"];
    [UICKeyChainStore setString:@"" forKey:@"password"];
    [UICKeyChainStore setString:@"" forKey:@"access_token"];
    [UICKeyChainStore setString:@"" forKey:@"expires_on"];
}


@end
