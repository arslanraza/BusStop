//
//  RUObjectMapping.h
//  A Class that provides all the Object Mappings for the RestKit Service Parser
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RKObjectMapping.h>

@interface RUObjectMapping : NSObject

+ (RKObjectMapping*)getLocationMapping;
+ (RKObjectMapping*)getLineMapping;

@end
