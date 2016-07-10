//
//  MainViewController.m
//  BusStops
//
//  Created by Arslan Raza on 10/07/2016.
//  Copyright © 2016 Arslan Raza. All rights reserved.
//

#import "MainViewController.h"
#import "RUServiceParser.h"
#import "BusInfoCell.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <SDWebImage/SDWebImageDownloader.h>

@interface MainViewController () <UITabBarDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *busStops;

@end

@implementation MainViewController

#pragma mark - Private Methods

- (void)getBusData {
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    [[RUServiceParser sharedParser] getBusListWithSuccess:^(NSArray *list) {
        weakSelf.busStops = list;
        [weakSelf.tableView reloadData];
        [weakSelf downloadImagesForVisibleCells];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        // Display an alert to the user in case the request fails
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"Something went wrong. Please try again."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction
                          actionWithTitle:@"Ok"
                          style:UIAlertActionStyleCancel
                          handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        [SVProgressHUD dismiss];
    }];
}

/**
 Downloads Images for only visible cells.
 */
- (void)downloadImagesForVisibleCells {
    
    if (self.busStops.count > 0) {
        
        NSArray *visiblePaths = self.tableView.indexPathsForVisibleRows;
        
        for (NSIndexPath *indexPath in visiblePaths) {
            
            Location *singleLocation = self.busStops[indexPath.row];
            
            if (!singleLocation.image) {
                
                __weak typeof(self) weakSelf = self;
                SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
                [downloader
                 downloadImageWithURL:singleLocation.getMapImageURL
                 options:0
                 progress:nil
                 completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                     if (image && finished) {
                         
                         singleLocation.image = image;
                         
                         // VisibleCell will only have a value if its currently displayed on screen
                         // Out of bound cells will return for the following check
                         BusInfoCell *visibleCell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
                         if (visibleCell) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                visibleCell.imageViewBusStop.image = image;
                             });
                             
                         }
                     }
                 }];
            }
        }
    }
}

- (void)configureNavigationBar {
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(getBusData)];
    self.navigationItem.rightBarButtonItem = refreshButton;
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureNavigationBar];
    [self getBusData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.busStops.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BusInfoCell *cell = (BusInfoCell*)[tableView dequeueReusableCellWithIdentifier:@"BusCell"];
    
    Location *singleLocation = self.busStops[indexPath.row];
    cell.busID.text = singleLocation.locationID;
    cell.busTitle.text = singleLocation.title;
    
    if (singleLocation.image) {
        cell.imageViewBusStop.image = singleLocation.image;
    } else {
        cell.imageViewBusStop.image = [UIImage imageNamed:@"PlaceHolder"];
    }
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self downloadImagesForVisibleCells];
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Public Methods

@end
