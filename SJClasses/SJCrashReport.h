//
//  SJCrashReport.h
//  singjie.com
//
//  Created by Lee Sing Jie on 1/7/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJCrashReport : NSObject

+ (id)setup;

+ (id)sharedInstance;

- (void)logViewDidLoad:(UIViewController *)viewController;

- (void)logViewWillAppear:(UIViewController *)viewController;
- (void)logViewDidAppear:(UIViewController *)viewController;

- (void)logViewWillDisappear:(UIViewController *)viewController;
- (void)logViewDidDisappear:(UIViewController *)viewController;

@end
