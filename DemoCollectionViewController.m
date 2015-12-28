//
//  DemoCollectionViewController.m
//  CollectionViewDemo
//
//  Created by Varindra Hart on 11/4/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "DemoCollectionViewController.h"
#import "DemoCollectionViewCell.h"

@interface DemoCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic) CGFloat cellWidth;

@end

@implementation DemoCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellWidth = self.view.bounds.size.width-100;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:Dem forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    UINib *nib = [UINib nibWithNibName:@"DemoCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"demoCell"];
    
    self.collectionView.delegate = self;
    [self.collectionView setPagingEnabled:YES];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DemoCollectionViewCell *cell = (DemoCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"demoCell" forIndexPath:indexPath];
    
    // Configure the cell
    cell.layer.borderColor = [[UIColor blackColor] CGColor];
    cell.layer.borderWidth = 2.0f;
    
    
   
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float width = self.view.bounds.size.width;
    return CGSizeMake(width-100, 360);
    //width -20
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
//    NSInteger numberOfCells = self.view.frame.size.width / flowLayout.itemSize.width;
//    NSInteger edgeInsets = (self.view.frame.size.width - (numberOfCells * flowLayout.itemSize.width)) / (numberOfCells + 1);
//    return UIEdgeInsetsMake(0, edgeInsets+20, 0,edgeInsets);
//}//edgeInsets+7 and edgeinset




- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    NSInteger numberOfCells = self.view.frame.size.width / self.cellWidth;
    NSInteger edgeInsets = (self.view.frame.size.width - (numberOfCells * self.cellWidth)) / (numberOfCells + 1);
    
    return UIEdgeInsetsMake(0, edgeInsets, 0, edgeInsets);
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
