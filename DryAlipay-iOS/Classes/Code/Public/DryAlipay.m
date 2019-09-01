//
//  DryAlipay.m
//  DryAlipay
//
//  Created by Ruiying Duan on 2019/4/25.
//

#import "DryAlipay.h"
#import <AlipaySDK/AlipaySDK.h>
#import <AlipaySDK/APayAuthInfo.h>

#pragma mark - DryAlipay
@implementation DryAlipay

/// 处理支付宝通过URL启动App时传递的数据
+ (void)handleOpenURL:(NSURL *)url completion:(BlockDryAlipayCode)completion {
    
    /// 检查数据
    if (!completion) {
        return;
    }
    
    /// 支付结果回调
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        [DryAlipay resultCallback:resultDic completion:completion];
    }];
}

/// 原生应用发起支付
+ (void)payWithScheme:(NSString *)scheme
                 oder:(NSString *)oder
           completion:(BlockDryAlipayCode)completion {
    
    /// 检查数据
    if (!completion) {
        return;
    }
    
    /// 检查数据
    if (!scheme || !oder) {
        completion(kDryAlipayCodeParamErr);
        return;
    }
    
    /// 发起支付
    [[AlipaySDK defaultService] payOrder:oder fromScheme:scheme callback:^(NSDictionary *resultDic) {
        [DryAlipay resultCallback:resultDic completion:completion];
    }];
}

/// 从h5链接中获取订单串并支付接口
+ (BOOL)payWithScheme:(NSString *)scheme
                  url:(NSString *)url
           completion:(BlockDryAlipayCode)completion {
    
    /// 检查数据
    if (!completion) {
        return NO;
    }
    
    /// 检查数据
    if (!scheme || !url) {
        completion(kDryAlipayCodeParamErr);
        return NO;
    }
    
    /// 发起支付
    return [[AlipaySDK defaultService] payInterceptorWithUrl:url fromScheme:scheme callback:^(NSDictionary *resultDic) {
        [DryAlipay resultCallback:resultDic completion:completion];
    }];
}

/// 回调
+ (void)resultCallback:(nullable NSDictionary *)resultDic completion:(BlockDryAlipayCode)completion {
    
    /// 检查数据
    if (!completion) {
        return;
    }
    
    /// 检查数据
    if (!resultDic) {
        completion(kDryAlipayCodeUnknown);
        return;
    }
    
    /// 检查数据
    if (![[resultDic allKeys] containsObject:@"resultStatus"]) {
        completion(kDryAlipayCodeUnknown);
        return;
    }
    
    /// 获取支付结果
    NSInteger resultStatus = [[resultDic valueForKey:@"resultStatus"] integerValue];
    switch (resultStatus) {
            
        case kDryAlipayCodeSuccess:{
            completion(kDryAlipayCodeSuccess);
        }break;
        case kDryAlipayCodeProcessing:{
            completion(kDryAlipayCodeProcessing);
        }break;
        case kDryAlipayCodeFail:{
            completion(kDryAlipayCodeFail);
        }break;
        case kDryAlipayCodeRepeat:{
            completion(kDryAlipayCodeRepeat);
        }break;
        case kDryAlipayCodeUserCancel:{
            completion(kDryAlipayCodeUserCancel);
        }break;
        case kDryAlipayCodeNetErr:{
            completion(kDryAlipayCodeNetErr);
        }break;
        case kDryAlipayCodeOther:{
            completion(kDryAlipayCodeOther);
        }break;
        default:{
            completion(kDryAlipayCodeUnknown);
        }break;
    }
    
    /// 清理Blcok
    completion = nil;
}

@end
