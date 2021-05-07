//
//  GTMAdRewardVideoAd.h
//  GTMAdSDK
//
//  Created by Aaslte on 2020/5/26.
//  Copyright © 2020 tredian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTMAdRewardVideoAd;

NS_ASSUME_NONNULL_BEGIN

@protocol GTMAdRewardVideoAdDelegate <NSObject>

@optional

/// 广告数据加载成功回调
- (void)gtm_rewardVideoAdDidLoad:(GTMAdRewardVideoAd *)rewardVideoAd;

/// 视频数据下载成功回调
- (void)gtm_rewardVideoAdVideoDidLoad:(GTMAdRewardVideoAd *)rewardVideoAd;

/// 视频播放页即将展示回调
- (void)gtm_rewardVideoAdWillVisible:(GTMAdRewardVideoAd *)rewardVideoAd;

/// 视频播放完成回调
- (void)gtm_rewardVideoAdDidPlayFinish:(GTMAdRewardVideoAd *)rewardVideoAd;

/// 加载激励视频出现错误回调
- (void)gtm_rewardVideoAd:(GTMAdRewardVideoAd *)rewardVideoAd didFailWithError:(NSError *_Nullable)error;

/// 视频广告信息点击回调
- (void)gtm_rewardVideoAdDidClick:(GTMAdRewardVideoAd *)rewardVideoAd;

/// 视频播放页关闭回调
- (void)gtm_rewardVideoAdDidClose:(GTMAdRewardVideoAd *)rewardVdieoAd;

/**
 视频广告播放达到激励条件回调
 
 @param rewardedVideoAd GTMAdRewardVideoAd 实例
 @param info 包含此次广告行为的一些信息
 
 如果上游是广点通 则信息为 @{@"GDT_TRANS_ID":@"930f1fc8ac59983bbdf4548ee40ac353"}, 通过@“GDT_TRANS_ID”可获取此次广告行为的交易id
 
 如果上游是头条 则信息为 @{@"verify": @(1)}
 通过@"verify"可以获取本次是否验证通过
 */
- (void)gtm_rewardVideoAdDidRewardEffective:(GTMAdRewardVideoAd *)rewardedVideoAd info:(NSDictionary *)info;

@end

@interface GTMServerVerificationOptions : NSObject

// 用户的userid,可选
@property(nonatomic, copy, nullable) NSString *userIdentifier;

// 服务器端验证回调中包含的可选自定义奖励字符串
@property(nonatomic, copy, nullable) NSString *customRewardString;

@end


@interface GTMAdRewardVideoAd : NSObject

/// 广告缓存的视频是否有效 (头条上游废弃该字段 上游广告为头条时总是返回YES)
@property (nonatomic, assign, readonly) BOOL isValid;

@property (nonatomic, weak) id<GTMAdRewardVideoAdDelegate> delegate;
@property (nonatomic, strong) GTMServerVerificationOptions *options;


/// 初始化
/// @param appId appId
/// @param placementId 广告位id
- (instancetype)initWithAppId:(NSString *)appId placementId:(NSString *)placementId;

/// 初始化
/// @param appId appId
/// @param placementId 广告位id
/// @param options 奖励依赖服务端回调所需参数
- (instancetype)initWithAppId:(NSString *)appId placementId:(NSString *)placementId options:(GTMServerVerificationOptions *)options;

/// 加载广告
- (void)loadAd;

/// 展示广告
/// @param rootViewController 用于present广告页面
- (void)showAdFromRootViewController:(UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END
