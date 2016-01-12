//
//  Challenge.m
//  ColorTimer
//
//  Created by Varindra Hart on 10/5/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "Challenge.h"

@implementation Challenge

// Insert code here to add functionality to your managed object subclass
- (BOOL)wasChallengeGoalMetScore:(int)score andStreak:(int)streak{

    if ([self.scoreChallenge boolValue]) {
        if (score < [self.scoreMax intValue]) {
            return NO;
        }
    }
    if ([self.streakChallenge boolValue]) {
        if (streak < [self.streakMax intValue]) {
            return NO;
        }
    }

    return YES;
}
@end
