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


#import "MSTranslateAccessTokenRequester.h"
#import "MSTranslateVendor.h"

@interface WikiViewController ()
{
    SushiType *selectedSushiType;
    WikiDetailViewController *wikiDetailViewController;
    AddSushiViewController *addSushiDetailViewController;
    SushiType *sushiType;
}

@property (strong, nonatomic) NSMutableArray *sushiTypeArray;

@end

@implementation WikiViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"wikiDetailPush"]) {
        wikiDetailViewController = [segue destinationViewController];
        [wikiDetailViewController setSelectedSushiType:selectedSushiType];
        
        SushiType *indexSushi = [self.sushiTypeArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        [wikiDetailViewController setSelectedSushiType:indexSushi];
    }
    
    if ([segue.identifier isEqualToString:@"addSushi"]) {
        addSushiDetailViewController = [segue destinationViewController];
        addSushiDetailViewController.addSushiDelegate = self;
    }
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
    //https://github.com/bitmapdata/MSTranslateVendor
    
    sushiType = [[SushiType alloc] init];
    [[MSTranslateAccessTokenRequester sharedRequester] requestSynchronousAccessToken:CLIENT_ID clientSecret:CLIENT_SECRET];
    MSTranslateVendor *vendor = [[MSTranslateVendor alloc] init];
    [vendor requestTranslate:@"pinapple roll" from:@"en" to:@"de" blockWithSuccess:
     ^(NSString *translatedText)
     {
         NSLog(@"translatedText: %@", translatedText);
         sushiType.name = @"dynamite roll";
         sushiType.japaneseName = translatedText;
         sushiType.sushiLogo = [UIImage imageNamed:@"dynamiteRoll.png"];
         [self.sushiTypeArray addObject:sushiType];
         [self.tableView reloadData];
     }
                     failure:^(NSError *error)
     {
         NSLog(@"error_translate: %@", error);
     }];
    
    sushiType = [[SushiType alloc] init];
    sushiType.name = @"california roll";
    sushiType.japaneseName = @"カリフォルニアロール";
    sushiType.description = @"The California roll is a maki-zushi, a kind of sushi roll, usually made inside-out, containing cucumber, crab meat or imitation crab, and avocado. In some countries it is made with mango or banana instead of avocado. Sometimes crab salad is substituted for the crab stick, and often the outer layer of rice (in an inside-out roll) is sprinkled with toasted sesame seeds, tobiko or masago.";
    sushiType.sushiLogo = [UIImage imageNamed:@"dynamiteRoll.png"];
    [self.sushiTypeArray addObject:sushiType];
    
    sushiType = [[SushiType alloc] init];
    sushiType.name = @"philadelphia roll";
    sushiType.japaneseName = @"フィラデルフィアロール";
    sushiType.description = @"The California roll is a maki-zushi, a kind of sushi roll, usually made inside-out, containing cucumber, crab meat or imitation crab, and avocado. In some countries it is made with mango or banana instead of avocado. Sometimes crab salad is substituted for the crab stick, and often the outer layer of rice (in an inside-out roll) is sprinkled with toasted sesame seeds, tobiko or masago.";
    sushiType.sushiLogo = [UIImage imageNamed:@"dynamiteRoll.png"];
    [self.sushiTypeArray addObject:sushiType];
    
    sushiType = [[SushiType alloc] init];
    sushiType.name = @"spider roll";
    sushiType.japaneseName = @"スパイダーロール";
    sushiType.description = @"The California roll is a maki-zushi, a kind of sushi roll, usually made inside-out, containing cucumber, crab meat or imitation crab, and avocado. In some countries it is made with mango or banana instead of avocado. Sometimes crab salad is substituted for the crab stick, and often the outer layer of rice (in an inside-out roll) is sprinkled with toasted sesame seeds, tobiko or masago.";
    sushiType.sushiLogo = [UIImage imageNamed:@"dynamiteRoll.png"];
    [self.sushiTypeArray addObject:sushiType];
    
    //NSLog(@"%@", self.sushiTypeArray);
    
//    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark delegate method

-(void) addName: (NSString*) name
 addDescription: (NSString*) description
       addImage: (UIImage*) image
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    sushiType = [[SushiType alloc] init];
    sushiType.name = name;
    sushiType.japaneseName = @"カリフォルニアロール";
    sushiType.description = description;
    sushiType.sushiLogo = image;
    [self.sushiTypeArray addObject:sushiType];
    [self.tableView reloadData];
}

@end
