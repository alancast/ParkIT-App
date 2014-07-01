//
//  BuildingInfoViewController.h
//  ParkIT
//
//  Created by allancas on 6/10/14.
//  Copyright (c) 2014 Cisco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildingInfoViewController : UIViewController

{
    struct buildingInfo
    {
        __unsafe_unretained NSString *buildingName;
        __unsafe_unretained NSString *addressLine1;
        __unsafe_unretained NSString *addressLine2;
        __unsafe_unretained NSString *addressLine3;
        __unsafe_unretained NSString *pictureName;
    };
}

@property int index;

@end
