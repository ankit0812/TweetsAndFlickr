//
//  SecondDetailViewController.m
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 8/3/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "SecondDetailViewController.h"

@interface SecondDetailViewController ()

@end

@implementation SecondDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tester2.text=_actualTester2;
    _tester2.editable = NO;
    _tester2.dataDetectorTypes = UIDataDetectorTypeLink;
    
    
    _tester3.text=_actualTester3;
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_actualTester3]]];
    
    _imageView.image = image;
    
    _tester4.text=_actualTester4;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
