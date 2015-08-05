//
//  FlickrDetailViewController.h
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 7/31/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrImages.h"

@interface FlickrDetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *imageShow;

- (IBAction)saveButton:(id)sender;

@property (nonatomic,strong) FlickrImages *collect;








@end
