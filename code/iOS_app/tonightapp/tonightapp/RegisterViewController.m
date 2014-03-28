//
//  RegisterViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 06/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation RegisterViewController

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
    [[self titleLabel] setFont:[UIFont fontWithName:@"Pacifico" size:48]];
    _titleLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.view.backgroundColor = UIColorFromRGB(0xe74c3c);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//TODO - Need to add in functions for register
- (IBAction)registerButton:(id)sender {
    
    //Split up the namme to first/last
    NSArray *names = [_nameField.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
//    NSDictionary *user = @{@"email" : _emailField.text, @"first_name" : values[0], @"last_name": values[1], @"password": _passwordField.text};
    
    NSDictionary* headers = @{@"accept": @"application/json"};
    NSDictionary* parameters = @{@"user[first_name]": names[0], @"user[last_name]": names[1], @"user[email]": _emailField.text, @"user[password]": _passwordField.text};
    
    UNIHTTPJsonResponse* response = [[UNIRest post:^(UNISimpleRequest* request) {
        [request setUrl:REGISTER_URL];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJson];
    
    NSLog(@"%@", response.body);
    
    
    //If the response is a created user use username/password and get an access token -> move to the main screen
    if([[response.body.object objectForKey:@"message"] isEqualToString:@"User created"]) {
        NSDictionary* headers = @{@"accept": @"application/json"};
        NSDictionary* parameters = @{@"grant_type": @"password", @"client_key": CLIENT_KEY, @"client_secret": CLIENT_SECRET, @"email":_emailField.text, @"password":_passwordField.text};
        
        UNIHTTPJsonResponse* response = [[UNIRest post:^(UNISimpleRequest* request) {
            [request setUrl:LOGIN_URL];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        
        NSString *accessToken = [response.body.object valueForKey:@"access_token"];
        NSString *expiresIn = [response.body.object valueForKey:@"expires_in"];
        
        //Set the details into the keychain
        [UICKeyChainStore setString:_emailField.text forKey:@"email"];
        [UICKeyChainStore setString:_passwordField.text forKey:@"password"];
        [UICKeyChainStore setString:accessToken forKey:@"access_token"];
        //Create a timestamp of when the token will expire
        float expiresOn = [expiresIn floatValue] + [[NSDate date]timeIntervalSince1970];
        [UICKeyChainStore setString:[NSString stringWithFormat:@"%f", expiresOn] forKey:@"expires_on"];
        
        //Perform segue
        [self performSegueWithIdentifier:@"registerSegue" sender:self];
        
    } else {
        //Show error message IE (Email already used)
    }
    
}

//Hide the keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


@end
