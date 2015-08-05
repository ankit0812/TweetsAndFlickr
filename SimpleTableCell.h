//
//  SimpleTableCell.h
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 8/3/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameTweet;

@property (weak, nonatomic) IBOutlet UITextView *textTweet;

@property (weak, nonatomic) IBOutlet UIImageView *imageSender;


@end