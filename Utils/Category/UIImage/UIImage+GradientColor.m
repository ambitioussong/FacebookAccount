//
//  UIImage+GradientColor.m
//  DCGame
//
//  Created by DaiPei on 2017/4/14.
//  Copyright © 2017年 Sawadee. All rights reserved.
//

#import "UIImage+GradientColor.h"

@implementation UIImage (GradientColor)

+ (UIImage *)imageWithGradientColorFromTop:(UIColor *)top toBottom:(UIColor *)bottom size:(CGSize)size {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    gradientLayer.colors = @[(id)top.CGColor, (id)bottom.CGColor];
    
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
