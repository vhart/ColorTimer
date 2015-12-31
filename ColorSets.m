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

    int applied = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ColorSetTypeApplied"]intValue];
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

    colorset.challengeDescription = @"Default color set";

    colorset.title = @"Basic";

    colorset.setType = ColorSetTypeDEFAULT;

    colorset.applied = [colorset isApplied];

    return colorset;

}

+ (ColorSets *)getColorSetGreenComplete{

    NSString *stringOfHexsForSet = @"0D2C54 A0DD95 00A6ED FFE838 FF8006 E11D25 BBFFFF 00CC36";

    ColorSets *colorset = [ColorSets new];

    colorset.colors = [colorset colorsFromStringOfHexs:stringOfHexsForSet];

    colorset.title = @"Uprising";

    colorset.challengeDescription = @"Complete all green level challenges";

    colorset.unlocked = [[[NSUserDefaults standardUserDefaults]objectForKey:@"GreenComplete"] boolValue];

    colorset.setType = ColorSetTypeGREENCOMPLETE;

    colorset.applied = [colorset isApplied];

    return colorset;
}

+ (ColorSets *)getColorSetRedComplete{

    NSString *stringOfHexsForSet = @"F76D02 FFFB1E 2078AA 472D30 527F1F 8C3664 89522C B21A1A";

    ColorSets *colorset = [ColorSets new];

    colorset.colors = [colorset colorsFromStringOfHexs:stringOfHexsForSet];

    colorset.title = @"Autumn";

    colorset.challengeDescription = @"Complete all red level challenges";

    colorset.unlocked = [[[NSUserDefaults standardUserDefaults]objectForKey:@"RedComplete"] boolValue];

    colorset.setType = ColorSetTypeREDCOMPLETE;

    colorset.applied = [colorset isApplied];

    return colorset;

}

+ (ColorSets *)getColorSetBlueComplete{
    NSString *stringOfHexsForSet = @"2183DF 1CD9BE CFA77D FBFF66 F98451 9078C3 00DFFF FA6261";

    ColorSets *colorset = [ColorSets new];

    colorset.colors = [colorset colorsFromStringOfHexs:stringOfHexsForSet];

    colorset.title = @"Surfs Up";

    colorset.challengeDescription = @"Complete all blue level challenges";

    colorset.unlocked = [[[NSUserDefaults standardUserDefaults]objectForKey:@"BlueComplete"] boolValue];

    colorset.setType = ColorSetTypeBLUECOMPLETE;

    colorset.applied = [colorset isApplied];

    colorset.unlocked = YES;

    return colorset;
}

+ (ColorSets *)getColorSetBlackComplete{
    NSString *stringOfHexsForSet = @"5A3082 6296A2 CB6298 969696 2374AA 0C0121 E02138 FCEC3F";

    ColorSets *colorset = [ColorSets new];

    colorset.colors = [colorset colorsFromStringOfHexs:stringOfHexsForSet];

    colorset.title = @"Cosmos";

    colorset.challengeDescription = @"Complete all black level challenges";

    colorset.unlocked = [[[NSUserDefaults standardUserDefaults]objectForKey:@"BlackComplete"] boolValue];

    colorset.setType = ColorSetTypeBLACKCOMPLETE;

    colorset.applied = [colorset isApplied];

    return colorset;
}

+ (ColorSets *)getColorSetMastered{
    NSString *stringOfHexsForSet = @"B3001B 262626 C1C1C1 358AEA 3CA529 CC9900 C16B1B 26547C";

    ColorSets *colorset = [ColorSets new];

    colorset.colors = [colorset colorsFromStringOfHexs:stringOfHexsForSet];

    colorset.title = @"Color Master";

    colorset.challengeDescription = @"Complete all challenges";

    colorset.unlocked = [[[NSUserDefaults standardUserDefaults]objectForKey:@"MasteredComplete"] boolValue];

    colorset.setType = ColorSetTypeMASTERED;

    colorset.applied = [colorset isApplied];

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

- (BOOL)isApplied{

    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"ColorSetTypeApplied"] intValue] == self.setType){
        return  YES;
    }

    return  NO;

}
@end
