//
//  SSMacros.h
//  StandardProjectTemplate
//
//  Created by CIZ on 17/4/18.
//  Copyright © 2017年 JSong. All rights reserved.
//

#ifndef SSMacros_h
#define SSMacros_h

#import "UIColor+hexstringToUIColor.h"

// Weak & Strong self avoid of retain cycle
#define WEAK_SELF       __weak typeof(self)weakSelf = self
#define STRONG_SELF     __strong typeof(weakSelf)self = weakSelf

#define IS_IPAD         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE_5     (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_4s    ([[UIScreen mainScreen] bounds].size.height < 568.0f)
#define IS_IPHONE_6P    (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)736) < DBL_EPSILON)

#define IOS_SDK_MORE_THAN_OR_EQUAL(__num)   [UIDevice currentDevice].systemVersion.floatValue >= (__num)
#define IOS_SDK_MORE_THAN(__num)            [UIDevice currentDevice].systemVersion.floatValue > (__num)
#define IOS_SDK_LESS_THAN(__num)            [UIDevice currentDevice].systemVersion.floatValue < (__num)


#define kColorWithRGBValue(r,g,b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define kColorWithHexValue(x)           [UIColor hexStringToColor:x]
#define kAvoidNilString(x)              (nil == x) ? (@"") : (x)
#define kNumberToString(x)              [NSString stringWithFormat:@"%@", (x)]

#define kLocalString(x)                 NSLocalizedString(x, nil)
#define kImageNamed(x)                  [UIImage imageNamed:x]
#define kStringEqual(x, y)              [x isEqualToString:y]
#define kStringContain(x, y)            (NSNotFound != [x rangeOfString:y].location)

#endif /* SSMacros_h */
