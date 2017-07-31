//
//  SDRoutorUtil.h
//  MethodTest
//
//  Created by xuelin on 2017/5/27.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (SDURLEncode)
- (NSString *)URLEncode;
- (NSString *)URLDecode;
@end
//  用来处理参数携带 拼接参数 返回编码、拼接后的URL
FOUNDATION_EXTERN NSURL *SDURLRouteQueryLink(NSString *baseUrl, NSDictionary *query);

//  添加参数
FOUNDATION_EXTERN NSString *SDURLRouteJoinParamterString(NSString *urlStr, NSString *query);

//  将拼接好的参数encode
FOUNDATION_EXTERN NSString *SDURLRouteEncodeURLQueryParamters(NSDictionary *paramter);

//  将参数decode
FOUNDATION_EXTERN NSDictionary *SDURLRouteDecodeURLQueryParamters(NSString *urlStr);
