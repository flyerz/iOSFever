//
//  ImageFlip.h
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImgflipResponse.h"

@interface ImageFlip : NSObject
+(void)getMemesWithCompletition:(void(^)(BOOL success, ImgflipResponse* response, NSString* errorMesasge))completition;
@end
