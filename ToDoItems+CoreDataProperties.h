//
//  ToDoItems+CoreDataProperties.h
//  toDoList
//
//  Created by JingLi on 1/19/16.
//  Copyright © 2016 JingLi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoItems.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoItems (CoreDataProperties)

@property (nonatomic) BOOL complete;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) CategoryItem *detail;

@end

NS_ASSUME_NONNULL_END
