//
//  UIActionSheet+SJBlock.h
//  singjie.com
//
//  Created by Lee Sing Jie on 19/3/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIActionSheetBlock)(void);

@interface UIActionSheet (SJBlock) <UIActionSheetDelegate>

+ (id)actionSheetTitle:(NSString *)title;

- (NSInteger)addButtonTitle:(NSString *)title onTriggered:(UIActionSheetBlock)triggeredBlock;

- (NSInteger)addCancelTitle:(NSString *)title;

- (NSInteger)addCancelTitle:(NSString *)title onTriggered:(UIActionSheetBlock)triggeredBlock;

- (NSInteger)addDestructiveTitle:(NSString *)title onTriggered:(UIActionSheetBlock)triggeredBlock;

@end
