//
//  UIActionSheet+SJBlock.m
//  BeeTalk
//
//  Created by Lee Sing Jie on 19/3/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import "UIActionSheet+SJBlock.h"

#import <objc/runtime.h>

static char BUTTONS_CALLBACKS_IDENTIFIER;

@implementation UIActionSheet (SJBlock)

+ (id)actionSheetTitle:(NSString *)title
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];

    actionSheet.delegate = actionSheet;

    return actionSheet;
}

- (NSInteger)addButtonTitle:(NSString *)title onTriggered:(UIActionSheetBlock)triggeredBlock
{
    NSInteger index = [self addButtonWithTitle:title];

    NSMutableDictionary *callbacks = [self buttonsCallbacks];

    if (callbacks == nil) {
        callbacks = [NSMutableDictionary dictionary];
        [self setButtonsCallbacks:callbacks];
    }

    if (triggeredBlock) {
        [callbacks setObject:triggeredBlock forKey:@(index)];
    }

    return index;
}

- (NSInteger)addCancelTitle:(NSString *)title
{
    NSInteger index = [self addButtonTitle:title onTriggered:nil];

    self.cancelButtonIndex = index;

    return index;
}

- (NSInteger)addCancelTitle:(NSString *)title onTriggered:(UIActionSheetBlock)triggeredBlock
{
    NSInteger index = [self addButtonTitle:title onTriggered:triggeredBlock];
    
    self.cancelButtonIndex = index;
    
    return index;
}

- (NSInteger)addDestructiveTitle:(NSString *)title onTriggered:(UIActionSheetBlock)triggeredBlock
{
    NSInteger index = [self addButtonTitle:title onTriggered:triggeredBlock];
    
    self.destructiveButtonIndex = index;
    
    return index;
}

- (NSMutableDictionary *)buttonsCallbacks
{
    return objc_getAssociatedObject(self, &BUTTONS_CALLBACKS_IDENTIFIER);
}

- (void)setButtonsCallbacks:(NSMutableDictionary *)dictionary
{
    objc_setAssociatedObject(self, &BUTTONS_CALLBACKS_IDENTIFIER, dictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSMutableDictionary *callbacks = [self buttonsCallbacks];

    UIActionSheetBlock callback = [callbacks objectForKey:@(buttonIndex)];

    if (callback) {
        callback();
    }
}

@end
