//
//  UIView+DashLine.h
//  iFun
//
//  Created by HeJi on 16/6/28.
//  Copyright © 2016年 AppFinder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DashLine)

- (void)drawDashLineForLineLength:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor;

- (void)drawDashLineForBorderWithDashLength:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth;

@end
