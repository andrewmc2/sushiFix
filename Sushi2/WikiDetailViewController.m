//
//  WikiDetailViewController.m
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-29.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "WikiDetailViewController.h"
#import "SushiCollectionViewCell.h"

@interface WikiDetailViewController ()
{
    NSMutableArray *sushiPicIdArray;
    NSMutableArray *sushiPicFarmArray;
    NSMutableArray *sushiPicSecretArray;
    NSMutableArray *sushiPicServerArray;
    
    NSMutableArray *sushiActualPictureArray;
    NSString *jsString;
    
    NSString *htmlContent;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)logArray:(id)sender;


@property (strong, nonatomic) NSOperationQueue *backgroundOperationQueue;

//-(void)putLabelsInScrollView:(int)numberOfLabels;

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
    self.sushiName.text = self.selectedSushiType.name;
    [self addPictureFromFlickr];
    self.backgroundOperationQueue = [[NSOperationQueue alloc] init];
    [self.backgroundOperationQueue setMaxConcurrentOperationCount:1];
    
    //webview
    NSString *sushiNameForWiki = [self.selectedSushiType.name stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@",sushiNameForWiki]];
    htmlContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    self.webView.hidden = YES;
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
    sushiActualPictureArray = [NSMutableArray array];
    
    NSString *searchParameters = [self.selectedSushiType.name stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *searchParametersLowerCase = [searchParameters lowercaseString];
    NSLog(@"%@",searchParametersLowerCase);
    
    NSString *allParts = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=fc646cc96c30c85cdc8def5e57ca7d51&tags=sushi&text=sushi+%@&format=json&nojsoncallback=1",searchParametersLowerCase];
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
         
         for (int i = 0; i < sushiPicFarmArray.count; i++) {
             NSString *flickTestUrlString = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg", sushiPicFarmArray[i],sushiPicServerArray[i],sushiPicIdArray[i],sushiPicSecretArray[i]];
             NSURL *urlPic = [NSURL URLWithString:flickTestUrlString];
             
             NSBlockOperation *myBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
                 NSData *imageData = [NSData dataWithContentsOfURL:urlPic];
                 UIImage *instaPhoto = [[UIImage alloc] initWithData:imageData];
                 
                 NSBlockOperation *mainQueueOperation = [NSBlockOperation blockOperationWithBlock:^{
                     //you don't want to update instance variables from different threads because the main thread could be updating it
                     //therefore get the main thread to do it
                     [sushiActualPictureArray addObject:instaPhoto];
                     [self.collectionView reloadData];
                 }]; //mainQueue block end
                 [[NSOperationQueue mainQueue] addOperation:mainQueueOperation];
             }]; //long block end
             
             [self.backgroundOperationQueue addOperation:myBlockOperation];
         }//for loop end
     }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return sushiActualPictureArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SushiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UIView *cellBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 175)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 175)];
    imageView.image = [UIImage imageNamed:@"japWood.png"];
    [cellBgView addSubview:imageView];
    cell.backgroundView = cellBgView;
    cell.sushiImage.image = [sushiActualPictureArray objectAtIndex:indexPath.item];
    //cell.sushiLabel.text = [sushiPicIdArray objectAtIndex:indexPath.item];

    return cell;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webviewloaded");
    jsString =  [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('p')[0].textContent;"];
    self.wikiText.text = jsString;
    NSLog(@"dfgfd %@",jsString);
    
}

- (IBAction)logArray:(id)sender {
    
    jsString =  [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('p')[0];"];
    self.wikiText.text = jsString;
    NSLog(@"%@",jsString);
}
@end
