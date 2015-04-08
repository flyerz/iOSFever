//
//  ConfigTest.m
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Config.h"

@interface ConfigTest : XCTestCase

@end

@implementation ConfigTest

- (void)testSourceUrl {
    if (![[Config sourceUrl] isKindOfClass:[NSString class]]) {
        XCTFail(@"[Config sourceUrl] is not string. sourceurl: %@", [Config sourceUrl]);
    } else {
        NSString* url = [Config sourceUrl];
        if ([url rangeOfString:@"http://"].location == NSNotFound && [url rangeOfString:@"https://"].location == NSNotFound) {
            XCTFail(@"[Config sourceUrl] is not a valid url. sourceurl: %@", url);
        }
    }
    XCTAssert(YES, @"[Config sourceUrl] seems good");
}
@end
