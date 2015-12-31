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
#import "ColorSets.h"
#import "NSUserDefaults+Updates.h"
#import <pop/POP.h>
#import <MarqueeLabel/MarqueeLabel.h>

NSTimeInterval const GameTimerInteval = 0.01f;

@interface GamePlayViewController () <UIAlertViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic)   IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic)   IBOutlet UILabel *timeLabel;
@property (weak, nonatomic)   IBOutlet UIView *currentColorView;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *arrayOfButtons;
@property (weak, nonatomic)   IBOutlet UIButton *startButton;
@property (weak, nonatomic)   IBOutlet UILabel *streakLabel;
@property (weak, nonatomic)   IBOutlet MarqueeLabel *challengeLabel;

@property (nonatomic) NSTimer *gameTimer;
@property (nonatomic) UIColor *currentColor;
@property (nonatomic) UIAlertAction *addAction;
@property (nonatomic) NSMutableArray *colorsArray;
@property (nonatomic) UIAlertController *alertController;

@property (nonatomic) int      scoreRank;
@property (nonatomic) int      streakRank;
@property (nonatomic) long     score;
@property (nonatomic) long     streak;
@property (nonatomic) float    gameAvg;
@property (nonatomic) float    timerValue;
@property (nonatomic) float    scoreOffset;
@property (nonatomic) float    valueForNewTap;
@property (nonatomic) float    fastestReaction;

@end

@implementation GamePlayViewController
#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];

    self.colorsArray = [NSMutableArray arrayWithArray:[ColorSets getColorSetCurrentlyApplied].colors];

    [self disableButtons];

    //CREATE AND ADD SWIPE GESTURES
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];

    [self addShadow];

    self.challengeLabel.marqueeType = MLContinuous;
    if (self.currentChallenge) {
        [self updateChallengeLabelText];
    }
    else{
        self.challengeLabel.hidden = YES;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postLocalNotificationForNewColorSetUnlocks) name:@"NewColorsUnlocked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addScoreOrStreak:) name:@"NewHighScoreOrStreak" object:nil];
}

#pragma mark - GAME SETUP Methods
- (void)reset {
    self.score = 0;
    self.streak = 0;
    self.streakLabel.text = @"STREAK: 0";
    self.scoreLabel.text = @"SCORE: 0";
    self.fastestReaction = [[[[NSUserDefaults standardUserDefaults]objectForKey:@"stats"]objectForKey:@"fastestReactionTime"] floatValue];
    self.fastestReaction = self.fastestReaction > 0.0f ? self.fastestReaction : 100.f;
    self.gameAvg = 0.0f;
    if (self.currentChallenge) {
        if (self.currentChallenge.speedChallenge) {
            self.timerValue = [[self.currentChallenge valueForKey:@"timeMax"] floatValue];
            self.valueForNewTap = self.timerValue;
        }
    }
    else{
        self.timerValue = 1.0;
    }
    self.scoreOffset = 0;
    [self nextQuestion];
}

- (void)nextQuestion{

    [self setNextColor];
    [self resetTimer];

}

- (void)disableButtons{

    for(UIButton *b in self.arrayOfButtons){
        b.enabled=NO;

    }
}

- (void)updateChallengeLabelText{

    if (self.currentChallenge) {
        self.challengeLabel.text = [NSString stringWithFormat:@"%@     Progress: %@/%@", self.currentChallenge.challengeDescription, self.currentChallenge.currentNumberOfSuccesses,self.currentChallenge.numberOfSuccessesNeeded];
        self.challengeLabel.animationDelay = 2.5f;
        self.timeLabel.hidden = YES;
    }
}

- (void)swapTimeLabelForChallengeLabel{
    if (self.currentChallenge) {
        self.challengeLabel.hidden = NO;
        self.timeLabel.hidden = YES;
    }
}

#pragma mark - Algorithm To Set Button Colors With No Duplicates or Repeats
- (void)setButtonColors{

    NSMutableArray *tempColorsArray = [NSMutableArray new];
    for (int i = 0; i<2; i++) {
        while (YES) {
            NSInteger indexForColor = arc4random_uniform((int)self.colorsArray.count);

            UIColor *color =  [self.colorsArray objectAtIndex:indexForColor];

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


- (void)decreaseTimer{
    self.timerValue -=.01;
    self.timeLabel.text = [NSString stringWithFormat:@"%.2f",self.timerValue];
    if (self.timerValue<=0.01) {
        self.timeLabel.text = @"0.00";
        [self gameOver];
    }


}

#pragma mark - Game Over Methods

- (void)gameOver {

    //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    if ([NSUserDefaults vibrationStatus]) {
        AudioServicesPlayAlertSound(1306);
    }

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
            if (self.streak >= [self.currentChallenge.streakMax integerValue] && self.currentChallenge.currentNumberOfSuccesses<self.currentChallenge.numberOfSuccessesNeeded) {
                [self.currentChallenge setValue:@([self.currentChallenge.currentNumberOfSuccesses integerValue]+1) forKey:@"currentNumberOfSuccesses"];
                if (self.currentChallenge.currentNumberOfSuccesses==self.currentChallenge.numberOfSuccessesNeeded) {
                    [self.currentChallenge setValue:self.currentChallenge.numberOfSuccessesNeeded forKey:@"currentNumberOfSuccesses"];
                    [self.currentChallenge setValue:[NSNumber numberWithBool:YES] forKey:@"completed"];
                    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"welcomeToTheLeaderBoard"] title:@"Crushing It!" message:@"Challenge complete!"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:
                     @"ChallengeCompleted" object:self.currentChallenge];
                    break;
                }
                break;
            }
            else if ((self.currentChallenge.consecutiveChallenge) && ([self.currentChallenge valueForKey:@"currentNumberOfSuccesses"]!=self.currentChallenge.numberOfSuccessesNeeded) && ([self.currentChallenge.currentNumberOfSuccesses integerValue]>0)){
                [self.currentChallenge setValue:@0 forKey:@"currentNumberOfSuccesses"];
                [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"welcomeToTheLeaderBoard"] title:@"Bad News" message:@"Consecutive Challenge Has Been Reset"];
                break;
            }
            break;
        }
        else if(self.currentChallenge.scoreChallenge) {
            if (self.score >= [self.currentChallenge.scoreMax integerValue] && self.currentChallenge.currentNumberOfSuccesses<self.currentChallenge.numberOfSuccessesNeeded) {
                [self.currentChallenge setValue:@([self.currentChallenge.currentNumberOfSuccesses integerValue]+1) forKey:@"currentNumberOfSuccesses"];
                if (self.currentChallenge.currentNumberOfSuccesses==self.currentChallenge.numberOfSuccessesNeeded) {
                    [self.currentChallenge setValue:self.currentChallenge.numberOfSuccessesNeeded forKey:@"currentNumberOfSuccesses"];
                    [self.currentChallenge setValue:[NSNumber numberWithBool:YES] forKey:@"completed"];
                    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"welcomeToTheLeaderBoard"] title:@"Crushing It!" message:@"Challenge complete!"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:
                     @"ChallengeCompleted" object:self.currentChallenge];
                    break;
                }
                break;
            }
            else if (self.currentChallenge.consecutiveChallenge && [self.currentChallenge valueForKey:@"currentNumberOfSuccesses"]!=self.currentChallenge.numberOfSuccessesNeeded && self.currentChallenge.currentNumberOfSuccesses!=0){

                [self.currentChallenge setValue:@0 forKey:@"currentNumberOfSuccesses"];

                [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"welcomeToTheLeaderBoard"] title:@"Bad News" message:@"Consecutive Challenge Has Been Reset"];
                break;
            }
            break;
        }
        break;
    }

    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext save:nil];

    [self checkForNewStreak];
    [self updateStats];

}


- (void)checkForNewStreak{
    int rank = [[HighScoresModel sharedModel] isNewStreak:[NSString stringWithFormat:@"%lu",self.streak]];
    int rank2 = [[HighScoresModel sharedModel] isNewScore:[NSString stringWithFormat:@"%lu",self.score]];
    self.streakRank = rank;
    self.scoreRank = rank2;
    if (rank > -1 || rank2 > -1) {

        if(rank > -1 && rank2 == -1){

            [self launchAlertControllerWithTitle:@"NEW HIGH STREAK!" andMessage:[NSString stringWithFormat:@"Streak rank: #%d",rank+1]];
        }
        else if(rank == -1 && rank2>-1){

            [self launchAlertControllerWithTitle:@"NEW HIGH STREAK!" andMessage:[NSString stringWithFormat:@"Score rank: #%d",rank2+1]];
        }
        else{

            [self launchAlertControllerWithTitle:@"NEW HIGH STREAK!" andMessage:[NSString stringWithFormat:@"Score rank: #%d\nStreak rank: #%d",rank2+1,rank+1]];
        }
    }

    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GAME OVER!" message:@"Good Effort\nTry Again!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        alert.delegate = self;
        [alert show];
    }

}


- (void)updateStats{

    NSMutableDictionary *newStats = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"stats"]];

    float averageReaction = ([newStats[@"averageReactionTime"]floatValue]*[newStats[@"streakToDate"]floatValue] + self.gameAvg);
    averageReaction = averageReaction>0? averageReaction/([newStats[@"streakToDate"]floatValue]+self.streak) : 0.0f;
    [newStats removeObjectForKey:@"averageReactionTime"];
    [newStats setObject:[NSNumber numberWithFloat:averageReaction] forKey:@"averageReactionTime"];

    NSInteger newScoreToDate = [newStats[@"scoreToDate"] integerValue];
    newScoreToDate += self.score;
    [newStats removeObjectForKey:@"scoreToDate"];
    [newStats setObject:[NSNumber numberWithInteger:newScoreToDate] forKey:@"scoreToDate"];

    NSInteger newStreakToDate = [newStats[@"streakToDate"] integerValue];
    newStreakToDate += self.streak;
    [newStats removeObjectForKey:@"streakToDate"];
    [newStats setObject:[NSNumber numberWithInteger:newStreakToDate] forKey:@"streakToDate"];

    NSInteger newHighScore = [newStats[@"highestScore"] integerValue];
    if (self.score > newHighScore) {
        [newStats removeObjectForKey:@"highestScore"];
        [newStats setObject:[NSNumber numberWithInteger:self.score] forKey:@"highestScore"];
    }
    NSInteger newLongestStreak = [newStats[@"longestStreak"] integerValue];
    if (self.streak > newLongestStreak) {
        [newStats removeObjectForKey:@"longestStreak"];
        [newStats setObject:[NSNumber numberWithInteger:self.streak] forKey:@"longestStreak"];
    }

    [newStats removeObjectForKey:@"fastestReactionTime"];
    [newStats setObject:[NSNumber numberWithFloat:self.fastestReaction] forKey:@"fastestReactionTime"];

    [[NSUserDefaults standardUserDefaults]setObject:newStats forKey:@"stats"];

}

- (void)cancelTimer {
    [self.gameTimer invalidate];
}


#pragma mark - Methods Chained When Answer Selected
- (IBAction)colorButtonTapped:(UIButton*)sender {
    if ([sender.backgroundColor isEqual: self.currentColorView.backgroundColor]) {
        [self incrementScore];
        [self increaseStreak];
        [self nextQuestion];
    }

    else {

        [self gameOver];
        [self disableButtons];
    }
}


#pragma mark - Game START button

- (IBAction)startGameButton:(UIButton *)sender {
    sender.enabled = NO;
    sender.hidden = YES;

    self.challengeLabel.hidden = YES;
    self.timeLabel.hidden = NO;

    for(UIButton *b in self.arrayOfButtons){
        
        b.enabled=YES;
    }

    [self reset];

    NSMutableDictionary *newStats = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"stats"]];

    NSInteger gamesPlayed = [newStats[@"gamesPlayed"] integerValue];
    gamesPlayed++;

    [newStats removeObjectForKey:@"gamesPlayed"];
    [newStats setObject:[NSNumber numberWithInteger:gamesPlayed] forKey:@"gamesPlayed"];

    [[NSUserDefaults standardUserDefaults]setObject:newStats forKey:@"stats"];

    [self.delegate viewController:self startButtonEnabled:sender.enabled];
}



#pragma mark - Methods Executed For Correct Answers
- (void)incrementScore {
    if (self.currentChallenge.speedChallenge) {

        float elapsedTime = self.valueForNewTap - self.timerValue;
        if (elapsedTime >= 1) {
            self.score++;
        }
        else{
            self.score+=(ceil((1-elapsedTime)*10)+self.scoreOffset);
        }
        self.valueForNewTap = self.timerValue;
        self.gameAvg += elapsedTime;
        self.fastestReaction = self.fastestReaction > elapsedTime? elapsedTime:self.fastestReaction;
    }
    else{
        self.score+=ceil([self.timeLabel.text floatValue]*10);
        self.gameAvg += 1 - [self.timeLabel.text floatValue];
        float comp = 1 - [self.timeLabel.text floatValue];
        self.fastestReaction = self.fastestReaction > (comp)? comp:self.fastestReaction;
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
    if ([self.currentChallenge.challengeIDNumber floatValue]>=3) {
        self.timerValue = 1.0 - .05*(self.streak/5);
        self.scoreOffset = floor(-1*(self.timerValue - 1.0)*10);
        if (self.timerValue<=.5) {
            self.timerValue = .5;
            self.scoreOffset = 5;
        }
        self.valueForNewTap = self.timerValue;
    }
    self.gameTimer = [NSTimer timerWithTimeInterval:GameTimerInteval target:self selector:@selector(decreaseTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.gameTimer forMode:NSRunLoopCommonModes];
}

#pragma mark - Establish New Answer Color

- (void)setNextColor {
    UIColor *realColor;
    while (YES) {


        NSInteger nextColor = arc4random_uniform((int)self.colorsArray.count);

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


#pragma mark - Delegate Methods For Swipes
-(void) swipeRecognized:(UISwipeGestureRecognizer *)swipe{
    [self.delegate viewController:self swipeGesture:swipe];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [self swapTimeLabelForChallengeLabel];
    [self updateChallengeLabelText];

    if (buttonIndex == 0) {
        [self.view endEditing:YES];
        return;
    }
}
- (void)launchAlertControllerWithTitle:(NSString *)title andMessage:(NSString *)message{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Name";
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];

    }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Nah" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.view endEditing:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    if (!self.addAction){

        UIAlertAction *add = [UIAlertAction actionWithTitle:@"Add me!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            UITextField *nameTextField = alert.textFields.firstObject;
                [self.view endEditing:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NewHighScoreOrStreak" object:nameTextField.text];
                [self dismissViewControllerAnimated:YES completion:nil];

        }];

        self.addAction = add;
        self.addAction.enabled = NO;
    }

    [alert addAction:cancel];
    [alert addAction:self.addAction];

    [self swapTimeLabelForChallengeLabel];

    [self updateChallengeLabelText];

    self.alertController = alert;

    [self presentViewController:alert animated:YES completion:nil];

}

- (void)addScoreOrStreak:(NSNotification *)notif{

    NSString *name = notif.object;

    if (self.streakRank!=-1) {
        [[HighScoresModel sharedModel] addStreak:[NSString stringWithFormat:@"%lu",self.streak] forUser:name];
    }

    if (self.scoreRank!=-1) {
        [[HighScoresModel sharedModel] addScore:[NSString stringWithFormat:@"%lu",self.score] forUser:name];
    }

    [self.delegate viewController:self newScoreAdded:YES];

    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"welcomeToTheLeaderBoard"] title:@"Crushing It!" message:@"The leaderboard recognizes your skill"];

    self.addAction.enabled = NO;

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.alertController.textFields.firstObject];
}

#pragma MARK - UIConfiguration
- (void)addShadow{
    
    [self.view.layer setCornerRadius:0];
    [self.view.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.view.layer setShadowOpacity:0.8];
    [self.view.layer setShadowOffset:CGSizeMake(0,2.5)];
    
}

#pragma MARK - Notification Response Method
- (void)postLocalNotificationForNewColorSetUnlocks{
    
    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"welcomeToTheLeaderBoard"] title:@"Color Sets" message:@"New color sets unlocked!"];
}

- (void)handleTextFieldDidChange:(NSNotification *)notif{
    UITextField *textField = notif.object;

    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length >= 1) {

        self.addAction.enabled = YES;
    }
    else{
        self.addAction.enabled = NO;
    }
}

@end