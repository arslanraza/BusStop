//
//  Location.m
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import "Location.h"
#import "RUServiceParser.h"

@interface Location ()

@property (readwrite, assign) BOOL isDownloading;

@end

@implementation Location

#pragma mark - Private Methods

#pragma mark - Life Cycle Methods

#pragma mark - Public Methods

- (NSURL*)getMapImageURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/staticmap?center=%f,%f&zoom=15&size=200x120&sensor=true"
            , self.lat.doubleValue, self.lon.doubleValue]];
}

- (void)getEstimatedTimeForNextBus:(void(^)(NSString *busNoAndTime))completion {
    
    if (!self.currentEstimate) {
        if (!self.isDownloading) {
            self.isDownloading = YES;
            __weak typeof(self) weakSelf = self;
            [[RUServiceParser sharedParser]
             getEstimatesForBusStopWithID:self.locationID
             success:^(NSArray *estimates) {
                 
                 Estimate *singleEstimate = estimates.firstObject;
                 weakSelf.currentEstimate = [NSString stringWithFormat:@"[%@] - %@ min(s)"
                                             , singleEstimate.line
                                             , singleEstimate.estimate?singleEstimate.estimate:@"0"];
                 if (completion) {
                     completion(weakSelf.currentEstimate);
                 }
                 
             } failure:^(NSError *error) {
                 NSLog(@"Failed Downloading Time for ID: %@", self.locationID);
                 weakSelf.isDownloading = NO;
             }];
        }
        
    } else {
        if (completion) {
            completion(self.currentEstimate);
        }
    }
    
}
@end
