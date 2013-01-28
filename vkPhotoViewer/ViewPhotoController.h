//
//  ViewPhotoController.h
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 26.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseInternetController.h"

@interface ViewPhotoController : BaseInternetController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSString *imageURL;

@end
