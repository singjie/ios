//
//  SJBarButtonItem.h
//  singjie.com
//
//  Created by Lee Sing Jie on 11/5/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJBarButtonItem : UIBarButtonItem

+ (SJBarButtonItem *)barButtonItemImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage title:(NSString *)title selector:(SEL)selector target:(id)target;

@end
