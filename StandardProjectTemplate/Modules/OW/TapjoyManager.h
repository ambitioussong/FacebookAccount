//
//  TapjoyManager.h
//  StandardProjectTemplate
//
//  Created by CIZ on 17/4/18.
//  Copyright © 2017年 JSong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TapjoyOWUnavailableBlock)();

@interface TapjoyManager : NSObject

+ (instancetype)sharedInstance;
- (void)startWithAppId:(NSString *)appId withPlacementId:(NSString *)placementId withUserId:(NSString *)user_id;
- (void)showWithViewController:(UIViewController *)viewController withUnavailableBlock:(TapjoyOWUnavailableBlock)unavailableBlock;

@end
