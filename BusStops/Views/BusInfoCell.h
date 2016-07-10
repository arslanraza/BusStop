//
//  BusInfoViewCell.h
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewBusStop;
@property (weak, nonatomic) IBOutlet UILabel *busID;
@property (weak, nonatomic) IBOutlet UILabel *busTitle;
@property (weak, nonatomic) IBOutlet UILabel *busTime;

@end
