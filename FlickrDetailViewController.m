//
//  FlickrDetailViewController.m
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 7/31/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "FlickrDetailViewController.h"
#import "FirstViewController.h"

@interface FlickrDetailViewController ()

@end

@implementation FlickrDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   _imageShow.image=self.collect.thumbnail;
 //_imageShow.image=[UIImage imageNamed:_collect];
    NSLog(@"%@",_imageShow);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveButton:(id)sender {
    
    UIImage *imageToSave = [_imageShow image]; // alternatively, imageView.image
    
    // Save it to the photo album
    UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Image saved to Photos successfully" delegate:nil                                                                                                                                                                                                 cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [myAlertView show];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
