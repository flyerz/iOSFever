//
//  RestResponseClassProtocol.h
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import "NSDictionary+JsonValue.h"
@protocol RestResponseClassProtocol <NSObject>

-(id)initWithJson:(NSDictionary*)json;

@end
