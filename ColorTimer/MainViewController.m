//
//  MainViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 8/16/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "MainViewController.h"
#import "GamePlayViewController.h"

@interface MainViewController ()

@property (nonatomic) GamePlayViewController *gameViewController;
@property (nonatomic) BOOL settingsButtonTapped;
@property (nonatomic) BOOL highScoresButtonTapped;
@property (nonatomic) CGPoint center;
@property (nonatomic) CGPoint left;
@property (nonatomic) CGPoint right;
@property (nonatomic) BOOL gameVCStartButtonStatus;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.settingsButtonTapped = NO;
    //    self.highScoresButtonTapped = NO;
    // Do any additional setup after loading the view.
    
    [[self.navigationController navigationBar] setHidden:NO];
    [self embedTableViewController];
   
    self.gameVCStartButtonStatus = NO;
    
   //*************************************************
    //SETTING UP REFERENCE POINTS FOR SLIDE ANIMATIONS
    
    self.center = self.view.center;
    
    
    CGPoint rightX = self.center;
    rightX.x += self.view.bounds.size.width/2;
    self.right = rightX;
    
    
    CGPoint leftX = self.center;
    leftX.x -= self.view.bounds.size.width/2;
    self.left = leftX;
   
    //*********************************************
    
    //CREATE AND ADD SWIPE GESTURES
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self.gameViewController action:@selector(swipeRecognized:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.gameViewController.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self.gameViewController action:@selector(swipeRecognized:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.gameViewController.view addGestureRecognizer:swipeRight];
    
    
}

//DELEGATE METHODS

- (void) ViewController:(GamePlayViewController *)sender startButtonEnabled:(BOOL)enabled{
    
    self.gameVCStartButtonStatus = enabled;
}

- (void) ViewController:(GamePlayViewController *)sender swipeGesture:(UISwipeGestureRecognizer *)swipe{
    
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
//***********************************




//ACTION FOR TRIGGERING SLIDE ANIMATION VIA THE NAV BAR

- (IBAction)settingsButton:(UIBarButtonItem *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint newCenter = self.gameViewController.view.center;
        if(!self.settingsButtonTapped){
            self.highScoresButtonTapped = NO;
            newCenter.x = self.right.x;
            self.gameViewController.view.center = newCenter;
        }
        else{
            newCenter.x = self.center.x;
            self.gameViewController.view.center = newCenter;
        }
        
        
    }];
    self.settingsButtonTapped=!self.settingsButtonTapped;
}

//****************************

- (IBAction)highScoresButton:(UIBarButtonItem *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint newCenter = self.gameViewController.view.center;
        if(!self.highScoresButtonTapped){
            self.settingsButtonTapped = NO;
            newCenter.x = self.left.x;
            self.gameViewController.view.center = newCenter;
        }
        else{
            newCenter.x = self.center.x;
            self.gameViewController.view.center = newCenter;
        }
        
    }];
    self.highScoresButtonTapped=!self.highScoresButtonTapped;
    
}
//*************************************************


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)embedTableViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GamePlayViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"gameViewController"];
    
    [self addChildViewController:vc];
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
    [vc willMoveToParentViewController:self];
    
    self.gameViewController = vc;
    self.gameViewController.delegate = self;
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
