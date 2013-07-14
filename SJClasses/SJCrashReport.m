//
//  SJCrashReport.m
//  singjie.com
//
//  Created by Lee Sing Jie on 1/7/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import "SJCrashReport.h"

#import <Crashlytics/Crashlytics.h>

static NSString * const kCrashReporterKey = @"<Your Key>";

@implementation SJCrashReport

+ (id)setup
{
    return [SJCrashReport sharedInstance];
}

+ (id)sharedInstance
{
    static SJCrashReport *reporter;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reporter = [[self alloc] init];
    });
    
    return reporter;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        [Crashlytics startWithAPIKey:kCrashReporterKey];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemoryWarning:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)logViewDidLoad:(UIViewController *)viewController
{
    [Crashlytics setObjectValue:viewController forKey:NSStringFromSelector(_cmd)];
}

- (void)logViewWillAppear:(UIViewController *)viewController
{
    [Crashlytics setObjectValue:viewController forKey:NSStringFromSelector(_cmd)];
}

- (void)logViewDidAppear:(UIViewController *)viewController
{
    [Crashlytics setObjectValue:viewController forKey:NSStringFromSelector(_cmd)];
}

- (void)logViewWillDisappear:(UIViewController *)viewController
{
    [Crashlytics setObjectValue:viewController forKey:NSStringFromSelector(_cmd)];
}

- (void)logViewDidDisappear:(UIViewController *)viewController
{
    [Crashlytics setObjectValue:viewController forKey:NSStringFromSelector(_cmd)];
}

- (void)didReceiveMemoryWarning:(NSNotification *)notification
{
    [Crashlytics setBoolValue:YES forKey:NSStringFromSelector(_cmd)];
}

@end
