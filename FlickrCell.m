//
//  FlickrCell.m
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 7/31/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "FlickrCell.h"
#import "FlickrImages.h"

@implementation FlickrCell
-(void) setPhoto:(FlickrImages *)photo {     //to assign the image fetched from flickr to our local image view in UICollection View Controller
    
    if(_photo != photo) {
        _photo = photo;
    }
    self.imageView.image = _photo.thumbnail;
}
@end
