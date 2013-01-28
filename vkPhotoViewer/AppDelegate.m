//
//  AppDelegate.m
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 25.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"

@implementation AppDelegate

@synthesize window;
@synthesize loginViewController;
@synthesize navigationController;
@synthesize netStatus;
@synthesize hostReach;

#pragma mark - Load

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    self.hostReach = [Reachability reachabilityWithHostName: @"vk.com"];
    [hostReach startNotifier];
    [self updateInterfaceWithReachability: hostReach];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];

    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.loginViewController];
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - Reachability

- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    self.netStatus = [curReach currentReachabilityStatus];
}

- (void) reachabilityChanged: (NSNotification* )note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    if([curReach currentReachabilityStatus] == NotReachable)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No internet connection or VK server is unavailable" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }    
    [self updateInterfaceWithReachability: curReach];
}

#pragma mark - Unload

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];    
}

@end
