//
//  UIImage+colorToImage.m
//  DCGame
//
//  Created by GeekSprite on 2017/4/11.
//  Copyright © 2017年 Sawadee. All rights reserved.
//

#import "UIImage+colorToImage.h"

@implementation UIImage (colorToImage)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    CGContextFillRect(context, rect);

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    

    
    return img;
    
    
}

@end
