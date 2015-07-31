//
//  FlickrCell.h
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 7/31/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@class FlickrImages;
@interface FlickrCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *imageView;      //to manage the image in the collection and displaying the image in collection view
@property (nonatomic, strong) FlickrImages *photo;
@end