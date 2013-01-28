//
//  PhotosViewController.m
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 26.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import "PhotosViewController.h"
#import "ViewPhotoController.h"

@interface PhotosViewController ()

@end

@implementation PhotosViewController

@synthesize albumId;
@synthesize albumList;
@synthesize jsonArray;
@synthesize internetProvider;

#pragma mark - Load

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Override parent methods

- (void)configureTable
{
    self.stringURL = [NSString stringWithFormat:
                      @"https://api.vk.com/method/photos.get?uid=%@&aid=%@&access_token=%@",
                      [[NSUserDefaults standardUserDefaults] objectForKey:vkUserId],
                      self.albumId,
                      [[NSUserDefaults standardUserDefaults] objectForKey:vkAccessToken]];
}

- (void)configureCell:(AlbumListCell *)cell withIndex:(NSIndexPath *)indexPath
{
    cell.imageURL = [self.jsonArray[indexPath.row] objectForKey:@"src_big"];
    cell.albumName.hidden = YES;
    cell.albumImage.frame = CGRectMake(85, 10, 150, 150);
    cell.activityIndicator.center = cell.albumImage.center;
}

#pragma mark - TableView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ViewPhotoController *viewPhotoController = [[ViewPhotoController alloc] init];
    viewPhotoController.imageURL = [self.jsonArray[indexPath.row] objectForKey:@"src_big"];
    [self.navigationController pushViewController:viewPhotoController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

@end
