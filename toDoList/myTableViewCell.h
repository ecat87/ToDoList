//
//  myTableViewCell.h
//  toDoList
//
//  Created by JingLi on 1/11/16.
//  Copyright © 2016 JingLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *itemCato;
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet UILabel *itemDesc;

@end
