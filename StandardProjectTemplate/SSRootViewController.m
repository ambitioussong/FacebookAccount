//
//  SSRootViewController.m
//  StandardProjectTemplate
//
//  Created by CIZ on 17/4/18.
//  Copyright © 2017年 JSong. All rights reserved.
//

#import "SSRootViewController.h"
#import <Masonry.h>
#import "UIView+PinToast.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface SSRootViewController ()

@property (strong, nonatomic) FBSDKProfilePictureView   *avatarView;
@property (strong, nonatomic) UILabel                   *nameLabel;

@property (strong, nonatomic) FBSDKLoginButton          *fbLoginButton;
@property (strong, nonatomic) UIButton                  *customLoginButton;
@property (strong, nonatomic) UIButton                  *logoutButton;

@end

@implementation SSRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configureViews];
}

- (void)configureViews {
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(30);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_bottom).offset(5);
        make.left.equalTo(self.avatarView);
    }];
    
    [self.view addSubview:self.logoutButton];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
        make.centerX.equalTo(self.view);
    }];
    
    self.fbLoginButton = [[FBSDKLoginButton alloc] init];
    // If your app asks for more than public_profile, email and user_friends, Facebook must review it before you release it.
    self.fbLoginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    [self.view addSubview:self.fbLoginButton];
    [self.fbLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-50);
    }];
    
    [self.view addSubview:self.customLoginButton];
    [self.customLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fbLoginButton.mas_bottom).offset(30);
        make.width.height.equalTo(self.fbLoginButton);
        make.centerX.equalTo(self.view);
    }];
    
    [self refreshPage];
    [self configProfile];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fbAccessTokenDidUpdate:)
                                                 name:FBSDKAccessTokenDidChangeNotification object:nil];
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fbProfileDidUpdate:)
                                                 name:FBSDKProfileDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods 

- (void)refreshPage {
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        self.fbLoginButton.hidden = YES;
        self.customLoginButton.hidden = YES;
        self.logoutButton.hidden = NO;
    } else {
        self.fbLoginButton.hidden = NO;
        self.customLoginButton.hidden = NO;
        self.logoutButton.hidden = YES;
    }
}

- (void)configProfile {
    self.avatarView.profileID = [FBSDKProfile currentProfile].userID;
    self.nameLabel.text = [FBSDKProfile currentProfile].name;
}

#pragma mark - Action

- (void)fbAccessTokenDidUpdate:(NSNotification *)notification {
    [self refreshPage];
}

- (void)fbProfileDidUpdate:(NSNotification *)notification {
    [self configProfile];
}

- (void)loginButtonClicked {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                 fromViewController:self
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
        if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
         }
     }];
}

- (void)logoutButtonClicked {
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    [FBSDKAccessToken setCurrentAccessToken:nil];
}

#pragma mark - Getter

- (FBSDKProfilePictureView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[FBSDKProfilePictureView alloc] init];
    }
    return _avatarView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont boldSystemFontOfSize:13];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UIButton *)customLoginButton {
    if (!_customLoginButton) {
        _customLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _customLoginButton.backgroundColor = [UIColor blueColor];
        [_customLoginButton setTitle: @"My Facebook Login Button" forState: UIControlStateNormal];
        [_customLoginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customLoginButton;
}

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutButton.backgroundColor = [UIColor redColor];
        [_logoutButton setTitle: @"Log out" forState: UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(logoutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

@end
