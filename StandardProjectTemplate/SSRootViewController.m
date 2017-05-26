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
#import <AccountKit/AccountKit.h>

typedef NS_ENUM(NSUInteger, FacebookLoginType) {
    kFacebookLoginTypeTraditional,
    kFacebookLoginTypeAccountLogin
};

@interface SSRootViewController ()<AKFViewControllerDelegate>

@property (assign, nonatomic) FacebookLoginType                     fbLoginType;

/* Facebook Login */

@property (strong, nonatomic) FBSDKProfilePictureView               *avatarView;
@property (strong, nonatomic) UILabel                               *nameLabel;

@property (strong, nonatomic) FBSDKLoginButton                      *fbLoginButton;
@property (strong, nonatomic) UIButton                              *customLoginButton;
@property (strong, nonatomic) UIButton                              *logoutButton;

/* Account Login */

@property (strong, nonatomic) UIButton                              *emailLoginButton;
@property (strong, nonatomic) UIButton                              *phoneNumberLoginButton;

@property (strong, nonatomic) AKFAccountKit                         *accountKit;
@property (strong, nonatomic) UIViewController<AKFViewController>   *pendingLoginViewController;
@property (strong, nonatomic) NSString                              *authorizationCode;

@end

@implementation SSRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.fbLoginType = kFacebookLoginTypeAccountLogin;
    
    switch (self.fbLoginType) {
        case kFacebookLoginTypeTraditional:
            [self configureFBLoginViews];
            break;
        case kFacebookLoginTypeAccountLogin:
            [self configureAccountKitLoginViews];
            break;
        default:
            break;
    }
}

- (void)configureFBLoginViews {
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

- (void)configureAccountKitLoginViews {
    self.pendingLoginViewController = [self.accountKit viewControllerForLoginResume];
    self.pendingLoginViewController.delegate = self;
    
    [self.view addSubview:self.emailLoginButton];
    [self.emailLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-50);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.phoneNumberLoginButton];
    [self.phoneNumberLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailLoginButton.mas_bottom).offset(30);
        make.width.height.equalTo(self.emailLoginButton);
        make.centerX.equalTo(self.view);
    }];
    
    [self.view addSubview:self.logoutButton];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
        make.centerX.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self isUserLoggedIn]) {
        // if the user is already logged in, go to the main screen
        [self proceedToMainScreen];
    } else if (self.pendingLoginViewController) {
        [self presentViewController:self.pendingLoginViewController animated:YES completion:NULL];
        self.pendingLoginViewController = nil;
    } else {
        // Show log in buttons
    }
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

/* Account kit */
- (BOOL)isUserLoggedIn {
    if ([self.accountKit currentAccessToken]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)proceedToMainScreen {

    
    [self.accountKit requestAccount:^(id<AKFAccount> account, NSError *error) {
        // account ID
        NSLog(@"Request account information");
//        self.accountIDLabel.text = account.accountID;
//        if ([account.emailAddress length] > 0) {
//            self.titleLabel.text = @"Email Address";
//            self.valueLabel.text = account.emailAddress;
//        }
//        else if ([account phoneNumber] != nil) {
//            self.titleLabel.text = @"Phone Number";
//            self.valueLabel.text = [[account phoneNumber] stringRepresentation];
//        }
    }];
}

- (void)loginWithPhoneNumber {
    AKFPhoneNumber *preFillPhoneNumber = nil;
    NSString *inputState = [[NSUUID UUID] UUIDString];
    UIViewController<AKFViewController> *viewController = [self.accountKit viewControllerForPhoneLoginWithPhoneNumber:preFillPhoneNumber
                                                                                                                state:inputState];
    viewController.enableSendToFacebook = YES;
    viewController.defaultCountryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:NULL];
}

- (void)loginWithEmail {
    NSString *preFillEmailAddress = nil;
    NSString *inputState = [[NSUUID UUID] UUIDString];
    UIViewController<AKFViewController> *viewController = [self.accountKit viewControllerForEmailLoginWithEmail:preFillEmailAddress
                                                                                                          state:inputState];
    viewController.delegate = self;
    [self presentViewController:viewController animated:YES completion:NULL];
}

#pragma mark - <AKFViewControllerDelegate>
- (void)viewController:(UIViewController<AKFViewController> *)viewController didCompleteLoginWithAuthorizationCode:(NSString *)code state:(NSString *)state {
    // An authorization code returned from the SDK is intended to be passed to your server, which exchanges it for an access token.
    // Your application's server may then use the access token to verify the user's identity for subsequent API calls.
}

- (void)viewController:(UIViewController<AKFViewController> *)viewController
didCompleteLoginWithAccessToken:(id<AKFAccessToken>)accessToken
                 state:(NSString *)state {
    // An access token returned from the SDK allows you to verify the authenticity of a user's identity on the server side when processing requests for your application.
    // You should pass the access token to your application's server to verify the user's identity.
}

- (void)viewController:(UIViewController<AKFViewController> *)viewController didFailWithError:(NSError *)error {
    NSLog(@"%@ did fail with error: %@", viewController, error);
}

- (void)viewControllerDidCancel:(UIViewController<AKFViewController> *)viewController {
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
    switch (self.fbLoginType) {
        case kFacebookLoginTypeTraditional: {
            FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
            [loginManager logOut];
            [FBSDKAccessToken setCurrentAccessToken:nil];
        }
            break;
        case kFacebookLoginTypeAccountLogin: {
            [self.accountKit logOut];
        }
            break;
        default:
            break;
    }
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

- (UIButton *)emailLoginButton {
    if (!_emailLoginButton) {
        _emailLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _emailLoginButton.backgroundColor = [UIColor blueColor];
        [_emailLoginButton setTitle: @"Log in through Email" forState: UIControlStateNormal];
        [_emailLoginButton addTarget:self action:@selector(loginWithEmail) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emailLoginButton;
}

- (UIButton *)phoneNumberLoginButton {
    if (!_phoneNumberLoginButton) {
        _phoneNumberLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneNumberLoginButton.backgroundColor = [UIColor blueColor];
        [_phoneNumberLoginButton setTitle: @"Log in through Phone" forState: UIControlStateNormal];
        [_phoneNumberLoginButton addTarget:self action:@selector(loginWithPhoneNumber) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneNumberLoginButton;
}

- (AKFAccountKit *)accountKit {
    if (!_accountKit) {
        _accountKit = [[AKFAccountKit alloc] initWithResponseType:AKFResponseTypeAccessToken];
    }
    return _accountKit;
}

@end
