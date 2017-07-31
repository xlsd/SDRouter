//
//  SDUIStackLifeCircleAction.h
//  MethodTest
//
//  Created by as_one on 2017/7/12.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDUIStackLifeCircleAction : NSObject

//@property (nonatomic, strong) NSString* identifier;
@property (nonatomic, strong, readonly) NSArray* viewControllerStack;

FOUNDATION_EXTERN SDUIStackLifeCircleAction* SDUIShareStackInstance();

- (void) hostController:(UIViewController*)vc viewWillAppear:(BOOL)animated;
- (void) hostController:(UIViewController*)vc viewDidAppear:(BOOL)animated;
- (void) hostController:(UIViewController*)vc viewWillDisappear:(BOOL)animated;
- (void) hostController:(UIViewController*)vc viewDidDisappear:(BOOL)animated;

@end
