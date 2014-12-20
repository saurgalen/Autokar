//
//  Measurement.h
//  NajebanyAutokar
//
//  Created by Piotr Nietrzebka on 13.12.2014.
//  Copyright (c) 2014 Tomatoez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Measurement : NSObject

@property (nonatomic, strong) NSNumber *timeDifference;
@property (nonatomic, strong) NSNumber *distance;


- (NSNumber *)velocityCalculate;
- (void)addMesurement:(Measurement *)mesurementAdd;



@end
