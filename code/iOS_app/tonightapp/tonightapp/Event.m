//
//  Event.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "Event.h"
#import "Venue.h"

@implementation Event


- (id)initWithEvent:(NSMutableArray *) event {
    //Event ID will always be true
    _event_id = [event valueForKey:@"id"];
    _ref_id = [event valueForKey:@"ref_id"];
    
    //Check for null and output
    _name = [self checkNullString:[event valueForKey:@"name"]];
    _desc = [self checkNullString:[event valueForKey:@"desc"]];
    _start_time = [self convertDate:[event valueForKey:@"start_time"]];
    _end_time = [self convertDate:[event valueForKey:@"end_time"]];
    
    //Need to set this as a venue object
    _venue = [[Venue alloc] initWithVenue:[event valueForKey:@"venue"]];
    
    NSURL *url = [NSURL URLWithString:[event valueForKey:@"cover_photo"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _cover_image = [UIImage imageWithData:data];
    
    return self;
}

//Check if there is a null string or not
-(NSString *)checkNullString:(NSString *) input {
    if (input == (id)[NSNull null] || input.length == 0 ){
        return @"";
    } else {
        return input;
    }
    
}

//Conver the date string into a function
- (NSDate *)convertDate:(NSString*) date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];

    //Data validation
    if((NSNull *)date == [NSNull null]){
        return NULL;
    } else {
        return [dateFormatter dateFromString:date];
    }
}


@end
