//
//  NearViewController.m
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "NearViewController.h"
#import <MapKit/MapKit.h>
#import "webViewController.h"
#import "AppDelegate.h"


@interface NearViewController ()
{
    CLLocationManager *locationManager;
    NSString *venue4SQWebAddress;
    float userLatitude;
    float userLongitude;
}

@property (strong, nonatomic) IBOutlet UIImageView *needle;
@property (strong, nonatomic) IBOutlet UILabel *nearestVenueAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *nearestVenueLabel;
@property (nonatomic) CLLocationCoordinate2D venueCoordinate;


-(IBAction)goToVenuePageButton:(id)sender;
-(void) nearestVenue;


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
    
    [self nearestVenue];
    [self startStandardLocationServices];

    

    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation * ourlocation = [locations lastObject];
    
    
    NSLog(@"this is from NearVicewCOntroller: %f", ourlocation.coordinate.latitude);
    userLatitude = ourlocation.coordinate.latitude;
    userLongitude = ourlocation.coordinate.longitude;
    
    NSLog(@"%f USER latitude", userLatitude);
}


-(void) startStandardLocationServices
{
    
    locationManager=[[CLLocationManager alloc] init];
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	locationManager.headingFilter = 1;
	locationManager.delegate=self;
    
    
    [locationManager startUpdatingLocation];
    
  //  [self distanceBetweenCoordinate:<#(CLLocationCoordinate2D)#> andCoordinate:<#(CLLocationCoordinate2D)#>];
    
    
       
}




-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"the error is %@", error);
}




-(void) nearestVenue
{
    NSString *nearestVenue = [[itemArray objectAtIndex:0]objectForKey:@"name"];
    NSString *nearestVenueAddress = [[itemArray objectAtIndex:0]valueForKeyPath: @"location.address"];

     NSString *venueLatitude = [[itemArray objectAtIndex:0]valueForKeyPath:@"location.lat"];
     NSString *venueLongitude = [[itemArray objectAtIndex:0]valueForKeyPath:@"location.lng"];
     self.venueCoordinate = CLLocationCoordinate2DMake([venueLatitude floatValue], [venueLongitude floatValue]);
    
    NSLog(@"the nearest venue is %@, and it is located %@", nearestVenue, nearestVenueAddress);
    self.nearestVenueLabel.text =  nearestVenue;
    self.nearestVenueAddressLabel.text = nearestVenueAddress;
    
    NSLog(@"%f, %f", self.venueCoordinate.latitude, self.venueCoordinate.longitude);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)goToVenuePageButton:(id)sender {
    
    venue4SQWebAddress = [[itemArray objectAtIndex:0]objectForKey:@"canonicalUrl"];    NSLog(@"%@ the web page is...", venue4SQWebAddress);
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //((webViewController *)segue.destinationViewController)) = sender;
    
    webViewController* fourSqWebViewController = [segue destinationViewController];
    fourSqWebViewController.venueWebSite = venue4SQWebAddress;
    
}


//-(CLLocationCoordinate2D)distance
-(CLLocationDistance)distanceBetweenCoordinate:(CLLocationCoordinate2D)userCoordinate andCoordinate:(CLLocationCoordinate2D)venueCoordinate {
    
    CLLocation *currentLocation =[[CLLocation alloc] initWithLatitude:userCoordinate.latitude
                                                           longitude:userCoordinate.longitude];
    
    CLLocation *destinationLocation = [[CLLocation alloc] initWithLatitude:venueCoordinate.latitude
                                                                longitude:venueCoordinate.longitude];
    
    CLLocationDistance distance = [currentLocation distanceFromLocation:destinationLocation];
    
    return distance;
    NSLog(@"distance %f", distance);
}

@end
