//
//  NSUserDefaults+Updates.h
//  ColorTimer
//
//  Created by Varindra Hart on 12/29/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Updates)

- (void)updateColorSetStatusForChallengeSection:(int)section;

+ (BOOL)vibrationStatus;

@end
