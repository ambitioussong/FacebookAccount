//
//  NSError+Message.h
//  GiftGame
//
//  Created by Ruozi on 8/3/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Message)

+ (NSError *)errorWithMessage:(NSString *)message code:(NSInteger)code;

@end
