//
//  AppDelegate.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "AppDelegate.h"
#import <UICKeyChainStore.h>
#import <Crashlytics/Crashlytics.h>
#import "LoginViewControler.h"
#import "User.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Include the Crashlytics library
    [Crashlytics startWithAPIKey:@"435cf48aecbd9c923549ac0057b69e7405f900b5"];
    
    //Check if the app has been launched before, if not set some key values as null
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // This is the first launch ever
        [UICKeyChainStore setString:@"" forKey:@"email"];
        [UICKeyChainStore setString:@"" forKey:@"password"];
        [UICKeyChainStore setString:@"" forKey:@"access_token"];
        [UICKeyChainStore setString:@"" forKey:@"expires_on"];
    }
    //Set the style of the header bar
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //Set the colour
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xe74c3c)];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    //Set the colour of the fonts of the back button
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //Set the colour of the status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //Set the Navigation bar title colours
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,[UIFont fontWithName:@"HelveticaNeue" size:18.0], NSFontAttributeName, nil]];
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    //Check the users token when the application loads back
    User *user = [[User alloc] initWithUser];
    if(![[user checkToken] isEqualToString:@"true"]){
        //Should never be called
        NSLog(@"Something went wrong");
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
 }

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
