//
//  GTMAdInterstitialAd.h
//  GTMAdSDK
//
//  Created by Aaslte on 2020/6/1.
//  Copyright © 2020 tredian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTMAdInterstitialAd;

NS_ASSUME_NONNULL_BEGIN

@protocol GTMAdInterstitialAdDelegate <NSObject>

@optional

/// 插屏广告数据加载成功
- (void)gtm_interstitialSuccessToLoadAd:(GTMAdInterstitialAd *)interstitialAd;

/// 插屏广告数据加载失败
- (void)gtm_interstitialFailToLoadAd:(GTMAdInterstitialAd *)interstitialAd error:(NSError *)error;

/// 插屏广告将要展示
- (void)gtm_interstitialWillVisible:(GTMAdInterstitialAd *)interstitialAd;

/// 插屏广告展示失败(接口废弃，统一错误回调在gtm_interstitialFailToLoadAd中)
- (void)gtm_interstitialFailToPresent:(GTMAdInterstitialAd *)interstitialAd;

/// 插屏广告点击回调(一些上游广告在点击展示详情后自动关闭 该回调在didClose之后调用)
- (void)gtm_interstitialDidClick:(GTMAdInterstitialAd *)interstitialAd;

/// 插屏点击后弹出的全屏广告被关闭回调
- (void)gtm_interstitialDidCloseOtherController:(GTMAdInterstitialAd *)interstitialAd;

/// 插屏广告展示结束回调(一些上游广告在点击展示详情后自动关闭 该回调在didClick之前调用)
- (void)gtm_interstitialDidClose:(GTMAdInterstitialAd *)interstitialAd;

@end

@interface GTMAdInterstitialAd : NSObject

@property (nonatomic, weak, nullable) id<GTMAdInterstitialAdDelegate> delegate;

/// 插屏预加载是否完成
@property (nonatomic, readonly) BOOL isAdValid;

/// 初始化
/// @param appId appId
/// @param placementId 广告位id
/// @param adSize 广告大小(根据上游返回，一些情况下设置无效，需要后台同步配置大小 目前后台可设置返回的宽高比为3:2 1:1 2:3，设置无效的上游广告会自动布局居中显示)
- (instancetype)initWithAppId:(NSString *)appId
                  placementId:(NSString *)placementId
                       adSize:(CGSize)adSize;

/// 加载广告
- (void)loadAd;

/// 展示广告
- (void)showAdFromRootViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
