//
//  NSMutableDictionary+safe.h
//  SnapUpload
//
//  Created by jiangao on 16/3/28.
//  Copyright © 2016年 JellyKit Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (safe)

- (void)safeSetObject:(id)aObj forKey:(id<NSCopying>)aKey;

- (id)safeObjectForKey:(id<NSCopying>)aKey;

@end
