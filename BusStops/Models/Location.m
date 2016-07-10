//
//  Location.m
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import "Location.h"

@implementation Location

#pragma mark - Private Methods

#pragma mark - Life Cycle Methods

#pragma mark - Public Methods

- (NSURL*)getMapImageURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/staticmap?center=%f,%f&zoom=15&size=200x120&sensor=true"
            , self.lat.doubleValue, self.lon.doubleValue]];
}
@end
