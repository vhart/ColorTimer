//
//  MainViewController.h
//  ColorTimer
//
//  Created by Varindra Hart on 8/16/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePlayViewController.h"
#import "GamePlayViewControllerDelegate.h"
#import "Challenge.h"
@interface MainViewController : UIViewController <GamePlayViewControllerDelegate>
@property (nonatomic) Challenge *currentChallenge;
@end
