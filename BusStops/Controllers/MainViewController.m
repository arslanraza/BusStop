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

@interface MainViewController () <UITabBarDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *busStops;

@end

@implementation MainViewController

#pragma mark - Private Methods

- (void)getBusData {
    __weak typeof(self) weakSelf = self;
    [[RUServiceParser sharedParser] getBusListWithSuccess:^(NSArray *list) {
        weakSelf.busStops = list;
        [weakSelf.tableView reloadData];
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
    }];
}

- (void)configureNavigationBar {
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(getBusData)];
    self.navigationItem.rightBarButtonItem = refreshButton;
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Public Methods

@end
