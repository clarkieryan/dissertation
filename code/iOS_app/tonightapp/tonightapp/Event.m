//
//  Event.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "Event.h"

@implementation Event


- (id)initWithEvent:(NSMutableArray *) event {
    
    //Need to implement some data validation
    
    _name = [event valueForKey:@"name"];
    _desc = [event valueForKey:@"desc"];
    _ref_id = [event valueForKey:@"ref_id"];
    _start_time = [event valueForKey:@"end_time"];
    _end_time = [event valueForKey:@"end_time"];
    _venue = [event valueForKey:@"venue"];
    
    NSURL *url = [NSURL URLWithString:[event valueForKey:@"cover_photo"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _cover_image = [UIImage imageWithData:data];
    
    return self;
}


@end
