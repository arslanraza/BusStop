//
//  RUObjectMapping.m
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import "RUObjectMapping.h"
#import "RUServiceParser.h"

@implementation RUObjectMapping

#pragma mark - Private Methods

+ (RKObjectMapping*)getMappingForClass:(Class)class withAttributeMappingFromDictionary:(NSDictionary*)dictionary {
    RKObjectMapping *mapping = [[RURestKitParser shareParser]
                                addMappingForClass:class
                                withAttributeMappingFromDictionary:dictionary];
    return mapping;
}

#pragma mark - Life Cycle Methods


#pragma mark - Class Methods

+ (RKObjectMapping*)getLocationMapping {
    return [self
            getMappingForClass:[Location class]
            withAttributeMappingFromDictionary:@{@"id":@"locationID"
                                                 , @"title":@"title"
                                                 , @"lat":@"lat"
                                                 , @"lon":@"lon"
                                                 , @"subtitle":@"subtitle"
                                                 , @"lines":@"lines"
                                                 }
            ];
}
+ (RKObjectMapping*)getLineMapping {
    return [self
            getMappingForClass:[Line class]
            withAttributeMappingFromDictionary:@{@"":@""
                                                 }
            ];
}

#pragma mark - Public Methods


@end
