//
//  MemeData.m
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import "MemeData.h"

@implementation MemeData
-(id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self && ![json isKindOfClass:[NSNull class]]) {
        self._id = [json jsonValueForKey:@"id"];
        self.name = [json jsonValueForKey:@"name"];
        self.url = [json jsonValueForKey:@"url"];
        self.width = [json jsonValueForKey:@"width"];
        self.height = [json jsonValueForKey:@"height"];             
    }
    return self;
}
@end
