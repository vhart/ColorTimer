//
//  MainViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 8/16/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "MainViewController.h"
#import "GamePlayViewController.h"
#import "SettingsViewController.h"

@interface MainViewController ()

@property (nonatomic) GamePlayViewController *gameViewController;
@property (nonatomic,weak) IBOutlet UIView *leftView;
@property (nonatomic, weak) IBOutlet UIView *rightView;

@property (nonatomic) BOOL gameVCStartButtonStatus;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[self.navigationController navigationBar] setHidden:YES];
    
    [self embedTableViewControllers];
    
    [self embedGameViewController];
   
    self.gameVCStartButtonStatus = YES;

    
}

//DELEGATE METHODS

- (void) viewController:(GamePlayViewController *)sender startButtonEnabled:(BOOL)enabled{
    
    self.gameVCStartButtonStatus = enabled;
}

- (void) viewController:(GamePlayViewController *)sender swipeGesture:(UISwipeGestureRecognizer *)swipe{
    
    [self swipeRecognized:swipe];
}

//************************************

//DELEGATE CALLED METHOD
- (void)swipeRecognized:(UISwipeGestureRecognizer *)swipe{
    if (self.gameVCStartButtonStatus && swipe.direction==UISwipeGestureRecognizerDirectionLeft) {
        CGPoint newCenter = self.gameViewController.view.center;
        newCenter.x -= self.gameViewController.view.bounds.size.width/2;
        self.gameViewController.view.center = newCenter;
    }
    
    else if (self.gameVCStartButtonStatus && swipe.direction==UISwipeGestureRecognizerDirectionRight){
        CGPoint newCenter = self.gameViewController.view.center;
        newCenter.x += self.gameViewController.view.bounds.size.width/2;
        self.gameViewController.view.center = newCenter;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//****************************************************
//EMBEDDING METHODS

- (void)embedGameViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GamePlayViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"gameViewController"];
    
    [self addChildViewController:vc];
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
    [vc willMoveToParentViewController:self];
    
    self.gameViewController = vc;
    self.gameViewController.delegate = self;
    
}



//********************

- (void)embedTableViewControllers{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingsViewController *settingsTVC = [storyboard instantiateViewControllerWithIdentifier:@"settingsViewController"];
    [self addChildViewController:settingsTVC];
    
    settingsTVC.view.frame = self.leftView.bounds;
    [self.leftView addSubview:settingsTVC.view];
    [settingsTVC willMoveToParentViewController:self];
    
    
    
}

//************************************

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
