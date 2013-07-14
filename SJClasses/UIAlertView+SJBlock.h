//
//  UIAlertView+SJBlock.h
//  singjie.com
//
//  Created by Lee Sing Jie on 23/4/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewBlock)(void);

@interface UIAlertView (SJBlock) <UIAlertViewDelegate>

+ (id)alertViewTitle:(NSString *)title message:(NSString*)message;

- (NSInteger)addButtonTitle:(NSString *)title onTriggered:(UIAlertViewBlock)triggeredBlock;

- (NSInteger)addCancelTitle:(NSString *)title;

@end
