//
//  MapToVenuePageViewController.m
//  Sushi2
//
//  Created by Craig on 5/31/13.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "MapToVenuePageViewController.h"

@interface MapToVenuePageViewController ()

@end

@implementation MapToVenuePageViewController

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
    NSURL *url = [NSURL URLWithString: self.venue4SqWebAddress ];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
