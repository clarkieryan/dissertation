//
//  MyFeedTableViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import <UNIRest.h>
#import <UICKeyChainStore/UICKeyChainStore.h>
#import "MyFeedTableViewController.h"
#import "EventTableViewCell.h"
#import "IndivEventViewController.h"
#import "MBProgressHUD.h"
#import "Event.h"

@interface MyFeedTableViewController (){
     NSArray *tableData;
     NSArray *_events;
}
@end

@implementation MyFeedTableViewController

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
    [super viewDidLoad];
    self.title = @"My Feed";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSDictionary* headers = @{@"accept": @"application/json"};
        NSDictionary* parameters = @{@"access_token": [UICKeyChainStore stringForKey:@"access_token"]};
        
        UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:@"http://ryc-diss.heroku.com/api/v1/events/"];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        _events = response.body.array;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"EventCell";
    EventTableViewCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier
                              forIndexPath:indexPath];
    
    NSDictionary *row = [_events objectAtIndex:indexPath.row];
    NSLog(@"%@", [row objectForKey:@"name"]);
    if([row objectForKey:@"name"] != [NSNull null] &&  [[row objectForKey:@"venue"] objectForKey:@"name"] != [NSNull null]){
        cell.eventNameLabel.text = [row objectForKey:@"name"];
        cell.venueLabel.text = [[row objectForKey:@"venue"] objectForKey:@"name"];
    } else {
        cell.eventNameLabel.text = @"";
        cell.venueLabel.text = @"";
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    IndivEventViewController *detailViewController = (IndivEventViewController *)segue.destinationViewController;
    detailViewController.event = [_events objectAtIndex:indexPath.row];
    detailViewController.eventName = [[_events objectAtIndex:indexPath.row] objectForKey:@"name"];
    detailViewController.eventDesc = [[_events objectAtIndex:indexPath.row] objectForKey:@"desc"];
}


@end
