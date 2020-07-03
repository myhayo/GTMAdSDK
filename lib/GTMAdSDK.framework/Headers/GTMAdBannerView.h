//
//  GTMAdBannerView.h
//  GTMAdSDK
//
//  Created by Aaslte on 2020/5/26.
//  Copyright © 2020 tredian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTMAdBannerView;

NS_ASSUME_NONNULL_BEGIN

@protocol GTMAdBannerViewDelegate <NSObject>

@optional

/// banner广告素材加载完成
- (void)gtm_bannerViewDidLoad:(GTMAdBannerView *)bannerView;

/// banner广告加载失败
- (void)gtm_bannerView:(GTMAdBannerView *)bannerView didLoadFailWithError:(NSError *)error;

/// banner广告显示回调
- (void)gtm_bannerViewDidBecomVisible:(GTMAdBannerView *)bannerView;

/// banner点击回调
- (void)gtm_bannerViewDidClick:(GTMAdBannerView *) bannerView;

/// 点击banner后弹出的广告页被关闭
- (void)gtm_bannerViewDidCloseOtherController:(GTMAdBannerView *)bannerView;

/// banner广告被关闭回调
- (void)gtm_bannerViewWillClose:(GTMAdBannerView *)bannerView;

@end

@interface GTMAdBannerView : UIView

@property (nonatomic, weak) id<GTMAdBannerViewDelegate> delegate;


/// 初始化
/// @param appId appId
/// @param placementId 广告位id
/// @param viewController present弹出广告页的vc
/// @param interval 轮播时间 [30~120] 不在范围无效 设置0则不轮播
- (instancetype)initWithAppId:(NSString *)appId
                  placementId:(NSString *)placementId
               viewController:(UIViewController *)viewController
                     interval:(int)interval;

/// 初始化
/// @param appId appId
/// @param placementId 广告位id
/// @param adSize 广告大小
/// @param viewController present弹出广告页的vc
/// @param interval 轮播时间 [30~120] 不在范围无效 设置0则不轮播
- (instancetype)initWithAppId:(NSString *)appId
                  placementId:(NSString *)placementId
                       adSize:(CGSize)adSize
               viewController:(UIViewController *)viewController
                     interval:(int)interval;

/// 加载显示广告
- (void)loadAdAndShow;

@end

NS_ASSUME_NONNULL_END
