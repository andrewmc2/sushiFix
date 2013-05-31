//
//  NearViewController.m
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "NearViewController.h"
#import <MapKit/MapKit.h>
#import "AppDelegate.h"

@interface NearViewController ()
{
    CLLocationManager *locationManager;
    
}

@property (strong, nonatomic) IBOutlet UIImageView *needle;
@property (strong, nonatomic) IBOutlet UILabel *nearestVenueAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *nearestVenueLabel;

@end

@implementation NearViewController

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


    //[self StartStandardLocationServices];

    self.needle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chopstickBowl.jpg"]];
    self.needle.frame = CGRectMake(10, 10, 70, 70);
    self.needle.backgroundColor = [UIColor clearColor];
    self.needle.opaque = NO;

    self.needle = self.needle;
    [self nearestVenue];
    
}

-(void) nearestVenue
{
    NSString *nearestVenue = [[itemArray objectAtIndex:0]objectForKey:@"name"];
    NSString *nearestVenueAddress = [[itemArray objectAtIndex:0]valueForKeyPath: @"location.address"];
    NSLog(@"the nearest venue is %@, and it is located %@", nearestVenue, nearestVenueAddress);
    self.nearestVenueLabel.text =  nearestVenue;
    self.nearestVenueAddressLabel.text = nearestVenueAddress;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"the error is %@", error);
}


-(void) locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"Magnetic heading %f", newHeading.magneticHeading);
    //If the value is 0, pointing magnetic north, 90 means east, 180 is south, etc.
    
    double degrees = newHeading.magneticHeading;
    double radians = degrees * M_PI / 180;
    self.needle.transform = CGAffineTransformMakeRotation(-radians);
    
    NSLog(@"New magnetic heading: %f", newHeading.magneticHeading);
    NSLog(@"New true heading: %f", newHeading.trueHeading);
    
}




@end
