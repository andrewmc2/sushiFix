//
//  WikiViewController.h
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddSushiDelegate.h"
#import "AddSushiViewController.h"


@interface WikiViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AddSushiDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addSushi;


@end
