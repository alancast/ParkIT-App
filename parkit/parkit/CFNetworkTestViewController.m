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
    // Create the request.
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://10.155.69.185:8080/ParkIT-test/rest/ParkITREST/availability"]];
    // Setting a timeout
    //request.timeoutInterval = 10.0;
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
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
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
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
    [super viewWillAppear:animated];
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://10.155.69.185:8080/ParkIT-test/rest/ParkITREST/availability"]];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self updateUI];
}

@end
