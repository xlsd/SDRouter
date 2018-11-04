//
//  ThreeViewController.m
//  MethodTest
//
//  Created by as_one on 2017/7/15.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import "ThreeViewController.h"
#import "SDRouter.h"
#import "SDConstant.h"
@interface ThreeViewController ()

@end

@implementation ThreeViewController

+ (void)load {
    [[SDRouter shareRutor] addPaten:ThreeController callback:^(SDRouterContext *context) {
        NSDictionary *dict = context.paramters;
        ThreeViewController *twoVc = [ThreeViewController new];
        twoVc.navigationItem.title = dict[@"title"];
        [context.topNavigationController pushViewController:twoVc animated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.numberOfLines = 0;
    label.text = @"这是通过URL连接跳转过来的，标题是Web页面传入的";
    [self.view addSubview:label];
    
}


@end
