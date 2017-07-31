//
//  SDRoutorUtil.m
//  MethodTest
//
//  Created by xuelin on 2017/5/27.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import "SDRoutorUtil.h"
@implementation NSString (SDURLEncode)
- (NSString *)URLEncode {
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"!*'\"();:@&=+$,/?%#[]%"] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
}

- (NSString *)URLDecode {
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapes(NULL, (__bridge CFStringRef)self,CFSTR(""));
}

@end



//  拼接参数 exemple http://www.baidu.com?key1=10&key2=20&key3=30
NSString *SDURLRouteEncodeURLQueryParamters(NSDictionary *paramters) {
    NSMutableDictionary *infos = [NSMutableDictionary dictionaryWithDictionary:paramters];
    NSArray *allkeys = infos.allKeys;
    NSMutableString *path = [NSMutableString new];
    //  获取dictionarys 所有的key 使用&拼接key
    for (int i = 0; i < allkeys.count; i++) {
        //  从第二个参数开始拼接
        if (i > 0) {
            [path appendString:@"&"];
        }
        NSString *key = [NSString stringWithFormat:@"%@",allkeys[i]];
        NSString *value = [NSString stringWithFormat:@"%@",infos[key]];
        //  对拼接的参数进行编码
        NSString *segment = [NSString stringWithFormat:@"%@=%@",[key URLEncode], [value URLEncode]];
        [path appendString:segment];
    }
    return path.copy;
}
//  将编码后的url和域名参数进行组合
NSString *SDURLRouteJoinParamterString(NSString *urlStr, NSString *query) {
    NSMutableString *str = [NSMutableString stringWithString:urlStr];
    if (![str hasSuffix:@"?"]) {
        [str appendString:@"?"];
    }
    
    if ([query hasPrefix:@"?"]) {
        query = [query substringFromIndex:1];
    }
    if (query) {
        [str appendString:query];
    }
    return str.copy;
}

//  返回编码、拼接后的URL
NSURL *SDURLRouteQueryLink(NSString *baseUrl, NSDictionary *query) {
    NSString *queryStr = SDURLRouteEncodeURLQueryParamters(query);
    NSString *urlStr = SDURLRouteJoinParamterString(baseUrl, queryStr);
    return [NSURL URLWithString:urlStr];
}
//  解码参数
NSDictionary *SDURLRouteDecodeURLQueryParamters(NSString *urlStr) {
    NSArray *cms = [urlStr componentsSeparatedByString:@"&"];
    if (cms.count == 0) return nil;
    
    NSMutableDictionary *paramters = [NSMutableDictionary new];
    for (NSString *s in cms) {
        NSRange indexOfEquel = [s rangeOfString:@"="];
        if (indexOfEquel.location == NSNotFound) {
            [paramters setValue:@"" forKey:[s URLDecode]];
        } else {
            NSString *key = [s substringToIndex:indexOfEquel.location];
            NSString *value = nil;
            if (s.length > indexOfEquel.location + indexOfEquel.length) {
                value = [s substringFromIndex:indexOfEquel.location + indexOfEquel.length];
            } else {
                value = @"";
            }
            paramters[[key URLDecode]] = [value URLDecode];
        }
    }
    return paramters.copy;
}
