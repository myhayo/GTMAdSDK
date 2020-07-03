//
//  GTMAdSplashAd.h
//  GTMAdSDK
//
//  Created by Aaslte on 2020/5/25.
//  Copyright © 2020 tredian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTMAdSplashAd;

NS_ASSUME_NONNULL_BEGIN

@protocol GTMAdSplashAdDelegate <NSObject>

@optional

/// 开屏广告素材获取成功
- (void)gtm_splashAdLoadSuccess:(GTMAdSplashAd *)splashAd;

/// 开屏广告成功展示
- (void)gtm_splashAdSuccessPresentScreen:(GTMAdSplashAd *)splashAd;

/// 开屏广告展示失败
- (void)gtm_splashAd:(GTMAdSplashAd *)splashAd didFailWithError:(NSError *)error;

/// 开屏广告点击回调
- (void)gtm_splashAdDidClick:(GTMAdSplashAd *)splashAd;

/// 开屏广告关闭回调
- (void)gtm_splashAdDidClose:(GTMAdSplashAd *)splashAd;

/// 点击后打开的广告页被关闭 (注意1.0.4版本之后 某些上游广告弹出的广告页被关闭时无法获取回调)
- (void)gtm_splashAdDidCloseOtherController:(GTMAdSplashAd *)splashAd;

@end

@interface GTMAdSplashAd : NSObject

@property (nonatomic, weak) id<GTMAdSplashAdDelegate> delegate;

/// 开屏广告的背景图片 可以设置背景图片作为开屏加载时的默认背景 （目前只针对广点通上游广告）
@property (nonatomic, strong) UIImage *backgroundImage;

/// 开屏广告的背景色 可以设置开屏图片来作为开屏加载时的背景色 （目前只针对广点通上游广告）
@property (nonatomic, copy) UIColor *backgroundColor;

/// 初始化开屏广告
/// @param appId appId
/// @param placementId 广告位id
- (instancetype)initWithAppId:(NSString *)appId placementId:(NSString *)placementId;

/// 展示全屏开屏广告
/// @param window 容器window
- (void)loadAdAndShowInWindow:(UIWindow *)window;


/// 展示开屏和底部自定义视图
/// @param window 容器window
/// @param bottomView 自定义底部视图
- (void)loadAdAndShowInWindow:(UIWindow *)window withBottomView:(UIView * _Nullable )bottomView;

@end

NS_ASSUME_NONNULL_END
