//
//  LoginViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"


@interface LoginViewController (){
    User *user;
}
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
    
    //Set how things look
    [[self titleLabel] setFont:[UIFont fontWithName:@"Pacifico" size:48]];
    _titleLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.view.backgroundColor = UIColorFromRGB(0xe74c3c);
    _passwordField.delegate = self;
    //Hide the activity indicator
    [_activityIndicator setHidden:TRUE];
}

- (void)viewDidAppear:(BOOL)animated
{
    //Reset the login error text
    _loginErrorText.text = @"";
    
    //Create the user object
    user = [[User alloc] initWithUser];

    //Check if they have a token
    NSString *userLoggedIn = [user checkToken];
    if([userLoggedIn isEqualToString:@"true"]){
        [self performSegueWithIdentifier: @"loginSegue" sender: self];
    } else {
        //Output the error
        _loginErrorText.text = userLoggedIn;
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

//Local login function
//Defining here as it's called by the login button and the return button.
- (void)loginUser:(NSString *)email withPassword:(NSString *)password
{
    //Start the loading icon
    [_activityIndicator setHidden:false];
    [_activityIndicator startAnimating];
    //Reset the login errro text and blank out boxes.
    _loginErrorText.text = @"";
    _emailField.enabled = FALSE;
    _emailField.backgroundColor = UIColorFromRGB(0xd3d3d3);
    _passwordField.enabled = FALSE;
    _passwordField.backgroundColor = UIColorFromRGB(0xd3d3d3);


    //Attempt a login
    NSString *loginResponse = [user loginUser:_emailField.text withPassword:_passwordField.text];
    if([loginResponse isEqualToString:@"true"]) {
        //Redirect to the new page
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    } else {
        //Stop the loading icon and render, re-enable the inputs and output login error
        [_activityIndicator stopAnimating];
        _loginErrorText.text = loginResponse;
        _emailField.enabled = TRUE;
        _emailField.backgroundColor = [UIColor whiteColor];
        _passwordField.enabled = TRUE;
        _passwordField.backgroundColor = [UIColor whiteColor];
    }

}

//Action called when login button is clicked
- (IBAction)loginButton:(id)sender {
    [self loginUser:_emailField.text withPassword:_passwordField.text];
    
}

//Hook up return key on keyboard.
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
