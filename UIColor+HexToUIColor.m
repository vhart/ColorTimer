//
//  UIColor+HexToUIColor.m
//  ColorTimer
//
//  Created by Varindra Hart on 12/28/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "UIColor+HexToUIColor.h"

@implementation UIColor (HexToUIColor)
//Code snippet via http://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string - darrinm
//Assume Hex String does not contain #

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:0];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
