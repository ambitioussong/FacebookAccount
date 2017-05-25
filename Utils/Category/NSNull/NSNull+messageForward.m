//
//  NSNull+messageForward.m
//  GiftGame
//
//  Created by Jerry Liu on 16/9/22.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import "NSNull+messageForward.h"
#import <objc/runtime.h>

@implementation NSNull (messageForward)

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    SEL newSelector = @selector(class);
    return [super methodSignatureForSelector:newSelector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    invocation.target = nil;
    [invocation invoke];
}

@end
