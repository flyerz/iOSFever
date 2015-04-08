//
//  ImgflipResponse.h
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestResponseClassProtocol.h"

@interface ImgflipResponse : NSObject <RestResponseClassProtocol>
@property (nonatomic, assign, readonly) BOOL success;
@property (nonatomic, strong, readonly) NSDictionary* data;
@end
