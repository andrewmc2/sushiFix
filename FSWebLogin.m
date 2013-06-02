//
//  FSWebLogin.m
//  Sushi2
//
//  Created by Craig on 6/1/13.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "FSWebLogin.h"

@interface FSWebLogin ()
{
    NSString *CLIENT_ID;
    NSString *CALLBACK_URL;
}
@property (nonatomic, readwrite, retain) UIWebView *webView;


@end

@implementation FSWebLogin


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    CLIENT_ID = @"D0XU5MW33I35U5LX42QX4SHUWETLZQK4LKM3BUCIUII4ANQM";
    CALLBACK_URL = @"app://testapp123";
    
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    NSString *authenticateURLString = [NSString stringWithFormat:@"https://foursquare.com/oauth2/authenticate?client_id=%@&response_type=token&redirect_uri=%@", CLIENT_ID, CALLBACK_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:authenticateURLString]];
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.webView = nil;
}

#pragma mark - Web view delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.scheme isEqualToString:@"itms-apps"]) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *URLString = [[self.webView.request URL] absoluteString];
    NSLog(@"--> %@", URLString);
    if ([URLString rangeOfString:@"access_token="].location != NSNotFound) {
        NSString *accessToken = [[URLString componentsSeparatedByString:@"="] lastObject];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:accessToken forKey:@"access_token"];
        [defaults synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
