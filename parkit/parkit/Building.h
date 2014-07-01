//
//  Building.h
//  ParkIT
//
//  Created by allancas on 6/9/14.
//  Copyright (c) 2014 Cisco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Building : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *spots;

@end
