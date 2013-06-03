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
#import "LocalVenueObject.h"


@interface NearViewController ()
{
    CLLocationManager *locationManager;
    NSString *venue4SQWebAddress;
    NSMutableArray *arrayWithDistance;
    NSArray *distanceSortedArray;

    float userLatitude;
    float userLongitude;
}

@property (strong, nonatomic) IBOutlet UIImageView *needle;
@property (strong, nonatomic) IBOutlet UILabel *nearestVenueAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *nearestVenueLabel;
@property (nonatomic) CLLocationCoordinate2D venueCoordinate;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;


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
    userLatitude = ourlocation.coordinate.latitude;
    userLongitude = ourlocation.coordinate.longitude;
    
}


-(void) startStandardLocationServices
{
    
    locationManager=[[CLLocationManager alloc] init];
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	locationManager.headingFilter = 1;
	locationManager.delegate=self;
    
    
    [locationManager startUpdatingLocation];
    
         
}




-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"the error is %@", error);
}




-(void) nearestVenue
{
//    NSString *nearestVenue = [[itemArray objectAtIndex:0]objectForKey:@"name"];
//    NSString *nearestVenueAddress = [[itemArray objectAtIndex:0]valueForKeyPath: @"location.address"];
//
//     NSString *venueLatitude = [[itemArray objectAtIndex:0]valueForKeyPath:@"location.lat"];
//     NSString *venueLongitude = [[itemArray objectAtIndex:0]valueForKeyPath:@"location.lng"];
//     self.venueCoordinate = CLLocationCoordinate2DMake([venueLatitude floatValue], [venueLongitude floatValue]);
    
//    self.nearestVenueLabel.text =  nearestVenue;
//    self.nearestVenueAddressLabel.text = nearestVenueAddress;
    
   
    
    arrayWithDistance =  [[NSMutableArray alloc]init];
    
    
    for (NSDictionary *venueDictionary in itemArray) {
        
        
        NSString *name = [venueDictionary valueForKeyPath:@"name"];
        
        NSString *streetAddress = [venueDictionary valueForKeyPath:@"location.address"];
        
        NSNumber *distance = [venueDictionary valueForKeyPath:@"location.distance"];
        NSString *fourSquareWebPage = [venueDictionary valueForKeyPath:@"canonicalUrl"];
        
        
        LocalVenueObject *localVenueObject = [LocalVenueObject LocalVenueObjectwithName:name andStreetAddress:streetAddress Distance:distance andFourSquareWebPage:fourSquareWebPage];
        
        [arrayWithDistance addObject:localVenueObject];
        
        
    } //end of fast enum
    
    NSLog(@"%@ venuearraywithdistance", arrayWithDistance);
    [self sortArray];
    
}

-(void) sortArray {
NSSortDescriptor *sortDescriptor;
sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance"
                                             ascending:YES];
NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
distanceSortedArray = [arrayWithDistance sortedArrayUsingDescriptors:sortDescriptors];
    NSLog(@"%@",distanceSortedArray);
    
    NSString *nearestVenue = [[distanceSortedArray objectAtIndex:0]valueForKeyPath:@"name"];
    NSString *nearestVenueAddress = [[distanceSortedArray objectAtIndex:0]valueForKeyPath:@"streetAddress"];
    NSNumber *nearestVenueDistance = [[distanceSortedArray objectAtIndex:0]valueForKeyPath:@"distance"];
    NSString *nearestVenueWebsite = [[distanceSortedArray objectAtIndex:0]valueForKeyPath:@"fourSquareWebPage"];
    NSLog(@"web site: %@", nearestVenueWebsite);
    
    NSNumber *furtherestVenueDistance = [[distanceSortedArray objectAtIndex:28]valueForKeyPath:@"distance"];
    NSLog(@"furtherest distance: %f", [furtherestVenueDistance floatValue]);
    
    self.nearestVenueLabel.text =  nearestVenue;
    NSLog(@"nearest venue: %@", nearestVenue);
    
    self.nearestVenueAddressLabel.text = nearestVenueAddress;
    NSLog(@"nearest addreess: %@", nearestVenueAddress);

    NSLog(@"nearest distance: %f", [nearestVenueDistance floatValue]);

   float  nearestVenueDistanceInMiles = ([nearestVenueDistance floatValue]*0.00062137);
    
    NSLog(@"nearestVenueDistanceinMiles: %.2f", nearestVenueDistanceInMiles);
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f miles", nearestVenueDistanceInMiles];

    
    

    
    
    
    
    

}


    
    
    
    
    
    
    



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)goToVenuePageButton:(id)sender {
    
    venue4SQWebAddress = [[distanceSortedArray objectAtIndex:0]valueForKeyPath:@"fourSquareWebPage"];
    NSLog(@"%@ the web page is...", venue4SQWebAddress);
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    webViewController* fourSqWebViewController = [segue destinationViewController];
    fourSqWebViewController.venueWebSite = venue4SQWebAddress;
    
}



@end
