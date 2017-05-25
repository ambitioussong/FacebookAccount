//
//  UIView+BoxShake.m
//  DCGame
//
//  Created by HeJi on 17/4/13.
//  Copyright © 2017年 Sawadee. All rights reserved.
//

#import "UIView+BoxShake.h"


static NSString *const shakeAnimationKey = @"ViewShakeAnimationKey";


@implementation UIView (BoxShake)

- (void)startShakeAnimation {
    if (![self.layer animationForKey:shakeAnimationKey]) {
        
        NSInteger shakeTimes = arc4random() % 4 + 40;
        
        CGFloat maxXOffset = CGRectGetWidth(self.frame) * 0.015;
        CGFloat maxYOffset = CGRectGetHeight(self.frame) * 0.015;
        CGFloat maxRotateOffset = 0.02 * M_PI;
        
        NSMutableArray *shakePositions = [NSMutableArray arrayWithObject:[NSValue valueWithCGPoint:self.center]];
        NSMutableArray *shakeRotations = [NSMutableArray arrayWithObject:@(0)];
        
        for (int shakeIndex = 0; shakeIndex < shakeTimes; shakeIndex++) {
            double xrValue = [self randomValueFrom:-1 to:1];
            double yrValue = [self randomValueFrom:-1 to:1];
            double rrValue = [self randomValueFrom:-1 to:1];
            
            CGPoint shakePoint = CGPointMake(CGRectGetMidX(self.frame) + xrValue * maxXOffset, CGRectGetMidY(self.frame) + yrValue * maxYOffset);
            [shakePositions addObject:[NSValue valueWithCGPoint:shakePoint]];
            
            CGFloat shakeRotation = maxRotateOffset * rrValue;
            [shakeRotations addObject:@(shakeRotation)];
        }
        
        [shakePositions addObject:[NSValue valueWithCGPoint:self.center]];
        [shakeRotations addObject:@(0)];
        
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animation];
        positionAnimation.keyPath = @"position";
        positionAnimation.values = shakePositions;
        positionAnimation.duration = 1.2;
        
        CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animation];
        rotationAnimation.keyPath = @"transform.rotation";
        rotationAnimation.values = shakeRotations;
        rotationAnimation.duration = 1.2;
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.animations = @[positionAnimation, rotationAnimation];
        animationGroup.duration = 1.2;
        animationGroup.removedOnCompletion = NO;
        animationGroup.fillMode = kCAFillModeForwards;
        animationGroup.repeatCount = HUGE_VAL;
        
        [self.layer addAnimation:animationGroup forKey:shakeAnimationKey];
    }
}

- (void)stopShakeAnimation {
    [self.layer removeAnimationForKey:shakeAnimationKey];
}

- (double)randomValueFrom:(double)from to:(double)to {
    return (double)arc4random() / RAND_MAX * (to - from) + from;
}

@end
