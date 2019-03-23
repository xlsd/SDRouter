# SDRouterDemo

### 本库是基于一水流年的模块化设计思想进行的简化版，请看原作者架构阐述。
### [一水流年DZURLRouter](http://dzpqzb.com/2016/11/08/2016-11-08-dzurlrouter/)

SDRouter use for decoupling.use simple code bridge native to native or H5 to native by AppSchema  with parameter, like this "asone://oneController?url=http://www.baidu.com" SDRouter 可以用来在模块与模块间的解耦及通信，也可以作为H5和原生的交互、跳转、传参。

![image](https://github.com/xlsd/SDRouter/blob/master/SpouttingFiles/demo.gif)

原生跳原生带参数使用（可以参考demo）：

1.给需要使用url跳转的控制器 定义url如
`NSString *const OneController = @"asone://oneController";`

2.在该控制器+load方法中添加如下代码
```
+ (void)load {
    [[SDRouter shareRutor] addPaten:OneController callback:^(SDRouterContext *context) {
        NSLog(@"优品财富: %@",context.paramters);
        OneViewController *textOneVc = [[OneViewController alloc] init];
        textOneVc.navigationItem.title = context.paramters[@"title"];
        [context.topNavigationController pushViewController:textOneVc animated:YES];
    }];
}
```

3.跳转到该控制器
```
NSDictionary *param = @{@"title":@"as_one"};
NSURL *url = SDURLRouteQueryLink(OneController, param);
[[SDRouter shareRutor] rutor:url];
```

H5跳原生带参数使用（可以参考demo）：
1.步骤同上1
2.步骤同上2
3.前端人员需要在页面元素中添加script代码如下
```
function jump(){
    window.location="asone://threeController?title=title=NativePage";
}
```
```
pod 'SDRouter'
```

其他说明:
其实前端不一定非要使用window.location，也可以直接给个url内链跳转也是一样的。这和该库内部实现方式有关，只是上面的脚本更加通用，两种方式的区别，会在[原理篇](http://www.jianshu.com/p/2f81b5fbd919)讲解。
