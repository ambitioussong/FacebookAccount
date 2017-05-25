//
//  FybrManager.h
//  StandardProjectTemplate
//
//  Created by CIZ on 17/4/18.
//  Copyright © 2017年 JSong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FyberOWUnavailableBlock)();

@interface FybrManager : NSObject

+ (instancetype)sharedInstance;
- (void)startWithAppId:(NSString *)appId withToken:(NSString *)token withUserId:(NSString *)userId;
- (void)showWithViewController:(UIViewController *)viewController withCustomInfoDic:(NSDictionary *)customInfoDic withUnavailableBlock:(FyberOWUnavailableBlock)unavailableBlock;

@end
