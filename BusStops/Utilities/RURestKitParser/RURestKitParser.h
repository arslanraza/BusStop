//
//  RURestKitParser.h
//  CoffeeKit
//
//  Created by Arslan Raza on 28/05/2015.
//  Copyright (c) 2015 Arslan Raza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "RURestKitObjectManager.h"

@interface RURestKitParser : NSObject

+ (RURestKitParser*)shareParser;

- (RKObjectMapping*)addMappingForClass:(Class)class withAttributeMappingFromArray:(NSArray*)arrayAttributedMapping;
- (RKObjectMapping*)addMappingForClass:(Class)class withAttributeMappingFromDictionary:(NSDictionary*)dictionary;

/**
 Adds Entity mapping for Core Data Models
 @param class: The class param to which the model mapping is requred
 @param arrayAttributedMapping: NSArray object for the Model's attributes mapping
 @return RKEntityMapping: returns a newly creating instance of RKObjectMapping
 */
- (RKEntityMapping*)addEntityMappingForClass:(Class)class withAttributeMappingFromArray:(NSArray*)arrayAttributedMapping;
/**
 Adds Entity mapping for Core Data Models
 @param class: The class param to which the model mapping is requred
 @param dictionary: NSDictionary object for the Model's attributes mapping
 @return RKEntityMapping: returns a newly creating instance of RKObjectMapping
 */
- (RKEntityMapping*)addEntityMappingForClass:(Class)class withAttributeMappingFromDictionary:(NSDictionary*)dictionary;

- (RKResponseDescriptor*)addResponseDescriptorWithMapping:(RKMapping*)mapping method:(RKRequestMethod)method pathPattern:(NSString*)pathPattern keyPath:(NSString*)keyPath statusCodes:(NSIndexSet*)statusCodes;

/**
 Initializes an `AFHTTPClient` and 'RKObjectManager' object with the specified base URL.
 
 This is the designated initializer.
 
 @param url The base URL for the HTTP client. This argument must not be `nil`.
 
 @return The newly-initialized RKObjectManager
 */
- (RKObjectManager*)configureRestKitWithBaseURL:(NSURL*)baseURL;


/**
 Use this method to get Restful objects with mapping
 
 @param path: POST path of BaseURL
 @param parameters: set request body parameters
 @param success: A block object to be executed when the request operation finishes successfully. This block has no return value and takes two arguments: the created object request operation and the `RKMappingResult` object created by object mapping the response data of request.
 @param failure: A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the resonse data. This block has no return value and takes two arguments:, the created request operation and the `NSError` object describing the network or parsing error that occurred.
 */
- (void)getObjectsAtPath:(NSString *)path
                 parameters:(NSDictionary *)parameters
                    success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                    failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;


/**
 Initializes an `AFHTTPClient` and 'RKObjectManager' object with the specified base URL.
 
 This is the designated initializer.
 
 @param url The base URL for the HTTP client. This argument must not be `nil`.
 @param Test Param 2
 @return The newly-initialized RKObjectManager
 */
- (void)getObjectsAtPath:(NSString *)path
              parameters:(NSDictionary *)parameters
           requestMethod:(RKRequestMethod)requestMethod
                 success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                 failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

/**
 Sends POST request to server
 
 @param path: POST path of BaseURL
 @param parameters: set request body parameters
 @param requestMethod: Sets the method for Request
 @param success A block object to be executed when the request operation finishes successfully. This block has no return value and takes two arguments: the created object request operation and the `RKMappingResult` object created by object mapping the response data of request.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the resonse data. This block has no return value and takes two arguments:, the created request operation and the `NSError` object describing the network or parsing error that occurred.
 
 @warning Instances of `RKObjectRequestOperation` are not capable of mapping the loaded `NSHTTPURLResponse` into a Core Data entity. Use an instance of `RKManagedObjectRequestOperation` if the response is to be mapped using an `RKEntityMapping`.
 */
- (void)loadRequestWithPath:(NSString*)path
                 parameters:(NSDictionary*)parameters
              requestMethod:(RKRequestMethod)requestMethod
                    success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                    failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

/**
 Use this method to set Authorization header with Token for HTTPClient
 
 @param aHaeder: String value for Header
 */
- (void)setAuthorizationHeaderWithToken:(NSString*)aHeader;

/**
 Use this method to Cancel a RestKit Request
 
 @param path: NSString value of path whose operation needs to be cancelled
 @param method: RKRequestMethod type of Request
 */
- (void)cancelOperationForPath:(NSString*)path method:(RKRequestMethod)method;

/**
 Use this method to get Objects from Local Dictionary
 
 @param path: NSString value of path whose operation needs to be cancelled
 @param method: RKRequestMethod type of Request
 */
- (void)getObjectsforKeyPath:(NSString*)keyPath
                 withMapping:(RKObjectMapping*)objectMapping
             objectDictionary:(NSDictionary*)objectDictionary
                      success:(void(^)(RKMappingResult *result))success
                      failure:(void(^)(NSError *error))failure;

@end
