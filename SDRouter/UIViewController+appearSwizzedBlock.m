//
//  UIViewController+appearSwizzedBlock.m
//  MethodTest
//
//  Created by as_one on 2017/7/15.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import "UIViewController+appearSwizzedBlock.h"
#import <objc/runtime.h>
void __SDViewControllerLifeCircleSwizzInstance(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static void* SDViewAppearKey = &SDViewAppearKey;

typedef void(^SDViewAppearBlock)(BOOL animated);

typedef void(^SDItorActionBlock)(SDUIStackLifeCircleAction* action );

void SDItorAction(NSArray* actions, SDItorActionBlock block) {
    for (SDUIStackLifeCircleAction* action in actions) {
        if (block) {
            block(action);
        }
    }
}

NSMutableArray* SDViewControllerGlobalActions() {
    static NSMutableArray* globalActions = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        globalActions = [NSMutableArray array];
    });
    return globalActions;
}

void SDVCRegisterGlobalAction(SDUIStackLifeCircleAction* action) {
    void(^Register)(void) = ^(void) {
        NSMutableArray* actions = SDViewControllerGlobalActions();
        if (![actions containsObject:action]) {
            [actions addObject:action];
        }
    };
    
    if ([NSThread mainThread]) {
        Register();
    } else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            Register();
        });
    }
}

void SDVCRemoveGlobalAction(SDUIStackLifeCircleAction* action) {
    void(^Remove)(void) = ^(void) {
        NSMutableArray* actions = SDViewControllerGlobalActions();
        if ([actions containsObject:action]) {
            [actions removeObject:action];
        }
    };
    if ([NSThread mainThread]) {
        Remove();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            Remove();
        });
    }
}

@implementation UIViewController (appearSwizzedBlock)
- (NSArray*) lifeCircleActions
{
    NSArray* lcs = objc_getAssociatedObject(self, SDViewAppearKey);
    if ([lcs isKindOfClass:[NSArray class]]) {
        return lcs;
    }
    return [NSArray array];
}

- (void) setLifeCircleActions:(NSArray*)array
{
    objc_setAssociatedObject(self, SDViewAppearKey, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (SDUIStackLifeCircleAction* )registerLifeCircleAction:(SDUIStackLifeCircleAction *)action
{
    NSMutableArray* array = [NSMutableArray arrayWithArray:[self lifeCircleActions]];
//    if ([array containsObject:action]) {
//        for (SDUIStackLifeCircleAction* act in array) {
//            if ([action.identifier isEqualToString:act.identifier]) {
//                return act;
//            }
//        }
//    }
    [array addObject:action];
    [self setLifeCircleActions:array];
    return action;
}

- (void) removeLifeCircleAction:(SDUIStackLifeCircleAction *)action
{
    NSArray* array = [self lifeCircleActions];
    NSInteger index = [array indexOfObject:action];
    if (index == NSNotFound) {
        return;
    }
    NSMutableArray* mArray = [NSMutableArray arrayWithArray:array];
    [mArray removeObjectAtIndex:index];
    [self setLifeCircleActions:array];
}



- (void) sd_action_performAction:(SDItorActionBlock)block
{
    SDItorAction([SDViewControllerGlobalActions() copy], block);
    SDItorAction([[self lifeCircleActions] copy], block);
}

- (void) sd_action_swizzViewDidDisappear:(BOOL)animated
{
    [self sd_action_swizzViewDidDisappear:animated];
    [self sd_action_performAction:^(SDUIStackLifeCircleAction *action) {
        if ([action respondsToSelector:@selector(hostController:viewDidDisappear:)]) {
            [action hostController:self viewDidDisappear:animated];
        }
    }];
}

- (void) sd_action_swizzViewWillDisappear:(BOOL)animated
{
    [self sd_action_swizzViewWillDisappear:animated];
    [self sd_action_performAction:^(SDUIStackLifeCircleAction *action) {
        if ([action respondsToSelector:@selector(hostController:viewWillDisappear:)]) {
            [action hostController:self viewWillDisappear:animated];
        }
    }];
}
- (void) sd_action_swizzviewWillAppear:(BOOL)animated
{
    [self sd_action_swizzviewWillAppear:animated];
    [self sd_action_performAction:^(SDUIStackLifeCircleAction *action) {
        if ([action respondsToSelector:@selector(hostController:viewWillAppear:)]) {
            [action hostController:self viewWillAppear:animated];
        }
    }];
}

-(void)sd_action_swizzviewDidAppear:(BOOL)animated
{
    [self sd_action_swizzviewDidAppear:animated];
    [self sd_action_performAction:^(SDUIStackLifeCircleAction *action) {
        if ([action respondsToSelector:@selector(hostController:viewDidAppear:)]) {
            [action hostController:self viewDidAppear:animated];
        }
    }];
}

@end

@interface UIViewControllerActionSetup : NSObject

@end

@implementation UIViewControllerActionSetup

+ (void) load {
    Class viewControllerClass = [UIViewController class];
    __SDViewControllerLifeCircleSwizzInstance(viewControllerClass,@selector(viewDidAppear:),@selector(sd_action_swizzviewDidAppear:));
    __SDViewControllerLifeCircleSwizzInstance(viewControllerClass, @selector(viewDidDisappear:), @selector(sd_action_swizzViewDidDisappear:));
    __SDViewControllerLifeCircleSwizzInstance(viewControllerClass, @selector(viewWillAppear:), @selector(sd_action_swizzviewWillAppear:));
    __SDViewControllerLifeCircleSwizzInstance(viewControllerClass, @selector(viewWillDisappear:), @selector(sd_action_swizzViewWillDisappear:));
}
@end
