//
//  SushiFourSquareWebVC.h
//  Sushi2
//
//  Created by MasterRyuX on 5/31/13.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SushiFourSquareWebVC : UIViewController<MKAnnotation>

@property (strong, nonatomic) IBOutlet UIWebView *FourSquarePage;

@property NSString * thisVenueURL;
@property id MKAnnotation;
@property(strong, nonatomic) NSDictionary *thisVenueDictionary;



@end
