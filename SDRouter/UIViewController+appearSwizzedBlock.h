//
//  UIViewController+appearSwizzedBlock.h
//  MethodTest
//
//  Created by as_one on 2017/7/15.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDUIStackLifeCircleAction.h"

/**
 every instance of UIViewController have a action cache. This category provide the API to manipulate this cache.
 */
@interface UIViewController (appearSwizzedBlock)


/**
 add an instance of DZViewControllerLifeCircleBaseAction to the instance of UIViewController or it's subclass.
 
 @param action the action that will be inserted in to the cache of UIViewController's instance.
 */
- (SDUIStackLifeCircleAction* )registerLifeCircleAction:(SDUIStackLifeCircleAction *)action;


/**
 remove an instance of DZViewControllerLifeCircleBaseAction from the instance of UIViewController or it's subclass.
 
 @param action the action that will be removed from cache.
 */
- (void) removeLifeCircleAction:(SDUIStackLifeCircleAction *)action;



/**
 This function will remove the target instance from the global cache . Global action will be call when every UIViewController appear. if you want put some logic into every instance of UIViewController, you can user it.
 
 @param action the action that will be rmeove from global cache.
 */
FOUNDATION_EXTERN void SDVCRemoveGlobalAction(SDUIStackLifeCircleAction* action);



/**
 This function will add an instance of DZViewControllerLifeCircleBaseAction into the global cache. Global action will be call when every UIViewController appear. if you want put some logic into every instance of UIViewController, you can user it.
 
 @param action the action that will be insert into global cache
 */

FOUNDATION_EXTERN void SDVCRegisterGlobalAction(SDUIStackLifeCircleAction* action);

@end
