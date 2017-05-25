//
//  SSOWManager.h
//  StandardProjectTemplate
//
//  Created by CIZ on 17/4/18.
//  Copyright © 2017年 JSong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SSOWUnavailableBlock)();

@interface SSOWManager : NSObject

+ (instancetype)sharedInstance;
- (void)startWithAppKey:(NSString *)appKey withUserId:(NSString *)userId;
- (void)showWithViewController:(UIViewController *)viewController withUnavailableBlock:(SSOWUnavailableBlock)unavailableBlock;

@end
