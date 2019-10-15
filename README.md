# DryAlipay-iOS
iOS: 简化支付宝支付

## 官网
* [蚂蚁金服开放平台 ](https://docs.open.alipay.com/54/104509) 更新时间2019-08-14(v15.6.5)

## Prerequisites
* iOS 10.0 +
* ObjC、Swift

## Installation
* pod 'DryAlipay-iOS'
* 为URL Types 添加回调scheme(identifier:"alipay"、URL Schemes:"ap+AppID")
* info.plist文件属性LSApplicationQueriesSchemes中增加alipay字段
* 消除Alipay编译警告
```
Build Settings -> Build Options -> Debug Information Format
Debug 模式下设置成 DWARF
Release 模式下设置成 DWARF with dSYM File
```

## Features
1. 处理支付宝通过URL启动App时传递的数据(必须调用，否则支付宝支付成功后无回调)
``` 
- (BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

/// 在app被杀模式下，通过这个方法获取支付结果
[DryAlipay handleOpenURL:url completion:^(DryAlipayCode code) {

}];

return YES;
}
```
2. 原生应用发起支付
```
[DryAlipay payWithScheme:"" oder:"" completion:^(DryAlipayCode code) {

}];
```
3. 从h5链接中获取订单串并支付接口
```
[DryAlipay payWithScheme:"" oder:"" completion:^(DryAlipayCode code) {

}];
```
