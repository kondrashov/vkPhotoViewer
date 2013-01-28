//
//  URLConnection.m
//  vkPhotoViewer
//
//  Created by Artem Kondrashov on 26.01.13.
//  Copyright (c) 2013 Depositphotos. All rights reserved.
//

#import "InternetProvider.h"

@interface InternetProvider ()

@property (strong, nonatomic) NSURLConnection *urlConnection;

@end

@implementation InternetProvider

@synthesize responseData;
@synthesize urlConnection;

#pragma mark - Load

- (void)requestWithURL:(NSString*)stringURL;
{
    self.responseData = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:stringURL]];
    self.urlConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(connectiondidFailWithError:)])
        [self.delegate connectiondidFailWithError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([self.delegate respondsToSelector:@selector(connectionDidFinishLoading:)])
        [self.delegate connectionDidFinishLoading:self.responseData];
}

@end

