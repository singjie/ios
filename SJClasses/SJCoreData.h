//
//  SJCoreData.h
//  singjie.com
//
//  Created by Lee Sing Jie on 29/5/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface SJCoreData : NSObject

@property (nonatomic, strong) NSManagedObjectContext *context;

@property (nonatomic, strong) NSManagedObjectContext *childContext;

+ (instancetype)coreDataModelName:(NSString *)name keyName:(NSString *)key;

- (void)reset;
- (void)save;

@end
