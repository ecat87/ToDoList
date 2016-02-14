//
//  addItemViewController.m
//  toDoList
//
//  Created by JingLi on 1/18/16.
//  Copyright © 2016 JingLi. All rights reserved.
//

#import "addItemViewController.h"
#import "AppDelegate.h"
#import "myViewController.h"

#import "ToDoItems.h"
#import "categoryCollectionViewController.h"

@interface addItemViewController ()<categoryCollectionViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *addCategory;
@property (strong, nonatomic) IBOutlet UITextField *addName;
@property (strong, nonatomic) IBOutlet UITextView *addDescription;

@end

@implementation addItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    //1 one click
    //2 double click
    [tapBackground setNumberOfTapsRequired:1];
    
    [self.view addGestureRecognizer:tapBackground];
}

-(void) dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)addNewItem:(id)sender {
    if(_addedCate == nil || [_addName.text isEqualToString:@""] || [_addDescription.text isEqualToString:@""]){
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Alert"
                                      message:@"Please enter all fields!!!"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
    else{
        AppDelegate *ad = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [ad managedObjectContext];
        ToDoItems *newItem = (ToDoItems *) [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItems" inManagedObjectContext:context];
        newItem.detail = _addedCate;
        newItem.name = _addName.text;
        newItem.desc = _addDescription.text;
        newItem.complete = false;
    
        NSError *err;
        if(![context save:&err]){
            NSLog(@"Error adding new items: %@", [err localizedDescription]);
        }
    
    //test
    /*
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
    */
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addCategory"]) {
        UINavigationController *navi = segue.destinationViewController;
        UIViewController *vc = navi.viewControllers[0];
        
        if ([vc isKindOfClass:[categoryCollectionViewController class]]) {
            categoryCollectionViewController *ccvc = (categoryCollectionViewController *)vc;
            ccvc.addDelegate = self;
        }
    }
}


- (void)didSelectCategory:(CategoryItem *)addedCategory {
    self.addedCate = addedCategory;
    [_addCategory setTitle:self.addedCate.categoryName forState:UIControlStateNormal];

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
