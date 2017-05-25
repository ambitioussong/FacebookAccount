//
//  UIImage+Size.m
//  GiftGame
//
//  Created by Dai Pei on 2016/11/13.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (Size)

+ (UIImage *)imageNamed:(NSString *)name size:(CGSize)size {
    UIImage *img = [UIImage imageNamed:name];
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
