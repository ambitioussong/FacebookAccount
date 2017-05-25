//
//  SSOWManager.m
//  StandardProjectTemplate
//
//  Created by CIZ on 17/4/18.
//  Copyright © 2017年 JSong. All rights reserved.
//

#import "SSOWManager.h"
#import "IronSource/IronSource.h"

@interface SSOWManager ()<ISOfferwallDelegate>

@property (nonatomic, assign) BOOL isReady;

@end

@implementation SSOWManager

+ (instancetype)sharedInstance {
    static SSOWManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SSOWManager alloc] init];
    });
    
    return _instance;
}

- (void)startWithAppKey:(NSString *)appKey withUserId:(NSString *)userId {
    [IronSource setOfferwallDelegate:self];
    
    [IronSource setUserId:userId];
    
    [IronSource initWithAppKey:appKey adUnits:@[IS_OFFERWALL]];
    
    [ISIntegrationHelper validateIntegration];
}

- (void)showWithViewController:(UIViewController *)viewController withUnavailableBlock:(SSOWUnavailableBlock)unavailableBlock {
    if (self.isReady) {
        [IronSource showOfferwallWithViewController:viewController];
    } else {
        if (unavailableBlock) {
            unavailableBlock();
        }
    }
}

#pragma mark - <ISOfferwallDelegate>

- (void)offerwallHasChangedAvailability:(BOOL)available {
    self.isReady = available;
}

- (void)offerwallDidShow {
    
}

- (void)offerwallDidFailToShowWithError:(NSError *)error {
    
}

- (BOOL)didReceiveOfferwallCredits:(NSDictionary *)creditInfo {
    return YES;
}

- (void)didFailToReceiveOfferwallCreditsWithError:(NSError *)error {
    
}

- (void)offerwallDidClose {
    
}

@end
