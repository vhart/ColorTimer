//
//  UIColor+HexToUIColor.h
//  ColorTimer
//
//  Created by Varindra Hart on 12/28/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexToUIColor)

+ (UIColor *)colorFromHexString:(NSString *)hexString;

@end
