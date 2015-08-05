//
//  Flickr.h
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 7/31/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FlickrImages;

typedef void (^FlickrSearchCompletionBlock)(NSString *searchTerm, NSArray *results, NSError *error);    //results is for saving the stored images count
typedef void (^FlickrImagesCompletionBlock)(UIImage *photoImage, NSError *error);

@interface Flickr : NSObject

// apiKey to store the API Key i.e an application programming interface key (API key) passed in by computer programs calling an API (application programming interface) to identify the calling program, its developer, or its user to the Web site . In this case our website is Flickr

@property(strong) NSString *apiKey;

- (void)searchFlickrForTerm:(NSString *) term completionBlock:(FlickrSearchCompletionBlock) completionBlock;
+ (void)loadImageForPhoto:(FlickrImages *)flickrPhoto thumbnail:(BOOL)thumbnail completionBlock:(FlickrImagesCompletionBlock) completionBlock;
+ (NSString *)flickrPhotoURLForFlickrImages:(FlickrImages *) flickrPhoto size:(NSString *) size;

@end
