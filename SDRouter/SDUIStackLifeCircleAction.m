//
//  SDUIStackLifeCircleAction.m
//  MethodTest
//
//  Created by as_one on 2017/7/12.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import "SDUIStackLifeCircleAction.h"
#import "UIViewController+appearSwizzedBlock.h"

static SDUIStackLifeCircleAction* SDUIShareStack;

SDUIStackLifeCircleAction* SDUIShareStackInstance() {
    return SDUIShareStack;
}

@interface SDUIStackLifeCircleAction () {
    NSPointerArray* _uiStack;
}
@end

@implementation SDUIStackLifeCircleAction

+ (void) load {
    SDUIShareStack = [SDUIStackLifeCircleAction new];
    SDVCRegisterGlobalAction(SDUIShareStack);
}
- (instancetype) init {
    self = [super init];
    if (!self) {
        return self;
    }
    _uiStack = [NSPointerArray weakObjectsPointerArray];
    return self;
}
- (void) hostController:(UIViewController *)vc viewDidAppear:(BOOL)animated {
    if (vc) {
        [_uiStack addPointer:(void*)vc];
    }
    [_uiStack compact];
}
- (void) hostController:(UIViewController *)vc viewWillDisappear:(BOOL)animated {
    [_uiStack compact];
}

- (void) hostController:(UIViewController *)vc viewWillAppear:(BOOL)animated {
    //  移除NULL
    [_uiStack compact];
}

- (void) hostController:(UIViewController *)vc viewDidDisappear:(BOOL)animated {
    NSArray* allObjects = [_uiStack allObjects];
    for (int i = (int)allObjects.count-1; i >= 0; i--) {
        id object = allObjects[i];
        if (vc == object) {
            [_uiStack replacePointerAtIndex:i withPointer:NULL];
        }
    }
    [_uiStack compact];
}

- (NSArray*) viewControllerStack {
    [_uiStack compact];
    return [_uiStack allObjects];
}


@end
