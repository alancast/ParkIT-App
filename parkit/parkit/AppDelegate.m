//
//  AppDelegate.m
//  ParkIT
//
//  Created by allancas on 6/6/14.
//  Copyright (c) 2014 Cisco. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ParkingViewController.h"
#import "Building.h"
@import CoreLocation;
@import CoreBluetooth;

@interface AppDelegate () <CLLocationManagerDelegate, CBPeripheralManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@property (strong, nonatomic) CLBeaconRegion *transmitRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    _tabBarController = [mainStoryboard instantiateViewControllerWithIdentifier:@"mainTabBarController"];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"]
                                                                           major:0
                                                                           minor:0
                                                                      identifier:@"PiBeacon"];
    [self.locationManager startMonitoringForRegion:beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
    
    
    /*
    NSDictionary *advertisingData = @{CBAdvertisementDataLocalNameKey:@"my-peripheral",
                                      CBAdvertisementDataServiceUUIDsKey:@[[CBUUID UUIDWithString:@"74278BDA-B644-4520-8F0C-720EAF059935"]]};
    // Start advertising over BLE
    [self.peripheralManager startAdvertising:advertisingData];
    */
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = @"Parking Spot 3 is available";
        notification.soundName = @"Default";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
    [self initBeacon];
    self.beaconPeripheralData = [self.transmitRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

- (void)initBeacon
{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"74278BDA-B644-4520-8F0C-720EAF059935"];
    self.transmitRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:0
                                                                minor:0
                                                           identifier:@"MyBeacon"];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
        [self performSelector:@selector(noAdvertising)  withObject:nil afterDelay:10.0];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
    }
}

-(void)noAdvertising
{
    [self.peripheralManager stopAdvertising];
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"content---%@", token);
    [[NSUserDefaults standardUserDefaults] setObject:token    forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];    
}

@end
