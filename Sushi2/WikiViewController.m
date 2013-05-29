//
//  WikiViewController.m
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "WikiViewController.h"
#import "SushiTypeTableCell.h"
#import "SushiType.h"
#import "WikiDetailViewController.h"

@interface WikiViewController ()
{
    SushiType *selectedSushiType;
    WikiDetailViewController *wikiDetailViewController;
}

@property (strong, nonatomic) NSMutableArray *sushiTypeArray;

@end

@implementation WikiViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"wikiDetailPush"]) {
        wikiDetailViewController = [segue destinationViewController];
        [wikiDetailViewController setSelectedSushiType:selectedSushiType];
    }
    
    //    if ([segue.identifier isEqualToString:@"viewContact"]) {
//        viewContactViewController = [segue destinationViewController];
//        Contact *indexContact = [self.contactArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
//        [viewContactViewController setSelectedContact:indexContact];
//    }
}

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
    self.sushiTypeArray = [NSMutableArray array];
    [self createSushiDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark create sushi

-(void)createSushiDetails
{
    //stuff
    SushiType *sushiType = [[SushiType alloc] init];
    sushiType.name = @"Dynamite Roll";
    sushiType.japaneseName = @"ダイナマイトロール";
    sushiType.sushiLogo = [UIImage imageNamed:@"dynamiteRoll.png"];
    [self.sushiTypeArray addObject:sushiType];
    
    sushiType = [[SushiType alloc] init];
    sushiType.name = @"California Roll";
    sushiType.japaneseName = @"カリフォルニアロール";
    sushiType.sushiLogo = [UIImage imageNamed:@"dynamiteRoll.png"];
    [self.sushiTypeArray addObject:sushiType];
    
    NSLog(@"%@", self.sushiTypeArray);
    
//    [self.tableView reloadData];
}

#pragma mark UITableViewDataSourceMethods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"sushiTypeCell";
    SushiTypeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil){
//        cell = [[SushiTypeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    //cell.textLabel.text = @"andrew";
    selectedSushiType = self.sushiTypeArray[indexPath.row];
    cell.sushiName.text = selectedSushiType.name;
    cell.japaneseSushiName.text = selectedSushiType.japaneseName;
    cell.sushiImage.image = selectedSushiType.sushiLogo;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sushiTypeArray.count;
}

@end
