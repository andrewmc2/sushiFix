//
//  MapViewController.h
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "NearViewController.h"



@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@end

NSArray* itemArray;