//
//  SJBarButtonItem.m
//  singjie.com
//
//  Created by Lee Sing Jie on 11/5/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import "SJBarButtonItem.h"

@implementation SJBarButtonItem

+ (SJBarButtonItem *)barButtonItemImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage title:(NSString *)title selector:(SEL)selector target:(id)target;
{
    SJBarButtonItem *barButton = [[SJBarButtonItem alloc] initWithImage:image highlightedImage:highlightedImage title:title selector:selector target:target];
    
    return barButton;
}

- (SJBarButtonItem *)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage title:(NSString *)title selector:(SEL)selector target:(id)target
{
    self = [super init];
    
    if (self) {
        NSParameterAssert(image);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.customView = button;
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        button.autoresizingMask |= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    
    return self;
}

@end
