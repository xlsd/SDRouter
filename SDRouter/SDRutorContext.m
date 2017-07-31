//
//  SDRutorContext.m
//  MethodTest
//
//  Created by xuelin on 2017/5/28.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import "SDRutorContext.h"
#import "SDUIStackLifeCircleAction.h"

@implementation SDRutorContext
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
