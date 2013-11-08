//
//  SJCoreData.m
//  singjie.com
//
//  Created by Lee Sing Jie on 29/5/13.
//  Copyright (c) 2013 Lee Sing Jie. All rights reserved.
//

#import "SJCoreData.h"

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface SJCoreData ()

@property (nonatomic, strong) NSPersistentStoreCoordinator *storeCoordinator;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

@property (nonatomic, strong) NSManagedObjectContext *mainPrivateContext;

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *modelName;

@end

@implementation SJCoreData

+ (SJCoreData *)coreDataModelName:(NSString *)name keyName:(NSString *)key
{
    SJCoreData *coreData = [[SJCoreData alloc] initWithModelName:name keyName:key];
    
    return coreData;
}

- (id)initWithModelName:(NSString *)name keyName:(NSString *)key
{
    self = [super init];
    
    if (self) {
        self.key = key;
        
        self.modelName = name;
        
        NSString *version = [[UIDevice currentDevice] systemVersion];
        
        BOOL isAtLeast6 = [version floatValue] >= 6.0;

        if (!isAtLeast6) {
            // To fix iOS 5 nested context issue
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(contextWillSave:)
                                                         name:NSManagedObjectContextWillSaveNotification
                                                       object:nil];
        }
        
        [self createContexts];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)createContexts
{
    NSPersistentStoreCoordinator *coordinator = [self storeCoordinator];
    if (coordinator != nil) {
        self.mainPrivateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [self.mainPrivateContext performBlockAndWait:^{
            [self.mainPrivateContext setPersistentStoreCoordinator:coordinator];
        }];
    }
    
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.context.parentContext = self.mainPrivateContext;
    
    NSLog(@"Contexts");
    NSLog(@"Main Private:%@", self.mainPrivateContext);
    NSLog(@"Main:%@", self.context);
}

- (void)reset
{
    NSLog(@"Logging out Core Data");
    [self.context performBlockAndWait:^{
        NSError *error = nil;
        [self.context save:&error];
        
        // FIXME: Shouldn't wait here. Wait is needed for pre-ios6 due to locking of NSFetchedResultsController
        [self.mainPrivateContext performBlockAndWait:^{
            NSError *error = nil;
            [self.mainPrivateContext save:&error];
        }];
    }];
    
    self.context = nil;
    self.mainPrivateContext = nil;
    self.storeCoordinator = nil;
}

- (void)save
{
    [self saveBottomUp];
}

- (void)saveBottomUp
{
    if (![self.childContext hasChanges]) {
        return;
    }

    [self.childContext performBlock:^{
        NSError *error = nil;
        [self.childContext save:&error];

        NSParameterAssert(error == nil);

        [self.context performBlock:^{
            NSError *error = nil;
            [self.context save:&error];

            NSParameterAssert(error == nil);

            [self.mainPrivateContext performBlock:^{
                NSError *error = nil;
                [self.mainPrivateContext save:&error];

                NSParameterAssert(error == nil);
            }];
        }];
    }];

}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// This is to fix weird behaviour of nested context in pre-ios6.0.
// Inspired by MagicalRecord @ Issue 250.
// https://github.com/magicalpanda/MagicalRecord/pull/250
- (void)contextWillSave:(NSNotification *)notification
{
    NSManagedObjectContext *context = [notification object];
    NSSet *insertedObjects = [context insertedObjects];
    
    if ([insertedObjects count])
    {
        NSError *error = nil;
        BOOL success = [context obtainPermanentIDsForObjects:[insertedObjects allObjects] error:&error];
        if (!success)
        {
            NSParameterAssert(error == nil);
        }
    }
}

#pragma mark - Lazy Initiators

- (NSPersistentStoreCoordinator *)storeCoordinator
{
    if (_storeCoordinator == nil)
    {
        NSString *storeFileName = [NSString stringWithFormat:@"%@-%@", self.modelName, self.key];
        
        NSParameterAssert(self.key.length);
        
        NSLog(@"CoreData FileName:%@", storeFileName);
        
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:storeFileName];
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,nil];
        
        NSError *error = nil;
        _storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        if (![_storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                             configuration:nil
                                                       URL:storeURL
                                                   options:options
                                                     error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
            
            NSLog(@"Deleted %@", storeURL);
            [_storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
            NSLog(@"Recreated Persistent Store");
        }
    }
    return _storeCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
		
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.modelName withExtension:@"momd"];
    
    NSParameterAssert(modelURL);
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSParameterAssert(_managedObjectModel);
    return _managedObjectModel;
}

- (NSManagedObjectContext *)childContext
{
    if (_childContext) {
        return _childContext;
    }

    _childContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    _childContext.parentContext = self.context;

    return _childContext;
}


@end
