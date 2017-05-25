//
//  UIViewController+GradientBGColor.m
//  DCGame
//
//  Created by DaiPei on 2017/4/14.
//  Copyright © 2017年 Sawadee. All rights reserved.
//

#import "UIViewController+GradientBGColor.h"

@implementation UIViewController (GradientBGColor)

- (void)setBackgroundToGradientColorFromTop:(UIColor *)top toBottom:(UIColor *)bottom {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = @[(id)top.CGColor, (id)bottom.CGColor];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}


@end
