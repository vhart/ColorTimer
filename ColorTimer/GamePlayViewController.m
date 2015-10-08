//
//  GamePlayViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 8/15/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "GamePlayViewController.h"
#import "HighScoresModel.h"
#import "HDNotificationView.h"
#import "AppDelegate.h"

NSTimeInterval const GameTimerInteval = 0.01f;

//typedef NS_ENUM(NSInteger, QuestionColor) {
//    Green = 0,
//    Red,
//    Blue,
//};

@interface GamePlayViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic) NSMutableArray *colorsArray;
@property (weak, nonatomic) IBOutlet UIView *currentColorView;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *arrayOfButtons;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UILabel *streakLabel;
@property (nonatomic) float timerValue;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger streak;

@property (nonatomic) NSTimer *gameTimer;
@property (nonatomic) UIColor *currentColor;

@property (nonatomic) int streakRank;
@property (nonatomic) int scoreRank;

@property (nonatomic) float valueForNewTap;

@end

@implementation GamePlayViewController
#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorsArray = [NSMutableArray new];
    
    [self.colorsArray addObject:[UIColor blackColor]];
    [self.colorsArray addObject:[UIColor orangeColor]];
    [self.colorsArray addObject:[UIColor cyanColor]];
    [self.colorsArray addObject:[UIColor brownColor]];
    [self.colorsArray addObject:[UIColor purpleColor]];
    [self.colorsArray addObject:[UIColor magentaColor]];
    [self.colorsArray addObject:[UIColor redColor]];
    [self.colorsArray addObject:[UIColor yellowColor]];
    
    [self disableButtons];
    
    
    //CREATE AND ADD SWIPE GESTURES
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    [self addShadow];
    
}


//*******************************************************

//Methods that will set up the game screen. Sets up in particular the score, questions, and button colors
#pragma mark - GAME SETUP Methods
- (void)reset {
    self.score = 0;
    self.streak = 0;
    self.streakLabel.text = @"STREAK: 0";
    self.scoreLabel.text = @"SCORE: 0";
    if (self.currentChallenge) {
        if (self.currentChallenge.speedChallenge) {
            self.timerValue = [[self.currentChallenge valueForKey:@"timeMax"] floatValue];
            self.valueForNewTap = self.timerValue;
        }
    }
    else{
        self.timerValue = 1.0;
    }
    [self nextQuestion];
}

- (void)nextQuestion {
    [self setNextColor];
    
    
    [self resetTimer];
    
    
}

- (void)disableButtons{
    for(UIButton *b in self.arrayOfButtons){
        b.enabled=NO;
    }
}

//*********************** Partitioned for organizational purposes
#pragma mark - Algorithm To Set Button Colors With No Duplicates or Repeats
- (void)setButtonColors{
    
    NSMutableArray *tempColorsArray = [NSMutableArray new];
    for (int i = 0; i<2; i++) {
        while (YES) {
            NSInteger idxForColor = arc4random_uniform(self.colorsArray.count);
            
            UIColor *color =  [self.colorsArray objectAtIndex:idxForColor];
            
            if (color != self.currentColor) {
                BOOL hasColor = NO;
                for (UIColor *c in tempColorsArray) {
                    if(c == color){
                        hasColor=YES;
                        break;
                    }
                }
                if(!hasColor){
                    [tempColorsArray addObject:color];
                    break;
                }
                else{
                    continue;
                }
            }
            
        }
    }
    
    [tempColorsArray insertObject:self.currentColor atIndex:arc4random_uniform(3)];
    NSInteger indexOfColor = 0;
    for(UIButton *b in self.arrayOfButtons){
        b.backgroundColor = tempColorsArray[indexOfColor];
        indexOfColor++;
    }
    
}

//**********************************************************



//EXECUTED BY TIMER TO DECREASE THE GAME's TIMER DISPLAYED TO THE USER
- (void)decreaseTimer{
    self.timerValue -=.01;
    self.timeLabel.text = [NSString stringWithFormat:@"%.2f",self.timerValue];
    if (self.timerValue<=0.01) {
        self.timeLabel.text = @"0.00";
        [self gameOver];
    }
    
    
}
//**********************************************************

#pragma mark - Game Over Methods

//GAME OVER METHODS, CANCELES TIMER AND CALLS ALL RESET METHODS
- (void)gameOver {
    
    //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    AudioServicesPlayAlertSound(1306);
    [self cancelTimer];
    [self disableButtons];
    
    self.startButton.enabled = YES;
    self.startButton.hidden = NO;
    
    [self gameEndChecks];
    
    
    //DELEGATE METHOD TRIGGERED
    [self.delegate viewController:self startButtonEnabled:self.startButton.enabled];
}

#pragma mark - DEFAULT Checking Method (Streak)
- (void)gameEndChecks{
    while (self.currentChallenge) {
        
        if (self.currentChallenge.streakChallenge) {
            if (self.streak >= [self.currentChallenge.streakMax integerValue]) {
                [self.currentChallenge setValue:@([self.currentChallenge.currentNumberOfSuccesses integerValue]+1) forKey:@"currentNumberOfSuccesses"];
                if (self.currentChallenge.currentNumberOfSuccesses>self.currentChallenge.numberOfSuccessesNeeded) {
                    [self.currentChallenge setValue:self.currentChallenge.numberOfSuccessesNeeded forKey:@"currentNumberOfSuccesses"];
                    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"welcomeToTheLeaderBoard"] title:@"Crushing It!" message:@"Challenge complete!"];
                    break;
                }
            }
            else if (self.currentChallenge.consecutiveChallenge && [self.currentChallenge valueForKey:@"currentNumberOfSuccesses"]!=0){
                [self.currentChallenge setValue:@0 forKey:@"currentNumberOfSuccesses"];
                [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"welcomeToTheLeaderBoard"] title:@"Bad News" message:@"Consecutive Challenge Has Been Reset"];
                break;
            }
        }
        else if(self.currentChallenge.scoreChallenge) {
            if (self.streak >= [self.currentChallenge.scoreMax integerValue]) {
                [self.currentChallenge setValue:@([self.currentChallenge.currentNumberOfSuccesses integerValue]+1) forKey:@"currentNumberOfSuccesses"];
                if (self.currentChallenge.currentNumberOfSuccesses>self.currentChallenge.numberOfSuccessesNeeded) {
                    [self.currentChallenge setValue:self.currentChallenge.numberOfSuccessesNeeded forKey:@"currentNumberOfSuccesses"];
                    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"welcomeToTheLeaderBoard"] title:@"Crushing It!" message:@"Challenge complete!"];
                    break;
                }
            }
            else if (self.currentChallenge.consecutiveChallenge && [self.currentChallenge valueForKey:@"currentNumberOfSuccesses"]!=0){
                [self.currentChallenge setValue:@0 forKey:@"currentNumberOfSuccesses"];
                [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"welcomeToTheLeaderBoard"] title:@"Bad News" message:@"Consecutive Challenge Has Been Reset"];
                break;
            }
        }
        break;
    }
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];
    
    [self checkForNewStreak];
}


- (void)checkForNewStreak{
    int rank = [[HighScoresModel sharedModel] isNewStreak:[NSString stringWithFormat:@"%lu",self.streak]];
    int rank2 = [[HighScoresModel sharedModel] isNewScore:[NSString stringWithFormat:@"%lu",self.score]];
    self.streakRank = rank;
    self.scoreRank = rank2;
    if (rank > -1 || rank2 > -1) {
        
        if(rank > -1 && rank2 == -1){
            UIAlertView *alertViewChangeName=[[UIAlertView alloc]initWithTitle:@"NEW HIGH STREAK!" message:[NSString stringWithFormat:@"Streak rank: #%d",rank+1] delegate:self cancelButtonTitle:@"..Meh" otherButtonTitles:@"Add Me!",nil];
            alertViewChangeName.alertViewStyle=UIAlertViewStylePlainTextInput;
            UITextField* titleField = [alertViewChangeName textFieldAtIndex: 0];
            titleField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            titleField.autocorrectionType = UITextAutocorrectionTypeDefault;
            [alertViewChangeName show];
        }
        else if(rank == -1 && rank2>-1){
            UIAlertView *alertViewChangeName=[[UIAlertView alloc]initWithTitle:@"NEW HIGH SCORE" message:[NSString stringWithFormat:@"Score rank: #%d",rank2+1] delegate:self cancelButtonTitle:@"..Meh" otherButtonTitles:@"Add Me!",nil];
            alertViewChangeName.alertViewStyle=UIAlertViewStylePlainTextInput;
            UITextField* titleField = [alertViewChangeName textFieldAtIndex: 0];
            titleField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            titleField.autocorrectionType = UITextAutocorrectionTypeDefault;
            [alertViewChangeName show];
            
        }
        else{
            UIAlertView *alertViewChangeName=[[UIAlertView alloc]initWithTitle:@"NEW HIGH SCORE AND STREAK" message:[NSString stringWithFormat:@"Score rank: #%d\nStreak rank: #%d",rank2+1,rank+1] delegate:self cancelButtonTitle:@"..Meh" otherButtonTitles:@"Add Me!",nil];
            alertViewChangeName.alertViewStyle=UIAlertViewStylePlainTextInput;
            UITextField* titleField = [alertViewChangeName textFieldAtIndex: 0];
            titleField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            titleField.autocorrectionType = UITextAutocorrectionTypeDefault;
            [alertViewChangeName show];
        }
    }
    
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GAME OVER!" message:@"Good Effort\nTry Again!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alert show];
    }
    
}

- (void)cancelTimer {
    [self.gameTimer invalidate];
}

//********************************************************


//USER SELECTS AN ANSWER (COLOR BUTTON)
#pragma mark - Methods Chained When Answer Selected
- (IBAction)colorButtonTapped:(UIButton*)sender {
    if (sender.backgroundColor == self.currentColorView.backgroundColor) {
        [self incrementScore];
        [self increaseStreak];
        [self nextQuestion];
    }
    
    else {
        
        [self gameOver];
        [self disableButtons];
    }
}

//*******************************************
#pragma mark - Game START button

//GAME BEGINS

- (IBAction)startGameButton:(UIButton *)sender {
    sender.enabled = NO;
    sender.hidden = YES;
    for(UIButton *b in self.arrayOfButtons){
        
        b.enabled=YES;
        
    }
    
    [self reset];
    
    //DELEGATE METHOD TRIGGERED
    [self.delegate viewController:self startButtonEnabled:sender.enabled];
}


//METHODS THAT WILL EXECUTE WHEN A QUESTION IS ANSWERED CORRECTLY
//SCORE, STREAK, COLOR OF BUTTONS AND UIVIEW, AND TIMER ARE UPDATED ACCORDINGLY
#pragma mark - Methods Executed For Correct Answers
- (void)incrementScore {
    if (self.currentChallenge.speedChallenge) {
        
        float elapsedTime = self.valueForNewTap - self.timerValue;
        if (elapsedTime >= 1) {
            self.score++;
        }
        else{
            self.score+=ceil((1-elapsedTime)*10);
        }
        self.valueForNewTap = self.timerValue;
    }
    else{
        self.score+=ceil([self.timeLabel.text floatValue]*10);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"SCORE: %ld",self.score];
    NSLog(@"%lu", self.score);
}


- (void)increaseStreak {
    self.streak++;
    self.streakLabel.text = [NSString stringWithFormat:@"STREAK: %ld",self.streak];
}

- (void)resetTimer {
    [self cancelTimer];
    if (!self.currentChallenge || !self.currentChallenge.speedChallenge){
        self.timerValue = 1.0;
    }
    self.gameTimer = [NSTimer timerWithTimeInterval:GameTimerInteval target:self selector:@selector(decreaseTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.gameTimer forMode:NSRunLoopCommonModes];
}

#pragma mark - Establish New Answer Color

- (void)setNextColor {
    UIColor *realColor;
    while (YES) {
        
        
        NSInteger nextColor = arc4random_uniform(self.colorsArray.count);
        
        realColor =  [self.colorsArray objectAtIndex:nextColor];
        
        if (realColor==self.currentColor) {
            continue;
        }
        else{
            break;
        }
    }
    self.currentColor = realColor;
    self.currentColorView.backgroundColor = realColor;
    [self setButtonColors];
    
}


//DELEGATE METHODS
#pragma mark - Delegate Methods For Swipes
-(void) swipeRecognized:(UISwipeGestureRecognizer *)swipe{
    [self.delegate viewController:self swipeGesture:swipe];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        return;
    }
    
    
    NSString *userName = [[alertView textFieldAtIndex:0] text];
    if (self.streakRank!=-1) {
        
        [[HighScoresModel sharedModel] addStreak:[NSString stringWithFormat:@"%lu",self.streak] forUser:userName];
    }
    if (self.scoreRank!=-1) {
        [[HighScoresModel sharedModel] addScore:[NSString stringWithFormat:@"%lu",self.score] forUser:userName];
    }
    [self.delegate viewController:self newScoreAdded:YES];
    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"welcomeToTheLeaderBoard"] title:@"Crushing It!" message:@"The leaderboard recognizes your skill"];
}

#pragma mark - Add a Shadow

- (void)addShadow{
    
    [self.view.layer setCornerRadius:0];
    [self.view.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.view.layer setShadowOpacity:0.8];
    [self.view.layer setShadowOffset:CGSizeMake(0,2.5)];
    
}

@end