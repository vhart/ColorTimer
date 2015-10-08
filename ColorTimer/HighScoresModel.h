//
//  HighScoresModel.h
//  ColorTimer
//
//  Created by Varindra Hart on 8/17/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScoresModel : NSObject

+(HighScoresModel *)sharedModel;

@property (nonatomic) NSMutableArray *highStreakData;
@property (nonatomic) NSMutableArray *highScoreData;

- (int)isNewStreak:(NSString *)streak ;
- (void)addStreak:(NSString *)streak forUser:(NSString *)userName;

- (int)isNewScore:(NSString *)score;
- (void)addScore:(NSString *)score forUser:(NSString *)userName;
@end
