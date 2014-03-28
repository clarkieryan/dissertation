//
//  IndivEventViewController.m
//  tonightapp
//
//  Created by Ryan Clarke on 05/03/2014.
//  Copyright (c) 2014 Ryan Clarke. All rights reserved.
//

#import "IndivEventViewController.h"
#import "Event.h"

@interface IndivEventViewController ()
    @property (weak, nonatomic) IBOutlet UIButton *followButton;
    @property (weak, nonatomic) IBOutlet UILabel *nameField;
    @property (weak, nonatomic) IBOutlet UITextView *descField;
    @property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@end

@implementation IndivEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)vistEventButton:(id)sender {
    NSString *urlString  = [NSString stringWithFormat:@"%@%@", @"http://facebook.com/", _event.ref_id];
    NSLog(@"%@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

//Action to follow a user
- (IBAction)followButton:(id)sender {
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSDictionary* headers = @{@"accept": @"application/json"};
        NSDictionary* parameters = @{@"access_token": [UICKeyChainStore stringForKey:@"access_token"]};
        
        UNIHTTPJsonResponse* response = [[UNIRest get:^(UNISimpleRequest* request) {
            [request setUrl:FOLLOW_EVENT(_event.id)];
            [request setHeaders:headers];
            [request setParameters:parameters];
        }] asJson];
        
        NSArray *body = response.body.array;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //If something
            [_followButton setTitleColor:UIColorFromRGB(0x0BD318)forState: UIControlStateNormal];
            _followButton.titleLabel.text = @"Following Event";
        });
    });

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_nameField.text = _event.name;
    _descField.text = _event.desc;
    _cityLabel.text = [_event.venue objectForKey:@"city"];
    _coverImageView.image = _event.cover_image;
    
    _descField.editable = false;
    _descField.dataDetectorTypes = UIDataDetectorTypeLink;

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

