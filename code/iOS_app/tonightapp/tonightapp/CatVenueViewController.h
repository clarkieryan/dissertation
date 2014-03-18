//
//  CatVenueViewController.h
//  tonightapp
//
//  Created by Ryan Clarke on 17/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatVenueViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
    @property (strong, nonatomic) NSDictionary *city;
@end
