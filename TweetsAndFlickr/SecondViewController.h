//
//  SecondViewController.h
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 7/31/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface SecondViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tweetTableView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;




@property (strong, nonatomic) NSArray *dataSource;


@end

