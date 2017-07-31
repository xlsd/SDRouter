//
//  SDRutor.h
//  MethodTest
//
//  Created by xuelin on 2017/5/27.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDRutorContext.h"
#import "SDRoutorUtil.h"
#import "SDURLParser.h"

typedef void(^SDCompleteCallback)(SDRutorContext *context);

@interface SDRutor : NSObject

+ (instancetype)shareRutor;

- (void)addPaten:(NSString *)paten callback:(SDCompleteCallback)callback;

- (void)rutor:(NSURL *)paten;
@end
