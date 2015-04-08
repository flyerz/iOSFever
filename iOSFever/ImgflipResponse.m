//
//  ImgflipResponse.m
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import "ImgflipResponse.h"


@implementation ImgflipResponse
-(id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self && ![json isKindOfClass:[NSNull class]]) {
        _success = [[json jsonValueForKey:@"success"] boolValue];
        _data = [json jsonValueForKey:@"data"];
        
    }
    return self;
}
@end
