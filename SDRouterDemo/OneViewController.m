//
//  OneViewController.m
//  MethodTest
//
//  Created by as_one on 2017/7/15.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import "OneViewController.h"
#import "SDRouter.h"
#import "SDConstant.h"

@interface OneViewController ()

@end

@implementation OneViewController

+ (void)load {
    [[SDRouter shareRutor] addPaten:OneController callback:^(SDRouterContext *context) {
        NSLog(@"优品财富: %@",context.paramters);
        OneViewController *textOneVc = [[OneViewController alloc] init];
        textOneVc.navigationItem.title = context.paramters[@"title"];
        [context.topNavigationController pushViewController:textOneVc animated:YES];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 80)];
    [button setTitle:@"openUrl" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openUrl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)openUrl {
    NSDictionary *dict = @{@"title":@"as_two"};
    NSURL *url = SDURLRouteQueryLink(TwoController, dict);
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {}];
}


@end
