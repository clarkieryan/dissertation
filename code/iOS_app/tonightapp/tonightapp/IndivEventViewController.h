//
//  IndivEventViewController.h
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndivEventViewController : UIViewController
@property (strong, nonatomic) NSString *eventName;
@property (strong, nonatomic) NSString *eventDesc;
@property (strong, nonatomic)NSDictionary *event;
@end
