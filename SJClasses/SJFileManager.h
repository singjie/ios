//
//  SJFileManager.h
//  singjie.com
//
//  Created by Lee Sing Jie on 7/7/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJFileManager : NSObject

- (id)initWithKey:(NSString *)key;

- (void)writeToUserDisk:(NSString *)path data:(NSData *)content;
- (void)writeToRoot:(NSString *)path data:(NSData *)content;

- (NSData *)loadFromUserDisk:(NSString *)path;
- (NSData *)loadFromRoot:(NSString *)path;

// Defaults to sj/ directory
- (NSString *)folder;

@end
