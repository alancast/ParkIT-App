//
//  ParkingSpacesViewController.m
//  parkit
//
//  Created by allancas on 6/16/14.
//  Copyright (c) 2014 Cisco. All rights reserved.
//

#import "ParkingSpacesViewController.h"

@interface ParkingSpacesViewController ()

@end

@implementation ParkingSpacesViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParkingSpaceCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"Parking Space %d", indexPath.row+1];
    UIButton *favoriteButton = (UIButton *)[cell viewWithTag:103];
    UIImage *starImage=[UIImage imageNamed:@"whiteStar.png"];
    CGSize size=CGSizeMake(favoriteButton.frame.size.width, favoriteButton.frame.size.height);
    [self resizeImage:starImage imageSize:size];
    [favoriteButton setImage:starImage forState:UIControlStateNormal];
    favoriteButton.tag = indexPath.row;
    return cell;
}

-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //here is the scaled image which has been changed to the size specified
    UIGraphicsEndImageContext();
    return newImage;
    
}

- (IBAction)toggleFavorite:(UIButton *)sender
{
    UIImage *starImage;
    if([sender currentImage] == [UIImage imageNamed:@"whiteStar.png"])
    {
        starImage=[UIImage imageNamed:@"yellowStar.png"];
    }
    else
    {
        starImage=[UIImage imageNamed:@"whiteStar.png"];
    }
    CGSize size=CGSizeMake(sender.frame.size.width, sender.frame.size.height);
    [self resizeImage:starImage imageSize:size];
    [sender setImage:starImage forState:UIControlStateNormal];
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

@end
