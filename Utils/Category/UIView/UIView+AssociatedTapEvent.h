//
//  UIView+AssociatedTapEvent.h
//  GiftGame
//
//  Created by Jason on 16/9/14.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^eventBlock)();

@interface UIView (AssociatedTapEvent)

- (void)handleTapEventWithBlock:(eventBlock)block;

@end
