//
//  LoginViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
    @property (weak, nonatomic) IBOutlet UITextField *emailField;
    @property (weak, nonatomic) IBOutlet UITextField *passwordField;
    - (IBAction)loginButton:(id)sender;
@end

@implementation LoginViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)loginUser:(NSString *)email withPassword:(NSString *)password
{
    if ([email  isEqual: @"test"] && [password isEqual: @"test"]) {
        return YES;
    } else {
        return NO;
    }
}

- (IBAction)loginButton:(id)sender {
    
    
}

//Perform the validation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return [self loginUser:_emailField.text withPassword:_passwordField.text];
}

@end
