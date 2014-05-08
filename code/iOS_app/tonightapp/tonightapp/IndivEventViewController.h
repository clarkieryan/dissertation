//
//  IndivEventViewController.h
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@class IndivEventViewController;

@protocol IndivEventViewControllerDelegate <NSObject>
- (void)addItemViewController:(IndivEventViewController *)controller didFinishEnteringItem:(Event *)event;
@end

@interface IndivEventViewController : UIViewController
@property (strong, nonatomic)Event *event;
@property (nonatomic, weak) id <IndivEventViewControllerDelegate> delegate;
@end
