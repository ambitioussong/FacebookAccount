//
//  NSDate+Calculate.m
//  GiftGame
//
//  Created by Andres He on 11/15/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "NSDate+Calculate.h"

@implementation NSDate (Calculate)

+ (NSInteger)daysSince1970UTC {
    NSTimeInterval intervalSince1970 = [[self date] timeIntervalSince1970];
    return intervalSince1970 / (60 * 60 * 24);
}

+ (NSInteger)daysSince1970Locale {
    NSDate *currentDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:currentDate];
    NSDate *localeDate = [currentDate dateByAddingTimeInterval:interval];
    NSTimeInterval intervalSince1970 = [localeDate timeIntervalSince1970];
    return intervalSince1970 / (60 * 60 * 24);
}

+ (NSInteger)minsSince1970UTC {
    NSTimeInterval intervalSince1970 = [[self date] timeIntervalSince1970];
    return intervalSince1970 / 60;
}

+ (NSInteger)minsSince1970Locale {
    NSDate *currentDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:currentDate];
    NSDate *localeDate = [currentDate dateByAddingTimeInterval:interval];
    NSTimeInterval intervalSince1970 = [localeDate timeIntervalSince1970];
    return intervalSince1970 / 60;
}

@end
