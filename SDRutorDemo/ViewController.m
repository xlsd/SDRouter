//
//  ViewController.m
//  SDRutorDemo
//
//  Created by as_one on 2017/7/16.
//  Copyright © 2017年 as_one. All rights reserved.
//

#import "ViewController.h"
#import "SDRouter.h"
#import "SDConstant.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 80)];
    [button setTitle:@"one" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)go {
    NSDictionary *param = @{@"title":@"as_one"};
    NSURL *url = SDURLRouteQueryLink(OneController, param);
    [[SDRouter shareRutor] rutor:url];
}


@end
