//
//  DemoCollectionViewController.m
//  CollectionViewDemo
//
//  Created by Varindra Hart on 11/4/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "DemoCollectionViewController.h"
#import "DemoCollectionViewCell.h"

@interface DemoCollectionViewController () <UICollectionViewDelegateFlowLayout, DemoCollectionViewCellDelegate>

@property (nonatomic) CGFloat cellWidth;
@property (nonatomic) NSArray <ColorSets *> *colorSetsArray;

@end

@implementation DemoCollectionViewController

static NSString * const reuseIdentifier = @"demoCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellWidth = self.view.bounds.size.width-100;
    
    UINib *nib = [UINib nibWithNibName:@"DemoCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.delegate = self;
    //[self.collectionView setPagingEnabled:YES];
    self.collectionView.allowsSelection = NO;

    self.colorSetsArray = [ColorSets getAllColorSets];

    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"Color Sets";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:217.0/255.0f green:0 blue:0 alpha:1];
    
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
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colorSetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DemoCollectionViewCell *cell = (DemoCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell setupCellForColorSet:self.colorSetsArray[indexPath.row]];
    cell.layer.cornerRadius = 10;
    cell.delegate = self;
    cell.index = indexPath.row;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float width = self.view.bounds.size.width;
    return CGSizeMake(width-50, 380);
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
    
    return UIEdgeInsetsMake(-50, edgeInsets, 0, edgeInsets);
}


#pragma mark <UICollectionViewDelegate>

#pragma mark <DemoCollectionViewCellDelegate>

- (void)didTapAppliedAtIndex:(NSInteger)index{

    for (NSInteger i = 0; i < self.colorSetsArray.count; i ++) {
        self.colorSetsArray[i].applied = NO;
        if (i == index) {
            self.colorSetsArray[i].applied = YES;
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:index] forKey:@"ColorSetTypeApplied"];

    [self.collectionView reloadData];
}

- (void)dismiss:(UIBarButtonItem *)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
