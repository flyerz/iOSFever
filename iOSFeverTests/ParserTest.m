//
//  ParserTest.m
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ImgflipResponse.h"
#import "MemeData.h"

@interface ParserTest : XCTestCase

@end

@implementation ParserTest

-(void)testImgflipParse {
    NSDictionary* testDict = [self dataFromJSONFileNamed:@"ImgflipResponseTest"];
    
    XCTAssert(testDict, @"testDictionary is nil");
    
    ImgflipResponse* testResponse = [[ImgflipResponse alloc] initWithJson:testDict];
    
    XCTAssert(testResponse, @"Couldn't create ImgflipResponse instance");
    XCTAssert(testResponse.success, @"ImgflipResponse wasnt successful");
    XCTAssert(testResponse.data, @"can parse ImgflipResponse data object");
    XCTAssert(YES, @"[[ImgflipResponse alloc] initWithJson:(NSDictionary *)json] seems good");
}

-(void)testMemeDataParse
{
    NSDictionary* testDict = [self dataFromJSONFileNamed:@"MemeDataTest"];
    
    XCTAssert(testDict, @"testDictionary is nil");
    
    MemeData* testMeme = [[MemeData alloc] initWithJson:testDict];
    
    XCTAssert(testMeme._id && [testMeme._id isKindOfClass:[NSString class]], @"MemeData _id value should have a string value");
    XCTAssert(testMeme.name && [testMeme.name isKindOfClass:[NSString class]], @"MemeData name value is not a string");
    
    if (!testMeme.url) {
        XCTFail(@"MemeData url value is required!");
    }
    
    XCTAssert(testMeme.width && [testMeme.width isKindOfClass:[NSNumber class]], @"MemeData width value is not a number");
    XCTAssert(testMeme.height && [testMeme.height isKindOfClass:[NSNumber class]], @"MemeData height value is not a number");
}

- (id)dataFromJSONFileNamed:(NSString *)fileName
{
    NSData* testData = [NSData dataWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:@"json"]];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:testData options:kNilOptions error:&error];
    
    if (error) {
        XCTFail(@"Can't read test json");
    }
    return json;
}

@end
