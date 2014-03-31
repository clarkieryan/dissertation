//
//  Venue.h
//  tonightapp
//
//  Created by Ryan Clarke on 31/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : NSObject
    @property(nonatomic, copy) NSString *name;
    @property(nonatomic, copy) NSString *desc;
    @property(nonatomic, copy) NSString *ref_id;
    @property(nonatomic, copy) NSString *post_code;
    @property(nonatomic, copy) NSString *phone;
    @property(nonatomic, copy) NSString *street;
    @property(nonatomic, copy) NSString *lon;
    @property(nonatomic, copy) NSString *lat;
    @property(nonatomic, copy) NSString *website;
    @property(nonatomic, copy) NSString *country;
    @property(nonatomic, copy) NSString *county;

    - (id)initWithVenue:(NSMutableArray *) event;
@end
