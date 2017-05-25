//
//  FullScreenLoadView.h
//  iFun
//
//  Created by Wiki Zhao on 14-12-4.
//  Copyright (c) 2014年 AppFinder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullScreenLoadView : UIView

+ (instancetype)sharedInstance;
- (void)startLoading;
- (void)startLoadingWithNoCloseButton;
- (void)stopLoading;
- (BOOL)stillLoading;

@end
