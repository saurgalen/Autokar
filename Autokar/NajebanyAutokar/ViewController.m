//
//  ViewController.m
//  NajebanyAutokar
//
//  Created by Piotr Nietrzebka on 12.12.2014.
//  Copyright (c) 2014 Tomatoez. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Measurement.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) NSDate *dateOld;
@property (nonatomic, weak) IBOutlet UILabel *labelTime;
@property (nonatomic, weak) IBOutlet UILabel *labelDistance;
@property (nonatomic, weak) IBOutlet UILabel *labelAverageVelocity;
@property (nonatomic, strong) NSMutableArray *mesurements;
@property (nonatomic, strong) Measurement *totalMesurement;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateOld = [NSDate date];
    
    self.manager = [[CLLocationManager alloc] init];
    [self.manager requestAlwaysAuthorization];
    
    [self.manager startUpdatingLocation];
    
    self.manager.delegate = self;
    
    self.mesurements = [NSMutableArray array];
    
    self.totalMesurement = [[Measurement alloc] init];
    
    
    

    
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    NSDate *dateNew = [NSDate date];
    NSTimeInterval timeDifference = [dateNew timeIntervalSinceDate:self.dateOld];
    
    CLLocationDistance distance = [newLocation distanceFromLocation:oldLocation];
    
    
    
    Measurement *measurementPointer = [[Measurement alloc] init];
    
    measurementPointer.distance = [NSNumber numberWithDouble:distance];
    measurementPointer.timeDifference = [NSNumber numberWithDouble:timeDifference];
    
    
    [self.mesurements addObject:measurementPointer];
    
    [self.totalMesurement addMesurement:measurementPointer];
    
    
    
    CGFloat     velocity = (distance*36) / (timeDifference*10);


    
    NSLog(@"- - - - - - - - - - - - - - - - - - -");
    NSLog(@"timeDifference: %@", @(timeDifference));
    NSLog(@"      distance: %@", @(distance));
    NSLog(@"         Speed: %@", @((distance*36)/(timeDifference*10)));
    
    self.dateOld = dateNew;
    
    self.labelTime.text = [NSString stringWithFormat:@"%f s" ,[self.totalMesurement.timeDifference doubleValue]];
    self.labelDistance.text = [NSString stringWithFormat:@"%f m",[self.totalMesurement.distance doubleValue]];
    self.labelAverageVelocity.text = [NSString stringWithFormat:@"%f km/h", [self.totalMesurement.velocityCalculate doubleValue]];
    
    NSIndexPath *indexToInsert = [NSIndexPath indexPathForRow:self.mesurements.count-1 inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexToInsert] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}




#pragma mark tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.mesurements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    Measurement *measurementPointer = self.mesurements[indexPath.row];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%f km/h", [measurementPointer.velocityCalculate doubleValue]]];

    
    return cell;

}



@end
