//
//  MyProfileViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "MyProfileViewController.h"
#import "MBProgressHUD.h"
#import <UICKeyChainStore.h>
#import <UNIRest.h>

@interface MyProfileViewController (){
    NSDictionary *profileDetails;
}
@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *emailField;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

@implementation MyProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"My Profile";
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSDictionary* headers = @{@"accept": @"application/json"};
        NSDictionary* parameters = @{@"access_token": [UICKeyChainStore stringForKey:@"access_token"]};
        
        UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:USER_URL];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        
        profileDetails = response.body.object;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
    
    
	// Do any additional setup after loading the view.
    NSDictionary* headers = @{@"accept": @"application/json"};
    NSDictionary* parameters = @{@"access_token": [UICKeyChainStore stringForKey:@"access_token"]};
    
    UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
        [request setUrl:USER_URL];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJson];
    
    profileDetails = response.body.object;

    //Fill up the fields
    _nameField.text = [NSString stringWithFormat:@"%@ %@",[profileDetails objectForKey:@"first_name"], [profileDetails objectForKey:@"last_name"]];
    _emailField.text = [profileDetails objectForKey:@"email"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutButton:(id)sender {
    
    //Remove the relevant keys
    [UICKeyChainStore setString:@"" forKey:@"email"];
    [UICKeyChainStore setString:@"" forKey:@"password"];
    [UICKeyChainStore setString:@"" forKey:@"access_token"];
    [UICKeyChainStore setString:@"" forKey:@"expires_on"];
    //Move to the login screen
    [self performSegueWithIdentifier:@"logoutSegue" sender:self];
}

@end
