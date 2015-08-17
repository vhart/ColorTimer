//
//  HighScoresModel.m
//  ColorTimer
//
//  Created by Varindra Hart on 8/17/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "HighScoresModel.h"

@implementation HighScoresModel

+ (HighScoresModel *)sharedModel {
    static HighScoresModel *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.scoresData = [[NSMutableArray alloc] init];
    });
    return sharedMyManager;
}
@end
