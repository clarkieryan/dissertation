//
//  DiscoverTableViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "IndivVenueViewController.h"
#import "MBProgressHUD.h"

@interface DiscoverTableViewController (){
    NSArray *venues;
    NSArray *categories;
    NSArray *cities;
    NSArray *content;
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
        
        UNIHTTPJsonResponse* venue_response = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:VENUES_URL];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        venues = venue_response.body.array;;
        
        UNIHTTPJsonResponse* cat_response = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:CATEGORIES_URL];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        
        UNIHTTPJsonResponse* cities_response = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:CITIES_URL];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        
        categories = cat_response.body.array;
        cities = cities_response.body.array;
        venues = venue_response.body.array;
        
        content = venues;
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)filterSegment:(id)sender {
    //Refresh the table view controller
    if([_filterSegment selectedSegmentIndex] == 0){
        content = venues;
    } else if([_filterSegment selectedSegmentIndex] == 1){
        content = categories;
    } else {
        content = cities;
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [content count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell"];
    
    NSDictionary *row = [content objectAtIndex:indexPath.row];
    if([_filterSegment selectedSegmentIndex] == 1){
        cell.textLabel.text = [row objectForKey:@"cat_name"];
    } else {
        cell.textLabel.text = [row objectForKey:@"name"];
    }

    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    IndivVenueViewController *detailViewController = (IndivVenueViewController *)segue.destinationViewController;
    detailViewController.venue = [venues objectAtIndex:indexPath.row];

}


@end
