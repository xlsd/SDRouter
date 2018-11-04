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
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, [UIScreen mainScreen].bounds.size.width - 30 * 2, 50)];
    [button setTitle:@"Router Open OneController并传参" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 25;
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)go {
    NSDictionary *param = @{@"title":@"NativePage"};
    NSURL *url = SDURLRouteQueryLink(OneController, param);
    [[SDRouter shareRutor] rutor:url];
}


@end
