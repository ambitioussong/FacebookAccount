//
//  SSLayoutMacros.h
//  StandardProjectTemplate
//
//  Created by CIZ on 17/4/18.
//  Copyright © 2017年 JSong. All rights reserved.
//

#ifndef SSLayoutMacros_h
#define SSLayoutMacros_h

#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height

#define DesignBaseWidth5S       375.0
#define DesignBaseHeight5S      667.0
#define ScreenWidthRatio5S      (SCREEN_WIDTH / DesignBaseWidth)
#define ScreenHeightRatio5S     (SCREEN_HEIGHT / DesignBaseHeight)

#define DesignBaseWidth6S       414.0
#define DesignBaseHeight6S      736.0

#define ScreenWidthRatio6S      (SCREEN_WIDTH / SQDesignBaseWidth)
#define ScreenHeightRatio6S     (SCREEN_HEIGHT / SQDesignBaseHeight)

#define TopBarButtonSize        CGSizeMake(36.0f, 36.0f)

#define kTopNaviBarAndStatusBarHeight 64.0f

#define kNaviBarHeight          44.0f
#define kStatusBarHeight        20.0f

#endif /* SSLayoutMacros_h */
