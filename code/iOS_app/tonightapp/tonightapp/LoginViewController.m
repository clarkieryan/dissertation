//
//  LoginViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "LoginViewController.h"
#import <UICKeyChainStore/UICKeyChainStore.h>
#import <UNIRest.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LoginViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *loginErrorText;
    @property (weak, nonatomic) IBOutlet UITextField *emailField;
    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
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
    
    //Text stuff
    [[self titleLabel] setFont:[UIFont fontWithName:@"Pacifico" size:48]];
    _titleLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.view.backgroundColor = UIColorFromRGB(0xe74c3c);
    _passwordField.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    _loginErrorText.text = @"";
    
    //Login logic
    float expiresOn = [[UICKeyChainStore stringForKey:@"expires_on"] floatValue];
    NSLog(@"%f %f", expiresOn, [[NSDate date]timeIntervalSince1970]);
    NSLog(@"%@", [UICKeyChainStore stringForKey:@"access_token"]);
    NSLog(@"%@ %@", [UICKeyChainStore stringForKey:@"email"], [UICKeyChainStore stringForKey:@"password"]);
    
    // Check if the current access_token is valid or not
    if(expiresOn > [[NSDate date]timeIntervalSince1970] && ![[UICKeyChainStore stringForKey:@"email"] isEqual:@""] && ![[UICKeyChainStore stringForKey:@"password"] isEqual:@""] && ![[UICKeyChainStore stringForKey:@"access_token"] isEqual:@""]) {
        [self performSegueWithIdentifier: @"loginSegue" sender: self];
    //Else check if there is a valid username/password if so log them in with these. 
    } else if( ![[UICKeyChainStore stringForKey:@"email"] isEqual:@""] && ![[UICKeyChainStore stringForKey:@"password"]  isEqual: @""]) {
        [self loginUser:[UICKeyChainStore stringForKey:@"email"] withPassword:[UICKeyChainStore stringForKey:@"password"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Remove the keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


- (BOOL)loginUser:(NSString *)email withPassword:(NSString *)password
{
    //Start a request
    NSDictionary* headers = @{@"accept": @"application/json"};
    NSDictionary* parameters = @{@"grant_type": @"password", @"client_key": @"52ed42059a524e66d64a67ac64211a124d49768fd7b9041ea9c168ca7f25ddeb", @"client_secret": @"bd402410a6099481f156f1e8b629b982208fdaabda3a1d4cf7d745ee17838d9c", @"email":email, @"password":password};
    
    UNIHTTPJsonResponse* response = [[UNIRest post:^(UNISimpleRequest* request) {
        [request setUrl:@"http://ryc-diss.herokuapp.com/oauth/token"];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJson];
    
    NSString *accessToken = [response.body.object valueForKey:@"access_token"];
    NSString *expiresIn = [response.body.object valueForKey:@"expires_in"];
    
    if(accessToken == NULL){
        //Set the error text as something
        _loginErrorText.text = @"Incorrect email/password";
        return NO;
    } else {
        //Set the details into the keychain
        [UICKeyChainStore setString:email forKey:@"email"];
        [UICKeyChainStore setString:password forKey:@"password"];
        [UICKeyChainStore setString:accessToken forKey:@"access_token"];
        //Create a timestamp of when the token will expire
        float expiresOn = [expiresIn floatValue] + [[NSDate date]timeIntervalSince1970];
        [UICKeyChainStore setString:[NSString stringWithFormat:@"%f", expiresOn] forKey:@"expires_on"];
        return YES;
    }
}
- (IBAction)loginButton:(id)sender {
    if([self loginUser:_emailField.text withPassword:_passwordField.text]) {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
}

//Hook up return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if([self loginUser:_emailField.text withPassword:_passwordField.text]) {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
    
    return YES;
}

//Perform the validation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return YES;
}

@end
