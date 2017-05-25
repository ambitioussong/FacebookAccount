//
//  CometAnimation.m
//  GiftGame
//
//  Created by Ruozi on 11/15/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "UIView+CometAnimation.h"
#import <objc/runtime.h>

#define kParticleOrginalRadius              5.0f
#define kAnimationSingleCircleDuration      2.0f

static const char dotLayerArrayKey;
static const char animationLayerKey;

@implementation UIView (CometAnimation)

#pragma mark - Public methods
- (void)startCometAnimation {
    
    [self layoutIfNeeded];
    
    [self stopCometAnimation]; 
    
    CALayer *animationLayer = [CALayer layer];
    animationLayer.frame = self.bounds;
    [self.layer addSublayer:animationLayer];
    
    NSMutableArray<CALayer *> *dotLayerArray = [NSMutableArray<CALayer *> array];
    
    for (int i = 0; i < 15; i++) {
        
        CGFloat particleRadius = kParticleOrginalRadius * [self ratioForIndex:i];
        
        CALayer *dotLayer = [CALayer layer];
        dotLayer.contents = (id)[UIImage imageNamed:@"home_btn_chest_comet_particle"].CGImage;
        dotLayer.frame = CGRectMake(-particleRadius, -particleRadius, 2 * particleRadius, 2 * particleRadius);
        dotLayer.opacity = [self fetchRandomOpacity];
        [animationLayer addSublayer:dotLayer];
        [dotLayerArray addObject:dotLayer];
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius];
    
    CAKeyframeAnimation *cometAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    cometAnimation.duration = kAnimationSingleCircleDuration;
    cometAnimation.path = path.CGPath;
    cometAnimation.calculationMode = kCAAnimationPaced;
    cometAnimation.rotationMode = kCAAnimationRotateAuto;
    cometAnimation.repeatCount = INFINITY;

    [dotLayerArray enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        cometAnimation.timeOffset = [self delayForIndex:idx];
        [obj addAnimation:cometAnimation forKey:nil];
    }];
    
    objc_setAssociatedObject(self, &animationLayerKey, animationLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &dotLayerArrayKey, dotLayerArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)stopCometAnimation {
    
    NSMutableArray<CALayer *> *dotLayerArray = objc_getAssociatedObject(self, &dotLayerArrayKey);
    [dotLayerArray enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeAllAnimations];
        [obj removeFromSuperlayer];
    }];
    
    CALayer *animationLayer = objc_getAssociatedObject(self, &animationLayerKey);
    [animationLayer removeFromSuperlayer];
}

#pragma mark - Private methods
- (CGFloat)ratioForIndex:(int)index {
    
    NSArray *ratioArray = @[@(1.0f), @(1.1f), @(1.0f), @(0.9f), @(1.0f),
                            @(0.85f), @(0.75f), @(0.8f), @(0.7f), @(0.65f),
                            @(0.4f), @(0.25f), @(0.4f), @(0.3f), @(0.2f)];
    
    NSInteger baseIndex = index % ratioArray.count;
    
    return ((NSNumber *)ratioArray[baseIndex]).floatValue;
}

- (CGFloat)delayForIndex:(NSUInteger)index {
    
    NSArray *delayArray = @[@(-0.00f), @(-0.02f), @(-0.03f), @(-0.05f), @(-0.07f),
                            @(-0.09f), @(-0.11f), @(-0.12f), @(-0.14f), @(-0.15f),
                            @(-0.16f), @(-0.17f), @(-0.18f), @(-0.20f), @(-0.23)];
    
    NSInteger baseIndex = index % delayArray.count;
    
//    NSInteger offset = index / delayArray.count;
//    return ((NSNumber *)delayArray[baseIndex]).floatValue + kAnimationSingleCircleDuration / 2 * offset;
    
    return ((NSNumber *)delayArray[baseIndex]).floatValue;
}

- (CGFloat)fetchRandomOpacity {
    float diff = 1.0f - 0.8f;
    return (((float) rand() / RAND_MAX) * diff) + 0.8f;
}



@end
