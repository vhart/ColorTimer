//
//  GamePlayViewControllerDelegate.h
//  ColorTimer
//
//  Created by Varindra Hart on 8/16/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GamePlayViewController.h"

@class GamePlayViewController;

@protocol GamePlayViewControllerDelegate <NSObject>

-(void) ViewController:(GamePlayViewController *)sender startButtonEnabled:(BOOL)enabled ;
-(void) ViewController:(GamePlayViewController *)sender swipeGesture:(UISwipeGestureRecognizer *)swipe;

@end
