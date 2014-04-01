//
//  RegisterViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 06/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"

@interface RegisterViewController (){
    User *user;
}
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
    user = [[User alloc] initWithUser];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//TODO - Need to add in functions for register
- (IBAction)registerButton:(id)sender {
    
    NSString *registerResponse = [user registerUser:_emailField.text withPassword:_passwordField.text withName:_nameField.text];
    
    if([registerResponse isEqualToString:@"true"]){
        [self performSegueWithIdentifier:@"registerSegue" sender:self];
    } else {
        //Return an error
    }
    
}

//Hide the keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


@end
