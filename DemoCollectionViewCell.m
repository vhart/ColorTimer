//
//  DemoCollectionViewCell.m
//  CollectionViewDemo
//
//  Created by Varindra Hart on 11/4/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "DemoCollectionViewCell.h"


@implementation DemoCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupCellForColorSet:(ColorSets *)colorset{

    for (int i = 0; i < self.colorViewArray.count; i++){
        self.colorViewArray[i].backgroundColor = colorset.colors[i];
        self.colorViewArray[i].layer.cornerRadius = 30;
    }

    self.challengeDescription.text = colorset.challengeDescription;

    NSString *titleForButton = !colorset.unlocked? @"Locked" : colorset.applied? @"Applied" : @"Apply";

    [self.lockedAndApplyButton setTitle:titleForButton forState:UIControlStateNormal];

    self.lockedAndApplyButton.enabled = !colorset.unlocked? NO: colorset.applied? NO: YES;

    self.cellTitleLabel.text = colorset.title;
    self.cellTitleLabel.backgroundColor = colorset.colors.firstObject;
}

- (IBAction)applyButtonSelected:(UIButton *)sender{

    [sender setTitle:@"Applied" forState:UIControlStateNormal];
    sender.enabled = NO;
    [self.delegate didTapAppliedAtIndex:self.index];
    
}

@end
