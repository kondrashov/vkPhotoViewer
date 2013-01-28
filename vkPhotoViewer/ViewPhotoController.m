//
//  ViewPhotoController.m
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 26.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import "ViewPhotoController.h"
#import "InternetProvider.h"

typedef enum
{
    FullScreenMode,
    FitScreenMode
} ViewMode;

@interface ViewPhotoController () <UIScrollViewDelegate>
{
    ViewMode curentMode;
    UIBarButtonItem *modeButton;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewPhotoController

@synthesize imageURL;
@synthesize internetProvider;
@synthesize activityIndicator;

#pragma mark - Load

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"View photo";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
    
    modeButton = [[UIBarButtonItem alloc] initWithTitle:@"Fit to screen"
                                                  style:UIBarButtonItemStyleDone
                                                 target:self
                                                 action:@selector(flipView)];
   
    self.navigationItem.rightBarButtonItem = modeButton;
    
    [self.internetProvider requestWithURL:self.imageURL];
}

#pragma mark - Actions

-(IBAction)flipView
{
    if(curentMode == FullScreenMode)
    {
        [self setImageMode:FitScreenMode];
        modeButton.title = @"Original size";
    }    
    else
    {
        [self setImageMode:FullScreenMode];
        modeButton.title = @"Fit to screen";
    }
}

#pragma mark - Methods

- (void)setImageMode:(ViewMode)imageMode
{
    switch (imageMode)
    {
        case FullScreenMode:
        {
            CGRect tempFrame;
            tempFrame.size.width = self.imageView.image.size.width;
            tempFrame.size.height = self.imageView.image.size.height;
            
            if(tempFrame.size.height < self.view.frame.size.height)
                tempFrame.origin.y = (self.view.frame.size.height - tempFrame.size.height) / 2.f;
            else
                tempFrame.origin.y = 0;
            
            if(tempFrame.size.width < self.view.frame.size.width)
                tempFrame.origin.x = (self.view.frame.size.width - tempFrame.size.width) / 2.f;
            else
                tempFrame.origin.x = 0;
            
            self.imageView.frame = tempFrame;            
            curentMode = FullScreenMode;
            
            break;
        }

        case FitScreenMode:
        {
            self.imageView.frame = self.view.bounds;
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            curentMode = FitScreenMode;
            
            break;
        }
    }
    [self recountUI];
}

- (void)recountUI
{
    self.scrollView.frame = self.view.bounds;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.imageView.frame.size.width, self.imageView.frame.size.height);
}

#pragma mark - ScrollView delegate

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:scrollView.contentOffset animated:YES];
}

#pragma mark - InternetProvider Delegate

- (void)connectionDidFinishLoading:(NSData *)responseData
{
    self.imageView.image = [UIImage imageWithData:responseData];
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    self.imageView.hidden = NO;

    [self setImageMode:FullScreenMode];
}

@end
