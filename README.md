# 火眼聚合广告 SDK v1.0.2 接入文档 （for iOS）



[TOC]

## 1. SDK 集成

### 1.1 CocoaPods集成

```ruby
pod 'GTMAdSDK'
```

### 1.2 聚合包使用第三方平台SDK版本

如果原工程内自行接入第三方广告SDK，请尽量使用下列版本

- 穿山甲SDK版本：**2.9.5.8**
- 广点通SDK版本：**4.11.8**

### 1.3 聚合SDK使用中各第三方平台注册APPID注意事项

聚合包中在使用任意类型广告**获取广告时**会调用对应平台的**`registerAppid`**的方法注册对应**appid**。

所以如果原工程集成了相同的第三方广告平台，需要在获取广告时重新注册**appid**，以免被聚合SDK重置appid后导致无法获取广告。

### 1.4 SDK手动集成

- 下载 GTMAdSDK，找到 lib 文件夹，SDK的framework文件在这个文件夹下
- 拖拽framework文件到 Xcode 工程内 (请勾选Copy items if needed选项) 
- 头文件如下：

```
.
├── GTMAdSDK.h
├── GTMAdSDKConfig.h
├── GTMAdSplashAd.h
├── GTMAdBannerView.h
├── GTMAdRewardVideoAd.h
├── GTMAdNativeExpressAd.h
├── GTMAdNativeExpressAdView.h
├── GTMAdInterstitialAd.h
└── GTMAdFullscreenVideoAd.h
```

- 在Build Phases -> link with libraries 下加入如下依赖.

```
StoreKit.framework
MobileCoreServices.framework
WebKit.framework
MediaPlayer.framework
MessageUI.framework
SafariServices.framework
CoreMedia.framework
CoreLocation.framework
AVFoundation.framework
CoreTelephony.framework
SystemConfiguration.framework
AdSupport.framework
CoreMotion.framework
Accelerate.framework
libresolv.9.tbd
libc++.tbd
libz.tbd
libsqlite3.tbd
libxml2.2.tbd
```

- 如果以上依赖库增加完仍旧报错，请添加ImageIO.framework。
- Build Setting --> Linking --> Other Linker Flag 设置 增加 `-ObjC` linker flag

### 1.5 集成过程中注意事项

手动集成聚合SDK时，因为聚合SDK依赖其他第三方平台的广告SDK，如穿山甲和广点通SDK，需要自行下载。

或者联系商务同学由我们提供。

## 2. SDK 调用

SDK支持**`开屏`**、**`Banner`**、**`激励视频`**、**`信息流模版(图文和视频)`**、**`插屏`**、**`全屏视频`**六种种类型的广告。

对应类型广告调用时导入对应的头文件。

### 2.1 开屏广告

##### 2.1.1 开屏广告对应头文件

```objective-c
#import "GTMAdSplashAd.h"
```

##### 2.1.2 展示开屏广告期间使用变量保存开屏实例

```objective-c
@property (nonatomic, strong) GTMAdSplashAd *splashAd;
```

##### 2.1.3 创建开屏实例并设置**`代理`**

```objective-c
_splashAd = [[GTMAdSplashAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDK494F6908BAD1"];
_splashAd.delegate = self;
```

##### 2.1.4 开始加载开屏广告，分为**`全屏开屏`**广告和**`非全屏开屏广告`**

```objective-c
// 全屏广告
[_splashAd loadAdAndShowInWindow:UIApplication.sharedApplication.keyWindow];
```

```objective-c
// 创建底部视图
UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height / 4 * 3, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height / 4)];
label.text = @"这是开屏广告底部视图";
label.textColor = [UIColor blackColor];
label.backgroundColor = [UIColor whiteColor];
label.font = [UIFont systemFontOfSize:30];
label.textAlignment = NSTextAlignmentCenter;
        
// 非全屏广告
[_splashAd loadAdAndShowInWindow:UIApplication.sharedApplication.keyWindow withBottomView:label];
```

##### 2.1.5 通过代理处理广告事件

```objective-c
// 实现代理
<GTMAdSplashAdDelegate>

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
```

### 2.2 Banner广告

##### 2.2.1 Banner广告对应头文件

```objective-c
#import "GTMAdBannerView.h"
```

##### 2.2.2 展示Banner广告期间使用变量保存Banner实例

```objective-c
@property (nonatomic, strong) GTMAdBannerView *bannerView;
```

##### 2.2.3 创建Banner实例、设置代理并发起广告加载。

```objective-c
[_bannerView removeFromSuperview];
_bannerView = [[GTMAdBannerView alloc] initWithAppId:@"6A90F3261545" placementId:@"SDK9BB9F992461E" viewController:self];
_bannerView.delegate = self;
// 获取广告并显示
[_bannerView loadAdAndShow];
        
_bannerView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - 200, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width / 6.4);
[self.view addSubview:_bannerView];
```

##### 2.2.4 通过代理处理广告事件

```objective-c
// 实现代理
<GTMAdBannerViewDelegate>
  
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
}
```

### 2.3 激励视频广告

##### 2.3.1 激励视频广告对应头文件

```objective-c
#import "GTMAdRewardVideoAd.h"
```

##### 2.3.2 激励视频展示期间使用变量保存激励视频实例

```objective-c
@property (nonatomic, strong) GTMAdRewardVideoAd *rewardVideoAd;
```

##### 2.3.3 创建实例、设置代理并发起广告请求

```objective-c
_rewardVideoAd = [[GTMAdRewardVideoAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDK2B98AAC02AA0"];
_rewardVideoAd.delegate = self;
[_rewardVideoAd loadAd];
```

##### 2.3.4 实现代理方法

```objective-c
// 实现代理
<GTMAdRewardVideoAdDelegate>
  
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
```

##### 2.3.5 其中在激励视频缓存成功的代理回调中选择是否展示激励视频

```objective-c
- (void)gtm_rewardVideoAdVideoDidLoad:(GTMAdRewardVideoAd *)rewardVideoAd {
    NSLog(@"----激励视频视频缓存成功----");
  	// 展示激励视频
    [rewardVideoAd showAdFromRootViewController:self];
  	// 可根据业务逻辑选择在之后展示 一般有效期为半小时 展示之前使用 isValid 判断广告是否有效再展示
}
```

### 2.4 信息流模版广告(图文和视频)

##### 2.4.1 模版广告对应头文件

```objective-c
#import "GTMAdNativeExpressAd.h"
#import "GTMAdNativeExpressAdView.h"
```

##### 2.4.2 创建实例并设置代理

```objective-c
@property (nonatomic, strong) GTMAdNativeExpressAd *nativeExpressAd;
@property (nonatomic, strong) NSMutableArray<GTMAdNativeExpressAdView *> *adViews;

// 高度给0 让模版在render之后自适应
_nativeExpressAd = [[GTMAdNativeExpressAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDKFB0E89AEC0B4" adSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 0)];
_nativeExpressAd.delegate = self;
[_nativeExpressAd loadAd:2];

for (UIView *adView in _adViews) {
	[adView removeFromSuperview];
}
[_adViews removeAllObjects];
```

##### 2.4.3 处理代理回调事件

```objective-c
// 实现代理
<GTMAdNativeExpressAdDelegate>

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
    NSLog(@"----原生模版广告加载失败----");
}

- (void)gtm_nativeExpressAdViewRenderFail:(GTMAdNativeExpressAdView *)nativeExpressAdView {
    [_loadingView stopAnimating];
    NSLog(@"----原生模版广告渲染失败----");
    [nativeExpressAdView removeFromSuperview];
    [_adViews removeObject:nativeExpressAdView];
    [_tableView reloadData];
}
```

##### 2.4.4 在获取到广告模版视图**`GTMAdNativeExpressAdView`**后调用渲染方法进行渲染

```objective-c
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
```

##### 2.4.5 模版视图渲染成功后，视图高度已经重新自适应调整，刷新界面。

```objective-c
- (void)gtm_nativeExpressAdViewRenderSuccess:(GTMAdNativeExpressAdView *)nativeExpressAdView {
    
    NSLog(@"%@", [NSString stringWithFormat:@"----原生模版广告_0%lu渲染成功----", (unsigned long)[_adViews indexOfObject:nativeExpressAdView] + 1]);
    [_tableView reloadData];
} 
```

##### 2.4.6 代理方法中收到模版广告被关闭回调后主动移除广告视图

```objective-c
- (void)gtm_nativeExpressAdViewDidClose:(GTMAdNativeExpressAdView *)nativeExpressadView {
    NSLog(@"----关闭原生模版广告----");
    [nativeExpressadView removeFromSuperview];
    [_adViews removeObject:nativeExpressadView];
    [_tableView reloadData];
}
```



### 2.5 插屏广告

##### 2.5.1 插屏广告对应头文件

```objective-c
#import "GTMAdInterstitialAd.h"
```

##### 2.5.2 创建实例并设置代理

```objective-c
@property (nonatomic, strong) GTMAdInterstitialAd *interstitialAd;

_interstitialAd = [[GTMAdInterstitialAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDKAEBDA8F71997" adSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 60, UIScreen.mainScreen.bounds.size.width)];
_interstitialAd.delegate = self;
[_interstitialAd loadAd];
```

##### 2.5.3 处理代理回调事件

```objective-c
// 实现代理
<GTMAdInterstitialAdDelegate>
  
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
```

##### 2.5.4 在广告加载成功后选择是否展示

```objective-c
- (void)gtm_interstitialSuccessToLoadAd:(GTMAdInterstitialAd *)interstitialAd {
    NSLog(@"----插屏广告加载成功----");
    // 显示插屏广告
    [interstitialAd showAdFromRootViewController:self];
    // 可根据业务逻辑选择在之后展示 一般有效期为半小时 展示之前使用 isValid 判断广告是否有效再展示
}
```

##### 2.5.5 注意代理中`点击广告回调` `广告展示结束回调`这两个回调的顺序会在不同上游的广告中表现不一样

- 一些上游广告点击后 先执行`广告展示结束回调`后立即执行`点击广告回调`，即点击广告时自动关闭广告页。
- 一些上游广告点击之后执行`点击广告回调`，不会主动关闭广告页。

### 2.6 全屏视频广告

##### 2.6.1 全屏视频广告对应头文件

```objective-c
#import "GTMAdFullscreenVideoAd.h"
```

##### 2.6.2 创建实例并设置代理

```objective-c
@property (nonatomic, strong) GTMAdFullscreenVideoAd *fullscreenVideoAd;

_fullscreenVideoAd = [[GTMAdFullscreenVideoAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDKFD4783576C59"];
_fullscreenVideoAd.delegate = self;
[_fullscreenVideoAd loadAd];
```

##### 2.6.3 实现代理方法

```objective-c
// 实现代理
<GTMAdFullscreenVideoAdDelegate>

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
```

##### 2.6.4 在广告渲染成功后选择是否展示

```objective-c
- (void)gtm_fullscreenVideoAdViewRenderSuccess:(GTMAdFullscreenVideoAd *)fullscreenVideoAd {
    
    NSLog(@"----全屏视频广告渲染成功----");
  	// 展示全屏视频广告
    [fullscreenVideoAd showAdFromRootViewController:self];
    [_loadingView stopAnimating];
  	// 可根据业务逻辑选择在之后展示 一般有效期为半小时 展示之前使用 isValid 判断广告是否有效再展示
}
```




## 3. 其它

- 所有类型广告中，需要传入的**`ViewController`**是用来展示广告详情页的，在广告展示期间，请保持**`ViewController`**存活。
- 更多关于接入方面的问题请参考iOS接入demo或者联系商务同学。
