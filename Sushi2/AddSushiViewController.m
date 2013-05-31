//
//  AddSushiViewController.m
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-31.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "AddSushiViewController.h"
#import "AddSushiCustomCell.h"

@interface AddSushiViewController ()

@end

@implementation AddSushiViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSourceMethods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cell";
    AddSushiCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil){
//        cell = [[AddSushiCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    
    if (indexPath.section == 0) {
        cell.cellName.text = @"name";
        cell.cellTextField.placeholder = @"insert name here";
    }
    
    if (indexPath.section == 1) {
        cell.cellName.text = @"description";
        cell.cellTextField.placeholder = @"insert description here";
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (IBAction)confirmEntry:(id)sender {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSString *sushiNameString = ((AddSushiCustomCell*)([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]])).cellTextField.text;
    NSString *sushiDescriptionString = ((AddSushiCustomCell*)([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]])).cellTextField.text;
    
    [self.addSushiDelegate addName:sushiNameString
                    addDescription:sushiDescriptionString
                          addImage:[UIImage imageNamed:@"chopstickBowl.jpg"]];
}
@end
