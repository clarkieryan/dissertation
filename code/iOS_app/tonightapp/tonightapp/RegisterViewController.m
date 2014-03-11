//
//  RegisterViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 06/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "RegisterViewController.h"
#import <UNIRest.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


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
    NSArray *values = [_nameField.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
//    NSDictionary *user = @{@"email" : _emailField.text, @"first_name" : values[0], @"last_name": values[1], @"password": _passwordField.text};
    NSString *userParams =[NSString stringWithFormat:@"{\"email\": \"%@\", \"first_name\": \"%@\", \"last_name\": \"%@\",\"password\": \"%@\" }", _emailField.text, values[0], values[1], _passwordField.text];
    
    NSDictionary* headers = @{@"accept": @"application/json"};
    NSDictionary* parameters = @{@"user": userParams};
    
    UNIHTTPJsonResponse* response = [[UNIRest post:^(UNISimpleRequest* request) {
        [request setUrl:@"http://ryc-diss.herokuapp.com/api/v1/register"];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJson];
    
    NSLog(@"%@", response.body);
    
    
    
    NSLog(@"Register Clicked");
}

//Hide the keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


@end
