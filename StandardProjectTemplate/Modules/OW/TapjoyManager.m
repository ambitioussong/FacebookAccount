//
//  TapjoyManager.m
//  StandardProjectTemplate
//
//  Created by CIZ on 17/4/18.
//  Copyright © 2017年 JSong. All rights reserved.
//

#import "TapjoyManager.h"
#import <Fyber_Tapjoy_11.9.1-r1/Tapjoy.h>
#import "FullScreenLoadView.h"

typedef enum{
    kTapjoyOWConnectedStarted,
    kTapjoyOWConnectedSucceed,
    kTapjoyOWConnectedFailed
}TapjoyOWConnectStatus;

@interface TapjoyManager ()<TJPlacementDelegate>

@property (nonatomic, strong) NSString                  *appId;
@property (nonatomic, strong) NSString                  *placementID;
@property (nonatomic, strong) NSString                  *userId;
@property (nonatomic, strong) UIViewController          *targetViewController;
@property (nonatomic, strong) TapjoyOWUnavailableBlock  unavailableBlock;
@property (nonatomic, strong) TJPlacement               *placement;
@property (nonatomic, assign) TapjoyOWConnectStatus     tapjoyOWConnectStatus;
@property (nonatomic, assign) BOOL                      isDuringRequest;

@end


@implementation TapjoyManager

+ (instancetype)sharedInstance {
    static TapjoyManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[TapjoyManager alloc] init];
    });
    
    return _instance;
}

- (void)startWithAppId:(NSString *)appId withPlacementId:(NSString *)placementId withUserId:(NSString *)user_id {
    
    self.appId = appId;
    self.placementID = placementId;
    self.userId = user_id;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tjcConnectSuccess:)
                                                 name:TJC_CONNECT_SUCCESS
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(tjcConnectFail:) 
                                                 name:TJC_CONNECT_FAILED 
                                               object:nil];
    
#ifdef DEBUG
    [Tapjoy setDebugEnabled:YES];
#else
    [Tapjoy setDebugEnabled:NO];
#endif
    
    [Tapjoy connect:appId];
    
    [Tapjoy setUserID:user_id];
    
    self.tapjoyOWConnectStatus = kTapjoyOWConnectedStarted;
}

- (void)showWithViewController:(UIViewController *)viewController withUnavailableBlock:(TapjoyOWUnavailableBlock)unavailableBlock {
    self.targetViewController = viewController;
    self.unavailableBlock = unavailableBlock;
    
    if (self.placement.isContentReady) {
        [self.placement showContentWithViewController:viewController];
    } else if (kTapjoyOWConnectedFailed == self.tapjoyOWConnectStatus) {
        [[FullScreenLoadView sharedInstance] startLoading];
        [self startWithAppId:self.appId withPlacementId:self.placementID withUserId:self.userId];
    } else if (kTapjoyOWConnectedStarted == self.tapjoyOWConnectStatus) {
        [[FullScreenLoadView sharedInstance] startLoading];
    } else if (kTapjoyOWConnectedSucceed == self.tapjoyOWConnectStatus) {
        [[FullScreenLoadView sharedInstance] startLoading];
        [self requestForContent];
    }
}

#pragma mark - Private method

- (void)requestForContent {
    if (self.isDuringRequest) {
        return;
    } else {
        [self.placement requestContent];
        self.isDuringRequest = YES;
    }
}

#pragma mark - Connection notification callback methods

- (void)tjcConnectSuccess:(NSNotification*)notifyObj {
    self.tapjoyOWConnectStatus = kTapjoyOWConnectedSucceed;
    [self requestForContent];
}

- (void)tjcConnectFail:(NSNotification*)notifyObj {
    self.tapjoyOWConnectStatus = kTapjoyOWConnectedFailed;
    
    if ([[FullScreenLoadView sharedInstance] stillLoading]) {
        [[FullScreenLoadView sharedInstance] stopLoading];
        if (self.unavailableBlock) {
            self.unavailableBlock();
        }
    }
}

#pragma mark - <TJPlacementDelegate>

- (void)requestDidSucceed:(TJPlacement*)placement {
    self.isDuringRequest = NO;
    if ([[FullScreenLoadView sharedInstance] stillLoading]) {
        [[FullScreenLoadView sharedInstance] stopLoading];
    }
}

- (void)requestDidFail:(TJPlacement*)placement error:(NSError*)error {
    self.isDuringRequest = NO;
    
    if ([[FullScreenLoadView sharedInstance] stillLoading]) {
        [[FullScreenLoadView sharedInstance] stopLoading];
        if (self.unavailableBlock) {
            self.unavailableBlock();
        }
    }
}

- (void)contentIsReady:(TJPlacement*)placement {
    [self.placement showContentWithViewController:self.targetViewController];
}

- (void)contentDidAppear:(TJPlacement*)placement {
}

- (void)contentDidDisappear:(TJPlacement*)placement {
}

#pragma mark - Getter

- (TJPlacement *)placement {
    if (!_placement) {
        _placement = [TJPlacement placementWithName:self.placementID delegate:self];
    }
    return _placement;
}

@end
