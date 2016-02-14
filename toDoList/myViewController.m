//
//  ViewController.m
//  toDoList
//
//  Created by JingLi on 1/5/16.
//  Copyright © 2016 JingLi. All rights reserved.
//

#import "myViewController.h"
#import "AppDelegate.h"
#import "ToDoItems.h"
#import "CategoryItem.h"

#import "myTableViewCell.h"
#import "detailViewController.h"
#import "addItemViewController.h"

@interface myViewController() <UIAlertViewDelegate>
@property (nonatomic) NSMutableArray *items;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *toolBar;

@end

@implementation myViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSManagedObjectContext *context = [ (AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDoItems" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    //sort if needed
    //    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    //    NSArray = *
    NSError *err;
    self.items = [[context executeFetchRequest:request error:&err] mutableCopy];
    if(!self.items){
        NSLog(@"Fail to load to-do list from disk");
    }

    [self.tableView reloadData];
    
    [self.tableView setEditing:NO animated:YES];
    self.toolBar.title = @"Edit";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Adding items

- (IBAction)addNewItem:(id)sender {
    UIStoryboard *storyboard = self.navigationController.storyboard;
    addItemViewController *aivc = [storyboard instantiateViewControllerWithIdentifier:@"toAddItem"];
    [self.navigationController pushViewController:aivc animated:YES];
}


#pragma mark - Deleting items

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object.
        NSManagedObjectContext *context = [ (AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        
        //delete from data base
        [context deleteObject:self.items[indexPath.row]];
        NSError *err;
        if (![context save:&err]) {
            NSLog(@"Error deleting item: %@", [err localizedDescription]);
        }
        
        [self.items removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

#pragma mark - Editing button
- (IBAction)editItem:(id)sender {
    if ([self.toolBar.title isEqualToString:@"Edit"])
    {
        [self.tableView setEditing:YES animated:YES];
        self.toolBar.title = @"Done";
        //[self.tableView allowsSelectionDuringEditing];
    }
    else
    {
        [self.tableView setEditing:NO animated:YES];
        self.toolBar.title = @"Edit";
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //页面跳转-Navigation: identifier是跳去的view-controller的Identity:Storyboard ID
    if (tableView.editing == YES) {
        UIStoryboard *storyboard = self.navigationController.storyboard;
        detailViewController *dvc = [storyboard instantiateViewControllerWithIdentifier:@"toDetail"];
        dvc.doUpdateItem = [self.items objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:dvc animated:YES];
    }
    else{
        NSManagedObjectContext *context = [ (AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        ToDoItems *getItem = [self.items objectAtIndex:indexPath.row];
        getItem.complete = !getItem.complete;
        [context save:nil];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = getItem.complete ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

//页面跳转-Segue: identifier是页面之间的联系Storyboard Segue:Identifier
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self performSegueWithIdentifier:@"toDetailViewSegue" sender:[self.items objectAtIndex:indexPath.row]];
//}
//
//
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if([segue.identifier  isEqual: @"toDetailViewSegue"]) {
//        DetailViewController *dvc = (DetailViewController*)segue.destinationViewController;
//        dvc.item = (ToDoItem *)sender;
//    }
//}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ToDoItemRow";
    myTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(!cell){
        cell = [[myTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    ToDoItems *item = [self.items objectAtIndex:indexPath.row];
    cell.itemCato.text = item.detail.categoryName;
    cell.itemName.text = item.name;
    cell.itemDesc.text = item.desc;
    cell.accessoryType = item.complete ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    

    return cell;
}



@end
