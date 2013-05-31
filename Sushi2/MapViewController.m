//
//  MapViewController.m
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "MapViewController.h"
#import "VenueObject.h"
#import "NearViewController.h"
#import "AppDelegate.h"

@interface MapViewController ()

{
    NSDictionary* firstDictionary;
    //NSArray* itemArray;
    NSDictionary *itemDictionary;
    NSMutableDictionary*
    listVenue;
    VenueObject* oneVenue;
    NSDictionary *categoryDictionary;
    NSMutableArray *categoryArray;
    NSMutableDictionary *categoryInfo;
    NSString *latitudeWithCurrentCoordinates;
    NSString *longitudeWithCurrentCoordinates;
    float ourFloatLat;
    float ourFloatLong;
    
    
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic)CLLocationManager*locationManager;
@property (nonatomic, strong) NSString * strLatitude;
@property (nonatomic, strong) NSString * strLongitude;

@end

@implementation MapViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:(NSCoder *)aDecoder];
    
    [self StartStandardLocationServices];
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        [self StartStandardLocationServices];
//        NSLog(@"test");
        // Custom initialization
    }
    return self;
}

-(void) StartStandardLocationServices
{
    if (nil == self.locationManager)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        
        // Set a movement threshold for new events.
        self.locationManager.distanceFilter = 500;
        
        [self.locationManager startUpdatingLocation];
        
        if([CLLocationManager headingAvailable]) {
            [self.locationManager startUpdatingHeading];
        } else {
            NSLog(@"No Compass -- You're lost");
        }
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // If it's a relatively recent event, turn off updates to save power
    CLLocation * ourlocation = [locations lastObject];
    NSDate* eventDate = ourlocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    //if (abs(howRecent) < 15.0) {
    
    // If the event is recent, do something with it.
    //NSLog(@"latitude %+.6f, longitude %+.6f\n", ourlocation.coordinate.latitude, ourlocation.coordinate.longitude);
    NSLog(@"this is from location manager: %f", ourlocation.coordinate.latitude);
    ourFloatLat = ourlocation.coordinate.latitude;
    ourFloatLong = ourlocation.coordinate.longitude;
    self.strLatitude = [NSString stringWithFormat: @"%f", ourlocation.coordinate.latitude];
    self.strLongitude = [NSString stringWithFormat: @"%f", ourlocation.coordinate.longitude];
    
    //[self StartStandardLocationServices];
    
    NSLog(@"this is from viewDidLoad");
    self.mapView.delegate = self;
    
    
    
    //NSString *urlString = @"https://api.foursquare.com/v2/venues/search?ll=41.894032,%20-87.634589&oauth_token=R0LICVP1OPDRVUGDTBAY4YQDCCRZKQ20BLR4SNG5XVKZ5T5M";
    //  NSString *urlString = @"https://api.foursquare.com/v2/venues/search?ll=41.894032,%20-87.634589&query=sushi&oauth_token=R0LICVP1OPDRVUGDTBAY4YQDCCRZKQ20BLR4SNG5XVKZ5T5M";
    
    
    NSString *CurrentCoord = [NSString stringWithFormat:@"%@,%@", self.strLatitude, self.strLongitude];
//    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%@&query=sushi&oauth_token=R0LICVP1OPDRVUGDTBAY4YQDCCRZKQ20BLR4SNG5XVKZ5T5M", CurrentCoord];   
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%@&query=sushi&oauth_token=R0LICVP1OPDRVUGDTBAY4YQDCCRZKQ20BLR4SNG5XVKZ5T5M", CurrentCoord];
    NSLog(@"The search URL is%@", urlString);
    
     NSURL *url = [NSURL URLWithString: urlString];

    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error)
     
     {
         
         
         NSDictionary *bigDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         
         NSDictionary * venueDictionary = [bigDictionary objectForKey:@"response"];
         
         NSArray *groupsArray = [venueDictionary objectForKey:@"groups"];
         
         NSDictionary* subgroupDictionary = [groupsArray objectAtIndex:0];
         itemArray = [subgroupDictionary objectForKey:@"items"];
         //categoryDictionary = [itemArray objectAtIndex:3];
         
         
         //for (NSMutableDictionary* listVenue in itemArray)
         for (listVenue in itemArray)
             
         {
             oneVenue = [[VenueObject alloc]init] ;
             
             
             oneVenue.title = [listVenue objectForKey:@"name"];
             NSLog(@"%@", oneVenue.title);
             oneVenue.placeID = [listVenue objectForKey:@"id"];
             oneVenue.subtitle = listVenue [@"location"][@"address"];
             oneVenue.placeLatitude = listVenue [@"location"][@"lat"];
             oneVenue.placeLongitude = listVenue [@"location"][@"lng"];
             oneVenue.coordinate = CLLocationCoordinate2DMake([oneVenue.placeLatitude floatValue], [oneVenue.placeLongitude floatValue]);
             //NSLog(@"%f", oneVenue.coordinate);
             categoryArray = [listVenue objectForKey: @"categories"];
             //categoryInfo = [categoryArray objectAtIndex:0];
             
             if (categoryArray == nil || categoryArray == NULL || [categoryArray count] == 0)
                 //[categoryArray isKindOfClass:[NSNull NSMutableArray]])
             {
                 oneVenue.venueCategory = @"Public Space";
             } else {
                 
                 categoryInfo = [categoryArray objectAtIndex:0];
                 oneVenue.venueCategory = [categoryInfo objectForKey:@"name"];
             }
             NSLog(@"%@", oneVenue.venueCategory);
             
             oneVenue.iconURL = [categoryInfo objectForKey: @"icon"];
             NSLog(@"%@", oneVenue.iconURL);
             NSURL *NSiconURL = [NSURL URLWithString:oneVenue.iconURL];
             oneVenue.venueTypeIcon = [NSData dataWithContentsOfURL:NSiconURL];
             oneVenue.venueIcon = [[UIImage alloc] initWithData:oneVenue.venueTypeIcon];
             //imageView.image = instaPhoto;
             oneVenue.distance = listVenue[@"location"][@"distance"];
             oneVenue.hugeDictionary = listVenue
             ;
             
             CLLocationCoordinate2D center = CLLocationCoordinate2DMake(ourFloatLat, ourFloatLong);
             MKCoordinateSpan span = MKCoordinateSpanMake(.05, .05);
             MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
             self.mapView.region = region;
             
             [self.mapView addAnnotation:oneVenue];
             
             
             
         }
         //end of fast enumeration
         
     }];
    
    
    
    
	// Do any additional setup after loading the view.
}

-(void)mapView:(MKMapView*)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    //    NSLog(@"HEY");
    //[mapView selectedAnnotations][0]
    [self performSegueWithIdentifier:@"FourSquareWebSegue" sender:self];
    
    //[ selectedAnnotations[0]];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //    BusStop *selectedBusStop = [_mapView selectedAnnotations][0];
    //    ((BusDetailVCViewController *)segue.destinationViewController).thisBusStop = sender;
    
   // BusDetailVCViewController* busDetailVC = [segue destinationViewController];
    
    //busDetailVC.detailAnnotation = [_mapView selectedAnnotations][0];
    
    
}

//}
//-(void) viewDidAppear:(BOOL)animated
//{
//    //[self StartStandardLocationServices];
//    NSLog(@"this is from viewDidAPPEAR %f", ourFloatLat);
//
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

  

@end
