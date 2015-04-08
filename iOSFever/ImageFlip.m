//
//  ImageFlip.m
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import "ImageFlip.h"
#import "AFNetworking.h"
#import "Config.h"

@implementation ImageFlip
+(void)getMemesWithCompletition:(void (^)(BOOL, ImgflipResponse *, NSString *))completition
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:[Config memeSourceUrl] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ImgflipResponse* imgFlipResponse = [[ImgflipResponse alloc] initWithJson:responseObject];
        if (imgFlipResponse) {
            completition(YES, imgFlipResponse, nil);
        } else {
            completition(NO, nil, @"The Meme API seems to be wrong:(");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completition(NO, nil, error.localizedDescription);
    }];
}
@end
