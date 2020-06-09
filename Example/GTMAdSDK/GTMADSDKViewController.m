//
//  GTMADSDKViewController.m
//  GTMAdSDK
//
//  Created by Aaslte on 06/09/2020.
//  Copyright (c) 2020 Aaslte. All rights reserved.
//

#import "GTMADSDKViewController.h"
#import "GTMAdSDK/GTMAdSDKConfig.h"
#import "GTMAdSDK/GTMAdSplashAd.h"
#import "GTMAdSDK/GTMAdBannerView.h"
#import "GTMAdSDK/GTMAdRewardVideoAd.h"
#import "GTMAdSDK/GTMAdNativeExpressAd.h"
#import "GTMAdSDK/GTMAdNativeExpressAdView.h"
#import "GTMAdSDK/GTMAdInterstitialAd.h"
#import "GTMAdSDK/GTMAdFullscreenVideoAd.h"

@interface GTMADSDKViewController () <UITableViewDelegate, UITableViewDataSource, GTMAdSplashAdDelegate, GTMAdBannerViewDelegate, GTMAdRewardVideoAdDelegate, GTMAdNativeExpressAdDelegate, GTMAdInterstitialAdDelegate, GTMAdFullscreenVideoAdDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@property (nonatomic, strong) GTMAdSplashAd *splashAd;
@property (nonatomic, strong) GTMAdBannerView *bannerView;
@property (nonatomic, strong) GTMAdRewardVideoAd *rewardVideoAd;

@property (nonatomic, strong) GTMAdNativeExpressAd *nativeExpressAd;
@property (nonatomic, strong) NSMutableArray<GTMAdNativeExpressAdView *> *adViews;

@property (nonatomic, strong) GTMAdInterstitialAd *interstitialAd;

@property (nonatomic, strong) GTMAdFullscreenVideoAd *fullscreenVideoAd;

@end

@implementation GTMADSDKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 40)];
    _tableView.tableHeaderView = headerView;
    _tableView.rowHeight = 60;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"adView_01"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"adView_02"];
    [self.view addSubview:_tableView];
    
    _loadingView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 60)];
    _loadingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    _loadingView.hidesWhenStopped = true;
    _loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    _adViews = [NSMutableArray array];
    
    NSLog(@"=====sdk version ===>  %@", [GTMAdSDKConfig sdkVersion]);
    NSLog(@"=====gdt sdk version ===>  %@", [GTMAdSDKConfig gdtSdkVersion]);
    NSLog(@"=====tt sdk version ===>  %@", [GTMAdSDKConfig ttSdkVersion]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7 + _adViews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row <= 6) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"开屏广告";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"banner广告";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"激励视频广告";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"信息流版本广告(图文)";
        } else if (indexPath.row == 4) {
            cell.textLabel.text = @"信息流版本广告(视频)";
        } else if (indexPath.row == 5) {
            cell.textLabel.text = @"插屏广告";
        } else if (indexPath.row == 6) {
            cell.textLabel.text = @"全屏视频广告";
        }
        return cell;
    } else {
        if (indexPath.row == 7) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adView_01" forIndexPath:indexPath];
            [cell.contentView addSubview:_adViews[0]];
            return cell;
        } else if (indexPath.row == 8) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"adView_02" forIndexPath:indexPath];
            [cell.contentView addSubview:_adViews[1]];
            return cell;
        }
        return [[UITableViewCell alloc] init];
    }
     
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row <= 6) {
        return 60;
    }
    if (indexPath.row == 7) {
        return _adViews[0].frame.size.height;
    } else if (indexPath.row == 8) {
        return _adViews[1].frame.size.height;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row > 6) {
        return;
    }
    
    if (_loadingView.isAnimating) {
        return;
    }
    
    [[tableView cellForRowAtIndexPath:indexPath].contentView addSubview:_loadingView];
    [_loadingView startAnimating];
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if (indexPath.row == 0) {
        
        _splashAd = [[GTMAdSplashAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDK494F6908BAD1"];
        _splashAd.delegate = self;
        
        /*
        if ((arc4random() % 10) % 2 == 0) {
            // 全屏广告
            [_splashAd loadAdAndShowInWindow:UIApplication.sharedApplication.keyWindow];
            return;
        }*/
        
        // 创建底部视图(用作非全屏开屏广告)
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height / 4 * 3, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height / 4)];
        label.text = @"这是开屏广告底部视图";
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:30];
        label.textAlignment = NSTextAlignmentCenter;
        
        // 非全屏广告
        [_splashAd loadAdAndShowInWindow:UIApplication.sharedApplication.keyWindow withBottomView:label];
    }
    
    if (indexPath.row == 1) {
        
        CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
        CGFloat bannerHeight = screenWidth / 640 * 100;
        CGSize adSize = CGSizeMake(screenWidth, bannerHeight);
        
        [_bannerView removeFromSuperview];
        _bannerView = [[GTMAdBannerView alloc] initWithAppId:@"6A90F3261545" placementId:@"SDKF6E5574E69D3" adSize:adSize viewController:self interval:30];
        [_bannerView loadAdAndShow];
        _bannerView.delegate = self;
        
        _bannerView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - 200, screenWidth, bannerHeight);
        [self.view addSubview:_bannerView];
    }
    
    if (indexPath.row == 2) {
        _rewardVideoAd = [[GTMAdRewardVideoAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDK2B98AAC02AA0"];
        _rewardVideoAd.delegate = self;
        [_rewardVideoAd loadAd];
    }
    
    
    if (indexPath.row == 3) {
        
        [_bannerView removeFromSuperview];
        
        // 高度给0 让模版在render之后自适应
        _nativeExpressAd = [[GTMAdNativeExpressAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDKFB0E89AEC0B4" adSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 0)];
        _nativeExpressAd.delegate = self;
        [_nativeExpressAd loadAd:2];
        for (UIView *adView in _adViews) {
            [adView removeFromSuperview];
        }
        [_adViews removeAllObjects];
    }
    
    if (indexPath.row == 4) {
        
        [_bannerView removeFromSuperview];
        
        // 高度给0 让模版在render之后自适应
        _nativeExpressAd = [[GTMAdNativeExpressAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDKD8D7CC6361DA" adSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 0)];
        _nativeExpressAd.delegate = self;
        [_nativeExpressAd loadAd:2];
        for (UIView *adView in _adViews) {
            [adView removeFromSuperview];
        }
        [_adViews removeAllObjects];
    }
    
    if (indexPath.row == 5) {
        
        _interstitialAd = [[GTMAdInterstitialAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDKAEBDA8F71997" adSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 60, UIScreen.mainScreen.bounds.size.width)];
        _interstitialAd.delegate = self;
        [_interstitialAd loadAd];
    }
    
    if (indexPath.row == 6) {
        
        _fullscreenVideoAd = [[GTMAdFullscreenVideoAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDKFD4783576C59"];
        _fullscreenVideoAd.delegate = self;
        [_fullscreenVideoAd loadAd];
    }
}


#pragma - mark 开屏广告

- (void)gtm_splashAdLoadSuccess:(GTMAdSplashAd *)splashAd {
    NSLog(@"-----开屏广告素材下载成功----");
}

- (void)gtm_splashAdSuccessPresentScreen:(GTMAdSplashAd *)splashAd {
    [_loadingView stopAnimating];
    NSLog(@"-----开屏广告展示成功----");
}

- (void)gtm_splashAd:(GTMAdSplashAd *)splashAd didFailWithError:(NSError *)error {
    [_loadingView stopAnimating];
    NSLog(@"-----开屏广告展示失败 [error=>%@] ----", error);
}

- (void)gtm_splashAdDidClick:(GTMAdSplashAd *)splashAd {
    NSLog(@"-----点击开屏广告----");
}

- (void)gtm_splashAdDidCloseOtherController:(GTMAdSplashAd *)splashAd {
    NSLog(@"-----打开的开屏广告页被关闭----");
}

- (void)gtm_splashAdDidClose:(GTMAdSplashAd *)splashAd {
    NSLog(@"----开屏广告结束----");
}


#pragma - mark banner广告
- (void)gtm_bannerViewDidLoad:(GTMAdBannerView *)bannerView {
    NSLog(@"-----banner广告素材下载成功----");
}

- (void)gtm_bannerViewDidBecomVisible:(GTMAdBannerView *)bannerView {
    [_loadingView stopAnimating];
    NSLog(@"-----banner广告显示成功----");
}

- (void)gtm_bannerView:(GTMAdBannerView *)bannerView didLoadFailWithError:(NSError *)error {
    [_loadingView stopAnimating];
    NSLog(@"-----banner广告展示失败 [error=>%@] ----", error);
}

- (void)gtm_bannerViewDidClick:(GTMAdBannerView *)bannerView {
    NSLog(@"-----点击banner广告----");
}

- (void)gtm_bannerViewDidCloseOtherController:(GTMAdBannerView *)bannerView {
    NSLog(@"-----点击banner广告后打开的广告关闭----");
}

- (void)gtm_bannerViewWillClose:(GTMAdBannerView *)bannerView {
    NSLog(@"-----banner广告被关闭----");
    _bannerView = nil;
}

#pragma mark - 激励视频广告
- (void)gtm_rewardVideoAdDidLoad:(GTMAdRewardVideoAd *)rewardVideoAd {
    NSLog(@"----激励视频素材加载成功----");
}

- (void)gtm_rewardVideoAdVideoDidLoad:(GTMAdRewardVideoAd *)rewardVideoAd {
    NSLog(@"----激励视频视频缓存成功----");
    [rewardVideoAd showAdFromRootViewController:self];
}

- (void)gtm_rewardVideoAdWillVisible:(GTMAdRewardVideoAd *)rewardVideoAd {
    [_loadingView stopAnimating];
    NSLog(@"----激励视频播放页显示----");
}

- (void)gtm_rewardVideoAdDidClick:(GTMAdRewardVideoAd *)rewardVideoAd {
    NSLog(@"----点击激励视频播放页信息----");
}

- (void)gtm_rewardVideoAdDidClose:(GTMAdRewardVideoAd *)rewardVdieoAd {
    NSLog(@"----激励视频播放页关闭----");
}

- (void)gtm_rewardVideoAdDidPlayFinish:(GTMAdRewardVideoAd *)rewardVideoAd {
    NSLog(@"----激励视频播放完成----");
}

- (void)gtm_rewardVideoAd:(GTMAdRewardVideoAd *)rewardVideoAd didFailWithError:(NSError *)error {
    [_loadingView stopAnimating];
    NSLog(@"----激励视频广告展示失败 [error=>%@] ----", error);
}

#pragma mark - 原生模版广告
- (void)gtm_nativeExpressAdSuccessToLoad:(GTMAdNativeExpressAd *)nativeExpressAd views:(NSArray<GTMAdNativeExpressAdView *> *)views {
    
    NSLog(@"----原生模版广告加载成功----");
    
    [_adViews removeAllObjects];
    
    for (int i = 0; i < views.count; i++) {
        GTMAdNativeExpressAdView *adView = views[i];
        // 渲染广告视图
        [adView rednerWithController:self];
        [_adViews addObject:adView];
        
    }
    
    [_tableView reloadData];
}

- (void)gtm_nativeExpressAdViewRenderSuccess:(GTMAdNativeExpressAdView *)nativeExpressAdView {
    
    NSLog(@"%@", [NSString stringWithFormat:@"----原生模版广告_0%lu渲染成功----", (unsigned long)[_adViews indexOfObject:nativeExpressAdView] + 1]);
    [_tableView reloadData];
}

- (void)gtm_nativeExpressAdViewWillShow:(GTMAdNativeExpressAdView *)nativeExpressAdView {
    [_loadingView stopAnimating];
    NSLog(@"----原生模版广告显示成功----");
}

- (void)gtm_nativeExpressAdViewDidClick:(GTMAdNativeExpressAdView *)nativeExpressAdView {
    NSLog(@"----点击原生模版广告----");
}

- (void)gtm_nativeExpressAdViewDidClose:(GTMAdNativeExpressAdView *)nativeExpressadView {
    NSLog(@"----关闭原生模版广告----");
    [nativeExpressadView removeFromSuperview];
    [_adViews removeObject:nativeExpressadView];
    [_tableView reloadData];
}

- (void)gtm_nativeExpressAdFailToLoad:(GTMAdNativeExpressAd *)nativeExpressAd error:(NSError *)error {
    [_loadingView stopAnimating];
    NSLog(@"----原生模版广告加载失败 [error=>%@] ----", error);
}

- (void)gtm_nativeExpressAdViewRenderFail:(GTMAdNativeExpressAdView *)nativeExpressAdView {
    [_loadingView stopAnimating];
    NSLog(@"----原生模版广告渲染失败----");
    [nativeExpressAdView removeFromSuperview];
    [_adViews removeObject:nativeExpressAdView];
    [_tableView reloadData];
}

#pragma mark - 插屏广告

- (void)gtm_interstitialSuccessToLoadAd:(GTMAdInterstitialAd *)interstitialAd {
    NSLog(@"----插屏广告加载成功----");
    
    // 显示插屏广告
    [interstitialAd showAdFromRootViewController:self];
    // 可根据业务逻辑选择在之后展示 一般有效期为半小时 展示之前使用 isValid 判断广告是否有效再展示
}

- (void)gtm_interstitialFailToLoadAd:(GTMAdInterstitialAd *)interstitialAd error:(NSError *)error {
    NSLog(@"----插屏广告加载失败 [error=>%@] ----", error);
    [_loadingView stopAnimating];
}

- (void)gtm_interstitialWillVisible:(GTMAdInterstitialAd *)interstitialAd {
    NSLog(@"----插屏广告显示成功----");
    [_loadingView stopAnimating];
}

- (void)gtm_interstitalFailToPresent:(GTMAdInterstitialAd *)interstitialAd {
    NSLog(@"----插屏广告显示失败----");
    [_loadingView stopAnimating];
}

- (void)gtm_interstitialDidClick:(GTMAdInterstitialAd *)interstitialAd {
    NSLog(@"----点击插屏广告----");
}

- (void)gtm_interstitialDidCloseOtherController:(GTMAdInterstitialAd *)interstitialAd {
    NSLog(@"----点击插屏广告后展示的广告页被关闭----");
}

- (void)gtm_interstitialDidClose:(GTMAdInterstitialAd *)interstitialAd {
    NSLog(@"----插屏广告展示完成----");
}

#pragma mark - 全屏视频广告

- (void)gtm_fullscreenVideoAdDidLoad:(GTMAdFullscreenVideoAd *)fullscreenVideoAd {
    
    NSLog(@"----全屏视频广告加载成功----");
}

- (void)gtm_fullscreenVideoAd:(GTMAdFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    NSLog(@"----全屏视频广告加载失败 [error=>%@] ----", error);
    [_loadingView stopAnimating];
}

- (void)gtm_fullscreenVideoAdViewRenderSuccess:(GTMAdFullscreenVideoAd *)fullscreenVideoAd {
    
    NSLog(@"----全屏视频广告渲染成功----");
    [fullscreenVideoAd showAdFromRootViewController:self];
    [_loadingView stopAnimating];
}

- (void)gtm_fullscrrenVideoAdViewRenderFail:(GTMAdFullscreenVideoAd *)fullscreenVideoAd error:(NSError *)error {
    
    NSLog(@"----全屏视频广告渲染失败 [error=>%@] ----", error);
    [_loadingView stopAnimating];
}

- (void)gtm_fullscreenVideoAdViewWillVisible:(GTMAdFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"----全屏视频广告即将展示----");
}

- (void)gtm_fullscreenVideoAdViewDidVisible:(GTMAdFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"----全屏视频广告展示成功----");
}

- (void)gtm_fullscreenVideoAdDidClick:(GTMAdFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"----点击全屏视频广告----");
}

- (void)gtm_fullscreenVideoAdDidCloseOtherController:(GTMAdFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"----点击全屏视频后打开的广告页被关闭----");
}

- (void)gtm_fullscreenVideoAdDidClose:(GTMAdFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"----关闭全屏视频广告----");
}

- (void)gtm_fullscreenVideoAdDidPlayFinish:(GTMAdFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"----全屏视频广告播放完成----");
}

@end
