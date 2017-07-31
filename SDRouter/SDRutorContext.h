//
//  SDRutorContext.h
//  MethodTest
//
//  Created by xuelin on 2017/5/28.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SDRutorContext : NSObject
/**
 解析出来的URL携带的参数 http://www.baidu.com?key1=value1&key2=value2
 {key1:value1, key2:value2}
 */
@property (nonatomic, strong) NSDictionary *paramters;

/**
 * UI栈
 */
@property (nonatomic, strong, readonly) NSArray* viewControllerStack;


/**
 * 栈顶控制器 可以用来present 行为
 */
@property (nonatomic, strong, readonly) UIViewController* topViewController;

/**
 * 如果全局UI栈中有 会返回距离栈底最近的nav, 而非栈顶
 */
@property (nonatomic, strong, readonly) UINavigationController* topNavigationController;

@end
