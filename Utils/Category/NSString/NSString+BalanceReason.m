//
//  NSString+BalanceReason.m
//  GiftGame
//
//  Created by HeJi on 16/8/9.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import "NSString+BalanceReason.h"

@implementation NSString (BalanceReason)

- (NSString *)nameFromReason {
    NSMutableString *retString = [[NSMutableString alloc] initWithString:self];
    NSRange range = [self rangeOfString:@"_" options:NSLiteralSearch];
    
    if (NSNotFound == range.location)
    {
        return retString;
    }
    else if (NSNotFound != [self rangeOfString:@"init_"].location)
    {
        return NSLocalizedString(@"Balance_From_Register", nil);
    }
    
    [retString deleteCharactersInRange:NSMakeRange(0, range.location + 1)];
    return retString;
}

@end
