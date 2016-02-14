//
//  detailViewController.h
//  toDoList
//
//  Created by JingLi on 1/7/16.
//  Copyright © 2016 JingLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItems.h"

@interface detailViewController : UIViewController
@property ToDoItems *doUpdateItem;
@property CategoryItem *changedCate;
@end
