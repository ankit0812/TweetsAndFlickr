//
//  FirstViewController.m
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 7/31/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "FirstViewController.h"
#import "Flickr.h"
#import "FlickrImages.h"
#import "FlickrCell.h"
#import "FlickrDetailViewController.h"

@interface FirstViewController (){
    NSMutableArray *image;
}
@property(nonatomic, strong) NSMutableArray *searchResults;

@property(nonatomic, strong) NSMutableArray *searches;

@property(nonatomic, strong) Flickr *flickr;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searches = [@[] mutableCopy];          //search is an array which will keep all the searched items in it to be used later
    self.searchResults = [@{} mutableCopy];     //searchResults keeps the details of each search item
    self.flickr = [[Flickr alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

       
}

#pragma mark - UITextFieldDelegate methods

- (BOOL) textFieldShouldReturn:(UITextField *)textField             //this will search the flikr for items
{
    [_searches removeAllObjects];
    [self.collectionView reloadData];
    
    
    UIActivityIndicatorView *spinner=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [_collectionView addSubview:spinner];
    spinner.frame=_collectionView.bounds;
    
    [spinner startAnimating];
    
    if([self connectedToInternet]==YES)
    {
    [self.flickr searchFlickrForTerm:textField.text completionBlock:^(NSString *searchTerm, NSArray *results, NSError *error)
     {

         [spinner removeFromSuperview];
         
         if(results && [results count] > 0)                //checks if any result for the query key is found or not
         {
             if(![self.searches containsObject:searchTerm])       //if the key was not searched before then it will be added to searches array
             {
                 [self.searches insertObject:searchTerm atIndex:0];
                 self.searchResults=(NSMutableArray *) results;
                 
                 NSLog(@"Found %lu photos matching %@", (unsigned long)[results count],searchTerm);
                 
             }
             
             dispatch_async(dispatch_get_main_queue(), ^         //images are fetched from flickr, so now reloading the collection to
                            {                                                   //show the searched data
                                
                                [self.collectionView reloadData];
                            });
         }
         else
         {
             NSLog(@"Error searching Flickr: %@", error.localizedDescription);
         }
     }];
    //[_spinner stopAnimating];
    [textField resignFirstResponder];
    _textField.text=@"";
   
    return YES;
    }
    else
    {
        NSString *error;
        
        error = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",
                 @"Not Connected to Internet",
                 @"Or", @"Not Logged on Twitter",@"Try Again"];
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:error
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
        return NO;
    }
    
}

#pragma mark - Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{                       //tells the number of sections to be returned for data to be displayed
    
   
  //  NSString *searchTerm = self.searches[section];                      //fetching search key from search array
    return [self.searchResults count];                      //now looking for the sarch key in dictionary
 
    
    
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return [self.searches count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{                         //collection view cells are put in reusable queue and deqeued when used
   // [spinner startAnimating];
   
    FlickrCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FlickrCell" forIndexPath:indexPath];
  //  NSString *searchTerm = self.searches[indexPath.section];
    cell.photo = self.searchResults[indexPath.row];
    
//NSLog(@" here goes the image %@",cell.photohumbnail);
    
 /*   UIImageView *ImageView = cell.photo.thumbnail;
    ImageView.image = [UIImage imageNamed:[image objectAtIndex:indexPath.row]];*/
   // [image addObject:(UIImage *)cell.photo.thumbnail];
   // NSLog(@" here goes the image %@",image);

    
    return cell;
}


#pragma mark – FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath                        //different images has different size so changing the size of cell accordingly
{
   /// NSString *searchTerm = self.searches[indexPath.section];
    
   // FlickrImages *photo =self.searchResults[indexPath.row];
    
    CGSize retval = CGSizeMake(100, 100);
    //if obtained picture is of 0 size then showing a blank area of 100X100 size
    
   // [spinner stopAnimating];
    return retval;
    
    
}


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);            //managing spacing around the cell
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"imageClicked"])
    {
        NSArray *indexPaths=[self.collectionView indexPathsForSelectedItems];
        
        FlickrDetailViewController *imageSelected=segue.destinationViewController;
        NSIndexPath *path=[indexPaths objectAtIndex:0];
        
        imageSelected.collect=[self.searchResults objectAtIndex:path.row];
        
        
        
      //  NSLog(@"%d",[image count]);
        
    /*
        NSArray *indexPaths=[self.collectionView indexPathsForSelectedItems];
        flickrImageClick *imageSelected=segue.destinationViewController;
        NSIndexPath *path=[indexPaths objectAtIndex:0];
        imageSelected.collect=[self.searchResults objectAtIndex:path.row];*/
      
        
    }
    
}

- (BOOL) connectedToInternet
{
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"] encoding:NSUTF8StringEncoding error:nil];
    return ( URLString != NULL ) ? YES : NO;
}
@end

