//
//  WikiDetailViewController.m
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "WikiDetailViewController.h"

@interface WikiDetailViewController ()
{
    NSMutableArray *sushiPicIdArray;
    NSMutableArray *sushiPicFarmArray;
    NSMutableArray *sushiPicSecretArray;
    NSMutableArray *sushiPicServerArray;
    int yPosition;
}

-(void)putLabelsInScrollView:(int)numberOfLabels;

@end

@implementation WikiDetailViewController

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
    NSLog(@"%@",self.selectedSushiType.name);
    self.sushiName.text = self.selectedSushiType.name;
    [self addPictureFromFlickr];
    self.wikiText.text = self.selectedSushiType.description;
    
    yPosition = 0;
    self.myScrollView.backgroundColor = [UIColor redColor];
    [self putLabelsInScrollView:15];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addPictureFromFlickr
{
    sushiPicIdArray = [NSMutableArray array];
    sushiPicFarmArray = [NSMutableArray array];
    sushiPicServerArray = [NSMutableArray array];
    sushiPicSecretArray = [NSMutableArray array];
    
    
//    - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement
//    
    NSString *searchParameters = [self.selectedSushiType.name stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *searchParametersLowerCase = [searchParameters lowercaseString];
    NSLog(@"%@",searchParametersLowerCase);
    
    NSString *allParts = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=072e43ef1d3d6c21afd0a0e704e2730f&tags=sushi&text=sushi+%@&format=json&nojsoncallback=1",searchParametersLowerCase];
    NSURL *url = [NSURL URLWithString:allParts];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error)
     {
         NSMutableDictionary *resultsDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         
         NSMutableDictionary *photosDict = [resultsDict objectForKey:@"photos"];
         
         NSMutableArray *photoArray = [photosDict objectForKey:@"photo"];
         
         for (NSDictionary *dict in photoArray) {
             NSString *photoIdString = [dict objectForKey:@"id"];
             [sushiPicIdArray addObject:photoIdString];
             NSString *farmIdString = [dict objectForKey:@"farm"];
             [sushiPicFarmArray addObject:farmIdString];
             NSString *serverIdString = [dict objectForKey:@"server"];
             [sushiPicServerArray addObject:serverIdString];
             NSString *secretIdString = [dict objectForKey:@"secret"];
             [sushiPicSecretArray addObject:secretIdString];
         }
         
         for (int i = 0; i < 4; i++) {
             NSString *flickTestUrlString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg", sushiPicFarmArray[i],sushiPicServerArray[i],sushiPicIdArray[i],sushiPicSecretArray[i]];
             NSURL *urlPic = [NSURL URLWithString:flickTestUrlString];
             NSData *imageData = [NSData dataWithContentsOfURL:urlPic];
             UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(yPosition, 0, 150, 50)];
             UIImage *instaPhoto = [[UIImage alloc] initWithData:imageData];
             imageView.image = instaPhoto;
             //[self.myScrollView addSubview:imageView];
             //yPosition += 160;
             NSLog(@"yo");
         }
         
         //self.flickrImage.image = instaPhoto;
     }];
}

-(void)putLabelsInScrollView:(int)numberOfLabels
{
    for (int i = 0; i < numberOfLabels; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(yPosition, 25, 180, 70)];
        [label setText:@"lab"];
        [self.myScrollView addSubview:label];
        yPosition += 250;
        
    }
    [self.myScrollView setContentSize:CGSizeMake(yPosition,self.myScrollView.frame.size.width)];
    //[self.view addSubview:self.myScrollView];
}

@end
