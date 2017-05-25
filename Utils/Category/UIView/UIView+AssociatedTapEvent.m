//
//  UIView+AssociatedTapEvent.m
//  GiftGame
//
//  Created by Jason on 16/9/14.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import "UIView+AssociatedTapEvent.h"
#import <objc/runtime.h>

static const char eventKey;

@implementation UIView (AssociatedTapEvent)

- (void)handleTapEventWithBlock:(eventBlock)block {

    if ([self isKindOfClass:[UIButton class]]) {
        return;
    }
    
    for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
        [self removeGestureRecognizer:recognizer];
    }
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedOnView)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapGestureRecognizer];
    
    if (block) {
        objc_setAssociatedObject(self, &eventKey,  block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)didTappedOnView {
    
    eventBlock block = objc_getAssociatedObject(self, &eventKey);
    block();
}

@end
