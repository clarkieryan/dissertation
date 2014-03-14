//
//  EventCell.h
//  tonightapp
//
//  Created by Ryan Clarke on 08/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;



@end
