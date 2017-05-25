//
//  NSError+Message.m
//  GiftGame
//
//  Created by Ruozi on 8/3/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "NSError+Message.h"

@implementation NSError (Message)

#pragma mark - Public methods
+ (NSError *)errorWithMessage:(NSString *)message code:(NSInteger)code {
    return [NSError errorWithDomain:@"【GiftClient】" code:code userInfo:@{NSLocalizedDescriptionKey: message? message : @"Unknown error!",
                                                                         NSLocalizedFailureReasonErrorKey: message? message : @"Unknown error!"}];
}

@end
