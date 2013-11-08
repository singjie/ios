//
//  SJLocation.m
//  NoteWeek
//
//  Created by Lee Sing Jie on 9/11/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import "SJLocation.h"

#import <CoreLocation/CoreLocation.h>

@interface SJLocation () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocation *location;

@end

@implementation SJLocation

+ (instancetype)sharedInstance
{
    static SJLocation *location;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[SJLocation alloc] init];
    });

    return location;
}

- (void)start
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;

    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = locations[0];

    if (self.location.horizontalAccuracy <= 200 || self.location.verticalAccuracy <= 200) {
        [manager stopUpdatingLocation];
    }
}

- (CLLocation *)currentLocation
{
    return self.location;
}

@end
