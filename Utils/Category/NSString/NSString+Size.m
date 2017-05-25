//
//  NSString+Size.m
//  GiftGame
//
//  Created by Mac on 16/8/2.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)getSizeWithMaxHeight:(CGFloat)height font:(UIFont *)font
{
    CGSize constraintSize;
    constraintSize.height = height;
    constraintSize.width = MAXFLOAT;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect frame = [self boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
    return frame.size;
}

- (CGSize)getSizeWithMaxWidth:(CGFloat)width font:(UIFont *)font {
    CGSize constraintSize;
    constraintSize.height = MAXFLOAT;
    constraintSize.width = width;
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect frame = [self boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
    return frame.size;
}

@end
