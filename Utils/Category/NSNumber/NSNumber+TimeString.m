//
//  NSNumber+TimeString.m
//  GiftGame
//
//  Created by HeJi on 16/8/9.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import "NSNumber+TimeString.h"

@implementation NSNumber (TimeString)

- (NSString *)timestampTransformToTimeStringForBalanceMode {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMM.dd";
    NSString *time = [dateFormatter stringFromDate:date];
    
    if (!time) {
        return @"";
    }
    return time;
}

- (NSString *)timestampTransformToTimeStringForOrderMode {
    return [self timestampTransformToTimeStringForBalanceMode];
}

- (NSString *)timestampTransformToTimeStringForNewsMode {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm";
    NSString *time = [dateFormatter stringFromDate:date];
    
    if (!time) {
        return @"";
    }
    return time;
}

- (NSString *)timestampTransformToTimeStringForInvitationMode {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY.MM.dd";
    NSString *time = [dateFormatter stringFromDate:date];
    
    if (!time) {
        return @"";
    }
    return time;
}

@end
