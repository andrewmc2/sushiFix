//
//  MapToVenuePageViewController.h
//  Sushi2
//
//  Created by Craig on 5/31/13.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface MapToVenuePageViewController : UIViewController

@property (strong, nonatomic) NSString *venue4SqWebAddress;
@property (strong, nonatomic) NSMutableDictionary *venueDictionaryForMapView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
