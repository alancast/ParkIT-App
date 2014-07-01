//
//  ParkingViewController.m
//  ParkIT
//
//  Created by allancas on 6/9/14.
//  Copyright (c) 2014 Cisco. All rights reserved.
//

#import "ParkingViewController.h"
#import "Building.h"
#import "BuildingInfoViewController.h"
#import "ParkingSpacesViewController.h"

@interface ParkingViewController ()

@end

@implementation ParkingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *buildingNames = @[@"1", @"2", @"3", @"4", @"5", @"9", @"10", @"11", @"12", @"21", @"J", @"K"];
    int numBuildings = [buildingNames count];
    self.buildings = [NSMutableArray arrayWithCapacity:numBuildings];
    
    for(int i=0; i<numBuildings; i++)
    {
        Building *building = [[Building alloc] init];
        building.name = [NSString stringWithFormat:@"Building %@", buildingNames[i]];
        [self.buildings addObject:building];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.buildings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuildingCell"];
    
    Building *building = (self.buildings)[indexPath.row];
    cell.textLabel.text = building.name;
    UIButton *infoButton = (UIButton *)[cell viewWithTag:102];
    infoButton.tag = indexPath.row;
    
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

- (IBAction)handleInfoButtonClick:(UIButton*)sender
{
    BuildingInfoViewController *switchViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"buildingInfoViewController"];
    switchViewController.index = sender.tag;
    [self.navigationController pushViewController:switchViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ParkingSpacesViewController *switchViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"parkingSpacesViewController"];
    switchViewController.index = indexPath.row;
    [[self navigationController] pushViewController:switchViewController animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
