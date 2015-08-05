//
//  SecondDetailViewController.h
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 8/3/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondDetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITextView *tester3;

@property (weak, nonatomic) IBOutlet UITextView *tester2;

@property (weak, nonatomic) IBOutlet UITextView *tester4;



- (IBAction)backButton:(id)sender;


@property (weak,nonatomic) NSString *actualTester2;

@property (weak,nonatomic) NSString *actualTester3;

@property (weak,nonatomic) NSString *actualTester4;

@end
