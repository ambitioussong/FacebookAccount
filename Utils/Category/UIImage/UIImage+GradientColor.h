//
//  UIImage+GradientColor.h
//  DCGame
//
//  Created by DaiPei on 2017/4/14.
//  Copyright © 2017年 Sawadee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GradientColor)

+ (UIImage *)imageWithGradientColorFromTop:(UIColor *)top toBottom:(UIColor *)bottom size:(CGSize)size;

@end
