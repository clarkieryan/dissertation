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
    NSArray *searchResults;
    NSArray *following;
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
    
    [_searchBar setTranslucent:NO];
    [_searchBar setBackgroundImage:[UIImage new]];
    _searchBar.backgroundColor = UIColorFromRGB(0xe74c3c);
    _searchBar.barTintColor =UIColorFromRGB(0xe74c3c);
    
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
    
    //_searchBar.barTintColor = UIColorFromRGB(0xe74c3c);
    
    
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
        
        UNIHTTPJsonResponse* followingResponse = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:USER_FOLLOWING];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];

        
        for (id event in response.body.array) {
            [events addObject:[[Event alloc] initWithEvent:event]];
        }
        
        following = followingResponse.body.array;
        
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    } else {
        return [sortedArray count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *row = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        row = [searchResults objectAtIndex:indexPath.row];
    } else {
        row = [sortedArray objectAtIndex:indexPath.row];
    }
    
    
    EventFeedTableViewCell *cell = (EventFeedTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"Event"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    cell.eventName.text = row.name;
    cell.venueName.text = row.venue.name;
    cell.eventCoverImage.image = row.cover_image;
    cell.eventTime.text = [formatter stringFromDate:row.start_time];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

//Search methods
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    //Replace with a get maybe - for the search request, will ease the search function.
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [sortedArray filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = nil;
    Event *event = nil;
    
    if (self.searchDisplayController.active) {
        indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        event = [searchResults objectAtIndex:indexPath.row];
    } else {
        indexPath = [self.tableView indexPathForSelectedRow];
        event = [sortedArray objectAtIndex:indexPath.row];
    }
    
    IndivEventViewController *detailViewController = (IndivEventViewController *)segue.destinationViewController;
    detailViewController.event = event;
    detailViewController.following = following;
}

@end
