//
//  Measurement.m
//  NajebanyAutokar
//
//  Created by Piotr Nietrzebka on 13.12.2014.
//  Copyright (c) 2014 Tomatoez. All rights reserved.
//

#import "Measurement.h"

@implementation Measurement

- (void)addMesurement:(Measurement *)mesurementAdd{
    
    double mesurementAddDistance = [mesurementAdd.distance doubleValue];
    double selfDistance = [self.distance doubleValue];
    double totalDistancev = mesurementAddDistance + selfDistance;
    self.distance = [NSNumber numberWithDouble:totalDistancev];
    
    double mesurementTimeDifference = [mesurementAdd.timeDifference doubleValue];
    double selfTimeDifference = [self.timeDifference doubleValue];
    double totalTimeDifference = mesurementTimeDifference + selfTimeDifference;
    self.timeDifference = [NSNumber numberWithDouble:totalTimeDifference];
}


- (NSNumber *)velocityCalculate
{
   double velocity = (self.distance.doubleValue*36) / (self.timeDifference.doubleValue*10);
    
    NSNumber *velocityNumber = [NSNumber numberWithDouble:velocity];
    
    return velocityNumber;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _distance = [[NSNumber alloc] init];
        _timeDifference = [[NSNumber alloc] init];
        
    }
    
    return self;
}

@end
