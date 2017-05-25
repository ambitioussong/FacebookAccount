//
//  UIView+Animation.m
//  GiftGame
//
//  Created by Andres He on 8/27/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

/**
 *  For the animation effects of gift box
 *
 *  @param enabled BOOL
 */
- (void)setShakeStatus:(BOOL)enabled
{
    if (enabled)
    {
        CGFloat rotation = 0.05f;
        
        CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
        shake.duration = 0.1;
        shake.autoreverses = YES;
        shake.repeatCount  = MAXFLOAT;
        shake.removedOnCompletion = NO;
        shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, -rotation, 0.0, 0.0, 1.0)];
        shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0, 0.0, 1.0)];
        
        [self.layer addAnimation:shake forKey:@"shakeAnimation"];
    }
    else
    {
        [self.layer removeAnimationForKey:@"shakeAnimation"];
    }
}

/**
 *  For the animation effects of close button
 *
 *  @param enabled BOOL
 */
- (void)ratationStatus:(BOOL)enabled {
    
    if (enabled) {
        CABasicAnimation *retation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        retation.fromValue = @(0);
        retation.toValue = @(4 * M_PI);
        retation.repeatCount = HUGE_VAL;
        retation.duration = 2;
        [self.layer addAnimation:retation forKey:@"ratationAnimation"];
    }
    else {
        [self.layer removeAnimationForKey:@"ratationAnimation"];
    }
}

- (void)ratationStatus:(BOOL)enabled duration:(NSTimeInterval)duration {
    if (enabled) {
        CABasicAnimation *retation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        retation.fromValue = @(0);
        retation.toValue = @(4 * M_PI);
        retation.repeatCount = HUGE_VAL;
        retation.duration = duration;
        [self.layer addAnimation:retation forKey:@"ratationAnimation"];
    }
    else {
        [self.layer removeAnimationForKey:@"ratationAnimation"];
    }
}

- (void)ratationCounterclockwiseStatus:(BOOL)enabled {
    
    if (enabled) {
        CABasicAnimation *retation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        retation.fromValue = @(0);
        retation.toValue = @(- 4 * M_PI);
        retation.repeatCount = HUGE_VAL;
        retation.duration = 2;
        [self.layer addAnimation:retation forKey:@"ratationAnimationReverse"];
    }
    else {
        [self.layer removeAnimationForKey:@"ratationAnimationReverse"];
    }
}

- (void)heartBeatingStatus:(BOOL)enbled {
    if (enbled) {
        CAKeyframeAnimation *heartBeatingAnimation = [CAKeyframeAnimation animation];
        heartBeatingAnimation.keyPath = @"transform.scale";
        heartBeatingAnimation.duration = 2.0;
        heartBeatingAnimation.repeatCount = INFINITY;
        NSNumber *scaleStart = @(1.0);
        NSNumber *scaleBoom = @(1.12);
        
        heartBeatingAnimation.values = @[scaleStart,
                                         scaleBoom,
                                         scaleStart,
                                         scaleBoom,
                                         scaleStart,
                                         scaleStart];
        
        heartBeatingAnimation.keyTimes = @[@(0.0),
                                           @(1.0 / 8.0),
                                           @(2.0 / 8.0),
                                           @(3.0 / 8.0),
                                           @(4.0 / 8.0),
                                           @(1.0)];
        heartBeatingAnimation.removedOnCompletion = NO;
        [self.layer addAnimation:heartBeatingAnimation forKey:@"heartBeatingAnimation"];
    } else {
        [self.layer removeAnimationForKey:@"heartBeatingAnimation"];
    }
}


@end
