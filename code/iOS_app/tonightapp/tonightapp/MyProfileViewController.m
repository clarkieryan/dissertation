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
#import "User.h"

@interface MyProfileViewController (){
    NSDictionary *profileDetails;
    NSArray *followingDetails;
}
@property (weak, nonatomic) IBOutlet UILabel *nameField;
@property (weak, nonatomic) IBOutlet UILabel *emailField;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UITableView *followingTable;

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
    
    _followingTable.delegate = self;
    _followingTable.dataSource = self;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSDictionary* headers = @{@"accept": @"application/json"};
        NSDictionary* parameters = @{@"access_token": [UICKeyChainStore stringForKey:@"access_token"]};
        
        UNIHTTPJsonResponse* userResponse = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:USER_URL];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        
        UNIHTTPJsonResponse* followingResponse = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:USER_FOLLOWING];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        
        profileDetails = userResponse.body.object;
        followingDetails = followingResponse.body.array;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_followingTable reloadData];
            _nameField.text = [NSString stringWithFormat:@"%@ %@",[profileDetails objectForKey:@"first_name"], [profileDetails objectForKey:@"last_name"]];
            _emailField.text = [profileDetails objectForKey:@"email"];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });


    //Fill up the fields
  
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButton:(id)sender {
    
    //Remove the relevant keys
    User *user = [[User alloc] initWithUser];
    [user logoutUser];
    //Move to the login screen
    [self performSegueWithIdentifier:@"logoutSegue" sender:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [followingDetails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [_followingTable dequeueReusableCellWithIdentifier:@"EventCell" forIndexPath:indexPath];
    NSDictionary *row = [followingDetails objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [row objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // (Nothing yet)
}

@end
