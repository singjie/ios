//
//  SJTableView.m
//  singjie.com
//
//  Created by Lee Sing Jie on 26/5/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import "SJTableView.h"

@implementation SJTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setEmptyFooterView:(BOOL)emptyFooterView
{
    _emptyFooterView = emptyFooterView;
    
    if (emptyFooterView) {
        self.tableFooterView = [[UIView alloc] init];
    } else {
        self.tableFooterView = nil;
    }
}

@end
