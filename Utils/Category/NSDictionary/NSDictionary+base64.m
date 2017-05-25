//
//  NSDictionary+base64.m
//  iFun
//
//  Created by Jason on 16/6/13.
//  Copyright © 2016年 AppFinder. All rights reserved.
//

#import "NSDictionary+base64.h"
#import "NSData+Base64.h"

@implementation NSDictionary (base64)

- (NSString *)base64ParamsDic
{
    NSString *encodedInfoString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (!jsonData)
    {
        return nil;
    }
    else
    {
        encodedInfoString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSString *base64String = [[encodedInfoString dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithSeparateLines:NO];
//    NSString *bodyString = [NSString stringWithFormat:@"body=%@", base64String];
//    
//    return [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    return base64String;
}

@end
