//
//  Challenge+CoreDataProperties.h
//  ColorTimer
//
//  Created by Varindra Hart on 10/5/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "Challenge.h"

NS_ASSUME_NONNULL_BEGIN

@interface Challenge (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *challengeDescription;
@property (nullable, nonatomic, retain) NSNumber *speedChallenge;
@property (nullable, nonatomic, retain) NSNumber *streakChallenge;
@property (nullable, nonatomic, retain) NSNumber *consecutiveChallenge;
@property (nullable, nonatomic, retain) NSNumber *scoreChallenge;
@property (nullable, nonatomic, retain) NSNumber *streakMax;
@property (nullable, nonatomic, retain) NSNumber *scoreMax;
@property (nullable, nonatomic, retain) NSNumber *timeMax;
@property (nullable, nonatomic, retain) NSNumber *numberOfSuccessesNeeded;
@property (nullable, nonatomic, retain) NSNumber *currentNumberOfSuccesses;
@property (nullable, nonatomic, retain) NSNumber *completed;
@property (nullable, nonatomic, retain) NSNumber *averageScorePerSec;
@property (nullable, nonatomic, retain) NSNumber *averageStreakPerSec;
@property (nullable, nonatomic, retain) NSNumber *challengeIDNumber;
@property (nullable, nonatomic, retain) NSString *challengeCompletedMessage;

@end

NS_ASSUME_NONNULL_END
