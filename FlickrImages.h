//
//  FlickrImages.h
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 7/31/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FlickrImages : NSObject

@property(nonatomic,strong) UIImage *thumbnail;
@property(nonatomic,strong) UIImage *largeImage;
@property(nonatomic) long long photoID;
@property(nonatomic) NSInteger farm;
@property(nonatomic) NSInteger server;
@property(nonatomic,strong) NSString *secret;

@end
