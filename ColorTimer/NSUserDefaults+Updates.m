//
//  NSUserDefaults+Updates.m
//  ColorTimer
//
//  Created by Varindra Hart on 12/29/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "NSUserDefaults+Updates.h"

@implementation NSUserDefaults (Updates)

- (void)updateColorSetStatusForChallengeSection:(int)section{

    NSArray <NSString *> * challengeKeys = @[@"GreenComplete",@"BlueComplete",@"RedComplete",@"BlackComplete",@"MasteredComplete"];

    [self setObject:@YES forKey:challengeKeys[section]];
    [self updateForMasteredIfNeeded];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"NewColorsUnlocked" object:nil];
}

- (void)updateForMasteredIfNeeded{

    NSArray <NSString *> * challengeKeys = @[@"GreenComplete",@"BlueComplete",@"RedComplete",@"BlackComplete"];

    for (NSString *key in challengeKeys) {
        if ([[self objectForKey:key] boolValue] == NO) {
            return;
        }
    }

    [self setObject:@YES forKey:@"MasteredComplete"];
}

+ (BOOL)vibrationStatus{

    return [[[self standardUserDefaults] objectForKey:@"Vibrations"] boolValue];
}

@end
