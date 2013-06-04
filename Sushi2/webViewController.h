//
//  webViewController.h
//  Sushi2
//
//  Created by Craig on 5/31/13.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) NSString *venueWebSite;
@end
