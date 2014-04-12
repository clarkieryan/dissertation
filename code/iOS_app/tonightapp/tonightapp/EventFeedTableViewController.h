//
//  EventFeedTableViewController.h
//  tonightapp
//
//  Created by Ryan Clarke on 18/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IndivEventViewController.h"

@interface EventFeedTableViewController : UITableViewController <IndivEventViewControllerDelegate>
    @property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
    @property (strong, nonatomic) NSDictionary *venue;
    @property (strong, nonatomic) NSDictionary *category;
    @property (strong, nonatomic) NSDictionary *city;
@end