//
//  NSNumber+TimeString.h
//  GiftGame
//
//  Created by HeJi on 16/8/9.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (TimeString)

- (NSString *)timestampTransformToTimeStringForBalanceMode;
- (NSString *)timestampTransformToTimeStringForOrderMode;
- (NSString *)timestampTransformToTimeStringForNewsMode;
- (NSString *)timestampTransformToTimeStringForInvitationMode;

@end
