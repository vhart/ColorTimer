//
//  ColorSets.h
//  ColorTimer
//
//  Created by Varindra Hart on 11/15/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum ColorSetEnum{

    ColorSetTypeDEFAULT = 0,
    ColorSetTypeGREENCOMPLETE = 1,
    ColorSetTypeBLUECOMPLETE,
    ColorSetTypeREDCOMPLETE,
    ColorSetTypeBLACKCOMPLETE,
    ColorSetTypeMASTERED,

}ColorSetType;

@interface ColorSets : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *challengeDescription;
@property (nonatomic) BOOL unlocked;
@property (nonatomic) BOOL applied;
@property (nonatomic) NSArray <UIColor *> *colors;
@property (nonatomic) ColorSetType setType;

+ (NSArray <ColorSets *> *)getAllColorSets;
+ (ColorSets *)getColorSetCurrentlyApplied;
@end
