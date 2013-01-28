//
//  AlbumListViewController.m
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 25.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import "AlbumListViewController.h"
#import "AlbumListCell.h"
#import "PhotosViewController.h"

static NSString* albumCellIdentifier = @"AlbumCell";

@interface AlbumListViewController ()

@end

@implementation AlbumListViewController

@synthesize jsonArray;
@synthesize albumList;
@synthesize internetProvider;
@synthesize stringURL;

#pragma  mark - Load

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Album List";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:vkLoginNotification object:nil];

    [self.albumList registerNib:[UINib nibWithNibName:@"AlbumListCell" bundle:nil] forCellReuseIdentifier:albumCellIdentifier];
    
    [self configureTable];
    
    [self.internetProvider requestWithURL:self.stringURL];
}

#pragma mark - Methods

- (void)configureTable
{
    self.stringURL = [NSString stringWithFormat:
                      @"https://api.vk.com/method/photos.getAlbums?uid=%@&need_covers=1&access_token=%@",
                      [[NSUserDefaults standardUserDefaults] objectForKey:vkUserId],
                      [[NSUserDefaults standardUserDefaults] objectForKey:vkAccessToken]];
}

- (void)configureCell:(AlbumListCell *)cell withIndex:(NSIndexPath *)indexPath
{
    cell.imageURL = [self.jsonArray[indexPath.row] objectForKey:@"thumb_src"];
    cell.albumName.text = [self.jsonArray[indexPath.row] objectForKey:@"title"];
}

#pragma mark - InternetProvider Delegate

- (void)connectionDidFinishLoading:(NSData *)responseData
{
    NSString *dataString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", dataString);

    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseData
                                                             options:NSJSONReadingMutableContainers
                                                               error:nil];
    self.jsonArray = [jsonDict objectForKey:@"response"];
    [self.albumList reloadData];

    NSLog(@"%@", self.jsonArray);
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jsonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumListCell *cell = (AlbumListCell *) [self.albumList dequeueReusableCellWithIdentifier:albumCellIdentifier];

    [self configureCell:cell withIndex:indexPath];
    [cell updateCell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
    PhotosViewController *photosViewController = [[PhotosViewController alloc] initWithNibName:@"AlbumListViewController" bundle:nil];
    photosViewController.title = [self.jsonArray[indexPath.row] objectForKey:@"title"];
    [photosViewController setAlbumId:[self.jsonArray[indexPath.row] objectForKey:@"aid"]];
    [self.navigationController pushViewController:photosViewController animated:YES];
}

@end
