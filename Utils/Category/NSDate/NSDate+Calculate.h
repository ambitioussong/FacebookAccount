//
//  NSDate+Calculate.h
//  GiftGame
//
//  Created by Andres He on 11/15/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calculate)

+ (NSInteger)daysSince1970UTC;

+ (NSInteger)daysSince1970Locale;

+ (NSInteger)minsSince1970UTC;

+ (NSInteger)minsSince1970Locale;
@end
