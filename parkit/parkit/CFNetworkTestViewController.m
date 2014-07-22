//
//  CFNetworkTestViewController.m
//  parkit
//
//  Created by allancas on 6/19/14.
//  Copyright (c) 2014 Cisco. All rights reserved.
//

#import "CFNetworkTestViewController.h"

@interface CFNetworkTestViewController ()
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSMutableArray *boolArray;
@property int whichURL; //1 if for map, 2 if for check in
@end

@implementation CFNetworkTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.whichURL = 1;
    // Create the request.
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://asf-parkit.cisco.com:8080/ParkIT-test/rest/ParkITREST/availability"]];
    // Setting a timeout
    //request.timeoutInterval = 10.0;
    
    // Create url connection and fire request
    NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    self.usernameLabel.text = username;
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.checkInButton.layer.cornerRadius = 5;
    self.checkInBackground.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    if(self.whichURL ==1)
    {
        _responseData = [[NSMutableData alloc] init];
        NSLog(@"receieved one");
    }
    NSLog(@"receieved two");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    if(self.whichURL == 1)
    {
        [_responseData appendData:data];
    }
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    if(self.whichURL == 1)
    {
        _sourceCodeView.text = [[NSString alloc]initWithData:_responseData encoding:NSASCIIStringEncoding];
        
        // convert to JSON
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:nil];
        
        // extract specific value...
        NSArray *results = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
        
        BOOL temp;
        _boolArray = [[NSMutableArray alloc] init];
        for(int i=0; i<[results count];i++)
        {
            NSNumber *trueFalse = [results objectAtIndex:i];
            if([trueFalse boolValue] == 0)
            {
                temp = false;
            }
            else
            {
                temp = true;
            }
            [_boolArray addObject:[NSNumber numberWithBool:temp]];
        }
        [self updateUI];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == _sourceCodeView)
    {
        if ([text isEqualToString:@"\n"])
        {
            [textView resignFirstResponder];
            return NO;
        }
    }
    return YES;
}

- (void)updateUI
{
    BOOL temp;
    for(int i=0; i<[_boolArray count]; i++)
    {
        if(i>7)
        {
            break;
        }
        UIImageView *tempView = (UIImageView *)[self.view viewWithTag:(11+i)];
        temp = [[_boolArray objectAtIndex:i] boolValue];
        if(temp)
        {
            tempView.image = [UIImage imageNamed:@"car.png"];
        }
        else
        {
            tempView.image = nil;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.whichURL = 1;
    [super viewWillAppear:animated];
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://asf-parkit.cisco.com:8080/ParkIT-test/rest/ParkITREST/availability"]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self updateUI];
}

- (IBAction)CheckIn:(id)sender
{
    self.checkInButton.selected = !self.checkInButton.selected;
    //[self.checkInButton setEnabled:NO];
    //[self.checkInButton setTitle:@"Checked In" forState:UIControlStateDisabled];
    //[self.checkInButton setTitle:@"" forState:UIControlStateDisabled];
    [self.checkInButton setTitle:@"" forState:UIControlStateSelected];
    [self.checkInButton setTitle:@"Check In" forState:UIControlStateNormal];
    if(self.checkInButton.selected)
    {
        self.checkInButton.alpha = .5;
        self.checkInBackground.alpha = 0;
        UIImageView *checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check.png"]];
        checkView.alpha = 0.2;
        checkView.contentMode = UIViewContentModeScaleAspectFit;
        checkView.frame = CGRectMake(0.0, 0.0, self.checkInButton.frame.size.width, self.checkInButton.frame.size.height);
        checkView.tag = 1;
        [self.checkInButton addSubview:checkView];
    }
    if(!self.checkInButton.selected)
    {
        self.checkInButton.alpha = 1;
        self.checkInBackground.alpha = 1;
        for (UIView *subView in self.checkInButton.subviews)
        {
            if (subView.tag == 1)
            {
                [subView removeFromSuperview];
            }
        }
    }
    self.whichURL = 2;
    NSDictionary *newDatasetInfo = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"username"], @"username", nil];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:newDatasetInfo options:kNilOptions error:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://asf-parkit.cisco.com:8080/ParkIT-test/rest/ParkITREST/availability"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    
    // print json:
    NSLog(@"JSON summary: %@", [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding]);
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
}
@end
