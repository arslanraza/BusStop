//
//  RURestKitParser.m
//  CoffeeKit
//
//  Created by Arslan Raza on 28/05/2015.
//  Copyright (c) 2015 Arslan Raza. All rights reserved.
//

#import "RURestKitParser.h"

@interface RURestKitParser ()

@property (nonatomic, strong) RURestKitObjectManager *restManager;

@end

@implementation RURestKitParser

static RURestKitParser *_sharedInstance = nil;

#pragma mark - Private Methods

- (NSError*)createErrorWithDomain:(NSString*)domain localizeDescription:(NSString*)description {
    NSMutableDictionary *details = [NSMutableDictionary dictionary];
    [details setValue:description?description:@"" forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:domain code:200 userInfo:details];
    return error;
}

- (RKObjectMapping*)addEmptyMappingWithRequestMethod:(RKRequestMethod)requestMethod {
    
    RKObjectMapping * emptyMapping = [RKObjectMapping mappingForClass:[NSNull class]];
    
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndexSet:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [set addIndexes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];
    
    RKResponseDescriptor * responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:emptyMapping
                                                                                             method:requestMethod
                                                                                        pathPattern:nil keyPath:nil
                                                                                        statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.restManager addResponseDescriptor:responseDescriptor];
    
    return emptyMapping;
}

#pragma mark - Life Cycle Methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark - Class Level Methods

+ (RURestKitParser*)shareParser {
    
    if (!_sharedInstance) {
        _sharedInstance = [[RURestKitParser alloc] init];
    }
    return _sharedInstance;
}

#pragma mark - Public Methods

- (RKObjectMapping*)addMappingForClass:(Class)class withAttributeMappingFromArray:(NSArray*)arrayAttributedMapping {
    
    // setup object mappings
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:class];
    [venueMapping addAttributeMappingsFromArray:arrayAttributedMapping];
    
    return venueMapping;
    
}

- (RKObjectMapping*)addMappingForClass:(Class)class withAttributeMappingFromDictionary:(NSDictionary*)dictionary {
    
    // setup object mappings
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:class];
    [venueMapping addAttributeMappingsFromDictionary:dictionary];
    
    return venueMapping;
    
}

- (RKEntityMapping*)addEntityMappingForClass:(Class)class withAttributeMappingFromDictionary:(NSDictionary*)dictionary {
    
    // setup object mappings
    RKEntityMapping *entityMapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass(class) inManagedObjectStore:self.restManager.managedObjectStore];
    [entityMapping addAttributeMappingsFromDictionary:dictionary];
    
    return entityMapping;
    
}

- (RKEntityMapping*)addEntityMappingForClass:(Class)class withAttributeMappingFromArray:(NSArray*)arrayAttributedMapping {
    
    // setup object mappings
    RKEntityMapping *entityMapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass(class) inManagedObjectStore:self.restManager.managedObjectStore];
    [entityMapping addAttributeMappingsFromArray:arrayAttributedMapping];
    
    return entityMapping;
    
}


- (RKResponseDescriptor*)addResponseDescriptorWithMapping:(RKMapping*)mapping method:(RKRequestMethod)method pathPattern:(NSString*)pathPattern keyPath:(NSString*)keyPath statusCodes:(NSIndexSet*)statusCodes {
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                 method:method
                                            pathPattern:pathPattern
                                                keyPath:keyPath
                                            statusCodes:statusCodes];
    [self.restManager addResponseDescriptor:responseDescriptor];
    
    return responseDescriptor;
    
}

- (RURestKitObjectManager*)configureRestKitWithBaseURL:(NSURL*)baseURL {
    
    // initialize AFNetworking HTTPClient
    //    NSURL *baseURL = [NSURL URLWithString:kBASE_URL];
    AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    //    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    self.restManager = [[RURestKitObjectManager alloc] initWithHTTPClient:client];
    return self.restManager;
    
    
    //    return objectManager;
}

- (void)getObjectsAtPath:(NSString *)path
              parameters:(NSDictionary *)parameters
                 success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                 failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
    
    [self.restManager postObject:nil path:path parameters:parameters success:success failure:failure];
}

- (void)getObjectsAtPath:(NSString *)path
              parameters:(NSDictionary *)parameters
           requestMethod:(RKRequestMethod)requestMethod
                 success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                 failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
    
    if (requestMethod == RKRequestMethodGET) {
        [self.restManager
         getObjectsAtPath:path
         parameters:parameters
         success:success
         failure:failure];
    } else {
        [self.restManager
         postObject:nil path:path
         parameters:parameters
         success:success
         failure:failure];
    }
}

- (void)loadRequestWithPath:(NSString*)path
                 parameters:(NSDictionary*)parameters
              requestMethod:(RKRequestMethod)requestMethod
                    success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                    failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure {
    
    [self addEmptyMappingWithRequestMethod:requestMethod];
    if (requestMethod == RKRequestMethodGET) {
        [self.restManager
         getObjectsAtPath:path
         parameters:parameters
         success:success
         failure:failure];
        
    } else if(requestMethod == RKRequestMethodPOST) {
        
        [self.restManager postObject:nil path:path parameters:parameters success:success failure:failure];
    } else if(requestMethod == RKRequestMethodDELETE) {
        [self.restManager deleteObject:nil path:path parameters:parameters success:success failure:failure];
    } else if(requestMethod == RKRequestMethodPUT) {
        [self.restManager
         putObject:nil
         path:path
         parameters:parameters
         success:success
         failure:failure];
    }
}

- (void)setAuthorizationHeaderWithToken:(NSString*)aHeader {
    [[self.restManager HTTPClient] setAuthorizationHeaderWithToken:aHeader];
}

- (void)cancelOperationForPath:(NSString*)path method:(RKRequestMethod)method {
    [self.restManager cancelAllObjectRequestOperationsWithMethod:method matchingPathPattern:path];
}

- (void)getObjectsforKeyPath:(NSString*)keyPath
                 withMapping:(RKObjectMapping*)objectMapping
            objectDictionary:(NSDictionary*)objectDictionary
                     success:(void(^)(RKMappingResult *result))success
                     failure:(void(^)(NSError *error))failure {
    
    __weak typeof (self) weakSelf = self;
    if (keyPath && objectMapping && objectDictionary) {
        //        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //            //Background Thread
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:objectDictionary
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        if (jsonData) {
            
            NSString* MIMEType = @"application/json";
            NSError* error;
            id parsedData = [RKMIMETypeSerialization objectFromData:jsonData MIMEType:MIMEType error:&error];
            if (parsedData == nil && error) {
                NSLog(@"parser error");
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    //Run UI Updates
                    if (failure) {
                        failure([weakSelf createErrorWithDomain:@"Mapping Failed" localizeDescription:@"Mapping failed: invalid jason data"]);
                    }
                });
                
                return ;
            }
            
            NSDictionary *mappingsDictionary = @{ keyPath : objectMapping };
            RKMapperOperation *mapper = [[RKMapperOperation alloc] initWithRepresentation:parsedData mappingsDictionary:mappingsDictionary];
            
            RKManagedObjectMappingOperationDataSource* mappingOperationDataSource = [[RKManagedObjectMappingOperationDataSource alloc]
                                                                                     initWithManagedObjectContext:weakSelf.restManager.managedObjectStore.mainQueueManagedObjectContext
                                                                                     cache:[RKFetchRequestManagedObjectCache new]];
            mapper.mappingOperationDataSource = mappingOperationDataSource;
            //                [weakSelf.restManager.managedObjectStore.mainQueueManagedObjectContext obtainPermanentIDsForObjects:[NSArray arrayWithObject:mapper.targetObject] error:nil];
            mapper.targetObject = nil;
            NSError *mappingError = nil;
            BOOL isMapped = [mapper execute:&mappingError];
            if (isMapped && !mappingError) {
                //                    NSLog(@"Mapping Successful : %@", mapper.mappingResult);
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    //Run UI Updates
                    if (success) {
                        success(mapper.mappingResult);
                    }
                });
                //                return mapper.mappingResult;
            }
            else {
                NSLog(@"error desc: %@", mappingError.localizedDescription);
                NSLog(@"error reason: %@", mappingError.localizedFailureReason);
                NSLog(@"error suggestion: %@", mappingError.localizedRecoverySuggestion);
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    //Run UI Updates
                    if (failure) {
                        failure(mappingError);
                    }
                });
                
            }
        }
        
        //        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            if (failure) {
                failure([weakSelf createErrorWithDomain:@"Nil Objects" localizeDescription:@"Mapping failed: nil objects passed"]);
            }
        });
        
    }
    
    
    
}

@end
