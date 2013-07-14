//
//  SJFileManager.m
//  singjie.com
//
//  Created by Lee Sing Jie on 7/7/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import "SJFileManager.h"

@interface SJFileManager ()

@property (nonatomic, strong) NSString *rootPath;

@property (nonatomic, strong) NSString *key;

@end

@implementation SJFileManager

- (id)initWithKey:(NSString *)key
{
    self = [super init];
    
    if (self) {
        self.key = key;
    }
    
    return self;
}

- (void)writeToUserDisk:(NSString *)path data:(NSData *)content
{
    NSString *userPath = [self.key stringByAppendingPathComponent:path];
    
    return [self writeToRoot:userPath data:content];
}

- (void)writeToRoot:(NSString *)path data:(NSData *)content
{
    NSString *fullPath = [[self rootPath] stringByAppendingPathComponent:path];
    
    NSString *pathWithoutFile = [fullPath stringByDeletingLastPathComponent];
    
    BOOL directoryExists = [[NSFileManager defaultManager] fileExistsAtPath:pathWithoutFile];
    
    if (!directoryExists) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:pathWithoutFile
                                  withIntermediateDirectories:YES
                                                   attributes:nil error:&error];
        NSParameterAssert(error == nil);
    }
    
    [content writeToFile:fullPath atomically:NO];
}

- (NSData *)loadFromUserDisk:(NSString *)path
{
    NSString *userPath = [self.key stringByAppendingPathComponent:path];
    
    return [self loadFromRoot:userPath];
}

- (NSData *)loadFromRoot:(NSString *)path
{
    NSString *fullPath = [[self rootPath] stringByAppendingPathComponent:path];
    
    return [NSData dataWithContentsOfFile:fullPath];
}

#pragma mark - Private Methods

- (NSString *)rootPath
{
    if (_rootPath == nil) {
        NSString *libFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _rootPath = [libFolder stringByAppendingPathComponent:self.folder];
    }
    
    return _rootPath;
}

- (NSString *)folder
{
    return @"sj";
}

@end
