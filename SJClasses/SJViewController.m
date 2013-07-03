//
//  SJViewController.m
//  singjie.com
//
//  Created by Lee Sing Jie on 1/7/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import "SJViewController.h"

#import "SJCrashReport.h"

@interface SJViewController ()

@end

@implementation SJViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[SJCrashReport sharedInstance] logViewDidLoad:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[SJCrashReport sharedInstance] logViewWillAppear:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[SJCrashReport sharedInstance] logViewDidAppear:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[SJCrashReport sharedInstance] logViewWillDisappear:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[SJCrashReport sharedInstance] logViewDidDisappear:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
