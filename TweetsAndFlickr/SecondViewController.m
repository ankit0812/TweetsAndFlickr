//
//  SecondViewController.m
//  TweetsAndFlickr
//
//  Created by optimusmac4 on 7/31/15.
//  Copyright (c) 2015 optimusmac4. All rights reserved.
//

#import "SecondViewController.h"
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#import "SecondDetailViewController.h"

#import "SimpleTableCell.h"

@interface SecondViewController ()


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.tweetTableView.estimatedRowHeight = 200;
    self.tweetTableView.rowHeight = UITableViewAutomaticDimension;
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 
    [self getTimeLine];
   
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getTimeLine
{
    
    [_spinner startAnimating];
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType
                                     options:nil completion:^(BOOL granted, NSError *error){
         if ((granted == YES) || (accountType==nil))
         {
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0 && [self connectedToInternet]==YES)
             {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
               //  NSString *query=@"Optimusmobili6ty";
               //  NSString *encodedQuery = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
              //   NSString *urlString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/search/tweets.json?q=%@", encodedQuery];
                 
                 NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
                 
                 NSMutableDictionary *parameters =
                 [[NSMutableDictionary alloc] init];
                 [parameters setObject:@"40" forKey:@"count"];
                 [parameters setObject:@"1" forKey:@"include_entities"];
                 
                 SLRequest *postRequest = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodGET
                                           URL:requestURL parameters:parameters];
                 
                 postRequest.account = twitterAccount;
                
                 [postRequest performRequestWithHandler:
                  ^(NSData *responseData, NSHTTPURLResponse
                    *urlResponse, NSError *error)
                  {
                      self.dataSource = [NSJSONSerialization
                                         JSONObjectWithData:responseData
                                         options:NSJSONReadingMutableLeaves
                                         error:&error];
                      
                      if (self.dataSource.count != 0) {
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [self.tweetTableView reloadData];
                          });
                      }
                  }];
               [_spinner stopAnimating];
       
             } else {
                 
               [_spinner stopAnimating];
        
                     // Handle failure to  get connected to internet
                     
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
             }
             
         } else {
             
            
             
            [_spinner stopAnimating];
       
               // Handle failure to get account access
             
             NSString *error;
             
             error = [NSString stringWithFormat:@"%@\n%@\n%@\n%@",
                      @"Could Not Access The account ",
                      @"Or", @"Check Details &",@"Try Again"];
             
             UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                               message:error
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
             [message show];
         }
      }];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SimpleTableCell";
    
    SimpleTableCell *cell = (SimpleTableCell *)[_tweetTableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    NSDictionary *tweet = _dataSource[[indexPath row]];
    NSDictionary *userInfo = [tweet objectForKey:@"user"];
    
    cell.nameTweet.text = userInfo[@"name"];
    cell.nameTweet.textAlignment = NSTextAlignmentJustified;

    
    cell.textTweet.text = tweet[@"text"];
    cell.textTweet.textAlignment = NSTextAlignmentJustified;
    
    NSString *temp=userInfo[@"profile_image_url"];     
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:temp]]];
    cell.imageSender.image =image;
    
   // NSLog(@"in cell for row");
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSecond"])
    {
        NSIndexPath *indexPath = [self.tweetTableView indexPathForSelectedRow];
        SecondDetailViewController *destViewController = segue.destinationViewController;
        
        NSDictionary *tweet = _dataSource[[indexPath row]];
        
        NSDictionary *userInfo = [tweet objectForKey:@"user"];
        
        destViewController.actualTester2=[_dataSource objectAtIndex:indexPath.row];
       // NSLog(@"%@",destViewController.actualTester2);
        destViewController.actualTester2=tweet[@"text"];
        
        destViewController.actualTester3=[userInfo objectForKey:@"profile_image_url"];
        //NSLog(@"%@",destViewController.actualTester3);
        
        destViewController.actualTester4=[userInfo objectForKey:@"name"];
       // NSLog(@"%@",destViewController.actualTester4);
        
        
     
        
        //   destViewController.actualTester2=tweet[@"text"];
        
        //destViewController.actualImage =[images objectAtIndex:indexPath.row];
    }
}

- (BOOL) connectedToInternet
    {
        NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"] encoding:NSUTF8StringEncoding error:nil];
        return ( URLString != NULL ) ? YES : NO;
    }

@end