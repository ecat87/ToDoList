//
//  detailViewController.m
//  toDoList
//
//  Created by JingLi on 1/7/16.
//  Copyright © 2016 JingLi. All rights reserved.
//

#import "detailViewController.h"
#import "AppDelegate.h"
#import "myViewController.h"
#import "categoryCollectionViewController.h"
#import "CategoryItem.h"

@interface detailViewController ()<categoryCollectionViewControllerDelegateChange>
@property (strong, nonatomic) IBOutlet UIButton *CateButton;
@property (strong, nonatomic) IBOutlet UITextField *NameField;
@property (strong, nonatomic) IBOutlet UITextView *DescField;
@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CALayer *textViewLayer = self.NameField.layer;
    [textViewLayer setCornerRadius:10];
    [textViewLayer setBorderWidth:1];
    textViewLayer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    [self.CateButton setTitle:self.doUpdateItem.detail.categoryName forState:UIControlStateNormal];
    self.NameField.text = self.doUpdateItem.name;
    self.DescField.text = self.doUpdateItem.desc;
    
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    //1 one click
    //2 double click
    [tapBackground setNumberOfTapsRequired:1];
    
    [self.view addGestureRecognizer:tapBackground];
}

-(void) dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - update item name and description
- (IBAction)updateItem:(id)sender {
    NSManagedObjectContext *context = [ (AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    self.doUpdateItem.detail = self.changedCate;
    self.doUpdateItem.name = self.NameField.text;
    self.doUpdateItem.desc = self.DescField.text;
    [context save:nil];

    //test
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CategoryItem"
    inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if(!fetchedObjects){
        NSLog(@"Fail to fetch data!");
    }
     
    for (CategoryItem *itemInfo in fetchedObjects) {
        NSLog(@"Name: %@", itemInfo.categoryName);
        NSLog(@"Icon: %@", itemInfo.categoryIcon);
        NSLog(@"ToDoItems: %@", itemInfo.toDoInCategory);
    }
     

    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - delete item
- (IBAction)deleteItem:(id)sender {
    NSManagedObjectContext *context = [ (AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    [context deleteObject:self.doUpdateItem];
    NSError *err;
    if (![context save:&err]) {
        NSLog(@"Error deleting item: %@", [err localizedDescription]);
    }
    [context save:nil];
    [self.navigationController popViewControllerAnimated:YES];
    

}

#pragma mark - jump and change item category
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"changeCategory"]) {
        UINavigationController *navi = segue.destinationViewController;
        UIViewController *vc = navi.viewControllers[0];
        
        if ([vc isKindOfClass:[categoryCollectionViewController class]]) {
            categoryCollectionViewController *ccvc = (categoryCollectionViewController *)vc;
            ccvc.changeDelegate = self;
        }
    }
}

- (void)didChangeCategory:(CategoryItem *)changedCategory {
    self.changedCate = changedCategory;
    [_CateButton setTitle:self.changedCate.categoryName forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
