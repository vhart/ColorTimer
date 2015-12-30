//
//  DemoCollectionViewCell.h
//  CollectionViewDemo
//
//  Created by Varindra Hart on 11/4/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorSets.h"

@protocol DemoCollectionViewCellDelegate <NSObject>

- (void)didTapAppliedAtIndex:(NSInteger)index;

@end

@interface DemoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (nonatomic)       IBOutletCollection(UIView) NSArray <UIView *> *
                                                       colorViewArray;
@property (weak, nonatomic) IBOutlet UILabel *challengeDescription;
@property (weak, nonatomic) IBOutlet UIButton *lockedAndApplyButton;
@property (nonatomic)       int colorSetNumber;
@property (nonatomic)       NSInteger index;
@property (nonatomic, weak) id <DemoCollectionViewCellDelegate> delegate;

- (void)setupCellForColorSet:(ColorSets *)colorset;

@end
