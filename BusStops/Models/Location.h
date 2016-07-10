//
//  Location.h
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Location : NSObject

@property (nonatomic, strong) NSString *locationID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lon;
@property (nonatomic, strong) NSString *subtitle;

@property (nonatomic, strong) NSArray *lines;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *currentEstimate;


/**
 Returns the NSURL object to get Location of the Bus Stop on Google Map
 */
- (NSURL*)getMapImageURL;

- (void)getEstimatedTimeForNextBus:(void(^)(NSString *busNoAndTime))completion;

@end
