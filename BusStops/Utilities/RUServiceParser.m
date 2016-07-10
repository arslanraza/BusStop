//
//  RUServiceParser.m
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import "RUServiceParser.h"
#import "RUObjectMapping.h"

@implementation RUServiceParser

#pragma mark - Private Methods


#pragma mark - Life Cycle Methods

+ (id)sharedParser {
    
    static RUServiceParser *sharedParser;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedParser = [[RUServiceParser alloc] init];
    });
    
    return sharedParser;
    
}

#pragma mark - Public Methods

- (void)getBusListWithSuccess:(void (^)(NSArray *list))success
                      failure:(void (^)(NSError *error))failure {
    
    NSString *path = @"services/bus";
    
    // Creating Mapping for Location Object
    RKObjectMapping *locationMapping = [RUObjectMapping getLocationMapping];
    
    // Adding the mapping in the respose descritor to be mapped later with the given key path
    [[RURestKitParser shareParser] addResponseDescriptorWithMapping:locationMapping
                                                             method:RKRequestMethodGET
                                                        pathPattern:nil
                                                            keyPath:@"locations"
                                                        statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    // Performs GET request
    [[RURestKitParser shareParser]
     getObjectsAtPath:path
     parameters:nil
     requestMethod:RKRequestMethodGET
     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
//        NSLog(@"Success : %@", operation.HTTPRequestOperation.responseString);
         
         NSArray *locations = [mappingResult.dictionary valueForKey:@"locations"];
         
//         NSSet *titles = [NSSet setWithArray:[locations valueForKeyPath:@"@distinctUnionOfObjects.title"]];
//         NSLog(@"Titles: %@", titles);
         
//         Location *location = locations.firstObject;
//         if (location) {
//             NSLog(@"%@", location);
//         }
        
         if (success) {
             success(locations);
         }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
        if (failure) {
            failure(error);
        }
       
    }];
}

@end
