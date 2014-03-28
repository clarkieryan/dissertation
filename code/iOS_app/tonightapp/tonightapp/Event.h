//
//  Event.h
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property(nonatomic, copy) NSString *id;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, copy) NSString *ref_id;
@property(nonatomic, copy) NSDate *start_time;
@property(nonatomic, copy) NSDate *end_time;
@property(nonatomic, copy) UIImage *cover_image;
@property(nonatomic, copy) NSDictionary *venue;


- (id)initWithEvent:(NSMutableArray *) event;

@end

