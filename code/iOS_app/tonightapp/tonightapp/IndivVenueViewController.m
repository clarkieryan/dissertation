//
//  IndivVenueViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 06/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "IndivVenueViewController.h"

@interface IndivVenueViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextView *descLabel;

@end

@implementation IndivVenueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _descLabel.editable = false;
    _descLabel.dataDetectorTypes = UIDataDetectorTypeLink;
    
    //Assign the labels
    if(![[_venue objectForKey:@"name"] isEqual:[NSNull null]]){
        _titleLabel.text = [_venue objectForKey:@"name"];
    }
    if(![[_venue objectForKey:@"city"] isEqual:[NSNull null]]){
       _cityLabel.text = [_venue objectForKey:@"city"];
    }
    if(![[_venue objectForKey:@"phone"] isEqual:[NSNull null]]){
        _phoneLabel.text = [_venue objectForKey:@"phone"];
    }
    if(![[_venue objectForKey:@"desc"] isEqual:[NSNull null]]){
        _descLabel.text = [_venue objectForKey:@"desc"];
    }

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)visitPageButton:(id)sender {
    
    NSString *urlString  = [NSString stringWithFormat:@"%@%@", @"http://facebook.com/", [_venue objectForKey:@"ref_id"]];
    NSLog(@"%@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

@end
