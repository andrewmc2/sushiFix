//
//  MapViewController.m
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "MapViewController.h"
#import "VenueObject.h"

@interface MapViewController ()

{
    NSDictionary* firstDictionary;
    NSArray* itemArray;
    NSDictionary *itemDictionary;
    NSMutableDictionary*
    listVenue;
    VenueObject* oneVenue;
    NSDictionary *categoryDictionary;
    NSMutableArray *categoryArray;
    NSMutableDictionary *categoryInfo;
    NSNull *null;
    
    
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

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
    
    self.mapView.delegate = self;
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(41.894032, -87.634589);
    MKCoordinateSpan span = MKCoordinateSpanMake(.05, .05);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    self.mapView.region = region;
    //NSString *urlString = @"https://api.foursquare.com/v2/venues/search?ll=41.894032,%20-87.634589&oauth_token=R0LICVP1OPDRVUGDTBAY4YQDCCRZKQ20BLR4SNG5XVKZ5T5M";
    NSString *urlString = @"https://api.foursquare.com/v2/venues/search?ll=41.894032,%20-87.634589&query=sushi&oauth_token=R0LICVP1OPDRVUGDTBAY4YQDCCRZKQ20BLR4SNG5XVKZ5T5M";
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
             categoryArray = [listVenue objectForKey: @"categories"];
             //categoryInfo = [categoryArray objectAtIndex:0];
             
             if (categoryArray == nil || categoryArray == NULL || [categoryArray count] == 0)
                 //[categoryArray isKindOfClass:[NSNull NSMutableArray]])
             {
                 oneVenue.venueCategory = @"Public Space";
             } else {
          
                 [categoryArray objectAtIndex:0];
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
             
             [self.mapView addAnnotation:oneVenue];
    
             
             
             
             //  [arrayOfObjects addObject:object];
             //NSLog(@"%@",listVenue);
         }
         //end of fast enumeration
         
         
         
         
         //NSLog(@"%@",listVenue);
     }];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
