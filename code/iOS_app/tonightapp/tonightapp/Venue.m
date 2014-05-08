//
//  Venue.m
//  tonightapp
//
//  Created by Ryan Clarke on 31/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "Venue.h"

@implementation Venue

- (id)initWithVenue:(NSMutableArray *) venue {
    
    _ref_id = [venue valueForKey:@"ref_id"];
    _lat = [venue valueForKey:@"lat"];
    _lon = [venue valueForKey:@"lon"];
    _phone = [venue valueForKey:@"phone"];
    
    _name = [self checkNullString:[venue valueForKey:@"name"]];
    _desc = [self checkNullString:[venue valueForKey:@"desc"]];
    _street = [self checkNullString:[venue valueForKey:@"street"]];
    _county = [self checkNullString:[venue valueForKey:@"county"]];
    _country = [self checkNullString:[venue valueForKey:@"country"]];
    _post_code = [self checkNullString:[venue valueForKey:@"post_code"]];
    _website = [self checkNullString:[venue valueForKey:@"website"]];
    
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

@end
