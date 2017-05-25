//
//  NSString+Size.h
//  GiftGame
//
//  Created by Mac on 16/8/2.
//  Copyright © 2016年 Ruozi. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface NSString (Size)

- (CGSize)getSizeWithMaxHeight:(CGFloat)height font:(UIFont *)font;
- (CGSize)getSizeWithMaxWidth:(CGFloat)width font:(UIFont *)font;

@end
