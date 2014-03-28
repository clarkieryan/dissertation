//
//  LoginViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *loginErrorText;
    @property (weak, nonatomic) IBOutlet UITextField *emailField;
    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
    @property (weak, nonatomic) IBOutlet UITextField *passwordField;
    @property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
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
     [_activityIndicator setHidden:TRUE];
}

- (void)viewDidAppear:(BOOL)animated
{
    _loginErrorText.text = @"";
    NSString *email = [UICKeyChainStore stringForKey:@"email"];
    NSString *password = [UICKeyChainStore stringForKey:@"password"];
    NSString *access_token = [UICKeyChainStore stringForKey:@"access_token"];
    float expiresOn = [[UICKeyChainStore stringForKey:@"expires_on"] floatValue];
    float currentTime =[[NSDate date]timeIntervalSince1970];
    
    NSLog(@"%f %f", expiresOn, currentTime);
    NSLog(@"%@", access_token);
    NSLog(@"%@ %@", email, password);
    
    //Login logic
    // Check if the current access_token is valid or not
    if(expiresOn > currentTime && ![email length] == 0 && ![password length] == 0 && ![access_token length] == 0) {
        [self performSegueWithIdentifier: @"loginSegue" sender: self];
    //Else check if there is a valid username/password if so log them in with these. 
    } else if( ![email length] == 0 && ![password length] == 0) {
        [self loginUser:email withPassword:password];
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


- (void)loginUser:(NSString *)email withPassword:(NSString *)password
{
    
    
    
    //Start a request
    NSDictionary* headers = @{@"accept": @"application/json"};
    NSDictionary* parameters = @{@"grant_type": @"password", @"client_key": CLIENT_KEY, @"client_secret": CLIENT_KEY, @"email":email, @"password":password};
    
    
    
    _loginErrorText.text = @"";
    _emailField.enabled = FALSE;
    _emailField.backgroundColor = UIColorFromRGB(0xd3d3d3);
    _passwordField.enabled = FALSE;
    _passwordField.backgroundColor = UIColorFromRGB(0xd3d3d3);
    [_activityIndicator setHidden:false];
    [_activityIndicator startAnimating];
    //Get the values from the response
    __block UNIHTTPJsonResponse* response;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        response = [[UNIRest post:^(UNISimpleRequest* request) {
            [request setUrl:LOGIN_URL];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *accessToken = [response.body.object valueForKey:@"access_token"];
            NSString *expiresIn = [response.body.object valueForKey:@"expires_in"];
            if(accessToken == NULL){
                //Set the error text as something
                [_activityIndicator stopAnimating];
                _loginErrorText.text = @"Incorrect email/password";
                _emailField.enabled = TRUE;
                _emailField.backgroundColor = [UIColor whiteColor];
                _passwordField.enabled = TRUE;
                _passwordField.backgroundColor = [UIColor whiteColor];
                
            } else {
                //Set the details into the keychain
                [UICKeyChainStore setString:email forKey:@"email"];
                [UICKeyChainStore setString:password forKey:@"password"];
                [UICKeyChainStore setString:accessToken forKey:@"access_token"];
                //Create a timestamp of when the token will expire
                float expiresOn = [expiresIn floatValue] + [[NSDate date]timeIntervalSince1970];
                [UICKeyChainStore setString:[NSString stringWithFormat:@"%f", expiresOn] forKey:@"expires_on"];
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
            }
        });
    });
    

}
- (IBAction)loginButton:(id)sender {
    [self loginUser:_emailField.text withPassword:_passwordField.text];
}

//Hook up return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self loginUser:_emailField.text withPassword:_passwordField.text];
    return YES;
}

//Perform the validation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return YES;
}

@end
