//
//  SDRouterContext.m
//  SDRutorDemo
//
//  Created by as_one on 2017/7/31.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import "SDRouterContext.h"
#import "SDUIStackLifeCircleAction.h"

@implementation SDRouterContext
- (NSArray*) viewControllerStack {
    return [SDUIShareStackInstance() viewControllerStack];
}

- (UIViewController*) topViewController {
    return SDUIShareStackInstance().viewControllerStack.lastObject;
}

- (UINavigationController*) topNavigationController {
    NSArray* vcs = [self viewControllerStack];
    for (int i = (int)vcs.count -1; i >=0 ; i--) {
        UIViewController* vc = vcs[i];
        if ([vc isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)vc;
        }
        if (vc.navigationController) {
            return vc.navigationController;
        }
    }
    return nil;
}

@end
