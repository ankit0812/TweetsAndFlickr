//
//  Flickr.m
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 7/31/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "Flickr.h"
#import "FlickrImages.h"

#define kFlickrAPIKey @"c436f7e76f7d5c9e3ad510278f838197"         //new flickr API Key obtained from flickr website for my yahoo email

@implementation Flickr


//this method creates a search url for flickr which will be used to search images according to the key

+ (NSString *)flickrSearchURLForSearchTerm:(NSString *) searchTerm


{
    
    searchTerm = [searchTerm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=20&format=json&nojsoncallback=1",kFlickrAPIKey,searchTerm];
    
}



+ (NSString *)flickrPhotoURLForFlickrImages:(FlickrImages *) flickrPhoto size:(NSString *) size

{
    
    if(!size)
        
    {
        
        size = @"m";
        
    }
    
    return [NSString stringWithFormat:@"https://farm%ld.staticflickr.com/%ld/%lld_%@_%@.jpg",(long)flickrPhoto.farm,(long)flickrPhoto.server,flickrPhoto.photoID,flickrPhoto.secret,size];
    
}



- (void)searchFlickrForTerm:(NSString *) term completionBlock:(FlickrSearchCompletionBlock) completionBlock

{
    
    NSString *searchURL = [Flickr flickrSearchURLForSearchTerm:term];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    
    dispatch_async(queue, ^{
        
        NSError *error = nil;
        
        NSString *searchResultString = [NSString stringWithContentsOfURL:[NSURL URLWithString:searchURL]
                                        
                                                                encoding:NSUTF8StringEncoding
                                        
                                                                   error:&error];
        
        if (error != nil) {
            
            completionBlock(term,nil,error);
            
        }
        
        else
            
        {
            
            NSData *jsonData = [searchResultString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *searchResultsDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                               
                                                                              options:kNilOptions
                                               
                                                                                error:&error];
            
            if(error != nil)
                
            {
                
                completionBlock(term,nil,error);
                
            }
            
            else
                
            {
                
                NSString * status = searchResultsDict[@"stat"];
                
                if ([status isEqualToString:@"fail"])
                    
                {
                    
                    NSError * error = [[NSError alloc] initWithDomain:@"FlickrSearch" code:0 userInfo:@{NSLocalizedFailureReasonErrorKey: searchResultsDict[@"message"]}];
                    
                    completionBlock(term, nil, error);
                    
                }
                
                else
                    
                {
                    
                    
                    
                    NSArray *objPhotos = searchResultsDict[@"photos"][@"photo"];
                    
                    NSMutableArray *flickrImages = [@[] mutableCopy];
                    
                    for(NSMutableDictionary *objPhoto in objPhotos)
                        
                    {
                        
                        FlickrImages *photo = [[FlickrImages alloc] init];
                        
                        photo.farm = [objPhoto[@"farm"] intValue];             //details of each image, saving the details to use later
                        
                        photo.server = [objPhoto[@"server"] intValue];
                        
                        photo.secret = objPhoto[@"secret"];
                        
                        photo.photoID = [objPhoto[@"id"] longLongValue];
                        
                        
                        
                        NSString *searchURL = [Flickr flickrPhotoURLForFlickrImages:photo size:@"m"];
                        
                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]
                                             
                                                                  options:0
                                             
                                                                    error:&error];
                        
                        UIImage *image = [UIImage imageWithData:imageData];
                        
                        photo.thumbnail = image;
                        
                        
                        
                        [flickrImages addObject:photo];
                        
                    }
                    
                    
                    
                    completionBlock(term,flickrImages,nil);
                    
                }
                
            }
            
        }
        
    });
    
}



+ (void)loadImageForPhoto:(FlickrImages *)flickrPhoto thumbnail:(BOOL)thumbnail completionBlock:(FlickrImagesCompletionBlock) completionBlock

{
    
    
    
    NSString *size = thumbnail ? @"m" : @"b";
    
    
    
    NSString *searchURL = [Flickr flickrPhotoURLForFlickrImages:flickrPhoto size:size];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    
    dispatch_async(queue, ^{
        
        NSError *error = nil;
        
        
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]
                             
                                                  options:0
                             
                                                    error:&error];
        
        if(error)
            
        {
            
            completionBlock(nil,error);
            
        }
        
        else
            
        {
            
            UIImage *image = [UIImage imageWithData:imageData];
            
            if([size isEqualToString:@"m"])
                
            {
                
                flickrPhoto.thumbnail = image;
                
            }
            
            else
                
            {
                
                flickrPhoto.largeImage = image;
                
            }
            
            completionBlock(image,nil);
            
        }
        
        
        
    });
    
}







@end