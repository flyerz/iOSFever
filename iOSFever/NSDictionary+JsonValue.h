//
//  NSDictionary+JsonValue.h
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JsonValue)
/** Returns nil if result would be an instance of NSNull class*/
-(id)jsonValueForKey:(id)aKey;
@end
