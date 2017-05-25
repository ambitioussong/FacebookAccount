//
//  UIView+Animation.h
//  GiftGame
//
//  Created by Andres He on 8/27/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

- (void)setShakeStatus:(BOOL)enabled;

- (void)ratationStatus:(BOOL)enabled;

- (void)ratationStatus:(BOOL)enabled duration:(NSTimeInterval)duration;

//Counterclockwise
- (void)ratationCounterclockwiseStatus:(BOOL)enabled;

- (void)heartBeatingStatus:(BOOL)enbled;

@end
