//
//  NearViewController.m
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "NearViewController.h"
#import <MapKit/MapKit.h>

@interface NearViewController ()
{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) IBOutlet UIImageView *needle;


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
    [self StartStandardLocationServices];

    self.needle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chopstickBowl.jpg"]];
    self.needle.frame = CGRectMake(10, 10, 70, 70);
    self.needle.backgroundColor = [UIColor clearColor];
    self.needle.opaque = NO;

    self.needle = self.needle;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) StartStandardLocationServices
{
    if (nil == locationManager)
    locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500;
    
    [locationManager startUpdatingLocation];

    if([CLLocationManager headingAvailable]) {
        [locationManager startUpdatingHeading];
    } else {
        NSLog(@"No Compass -- You're lost");
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // If it's a relatively recent event, turn off updates to save power
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
    
    // If the event is recent, do something with it.
    NSLog(@"latitude %+.6f, longitude %+.6f\n", location.coordinate.latitude, location.coordinate.longitude);
    }
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
