//
//  AddSushiViewController.h
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-31.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddSushiDelegate.h"

@interface AddSushiViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *addedImage;
@property (weak, nonatomic) IBOutlet UIButton *addPic;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) id <AddSushiDelegate> addSushiDelegate;

- (IBAction)confirmEntry:(id)sender;





@end