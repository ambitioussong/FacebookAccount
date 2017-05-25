//
//  FullScreenLoadView.m
//  iFun
//
//  Created by Wiki Zhao on 14-12-4.
//  Copyright (c) 2014年 AppFinder. All rights reserved.
//

#import "FullScreenLoadView.h"
#import "AppDelegate.h"
#import "RTSpinKitView.h"

@interface FullScreenLoadView ()

@property (nonatomic, strong) RTSpinKitView *spinner;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic) BOOL isLoading;

@end

static FullScreenLoadView *_fullScreenLoadingView = nil;

@implementation FullScreenLoadView

@synthesize spinner = _spinner;
@synthesize closeButton = _closeButton;
@synthesize isLoading = _isLoading;

+ (instancetype)sharedInstance
{
    if (nil == _fullScreenLoadingView)
    {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            CGRect screenBounds = [[UIScreen mainScreen] bounds];
            
            _fullScreenLoadingView = [[FullScreenLoadView alloc] initWithFrame:screenBounds];
            [_fullScreenLoadingView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f]];

            _fullScreenLoadingView.spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleCircle color:[UIColor whiteColor]];
            _fullScreenLoadingView.spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
            [_fullScreenLoadingView addSubview:_fullScreenLoadingView.spinner];
            
            _fullScreenLoadingView.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_fullScreenLoadingView.closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
            _fullScreenLoadingView.closeButton.frame = CGRectMake(screenBounds.size.width - 64, kTopNaviBarAndStatusBarHeight, 54, 54);
            _fullScreenLoadingView.closeButton.tintColor = [UIColor whiteColor];
            [_fullScreenLoadingView addSubview:_fullScreenLoadingView.closeButton];
            
            _fullScreenLoadingView.isLoading = NO;
        });
    }
    
    return _fullScreenLoadingView;
}

- (void)startLoading
{
    if (_isLoading)
    {
        return;
    }
    _isLoading = YES;
    
    UIWindow* mainWindow = (((AppDelegate *)[UIApplication sharedApplication].delegate).window);
    [_spinner startAnimating];
    [mainWindow addSubview:self];
    
    [_closeButton setHidden:NO];
    [_closeButton addTarget:self action:@selector(stopLoading) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startLoadingWithNoCloseButton
{
    [self startLoading];
    
    if(_closeButton)
    {
        [_closeButton setHidden:YES];
    }
}

- (void)stopLoading
{
    if (!_isLoading)
    {
        return;
    }
    _isLoading = NO;
    
    [self removeFromSuperview];
    [_spinner stopAnimating];
}

- (BOOL)stillLoading
{
    return _isLoading;
}

@end
