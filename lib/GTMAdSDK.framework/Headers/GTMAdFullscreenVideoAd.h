//
//  GTMAdFullscreenVideoAd.h
//  GTMAdSDK
//
//  Created by Aaslte on 2020/6/1.
//  Copyright © 2020 tredian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTMAdFullscreenVideoAd;

NS_ASSUME_NONNULL_BEGIN

@protocol GTMAdFullscreenVideoAdDelegate <NSObject>

@optional

/// 广告加载成功
- (void)gtm_fullscreenVideoAdDidLoad:(GTMAdFullscreenVideoAd *)fullscreenVideoAd;

/// 广告加载失败
- (void)gtm_fullscreenVideoAd:(GTMAdFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error;

/// 广告渲染成功
- (void)gtm_fullscreenVideoAdViewRenderSuccess:(GTMAdFullscreenVideoAd *)fullscreenVideoAd;

/// 广告渲染失败
- (void)gtm_fullscrrenVideoAdViewRenderFail:(GTMAdFullscreenVideoAd *)fullscreenVideoAd error:(NSError *_Nullable)error;

/// 广告即将展示
- (void)gtm_fullscreenVideoAdViewWillVisible:(GTMAdFullscreenVideoAd *)fullscreenVideoAd;

/// 广告展示成功
- (void)gtm_fullscreenVideoAdViewDidVisible:(GTMAdFullscreenVideoAd *)fullscreenVideoAd;

/// 点击广告
- (void)gtm_fullscreenVideoAdDidClick:(GTMAdFullscreenVideoAd *)fullscreenVideoAd;

/// 点击广告后展示的详情页被关闭 (注意1.0.4版本之后 某些上游广告弹出的广告页被关闭时无法获取回调)
- (void)gtm_fullscreenVideoAdDidCloseOtherController:(GTMAdFullscreenVideoAd *)fullscreenVideoAd;

/// 视频播放完成（1.0.4版本之后如果配置了sigmob平台的广告 播放完成不能作为完整播放视频的判断条件，因为sigmob平台广告在点击跳过按钮后依然回调播放完成）
- (void)gtm_fullscreenVideoAdDidPlayFinish:(GTMAdFullscreenVideoAd *)fullscreenVideoAd;

/// 关闭广告页面
- (void)gtm_fullscreenVideoAdDidClose:(GTMAdFullscreenVideoAd *)fullscreenVideoAd;

@end

@interface GTMAdFullscreenVideoAd : NSObject

@property (nonatomic, weak, nullable) id<GTMAdFullscreenVideoAdDelegate> delegate;

/// 视频是否有效
@property (nonatomic, readonly) BOOL isAdValid;

/// 初始化
/// @param appId appId
/// @param placementId 广告位id
- (instancetype)initWithAppId:(NSString *)appId
                  placementId:(NSString *)placementId;

/// 加载广告
- (void)loadAd;

/// 展示广告
- (void)showAdFromRootViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
