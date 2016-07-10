//
//  RURestKitObjectManager.h
//  ZemCar
//
//  Created by Arslan Raza on 25/06/2015.
//  Copyright (c) 2015 Arslan Raza. All rights reserved.
//

#import "RKObjectManager.h"

@interface RURestKitObjectManager : RKObjectManager

/**
 Initializes the receiver with the given AFNetworking HTTP client object, adopting the network configuration from the client.
 
 This is the designated initializer. If the `sharedManager` instance is `nil`, the receiver will be set as the `sharedManager`. The default headers and parameter encoding of the given HTTP client are adopted by the receiver to initialize the values of the `defaultHeaders` and `requestSerializationMIMEType` properties.
 
 @param client The AFNetworking HTTP client with which to initialize the receiver.
 @return The receiver, initialized with the given client.
 */
- (instancetype)initWithHTTPClient:(AFRKHTTPClient *)client;

/**
 Return the shared instance of the object manager
 
 @return The shared manager instance.
 */
+ (instancetype)sharedManager;

@end
