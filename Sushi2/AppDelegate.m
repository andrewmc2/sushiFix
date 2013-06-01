//
//  AppDelegate.m
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"
//@interface AppDelegate ()
//@property (strong, nonatomic)CLLocationManager*locationManager;
//@property (nonatomic, strong) NSString * strLatitude;
//@property (nonatomic, strong) NSString * strLongitude;
//
//@end
@implementation AppDelegate

//CLLocation* location;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //    [self StartStandardLocationServices];
    // Override point for customization after application launch.
    [self startStandardLocationServices];
    
    return YES;
}

-(void) startStandardLocationServices
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
    self.location = [locations objectAtIndex:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"locationUpdated" object:nil];
}

//-(NSString*)ReturnLatLongforURL
//{
//    
//    NSString *CurrentCoord = [NSString stringWithFormat:@"%@,%@", self.strLatitude, self.strLongitude];
//  //  NSString *str = @"lat=";
//    //str = [str stringByAppendingString:strLatitude];
//    //str = [str stringByAppendingString:@"&long="];
//    //str = [str stringByAppendingString:strLongitude];
//    
//    return CurrentCoord;
//}

////- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//
//    // If it's a relatively recent event, turn off updates to save power
//    location = [locations lastObject];
//    NSDate* eventDate = location.timestamp;
//    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
//    //if (abs(howRecent) < 15.0) {
//        
//        // If the event is recent, do something with it.
//        NSLog(@"latitude %+.6f, longitude %+.6f\n", location.coordinate.latitude, location.coordinate.longitude);
//    //}
//    //HoldLocation = location
//}



							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
