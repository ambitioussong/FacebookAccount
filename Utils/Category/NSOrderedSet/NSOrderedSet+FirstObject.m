//
//  NSOrderedSet+FirstObject.m
//  EX2Kit
//
//  Created by Benjamin Baron on 8/7/13.
//
//

#import "NSOrderedSet+FirstObject.h"
#import "NSOrderedSet+Safe.h"

@implementation NSOrderedSet (FirstObject)

- (id)firstObjectSafe
{
	return [self objectAtIndexSafe:0];
}

@end
