//
//  AlbumListCell.h
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 25.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *albumImage;
@property (strong, nonatomic) IBOutlet UILabel *albumName;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void)updateCell;

@end
