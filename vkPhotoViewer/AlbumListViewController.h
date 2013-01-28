//
//  AlbumListViewController.h
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 25.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InternetProvider.h"
#import "BaseInternetController.h"
#include "Constants.h"

@interface AlbumListViewController : BaseInternetController <UITableViewDataSource,
                                                             UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *albumList;
@property (strong, nonatomic) NSArray *jsonArray;
@property (strong, nonatomic) NSString *stringURL;

@end
