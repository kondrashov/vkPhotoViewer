//
//  BaseInternetController.h
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 28.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InternetProvider.h"

@interface BaseInternetController : UIViewController <InternetProviderDelegate>

@property (strong, nonatomic) InternetProvider *internetProvider;

@end
