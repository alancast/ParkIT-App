//
//  BuildingInfoViewController.m
//  ParkIT
//
//  Created by allancas on 6/10/14.
//  Copyright (c) 2014 Cisco. All rights reserved.
//

#import "BuildingInfoViewController.h"

@interface BuildingInfoViewController ()

@end

@implementation BuildingInfoViewController

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
    struct buildingInfo buildingsArray[12];
    NSArray *buildingNames;
    buildingNames = @[@"1", @"2", @"3", @"4", @"5", @"9", @"10", @"11", @"12", @"21", @"J", @"K"];
    NSArray *buildingAdresses;
    buildingAdresses = @[@"3850 Zanker Road", @"3800 Zanker Road", @"225 East Tasman Drive", @"275 East Tasman Drive", @"325 East Tasman Drive", @"260 East Tasman Drive", @"300 East Tasman Drive", @"350 East Tasman Drive", @"400 East Tasman Drive", @"771 Alder Drive", @"255 West Tasman Drive", @"225 West Tasman Drive"];

    for(int i=0; i<12; i++)
    {
        buildingsArray[i].addressLine1 = buildingAdresses[i];
        buildingsArray[i].buildingName = [NSString stringWithFormat:@"Building %@", buildingNames[i]];
        buildingsArray[i].pictureName = [NSString stringWithFormat:@"building%@.jpg", buildingNames[i]];
        buildingsArray[i].addressLine2 = @"San Jose, California 95134";
        buildingsArray[i].addressLine3 = @"United States";
    }
    buildingsArray[9].addressLine2 = @"Milpitas, California 95035";
    //Name
    UILabel *name = [[UILabel alloc] init];
    [name setFrame:CGRectMake(0,70,self.view.frame.size.width,20)];
    name.textColor=[UIColor blackColor];
    [self.view addSubview:name];
    name.text= buildingsArray[self.index].buildingName;
    name.textAlignment = NSTextAlignmentCenter;
    //Picture
    UIImage *buildingImage=[UIImage imageNamed:buildingsArray[self.index].pictureName];
    CGSize size=CGSizeMake(220, 160);
    [self resizeImage:buildingImage imageSize:size];
    UIImageView *buildingImageView = [[UIImageView alloc] initWithImage:buildingImage];
    buildingImageView.frame = CGRectMake(50, 90, 220, 160);
    [self.view addSubview:buildingImageView];
    //Adress Line 1
    UILabel *addr1 = [[UILabel alloc] init];
    [addr1 setFrame:CGRectMake(0,255,self.view.frame.size.width,20)];
    addr1.textColor=[UIColor blackColor];
    [self.view addSubview:addr1];
    addr1.text= buildingsArray[self.index].addressLine1;
    addr1.textAlignment = NSTextAlignmentCenter;
    //Adress Line 2
    UILabel *addr2 = [[UILabel alloc] init];
    [addr2 setFrame:CGRectMake(0,275,self.view.frame.size.width,20)];
    addr2.textColor=[UIColor blackColor];
    [self.view addSubview:addr2];
    addr2.text= buildingsArray[self.index].addressLine2;
    addr2.textAlignment = NSTextAlignmentCenter;
    //Adress Line 3
    UILabel *addr3 = [[UILabel alloc] init];
    [addr3 setFrame:CGRectMake(0,295,self.view.frame.size.width,20)];
    addr3.textColor=[UIColor blackColor];
    [self.view addSubview:addr3];
    addr3.text= buildingsArray[self.index].addressLine3;
    addr3.textAlignment = NSTextAlignmentCenter;
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

@end
