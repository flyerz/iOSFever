//
//  NSDictionary+JsonValue.m
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import "NSDictionary+JsonValue.h"

@implementation NSDictionary (JsonValue)
-(id)jsonValueForKey:(id)aKey
{
    id result = [self objectForKey:aKey];
    return [result isKindOfClass:[NSNull class]] ? nil : result;
}
@end
