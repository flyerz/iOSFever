//
//  Config.m
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import "Config.h"

@implementation Config

//get the plist
+(NSDictionary*)getConfig {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AppConfig" ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:path];
}

+(NSString *)sourceUrl
{
    return [[Config getConfig] objectForKey:@"sourceUrl"];
}

@end
