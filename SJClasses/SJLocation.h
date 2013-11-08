//
//  SJLocation.h
//  NoteWeek
//
//  Created by Lee Sing Jie on 9/11/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface SJLocation : NSObject

+ (instancetype)sharedInstance;

- (void)start;

- (CLLocation *)currentLocation;

@end
