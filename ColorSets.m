//
//  ColorSets.m
//  ColorTimer
//
//  Created by Varindra Hart on 11/15/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "ColorSets.h"
#import "UIColor+HexToUIColor.h"

@implementation ColorSets

+ (NSArray <ColorSets *> *)getAllColorSets{

    NSMutableArray <ColorSets *> *allColorSets = [NSMutableArray new];

    for (int i = 0; i < 6; i++) {
        [allColorSets addObject:[self getColorSetForValue:i]];
    }

    return allColorSets;
}

+ (ColorSets *)getColorSetCurrentlyApplied{

    int applied = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppliedColorSetValue"]intValue];
    return [self getColorSetForValue:applied];

}

+ (ColorSets *)getColorSetForValue:(int)value{

    switch (value) {
        case ColorSetTypeDEFAULT:
        {
            return [self getColorSetDefault];
            break;
        }
        case ColorSetTypeGREENCOMPLETE:
        {
            return [self getColorSetGreenComplete];
            break;
        }
        case ColorSetTypeBLUECOMPLETE:
        {
            return [self getColorSetBlueComplete];
            break;
        }
        case ColorSetTypeREDCOMPLETE:
        {
            return [self getColorSetRedComplete];
            break;
        }
        case ColorSetTypeBLACKCOMPLETE:
        {
            return [self getColorSetBlackComplete];
            break;
        }
        case ColorSetTypeMASTERED:
        {
            return [self getColorSetMastered];
            break;
        }
        default:
            return nil;
            break;
    }

}

+ (ColorSets *)getColorSetDefault{

    ColorSets *colorset = [ColorSets new];
    colorset.colors = [NSArray arrayWithObjects:
                       [UIColor blackColor],
                       [UIColor orangeColor],
                       [UIColor cyanColor],
                       [UIColor brownColor],
                       [UIColor purpleColor],
                       [UIColor magentaColor],
                       [UIColor redColor],
                       [UIColor yellowColor],
                        nil];
    colorset.unlocked = YES;
    colorset.challengeDescription = @"";
    colorset.title = @"Simple";
    colorset.setType = ColorSetTypeDEFAULT;
    return colorset;

}

+ (ColorSets *)getColorSetGreenComplete{

    NSString *stringOfHexsForSet = @"0D2C54 7FB800 00A6ED FFB400 F6511D E63946 457B9D 32936F";

    ColorSets *colorset = [ColorSets new];

    colorset.colors = [colorset colorsFromStringOfHexs:stringOfHexsForSet];

    colorset.title = @"Welcome To The Club";

    colorset.challengeDescription = @"Complete all green level challenges";

    colorset.unlocked = [[[NSUserDefaults standardUserDefaults]objectForKey:@"GreenComplete"] boolValue];

    colorset.applied = NO;

    colorset.setType = ColorSetTypeGREENCOMPLETE;
    
    return colorset;
}

+ (ColorSets *)getColorSetRedComplete{

    NSString *stringOfHexsForSet = @"C9CBA3 FFE1A8 E26D5C 472D30 527F1F F15946 BC7247 DB504A";

    ColorSets *colorset = [ColorSets new];

    colorset.colors = [colorset colorsFromStringOfHexs:stringOfHexsForSet];

    colorset.title = @"Autumn";

    colorset.challengeDescription = @"Complete all red level challenges";

    colorset.unlocked = [[[NSUserDefaults standardUserDefaults]objectForKey:@"RedComplete"] boolValue];

    colorset.applied = NO;

    colorset.setType = ColorSetTypeREDCOMPLETE;
    
    return colorset;

}

+ (ColorSets *)getColorSetBlueComplete{
    NSString *stringOfHexsForSet = @"4281C0 62AFB7 E6B27B FBF28A FE9342 00B398 00DFFF CD5334";

    ColorSets *colorset = [ColorSets new];

    colorset.colors = [colorset colorsFromStringOfHexs:stringOfHexsForSet];

    colorset.title = @"Surfs Up";

    colorset.challengeDescription = @"Complete all blue level challenges";

    colorset.unlocked = [[[NSUserDefaults standardUserDefaults]objectForKey:@"BlueComplete"] boolValue];

    colorset.applied = NO;

    colorset.setType = ColorSetTypeBLUECOMPLETE;
    
    return colorset;
}

+ (ColorSets *)getColorSetBlackComplete{
    NSString *stringOfHexsForSet = @"C2E7D9 A6CFD5 2A4F91 0B3049 0C0121 9E1111 391F51 FCEC3F";

    ColorSets *colorset = [ColorSets new];

    colorset.colors = [colorset colorsFromStringOfHexs:stringOfHexsForSet];

    colorset.title = @"Cosmos";

    colorset.challengeDescription = @"Complete all black level challenges";

    colorset.unlocked = [[[NSUserDefaults standardUserDefaults]objectForKey:@"BlackComplete"] boolValue];

    colorset.applied = NO;

    colorset.setType = ColorSetTypeBLACKCOMPLETE;
    
    return colorset;
}

+ (ColorSets *)getColorSetMastered{
    NSString *stringOfHexsForSet = @"B3001B 262626 C1C1C1 358AEA 3CA529 CC9900 C16B1B 26547C";

    ColorSets *colorset = [ColorSets new];

    colorset.colors = [colorset colorsFromStringOfHexs:stringOfHexsForSet];

    colorset.title = @"Color Master";

    colorset.challengeDescription = @"Complete all challenges";

    colorset.unlocked = [[[NSUserDefaults standardUserDefaults]objectForKey:@"MasteredComplete"] boolValue];

    colorset.applied = NO;

    colorset.setType = ColorSetTypeMASTERED;
    
    return colorset;
}

- (NSArray <UIColor *> *)colorsFromStringOfHexs:(NSString *)longHexString{

    NSMutableArray <UIColor *> *colorsArray = [NSMutableArray new];

    for (NSString *hex in [self getAllHexStringsFrom:longHexString]) {

        [colorsArray addObject:[UIColor colorFromHexString:hex]];
    }

    return colorsArray;

}

- (NSArray <NSString *> *)getAllHexStringsFrom:(NSString *)longHexString{

    return [longHexString componentsSeparatedByString:@" "];

}


@end
