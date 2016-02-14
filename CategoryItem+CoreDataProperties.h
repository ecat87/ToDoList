//
//  CategoryItem+CoreDataProperties.h
//  toDoList
//
//  Created by JingLi on 1/19/16.
//  Copyright © 2016 JingLi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CategoryItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *categoryIcon;
@property (nullable, nonatomic, retain) NSString *categoryName;
@property (nullable, nonatomic, retain) NSSet<ToDoItems *> *toDoInCategory;

@end

@interface CategoryItem (CoreDataGeneratedAccessors)

- (void)addToDoInCategoryObject:(ToDoItems *)value;
- (void)removeToDoInCategoryObject:(ToDoItems *)value;
- (void)addToDoInCategory:(NSSet<ToDoItems *> *)values;
- (void)removeToDoInCategory:(NSSet<ToDoItems *> *)values;

@end

NS_ASSUME_NONNULL_END
