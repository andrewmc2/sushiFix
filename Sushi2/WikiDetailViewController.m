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
}

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
         
         NSString *flickTestUrlString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg", sushiPicFarmArray[1],sushiPicServerArray[1],sushiPicIdArray[1],sushiPicSecretArray[1]];
         
         NSURL *urlPic = [NSURL URLWithString:flickTestUrlString];
         NSData *imageData = [NSData dataWithContentsOfURL:urlPic];
         UIImage *instaPhoto = [[UIImage alloc] initWithData:imageData];
         self.flickrImage.image = instaPhoto;
     }];
}


@end
