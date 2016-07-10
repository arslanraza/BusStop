//
//  RUServiceParser.m
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import "RUServiceParser.h"
#import "Location.h"
#import "Line.h"

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
//    @property (nonatomic, strong) NSNumber *lat;
//    @property (nonatomic, strong) NSNumber *lon;
//    @property (nonatomic, strong) NSString *subtitle;
//    
//    @property (nonatomic, strong) NSArray *lines;

    // 1
    RKObjectMapping *locationMapping = [[RURestKitParser shareParser]
                                        addMappingForClass:[Location class]
                                        withAttributeMappingFromDictionary:@{@"locationID":@"id"
                                                                             , @"title":@"title"
                                                                             , @"lat":@"lat"
                                                                             , @"lon":@"lon"
                                                                             , @"subtitle":@"subtitle"
                                                                             , @"lines":@"lines"
                                                                             }
                                        ];
    
    
    // 2
    [[RURestKitParser shareParser] addResponseDescriptorWithMapping:locationMapping
                                                             method:RKRequestMethodGET
                                                        pathPattern:nil
                                                            keyPath:@"locations"
                                                        statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    // 3
    [[RURestKitParser shareParser]
     getObjectsAtPath:path
     parameters:nil
     requestMethod:RKRequestMethodGET
     success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
//        NSLog(@"Success : %@", operation.HTTPRequestOperation.responseString);
         
         NSArray *locations = [mappingResult.dictionary valueForKey:@"locations"];
         Location *location = locations.firstObject;
         if (location) {
             NSLog(@"%@", location);
         }
        
         if (success) {
             success(nil);
         }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failure : %@ -- Error: %@", operation.HTTPRequestOperation.responseString, error.localizedDescription);
        if (failure) {
            failure(error);
        }
       
    }];
}

@end
