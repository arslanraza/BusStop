//
//  RUServiceParser.h
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RURestKitParser.h"
#import "Location.h"
#import "Line.h"

@interface RUServiceParser : NSObject

/**
 Creates a shared instance of the RUServicesParser class
 */
+ (id)sharedParser;

/**
 Returns a List of all the Bus Stops
 */
- (void)getBusListWithSuccess:(void (^)(NSArray *list))success
                      failure:(void (^)(NSError *error))failure;
@end
