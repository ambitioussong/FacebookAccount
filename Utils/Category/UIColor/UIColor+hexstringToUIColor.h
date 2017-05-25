//
//  UIColor+hexstringToUIColor.h
//  PopU
//
//  Created by Jerry on 13-11-7.
//  Copyright (c) 2013年 Pinssible. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (hexstringToUIColor)

+ (UIColor *)hexStringToColor:(NSString *)stringToConvert;
+ (UIColor *)hexStringToColor:(NSString *)stringToConvert alpha:(CGFloat)alpha;

@end
