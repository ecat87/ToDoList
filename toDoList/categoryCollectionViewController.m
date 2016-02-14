//
//  categoryCollectionViewController.m
//  toDoList
//
//  Created by JingLi on 1/19/16.
//  Copyright © 2016 JingLi. All rights reserved.
//

#import "categoryCollectionViewController.h"
#import "AppDelegate.h"

#import "categoryCollectionViewCell.h"
#import "CategoryItem.h"


@interface categoryCollectionViewController ()
@property (nonatomic) NSMutableArray *cateitems;

@end

@implementation categoryCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSManagedObjectContext *context = [ (AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CategoryItem" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSError *err;
    self.cateitems = [[context executeFetchRequest:request error:&err] mutableCopy];
    if(!self.cateitems){
        NSLog(@"Fail to load to-do category from disk");
    }
    [self.collectionView reloadData];
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
#pragma mark - Select category
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryItem *getCate = [self.cateitems objectAtIndex:indexPath.row];
    
    if ([self.addDelegate respondsToSelector:@selector(didSelectCategory:)]) {
        [self.addDelegate didSelectCategory:getCate];
    }
    if ([self.changeDelegate respondsToSelector:@selector(didChangeCategory:)]) {
        [self.changeDelegate didChangeCategory:getCate];
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)cancelButton:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return [self.cateitems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ccIdentifier = @"cateCollection";
    categoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ccIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    CategoryItem *cateItem = [self.cateitems objectAtIndex:indexPath.row];
    cell.cateName.text = cateItem.categoryName;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
