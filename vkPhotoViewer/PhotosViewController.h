//
//  PhotosViewController.h
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 26.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumListViewController.h"
#import "AlbumListCell.h"
#import "InternetProvider.h"
#import "Constants.h"

@interface PhotosViewController : AlbumListViewController

@property (strong, nonatomic) NSString *albumId;

@end
