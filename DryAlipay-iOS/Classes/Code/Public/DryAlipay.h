//
//  DryAlipay.h
//  DryAlipay
//
//  Created by Ruiying Duan on 2019/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 支付状态码
typedef NS_ENUM(NSInteger, DryAlipayCode) {
    /// 订单支付成功
    kDryAlipayCodeSuccess       = 9000,
    /// 正在处理中(有可能已经支付成功，请查询商户订单列表中订单的支付状态)
    kDryAlipayCodeProcessing    = 8000,
    /// 订单支付失败
    kDryAlipayCodeFail          = 4000,
    /// 重复请求
    kDryAlipayCodeRepeat        = 5000,
    /// 用户取消
    kDryAlipayCodeUserCancel    = 6001,
    /// 网络连接出错
    kDryAlipayCodeNetErr        = 6002,
    /// 支付结果未知(有可能已经支付成功，请查询商户订单列表中订单的支付状态)
    kDryAlipayCodeOther         = 6004,
    /// 未知错误
    kDryAlipayCodeUnknown       = -1,
    /// 参数异常
    kDryAlipayCodeParamErr      = -2,
};

#pragma mark - Block
/// 支付状态码回调
typedef void (^BlockDryAlipayCode)  (DryAlipayCode code);

#pragma mark - DryAlipay
@interface DryAlipay : NSObject

/// @说明 处理支付宝通过URL启动App时传递的数据(必须调用，否则支付宝支付成功后无回调)
/// @注释 需要在application:openURL:options:中调用
/// @注释 在app被杀模式下，通过这个方法获取支付结果
/// @参数 completion: 支付状态码回调，详情查看DryAlipayCode
/// @返回 BOOL
+ (void)handleOpenURL:(NSURL *)url completion:(nullable BlockDryAlipayCode)completion;

/// @说明 原生应用发起支付
/// @注释 如果外部存在支付宝钱包，则直接跳转到支付宝钱包付款；不存在的场景下，在 SDK 内部进行 H5 支付
/// @参数 scheme:     app绑定的scheme("ap+AppID")
/// @参数 oder:       订单信息(由服务端下发)
/// @参数 completion: 支付状态码回调，详情查看DryAlipayCode(只有当handleOpenURL接口的completion为nil时会使用这个bolock)
/// @返回 void
+ (void)payWithScheme:(NSString *)scheme
                 oder:(NSString *)oder
           completion:(BlockDryAlipayCode)completion;

/// @说明 从h5链接中获取订单串并支付接口
/// @参数 scheme:     app绑定的scheme("ap+AppID")
/// @参数 url:        拦截的 url string
/// @参数 completion: 支付状态码回调，详情查看DryAlipayCodes
/// @返回 YES为成功获取订单信息并发起支付流程；NO为无法获取订单信息，输入url是普通url
+ (BOOL)payWithScheme:(NSString *)scheme
                  url:(NSString *)url
           completion:(BlockDryAlipayCode)completion;

@end

NS_ASSUME_NONNULL_END
