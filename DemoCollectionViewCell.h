//
//  DemoCollectionViewCell.h
//  CollectionViewDemo
//
//  Created by Varindra Hart on 11/4/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;

@property (nonatomic) IBOutletCollection(UIView) NSArray *colorViewArray;

@property (weak, nonatomic) IBOutlet UILabel *challengeDescription;
@property (weak, nonatomic) IBOutlet UIButton *lockedAndApplyButton;
@property (nonatomic) int colorSetNumber;

@end
