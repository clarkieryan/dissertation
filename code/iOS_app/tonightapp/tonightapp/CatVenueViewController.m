//
//  CatVenueViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 17/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "CatVenueViewController.h"
#import <MBProgressHUD.h>

@interface CatVenueViewController (){
    NSArray *content;
    NSArray *venues;
    NSArray *categories;
}
@property (weak, nonatomic) IBOutlet UIToolbar *segmentToolBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *catVenSegment;
@property (weak, nonatomic) IBOutlet UITableView *outputTable;

@end

@implementation CatVenueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       

    }
    return self;
}

- (IBAction)catVenSegment:(id)sender {
    if([_catVenSegment selectedSegmentIndex]){
        content = venues;
    } else {
        content = categories;
    }
    [_outputTable reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     //Remove the border from bottom

    //navigationBar.backgroundColor = UIColorFromRGB(0xe74c3c);
    _segmentToolBar.barTintColor = UIColorFromRGB(0xe74c3c);
    _segmentToolBar.layer.borderWidth = 1;
    _segmentToolBar.layer.borderColor = [UIColorFromRGB(0xe74c3c) CGColor];
    [_segmentToolBar setClipsToBounds:YES];
    

    // Do any additional setup after loading the view.
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSDictionary* headers = @{@"accept": @"application/json"};
        NSDictionary* parameters = @{@"access_token": [UICKeyChainStore stringForKey:@"access_token"]};
        
        NSString *city_id = [_city objectForKey:@"id"];
        
        //NSString *id = [_city objectForKey:@"name"];
        UNIHTTPJsonResponse* venue_response = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:VENUE_BY_CITY(city_id)];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        venues = venue_response.body.array;;
        
        UNIHTTPJsonResponse* cat_response = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:CATEGORY_BY_CITY_URL(city_id)];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        
        categories = cat_response.body.array;
        venues = venue_response.body.array;
        
        content = categories;
        NSLog(@"%@", CATEGORY_BY_CITY_URL(@"13"));
        dispatch_async(dispatch_get_main_queue(), ^{
            [_outputTable reloadData];
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
    return [content count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *row = [content objectAtIndex:indexPath.row];
    UITableViewCell *cell = [_outputTable dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [row objectForKey:@"name"];
    
    // Configure the cell...
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
