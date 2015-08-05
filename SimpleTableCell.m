//
//  SimpleTableCell.m
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 8/3/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell

@synthesize textTweet;
@synthesize nameTweet;
@synthesize imageSender;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
