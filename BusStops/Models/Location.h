//
//  Location.h
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic, strong) NSString *locationID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lon;
@property (nonatomic, strong) NSString *subtitle;

@property (nonatomic, strong) NSArray *lines;

@end
