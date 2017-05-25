//
//  UIView+DashLine.m
//  iFun
//
//  Created by HeJi on 16/6/28.
//  Copyright © 2016年 AppFinder. All rights reserved.
//

#import "UIView+DashLine.h"

@implementation UIView (DashLine)

- (void)drawDashLineForLineLength:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor
{
    if ([[[self layer] sublayers] objectAtIndex:0])
    {
        self.layer.sublayers = nil;
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:lineColor.CGColor];
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:@(lineLength), @(lineSpacing), nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [self.layer addSublayer:shapeLayer];
}

- (void)drawDashLineForBorderWithDashLength:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    [shapeLayer setLineWidth:lineWidth];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:lineColor.CGColor];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:@(lineLength), @(lineSpacing), nil]];
    shapeLayer.lineCap = @"square";
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2)];
    shapeLayer.bounds = self.frame;
    [shapeLayer setPath:[UIBezierPath bezierPathWithRoundedRect:self.frame cornerRadius:self.layer.cornerRadius].CGPath];
    [self.layer addSublayer:shapeLayer];
}
@end
