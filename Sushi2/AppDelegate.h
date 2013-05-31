//
//  AppDelegate.h
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
-(void) StartStandardLocationServices;
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
@property (strong, nonatomic) UIWindow *window;

@end



//CLLocation* location;
//CLLocation * HoldLocation;
