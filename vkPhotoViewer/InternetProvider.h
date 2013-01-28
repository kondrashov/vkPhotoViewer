//
//  URLConnection.h
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 26.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InternetProviderDelegate <NSObject>

- (void)connectionDidFinishLoading:(NSData*)responseData;

@optional
- (void)connectiondidFailWithError:(NSError *)error;

@end

@interface InternetProvider : NSObject <NSURLConnectionDelegate>

@property (strong, nonatomic) NSMutableData *responseData;
@property (weak, nonatomic) id<InternetProviderDelegate> delegate;

- (void)requestWithURL:(NSString*)stringURL;

@end
