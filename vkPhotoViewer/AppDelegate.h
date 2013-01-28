//
//  AppDelegate.h
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 25.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@class LoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (assign, nonatomic) NetworkStatus netStatus;
@property (strong, nonatomic) Reachability  *hostReach;

- (void)updateInterfaceWithReachability: (Reachability*) curReach;

@end
