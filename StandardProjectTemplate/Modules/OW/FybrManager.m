//
//  FybrManager.m
//  StandardProjectTemplate
//
//  Created by CIZ on 17/4/18.
//  Copyright © 2017年 JSong. All rights reserved.
//

#import "FybrManager.h"
#import <FyberSDK.h>

@implementation FybrManager

+ (instancetype)sharedInstance {
    static FybrManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[FybrManager alloc] init];
    });
    
    return _instance;
}

- (void)startWithAppId:(NSString *)appId withToken:(NSString *)token withUserId:(NSString *)userId {
    FYBSDKOptions *options = [FYBSDKOptions optionsWithAppId:appId
                                                      userId:userId
                                               securityToken:token];
    [FyberSDK startWithOptions:options];
}

- (void)showWithViewController:(UIViewController *)viewController withCustomInfoDic:(NSDictionary *)customInfoDic withUnavailableBlock:(FyberOWUnavailableBlock)unavailableBlock {
    FYBOfferWallViewController *offerWallViewController = [FyberSDK offerWallViewController];
    offerWallViewController.shouldDismissOnRedirect = NO;
    
    FYBRequestParameters *parameters = [[FYBRequestParameters alloc] init];
    if (customInfoDic && customInfoDic.count > 0) {
        [parameters addCustomParameters:customInfoDic];
    }
    
    [offerWallViewController presentFromViewController:viewController parameters:parameters animated:YES completion:^{
        ;
    } dismiss:^(NSError *error) {
        if (error && unavailableBlock) {
            unavailableBlock();
        }
    }];
}

@end
