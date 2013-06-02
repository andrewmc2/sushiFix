//
//  webViewController.m
//  Sushi2
//
//  Created by Craig on 5/31/13.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "webViewController.h"
#import "NearViewController.h"

@interface webViewController ()

@end

@implementation webViewController

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
    
    NSURL *url = [NSURL URLWithString:self.venueWebSite];
    
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:requestObj];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
