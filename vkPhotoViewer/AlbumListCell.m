//
//  AlbumListCell.m
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 25.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import "AlbumListCell.h"
#import "InternetProvider.h"

@interface AlbumListCell () <InternetProviderDelegate>

@property (strong, nonatomic) InternetProvider *internetProvider;

@end

@implementation AlbumListCell

@synthesize albumImage;
@synthesize albumName;
@synthesize imageURL;
@synthesize internetProvider;

#pragma mark - Load

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.internetProvider = [InternetProvider new];
        self.internetProvider.delegate = self;
    }
    return self;
}

#pragma mark - Public methods

- (void)updateCell
{
    self.albumImage.image = nil;
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    [self.internetProvider requestWithURL:imageURL];
}

#pragma mark - InternetProvider Delegate

- (void)connectionDidFinishLoading:(NSData *)responseData
{
    self.albumImage.image = [UIImage imageWithData:responseData];
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    self.albumImage.hidden = NO;
}

@end
