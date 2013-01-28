//
//  PhotosCell.h
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 26.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *photoImg;
@property (retain, nonatomic) NSString *imageURL;

- (void)updateCell;

@end
