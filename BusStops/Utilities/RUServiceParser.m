//
//  RUServiceParser.m
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import "RUServiceParser.h"

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

@end
