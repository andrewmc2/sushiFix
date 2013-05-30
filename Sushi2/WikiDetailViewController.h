//
//  WikiDetailViewController.h
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SushiType.h"

@interface WikiDetailViewController : UIViewController

@property (strong, nonatomic) SushiType *selectedSushiType;

@property (weak, nonatomic) IBOutlet UILabel *sushiName;
@property (weak, nonatomic) IBOutlet UITextView *wikiText;
@property (weak, nonatomic) IBOutlet UIImageView *flickrImage;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end
