//
//  SDRutor.m
//  MethodTest
//
//  Created by xuelin on 2017/5/27.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import "SDRutor.h"
#import "SDURLParser.h"


@implementation SDRutor {
    NSMutableArray<NSDictionary *> *_results;
}
static SDRutor *_rutor;
+ (instancetype)shareRutor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _rutor = [[SDRutor alloc] init];
    });
    return _rutor;
}

- (instancetype)init {
    if (self = [super init]) {
        _results = @[].mutableCopy;
    }
    return self;
}

- (void)addPaten:(NSString *)paten callback:(SDCompleteCallback)callback{
    
    NSDictionary *dict = @{paten:callback};
    
    if (![_results containsObject:dict]) {
        [_results addObject:dict];
    }
}

- (void)rutor:(NSURL *)paten {
    SDURLParser *parser = [[SDURLParser alloc] initWithURL:paten];
    [_results enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj allKeys].firstObject isEqualToString:parser.paten]) {
            SDRutorContext *context = [[SDRutorContext alloc] init];
            context.paramters = parser.paramters;
            if ([obj allValues].firstObject) {
                SDCompleteCallback callback = (SDCompleteCallback)[obj allValues].firstObject;
                callback(context);
            }
            *stop = YES;
        }
    }];
}



@end
