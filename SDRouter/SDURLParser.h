//
//  SDURLParser.h
//  MethodTest
//
//  Created by xuelin on 2017/5/27.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * 解析URL
 */
@interface SDURLParser : NSObject
/*
the request's origin url
*/
@property (nonatomic, strong, readonly) NSURL* originURL;

/**
 This property contains the scheme. Any percent-encoded characters are not unescaped. For example, in the URL https://github.com/giveMeHug, the scheme is https.
 The full URL is the concatenation of the scheme, a colon (:), and the value of resourceSpecifier.
 
 */
@property (nonatomic, strong, readonly) NSString* scheme;

/**
 Result of paten by the parser
 */
@property (nonatomic, strong, readonly) NSString *paten;

/**
 the first part of URL's paths
 */
@property (nonatomic, strong, readonly) NSString* module;


/**
 the sencond part of URL's paths
 */
@property (nonatomic, strong, readonly) NSString* method;


/**
 the paramters decoded from the query string.
 */
@property (nonatomic, strong, readonly) NSDictionary* paramters;
//  需要解析的URL
- (instancetype) initWithURL:(NSURL*)url;
@end
