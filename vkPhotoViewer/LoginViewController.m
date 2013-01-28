//
//  ViewController.m
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 25.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import "LoginViewController.h"
#import "AlbumListViewController.h"

#define appID @"3378750"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UILabel *loginLabel;
@property (strong, nonatomic) IBOutlet UIButton *albumBtn;
@property (strong, nonatomic) IBOutlet UIButton *logoutBtn;

@end

@implementation LoginViewController

@synthesize activityIndicator;

#pragma mark - Load

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.title = @"Login";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(alreadyLogin)
                                                 name:vkLoginNotification
                                               object:nil];    
    [self.activityIndicator startAnimating];
    [self startLogin];    
}

- (void)startLogin
{
    NSString *authLink = [NSString stringWithFormat:@"https://oauth.vk.com/authorize?client_id=%@&scope=8197&redirect_uri=http://api.vk.com/blank.html&display=touch&response_type=token", appID];
    NSURL *url = [NSURL URLWithString:authLink];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)alreadyLogin
{
    self.loginLabel.hidden = NO;
    self.albumBtn.hidden = NO;
    self.logoutBtn.hidden = NO;
}

#pragma mark - WebView delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *webViewURL = webView.request.URL.absoluteString;
    
    NSString *cancelURL = @"http://api.vk.com/blank.html#error=access_denied&error_reason=user_denied&error_description=User%20denied%20your%20request";
    
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    self.webView.hidden = NO;
    
    NSLog(@"URL = %@", webViewURL);
    
    if([webViewURL rangeOfString:@"access_token"].location != NSNotFound)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        self.webView.hidden = YES;
        
        NSString *accessToken = [self stringBetweenString:@"access_token="
                                                andString:@"&"
                                              innerString:webView.request.URL.absoluteString];
        
        NSArray *paramArray = [webView.request.URL.absoluteString componentsSeparatedByString:@"&user_id="];
        NSString *userId = [paramArray lastObject];

        if(accessToken && userId)
        {
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:vkAccessToken];
            [[NSUserDefaults standardUserDefaults] setObject:userId forKey:vkUserId];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [self onAlbumBtn:nil];
    }
    else if([webViewURL isEqualToString:cancelURL] ||
            [webViewURL rangeOfString:@"m.vk.com"].location != NSNotFound)
    {
        [self startLogin];
    }

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error connection - %@", error);
    [self startLogin];
}

#pragma mark - Actions

- (IBAction)onAlbumBtn:(id)sender
{
    BOOL animated;
    animated = sender ? YES : NO;
    
    AlbumListViewController *albumListViewController = [[AlbumListViewController alloc] init];
    [self.navigationController pushViewController:albumListViewController animated:animated];
}

- (IBAction)onLogout:(id)sender
{
    self.loginLabel.hidden = YES;
    self.albumBtn.hidden = YES;
    self.logoutBtn.hidden = YES;

    [self startLogin];
}

#pragma mark - Helper methods

- (NSString*)stringBetweenString:(NSString*)start
                       andString:(NSString*)end
                     innerString:(NSString*)str
{
    NSScanner* scanner = [NSScanner scannerWithString:str];
    [scanner setCharactersToBeSkipped:nil];
    [scanner scanUpToString:start intoString:NULL];
    if ([scanner scanString:start intoString:NULL])
    {
        NSString* result = nil;
        if ([scanner scanUpToString:end intoString:&result])
            return result;
    }
    return nil;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
