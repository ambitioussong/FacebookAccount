//
//  UIImage+MaskedColor.m
//  GiftGame
//
//  Created by Jason on 16/9/18.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import "UIImage+MaskedColor.h"

@implementation UIImage (Alpha)

+ (UIImage *)imageNamed:(NSString *)name andMaskedWithcolor:(UIColor *)color
{
    UIImage *image = [UIImage imageNamed:name];
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    [image drawInRect:rect];
    CGContextSetFillColorWithColor(c, [color CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

@end
