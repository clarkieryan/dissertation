//
//  EventFeedTableViewCell.m
//  tonightapp
//
//  Created by Ryan Clarke on 19/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "EventFeedTableViewCell.h"

@implementation EventFeedTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
