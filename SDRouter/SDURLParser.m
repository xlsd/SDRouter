//
//  SDURLParser.m
//  MethodTest
//
//  Created by xuelin on 2017/5/27.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import "SDURLParser.h"
#import "SDRoutorUtil.h"

@implementation SDURLParser
- (instancetype) initWithURL:(NSURL*)url {
    self = [super init];
    if (!self) {
        return self;
    }
    _originURL = url;
    [self decodeURL];
    return self;
}

- (void) decodeURL
{
    _scheme = _originURL.scheme;
    NSArray* paths = _originURL.pathComponents;
    _module = _originURL.host;
    if (paths.count > 1) {
        _method = paths[1];
    }
    NSString* query = _originURL.query;
    _paramters = SDURLRouteDecodeURLQueryParamters(query);
    _paten = [NSString stringWithFormat:@"%@://%@", _scheme, _module];
}
@end
