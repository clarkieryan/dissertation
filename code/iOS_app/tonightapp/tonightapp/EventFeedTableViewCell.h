//
//  EventFeedTableViewCell.h
//  tonightapp
//
//  Created by Ryan Clarke on 19/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventFeedTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UIImageView *eventCoverImage;
    @property (weak, nonatomic) IBOutlet UILabel *eventName;
    @property (weak, nonatomic) IBOutlet UILabel *eventTime;
    @property (weak, nonatomic) IBOutlet UILabel *venueName;
@end
