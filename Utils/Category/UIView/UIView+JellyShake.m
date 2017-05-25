//
//  UIView+JellyShake.m
//  JellyShakeAnimationDemo
//
//  Created by DaiPei on 2017/4/13.
//  Copyright © 2017年 DaiPei. All rights reserved.
//

#import "UIView+JellyShake.h"
#import <objc/runtime.h>

#define JellyShakeKey @"JellyShake"

@implementation UIView (JellyShake)

- (void)startJellyShake {
    
    if ([self.layer animationForKey:JellyShakeKey]) {
        return ;
    }
    
    
    CGFloat animationTime = 1.5;
    
    CGFloat sx = 1, sy = 1, sz = 1, tx = 0, ty = 0, tz = 0;
    NSValue *value0 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(sx, sy, sz)];
    
    sx = 1.2;
    sy = 0.9;
    ty = (1 - sy) * CGRectGetHeight(self.layer.bounds) / 2;
    CATransform3D scale1 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move1 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value1 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale1, move1)];
    
    sx = 0.9;
    sy = 1.05;
    ty = (1 - sy) * CGRectGetHeight(self.layer.bounds) / 2;
    CATransform3D scale2 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move2 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value2 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale2, move2)];
    
    sx = 1.05;
    sy = 0.975;
    ty = (1 - sy) * CGRectGetHeight(self.layer.bounds) / 2;
    CATransform3D scale3 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move3 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value3 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale3, move3)];
    
    sx = 0.975;
    sy = 1.015;
    ty = (1 - sy) * CGRectGetHeight(self.layer.bounds) / 2;
    CATransform3D scale4 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move4 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value4 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale4, move4)];
    
    sx = 1.015;
    sy = 0.995;
    ty = (1 - sy) * CGRectGetHeight(self.layer.bounds) / 2;
    CATransform3D scale5 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move5 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value5 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale5, move5)];
    
    sx = 0.985;
    sy = 1.005;
    ty = (1 - sy) * CGRectGetHeight(self.layer.bounds) / 2;
    CATransform3D scale6 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move6 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value6 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale6, move6)];
    
    sx = 1;
    sy = 1;
    ty = 0;
    CATransform3D scale7 = CATransform3DMakeScale(sx, sy, sz);
    CATransform3D move7 = CATransform3DMakeTranslation(tx, ty, tz);
    NSValue *value7 = [NSValue valueWithCATransform3D:CATransform3DConcat(scale7, move7)];
    
    
    CAKeyframeAnimation *jellyShake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    jellyShake.values = @[value0, value1, value2, value3, value4, value5, value6, value7, value0];
    jellyShake.keyTimes = @[@0, @0.25, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
    jellyShake.duration = animationTime;
    jellyShake.repeatCount = INFINITY;
    jellyShake.removedOnCompletion = NO;
    
    [self.layer addAnimation:jellyShake forKey:JellyShakeKey];
    
}

- (void)stopJellyShake {
    
    if ([self.layer animationForKey:JellyShakeKey]) {
        [self.layer removeAnimationForKey:JellyShakeKey];
    }
    
}


@end
