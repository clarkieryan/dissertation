//
//  EventFeedTableViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 18/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "EventFeedTableViewController.h"
#import "Event.h"
#import "EventFeedTableViewCell.h"
#import "IndivEventViewController.h"
#import <MBProgressHUD.h>

@interface EventFeedTableViewController (){
    NSMutableArray *events;
    NSString *url;
    NSArray *sortedArray;
}

@end

@implementation EventFeedTableViewController

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
    
    
    //Use the url string to se the relevant data source
    if([_venue count] == 0) {
        //TODO change to feed when implemented
        self.title = @"My Feed";
        url = EVENTS_URL;
    } else if([_category count] == 0) {
        self.title = [_venue objectForKey:@"name"];
        url = VENUE_EVENTS_URL([_venue objectForKey:@"id"]);
    } else {
        self.title = @"Categories";
        url = CATEGORIES_EVENTS_URL([_city objectForKey:@"id"], [_category objectForKey:@"id"]);
    }
    
    
    events = [NSMutableArray array];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSDictionary* headers = @{@"accept": @"application/json"};
        NSDictionary* parameters = @{@"access_token": [UICKeyChainStore stringForKey:@"access_token"]};
        
        UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:url];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        
        for (id event in response.body.array) {
            [events addObject:[[Event alloc] initWithEvent:event]];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            //Sort the output
            sortedArray = [events sortedArrayUsingComparator:^NSComparisonResult(Event *event1, Event *event2){
                return [event1.start_time compare:event2.start_time];
            }];
            
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });

    
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


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *headerTitle;
    if (section==0) {
        headerTitle = @"Future Events";
    }
    return headerTitle;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sortedArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *row = [sortedArray objectAtIndex:indexPath.row];
    EventFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Event"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    cell.eventName.text = row.name;
    cell.venueName.text = [row.venue objectForKey:@"name"];
    cell.eventCoverImage.image = row.cover_image;
    cell.eventTime.text = [formatter stringFromDate:row.start_time];

    return cell;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    IndivEventViewController *detailViewController = (IndivEventViewController *)segue.destinationViewController;
    detailViewController.event = [sortedArray objectAtIndex:indexPath.row];
}

@end
