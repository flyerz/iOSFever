//
//  MemeData.h
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestResponseClassProtocol.h"

@interface MemeData : NSObject <RestResponseClassProtocol>
@property (nonatomic, strong) NSString* _id;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSNumber* width;
@property (nonatomic, strong) NSNumber* height;
@end
