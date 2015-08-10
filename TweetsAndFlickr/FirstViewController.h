//
//  FirstViewController.h
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 7/31/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrCell.h"

@interface FirstViewController : UIViewController <UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, weak) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

