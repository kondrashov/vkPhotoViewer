//
//  PhotosCell.m
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 26.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import "PhotosCell.h"
#import "InternetProvider.h"

@interface PhotosCell () <InternetProviderDelegate>

@property (retain, nonatomic) InternetProvider *internetProvider;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation PhotosCell

@synthesize internetProvider;
@synthesize activityIndicator;
@synthesize imageURL;

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
    self.photoImg.image = nil;
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    [self.internetProvider requestWithURL:imageURL];
}

#pragma mark - InternetProvider Delegate

- (void)connectionDidFinishLoading:(NSData *)responseData
{
    self.photoImg.image = [UIImage imageWithData:responseData];
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    self.photoImg.hidden = NO;
}

#pragma mark - Unload

- (void)dealloc
{
    [internetProvider release];
    [activityIndicator release];
    [imageURL release];
    [_photoImg release];
    [super dealloc];
}
@end
