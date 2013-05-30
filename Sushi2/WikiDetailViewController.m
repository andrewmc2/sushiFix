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
    self.wikiText.text = @"andrew";
    [self putWikiInTextfield];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)putWikiInTextfield
{
    sushiPicIdArray = [NSMutableArray array];
    sushiPicFarmArray = [NSMutableArray array];
    sushiPicServerArray = [NSMutableArray array];
    sushiPicSecretArray = [NSMutableArray array];
    
    NSString *allParts = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=072e43ef1d3d6c21afd0a0e704e2730f&tags=sushi&text=dynamite+roll&format=json&nojsoncallback=1&auth_token=72157633797958328-eff299d43d8ea864&api_sig=4a8739e8c0e062134119dce4ce5fbf82"];
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
         
         NSString *flickTestUrlString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg", sushiPicFarmArray[0],sushiPicServerArray[0],sushiPicIdArray[0],sushiPicSecretArray[0]];
         NSLog(@"%@",flickTestUrlString);
         
         NSURL *urlPic = [NSURL URLWithString:flickTestUrlString];
         NSData *imageData = [NSData dataWithContentsOfURL:urlPic];
         UIImage *instaPhoto = [[UIImage alloc] initWithData:imageData];
         self.flickrImage.image = instaPhoto;
     }];
}


@end
