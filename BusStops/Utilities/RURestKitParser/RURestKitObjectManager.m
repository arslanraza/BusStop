//
//  RURestKitObjectManager.m
//  ZemCar
//
//  Created by Arslan Raza on 25/06/2015.
//  Copyright (c) 2015 Arslan Raza. All rights reserved.
//

#import "RURestKitObjectManager.h"

#define kREQUEST_TIME_OUT_INTERVAL          20

@implementation RURestKitObjectManager

- (instancetype)initWithHTTPClient:(AFRKHTTPClient *)client {
    return [super initWithHTTPClient:client];
}

+ (instancetype)sharedManager {
    return [super sharedManager];
}

- (NSMutableURLRequest*)requestWithObject:(id)object method:(RKRequestMethod)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    NSMutableURLRequest *request = [super requestWithObject:object method:method path:path parameters:parameters];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    [request setTimeoutInterval:kREQUEST_TIME_OUT_INTERVAL];
    return request;
}

@end
