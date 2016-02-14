//
//  categoryCollectionViewController.h
//  toDoList
//
//  Created by JingLi on 1/19/16.
//  Copyright © 2016 JingLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryItem.h"

@protocol categoryCollectionViewControllerDelegate <NSObject>

- (void) didSelectCategory:(CategoryItem *)addedCategory;

@end

@protocol categoryCollectionViewControllerDelegateChange <NSObject>

- (void) didChangeCategory:(CategoryItem *)changedCategory;

@end

@interface categoryCollectionViewController : UICollectionViewController

@property (nonatomic, weak) id<categoryCollectionViewControllerDelegate> addDelegate;
@property (nonatomic, weak) id<categoryCollectionViewControllerDelegateChange> changeDelegate;

@end
