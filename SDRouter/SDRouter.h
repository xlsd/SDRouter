//
//  SDRouter.h
//  SDRutorDemo
//
//  Created by as_one on 2017/5/27.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDRouterContext.h"
#import "SDRoutorUtil.h"
#import "SDURLParser.h"

typedef void(^SDCompleteCallback)(SDRouterContext *context);

@interface SDRouter : NSObject

+ (instancetype)shareRutor;

- (void)addPaten:(NSString *)paten callback:(SDCompleteCallback)callback;

- (void)rutor:(NSURL *)paten;
@end
