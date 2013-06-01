//
//  SushiFourSquareWebVC.m
//  Sushi2
//
//  Created by MasterRyuX on 5/31/13.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "SushiFourSquareWebVC.h"
#import "SushiVenueAnnotation.h"


@interface SushiFourSquareWebVC ()

@end


@implementation SushiFourSquareWebVC
@synthesize thisVenueURL;

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
    
  //  self.venue
    
    NSURL *url = [NSURL URLWithString:thisVenueURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.FourSquarePage loadRequest:requestObj];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
