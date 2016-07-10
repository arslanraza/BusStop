//
//  BusInfoViewCell.m
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import "BusInfoCell.h"
#import "UIView+Animations.h"

@implementation BusInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.imageViewBusStop setCornerRadiusAsCircle];
    [self.imageViewBusStop.layer setBorderWidth:1.0];
    [self.imageViewBusStop.layer setBorderColor:[UIColor whiteColor].CGColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
