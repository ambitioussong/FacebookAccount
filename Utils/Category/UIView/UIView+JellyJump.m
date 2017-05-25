//
//  UIView+JellyJump.m
//  JellyJump
//
//  Created by DaiPei on 2017/3/5.
//  Copyright © 2017年 DaiPei. All rights reserved.
//

#import "UIView+JellyJump.h"

#define JellyJumpAnimationKey @"jellyJump"

@implementation UIView (JellyJump)

- (void)startJump {
    
    if ([self.layer animationForKey:JellyJumpAnimationKey]) {
        return;
    }
    
    CGFloat floatKey = arc4random() % 9 * 0.025 - 0.1;
    
    CGFloat animationKeyTime = 0.8 + floatKey;
    
    NSArray *animationKeyTimes = @[@(0), @(0.246 * animationKeyTime), @(0.492 * animationKeyTime), @(0.656 * animationKeyTime), @(0.738 * animationKeyTime), @(0.869 * animationKeyTime), @(1 * animationKeyTime)];
    CGFloat wholeDuration = 1.f / animationKeyTime;
    
    CGFloat sx = 1;
    CGFloat sy = 1;
    CGFloat sz = 1;
    
    CGFloat tx = 0;
    CGFloat ty = 0;
    CGFloat tz = 0;
    
    CAKeyframeAnimation *jellyJump = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    NSValue *value0 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(sx, sy, sz)];
    
    CAMediaTimingFunction *function0 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    sx = 1.1;
    sy = 0.9;
    ty = (1 - sy) * CGRectGetHeight(self.layer.bounds) / 2;
    CATransform3D scale1 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move1 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value1 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale1, move1)];
    
    CAMediaTimingFunction *function1 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    sx = 0.95;
    sy = 1;
    ty = -CGRectGetHeight(self.layer.bounds) * 0.25;
    CATransform3D scale2 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move2 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value2 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale2, move2)];
    
    CAMediaTimingFunction *function2 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CATransform3D scale3 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move3 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value3 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale3, move3)];
    
    CAMediaTimingFunction *function3 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    sx = 1;
    sy = 1;
    ty = 0;
    CATransform3D scale4 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move4 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value4 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale4, move4)];
    
    CAMediaTimingFunction *function4 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    sx = 1.1;
    sy = 0.9;
    ty = (1 - sy) * CGRectGetHeight(self.layer.bounds) / 2;
    CATransform3D scale5 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move5 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value5 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale5, move5)];
    
    CAMediaTimingFunction *function5 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    sx = 1;
    sy = 1;
    ty = 0;
    CATransform3D scale6 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move6 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value6 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale6, move6)];
    
    CAMediaTimingFunction *function6 = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CATransform3D scale7 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move7 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value7 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale7, move7)];
    
    
    jellyJump.values = @[value0, value1, value2, value3, value4, value5, value6, value7];
    jellyJump.keyTimes = @[animationKeyTimes[0], animationKeyTimes[1], animationKeyTimes[2], animationKeyTimes[3], animationKeyTimes[4], animationKeyTimes[5], animationKeyTimes[6], @(1)];
    jellyJump.timingFunctions = @[function0, function1, function2, function3, function4, function5, function6];
    
    jellyJump.duration = wholeDuration;
    jellyJump.fillMode = kCAFillModeBackwards;
    jellyJump.removedOnCompletion = NO;
    jellyJump.repeatCount = INFINITY;
    
    jellyJump.beginTime = arc4random() % 5 * 0.2;
    
    [self.layer addAnimation:jellyJump forKey:JellyJumpAnimationKey];
}

- (void)stopJump {
    if ([self.layer animationForKey:JellyJumpAnimationKey]) {
        [self.layer removeAnimationForKey:JellyJumpAnimationKey];
    }
}

@end
