//
//  GTMAdNativeExpressAd.h
//  GTMAdSDK
//
//  Created by Aaslte on 2020/5/27.
//  Copyright © 2020 tredian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTMAdNativeExpressAd;
@class GTMAdNativeExpressAdView;

NS_ASSUME_NONNULL_BEGIN

@protocol GTMAdNativeExpressAdDelegate <NSObject>

@optional

/// 拉取原生模版广告成功
- (void)gtm_nativeExpressAdSuccessToLoad:(GTMAdNativeExpressAd *)nativeExpressAd views:(NSArray<GTMAdNativeExpressAdView *> *)views;

/// 拉取原生模版广告失败
- (void)gtm_nativeExpressAdFailToLoad:(GTMAdNativeExpressAd *)nativeExpressAd error:(NSError *)error;

/// 原生模板广告渲染成功, 此时的nativeExpressAdView.size.height已经根据初始化时的size.width 完成了动态更新。
- (void)gtm_nativeExpressAdViewRenderSuccess:(GTMAdNativeExpressAdView *)nativeExpressAdView;

/// 原生模板广告渲染失败
- (void)gtm_nativeExpressAdViewRenderFail:(GTMAdNativeExpressAdView *)nativeExpressAdView;

/// 原生模版广告即将显示回调
- (void)gtm_nativeExpressAdViewWillShow:(GTMAdNativeExpressAdView *)nativeExpressAdView;

/// 原生模板广告点击回调
- (void)gtm_nativeExpressAdViewDidClick:(GTMAdNativeExpressAdView *)nativeExpressAdView;

/// 原生模版广告被关闭
- (void)gtm_nativeExpressAdViewDidClose:(GTMAdNativeExpressAdView *)nativeExpressadView;

@end

@interface GTMAdNativeExpressAd : NSObject

@property (nonatomic, weak) id<GTMAdNativeExpressAdDelegate> delegate;

/// 初始化
/// @param appId appId
/// @param placementId 广告位id
/// @param adSize 广告大小
- (instancetype)initWithAppId:(NSString *)appId
                  placementId:(NSString *)placementId
                       adSize:(CGSize)adSize;


/// 请求模版广告
/// @param count 单次请求个数 次数范围[0, 4) 最多不超过3个
- (void)loadAd:(NSInteger)count;


@end

NS_ASSUME_NONNULL_END
