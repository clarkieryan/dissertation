//
//  DiscoverTableViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "CatVenueViewController.h"
#import "MBProgressHUD.h"

@interface DiscoverTableViewController (){
    NSArray *cities;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *filterSegment;

@end

@implementation DiscoverTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    //Set the title (Somewhat redundant)
    self.title = @"Discover";
    
    //Show the progress bar and load the data
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSDictionary* headers = @{@"accept": @"application/json"};
        NSDictionary* parameters = @{@"access_token": [UICKeyChainStore stringForKey:@"access_token"]};
        
        
        UNIHTTPJsonResponse* cities_response = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:CITIES_URL];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        
        cities = cities_response.body.array;
        
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell"];
    
    NSDictionary *row = [cities objectAtIndex:indexPath.row];
    cell.textLabel.text = [row objectForKey:@"name"];

    return cell;
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Pass the relevant city object
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    CatVenueViewController *detailViewController = (CatVenueViewController *)segue.destinationViewController;
    detailViewController.city = [cities objectAtIndex:indexPath.row];

}


@end
