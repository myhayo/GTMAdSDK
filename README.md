# **火眼聚合广告** SDK v1.1.2 接入文档 （for iOS）

[TOC]

## 1. SDK 集成

### 1.1 CocoaPods集成

```ruby
pod 'GTMAdSDK'
```

### 1.2 聚合包使用第三方平台SDK版本

**聚合SDK1.1.0版本开始使用头条SDK新版本，头条更新了在iOS14中广告标识的支持。**

**请注意如有配置头条的广告位，需要在工程内info.plist文件中配置**

### 头条SDK(穿山甲SDK)额外配置：

- 将穿山甲的 SKAdNetwork ID 添加到 info.plist 中，以保证 `SKAdNetwork` 的正确运行

```xml
<key>SKAdNetworkItems</key>
  <array>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>238da6jt44.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>22mmun2rn5.skadnetwork</string>
    </dict>
	</array>
```

- 支持苹果 ATT：从 iOS 14 开始，若开发者设置 App Tracking Transparency 向用户申请跟踪授权，在用户授权之前IDFA 将不可用。 如果用户拒绝此请求，应用获取到的 IDFA 将自动清零，可能会导致您的广告收入的降低。

- 要获取 App Tracking Transparency 权限，请更新您的 Info.plist，添加 NSUserTrackingUsageDescription 字段和自定义文案描述。代码示例

  ```xml
  <key>NSUserTrackingUsageDescription</key>
  <string>该标识符将用于向您投放个性化广告</string>
  ```

- 要向用户申请权限时，请调用 `requestTrackingAuthorizationWithCompletionHandler:`，我们建议您申请权限后再请求广告，以便获得穿山甲准确获得用户的授权。

- 调用下面权限申请后，会弹出系统提示弹窗，弹窗中文案如info.plist中配置的文案**该标识符将用于向您投放个性化广告**，或者自己定义文案。

  **Swift 代码示例**

  ```swift
  import AppTrackingTransparency
  import AdSupport
  func requestIDFA() {
    ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
      // Tracking authorization completed. Start loading ads here.
      // loadAd()
    })
  }
  ```

  **Objective-C 代码示例**

  ```objective-c
  #import <AppTrackingTransparency/AppTrackingTransparency.h>
  #import <AdSupport/AdSupport.h>
  - (void)requestIDFA {
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
      // Tracking authorization completed. Start loading ads here.
      // [self loadAd];
    }];
  }
  ```

### 如有不明白的地方请访问下面地址查看详情

[穿山甲新版配置说明](https://www.pangle.cn/help/doc/5fbdb5571ee5c2001d3f0c6f)

https://www.pangle.cn/help/doc/5fbdb5571ee5c2001d3f0c6f

### 其他注意事项

如果原工程内自行接入第三方广告SDK，请尽量使用下列版本

聚合版本1.0.6对应：

- 穿山甲SDK版本：**3.2.0.1**
- 广点通SDK版本：**4.11.10**
- sigmob SDK版本：**2.20.1**

聚合版本1.0.8对应：

- 穿山甲SDK版本：**3.2.0.1**
- 广点通SDK版本：**4.12.1**
- sigmob SDK版本：**2.23.1**

聚合版本1.1.0对应：

- 穿山甲SDK版本：**3.4.2.3**
- 广点通SDK版本：**4.12.3**
- sigmob SDK版本：**2.25.1**

聚合版本1.1.1对应：

- 穿山甲SDK版本：**3.5.1.2**
- 广点通SDK版本：**4.12.60**
- sigmob SDK版本：**2.25.1**

如果是通过pod集成，pod配置文件里未对上游广告SDK限制了版本，pod-install时会自动依赖最新版本。

如果之前已经接入旧版本GTMAd，进行升级SDK时，记得执行pod update Ads-CN 和GDTMobSDK，pod本地会有旧版Ads-CN、GDTMobSDK的缓存。

如果pod导入的第三方SDK版本超过聚合版本里使用的第三方SDK版本时，有可能出现不兼容现象，此时请修改pod配置文件(GTMAdSDK.podspec)，在文件中对第三方SDK进行版本限制。

可以fork本仓库部署到自己私有的pod仓库，方便修改第三方SDK依赖。

如果是手动集成则需注意对应版本。

这里之所以需要限制版本是因为穿山甲的sdk在版本迭代过程中做了比较大的改动，相应的火眼聚合sdk也需要进行迭代。

一般来说不需要对版本进行限制时，文档中会进行说明，目前1.0.5和1.0.6需要严格选择穿山甲的版本。

1.0.5版本依赖穿山甲版本为2.9.5.8，1.0.6版本对应穿山甲版本为3.2.0.1以上。

### 1.3 聚合SDK使用中各第三方平台注册APPID注意事项

聚合包中在使用任意类型广告**获取广告时**会调用对应平台的**registerAppid**的方法注册对应**appid**。

所以如果原工程集成了相同的第三方广告平台，需要在获取广告时重新注册**appid**，以免被聚合SDK重置appid后导致无法获取广告。

### 1.4 SDK手动集成

- 下载 GTMAdSDK，找到 lib 文件夹，SDK的framework文件在这个文件夹下
- 拖拽framework文件到 Xcode 工程内 (请勾选Copy items if needed选项) 
- 第三方平台依赖包请自行下下载(下方有第三方包下载地址)或者询问运营同学获取。
- 头文件如下：

```yaml
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

```haskell
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
libbz2.tbd
```

- 如果以上依赖库增加完仍旧报错，请添加ImageIO.framework。
- Build Setting --> Linking --> Other Linker Flag 设置 增加 `-ObjC` linker flag

### 1.5 集成过程中注意事项

手动集成聚合SDK时，因为聚合SDK依赖其他第三方平台的广告SDK，如穿山甲和广点通SDK、sigmob。

第三方广告平台的包下载地址。

[广点通](https://github.com/gdtmobsdk/GDTMobSDK) https://github.com/gdtmobsdk/GDTMobSDK

[穿山甲](https://github.com/bytedance/Bytedance-UnionAD) https://github.com/bytedance/Bytedance-UnionAD

[sigmob](https://cocoapods.org/pods/SigmobAd-iOS) https://cocoapods.org/pods/SigmobAd-iOS

## 2. SDK 调用

SDK支持`开屏`、`Banner`、`激励视频`、`信息流模版(图文和视频)`、`插屏`、`全屏视频`六种种类型的广告。

对应类型广告调用时导入对应的头文件。

### 2.1 开屏广告

##### 2.1.1 开屏广告对应头文件

```objectivec
#import "GTMAdSplashAd.h"
```

##### 2.1.2 展示开屏广告期间使用变量保存开屏实例

```objectivec
@property (nonatomic, strong) GTMAdSplashAd *splashAd;
```

##### 2.1.3 创建开屏实例并设置**代理**

```objectivec
@property (nonatomic, strong) GTMAdSplashAd *splashAd;
@property (nonatomic, strong) UILabel *launchView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
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
    [_splashAd loadAdAndShowInWindow:_window withBottomView:label];
    
    // 为了使启动页和开屏衔接 加载开屏的同时 在window或者window的rootViewController上放置一个和启动页LaunchScreen一样布局的view 在开屏加载成功或者失败时移除
    _launchView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    _launchView.text = @"火眼聚合广告";
    _launchView.textColor = [UIColor blackColor];
    _launchView.backgroundColor = [UIColor whiteColor];
    _launchView.font = [UIFont systemFontOfSize:20];
    _launchView.textAlignment = NSTextAlignmentCenter;
    
    // 1. 直接在rootVC的view上添加
//    [_window.rootViewController.view addSubview:_launchView];
    
    
    // 2.在window上添加
    // 如果不想在rootVC上添加这个仿启动页布局 可以在window上添加 但是需要注意 rootVC的view在显示之前是没有添加在window上的
    // 所以如果想要_launchView在rootVC的view的上层 需要先完成rootVC的加载
    [_window makeKeyAndVisible];
    [_window addSubview:_launchView];
    
    return YES;
}
```

##### 2.1.4 开始加载开屏广告，分为**全屏开屏**广告和**非全屏开屏广告**

```objectivec
// 全屏广告
[_splashAd loadAdAndShowInWindow:_window];
```

```objectivec
// 创建底部视图
UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height / 4 * 3, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height / 4)];
label.text = @"这是开屏广告底部视图";
label.textColor = [UIColor blackColor];
label.backgroundColor = [UIColor whiteColor];
label.font = [UIFont systemFontOfSize:30];
label.textAlignment = NSTextAlignmentCenter;
        
// 非全屏广告
[_splashAd loadAdAndShowInWindow:_window withBottomView:label];
```

##### 2.1.5 启动页和开屏广告衔接建议

```objectivec
    // 为了使启动页和开屏衔接 加载开屏的同时 在window或者window的rootViewController上放置一个和启动页LaunchScreen一样布局的view 在开屏加载成功或者失败时移除
    _launchView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    _launchView.text = @"火眼聚合广告";
    _launchView.textColor = [UIColor blackColor];
    _launchView.backgroundColor = [UIColor whiteColor];
    _launchView.font = [UIFont systemFontOfSize:20];
    _launchView.textAlignment = NSTextAlignmentCenter;
    
    // 1. 直接在rootVC的view上添加
//    [_window.rootViewController.view addSubview:_launchView];
    
    
    // 2.在window上添加
    // 如果不想在rootVC上添加这个仿启动页布局 可以在window上添加 但是需要注意 rootVC的view在显示之前是没有添加在window上的
    // 所以如果想要_launchView在rootVC的view的上层 需要先完成rootVC的加载
    [_window makeKeyAndVisible];
    [_window addSubview:_launchView];
```

##### 2.1.6 通过代理处理广告事件

```objectivec
// 实现代理
<GTMAdSplashAdDelegate>

- (void)gtm_splashAdLoadSuccess:(GTMAdSplashAd *)splashAd {
    NSLog(@"-----开屏广告素材下载成功----");
}

- (void)gtm_splashAdSuccessPresentScreen:(GTMAdSplashAd *)splashAd {
    [_launchView removeFromSuperview];
    NSLog(@"-----开屏广告展示成功----");
}

- (void)gtm_splashAd:(GTMAdSplashAd *)splashAd didFailWithError:(NSError *)error {
    [_launchView removeFromSuperview];
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

```objectivec
#import "GTMAdBannerView.h"
```

##### 2.2.2 展示Banner广告期间使用变量保存Banner实例

```objectivec
@property (nonatomic, strong) GTMAdBannerView *bannerView;
```

##### 2.2.3 创建Banner实例、设置代理并发起广告加载。

```objectivec
[_bannerView removeFromSuperview];
_bannerView = [[GTMAdBannerView alloc] initWithAppId:@"6A90F3261545" placementId:@"SDKF6E5574E69D3" adSize:adSize viewController:self interval:30];
_bannerView.delegate = self;
// 获取广告并显示
[_bannerView loadAdAndShow];
        
_bannerView.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - 200, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width / 6.4);
[self.view addSubview:_bannerView];
```

##### 2.2.4 通过代理处理广告事件

```objectivec
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

```objectivec
#import "GTMAdRewardVideoAd.h"
```

##### 2.3.2 激励视频展示期间使用变量保存激励视频实例

```objectivec
@property (nonatomic, strong) GTMAdRewardVideoAd *rewardVideoAd;
```

##### 2.3.3 创建实例、设置代理并发起广告请求

```objectivec
_rewardVideoAd = [[GTMAdRewardVideoAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDK2B98AAC02AA0"];
_rewardVideoAd.delegate = self;
[_rewardVideoAd loadAd];
```

##### 2.3.4 实现代理方法

```objectivec
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

```objectivec
- (void)gtm_rewardVideoAdVideoDidLoad:(GTMAdRewardVideoAd *)rewardVideoAd {
    NSLog(@"----激励视频视频缓存成功----");
		// 展示激励视频
    [rewardVideoAd showAdFromRootViewController:self];
		// 可根据业务逻辑选择在之后展示 一般有效期为半小时 展示之前使用 isValid 判断广告是否有效再展示
  	if ([rewardVideoAd isValid]) {
      
    }
}
```

### 2.4 信息流模版广告(图文和视频)

##### 2.4.1 模版广告对应头文件

```objectivec
#import "GTMAdNativeExpressAd.h"
#import "GTMAdNativeExpressAdView.h"
```

##### 2.4.2 创建实例并设置代理

```objectivec
@property (nonatomic, strong) GTMAdNativeExpressAd *nativeExpressAd;
@property (nonatomic, strong) NSMutableArray<GTMAdNativeExpressAdView *> *adViews;

// 高度给0 让模版在render之后自适应
_nativeExpressAd = [[GTMAdNativeExpressAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDKFB0E89AEC0B4" adSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 0)];
_nativeExpressAd.delegate = self;
// 注意这里一次加载了两个adView，加载多个时，每个adView都需要进行渲染，否则影响曝光率
// 如果不需要一次加载多个，修改为每次加载一个就好了
[_nativeExpressAd loadAd:2]; 

for (UIView *adView in _adViews) {
	[adView removeFromSuperview];
}
[_adViews removeAllObjects];
```

##### 2.4.3 处理代理回调事件

```objectivec
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
  // 注意这里渲染成功了 不代表曝光成功了 只有当广告出现在屏幕可见的地方才会曝光成功
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

```objectivec
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

```objectivec
- (void)gtm_nativeExpressAdViewRenderSuccess:(GTMAdNativeExpressAdView *)nativeExpressAdView {
    
    NSLog(@"%@", [NSString stringWithFormat:@"----原生模版广告_0%lu渲染成功----", (unsigned long)[_adViews indexOfObject:nativeExpressAdView] + 1]);
    [_tableView reloadData];
} 
```

##### 2.4.6 代理方法中收到模版广告被关闭回调后主动移除广告视图

```objectivec
- (void)gtm_nativeExpressAdViewDidClose:(GTMAdNativeExpressAdView *)nativeExpressadView {
    NSLog(@"----关闭原生模版广告----");
    [nativeExpressadView removeFromSuperview];
    [_adViews removeObject:nativeExpressadView];
    [_tableView reloadData];
}
```



### 2.5 插屏广告

##### 2.5.1 插屏广告对应头文件

```objectivec
#import "GTMAdInterstitialAd.h"
```

##### 2.5.2 创建实例并设置代理

```objectivec
@property (nonatomic, strong) GTMAdInterstitialAd *interstitialAd;

_interstitialAd = [[GTMAdInterstitialAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDKAEBDA8F71997" adSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 60, UIScreen.mainScreen.bounds.size.width)];
_interstitialAd.delegate = self;
[_interstitialAd loadAd];
```

##### 2.5.3 处理代理回调事件

```objectivec
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

```objectivec
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

```objectivec
#import "GTMAdFullscreenVideoAd.h"
```

##### 2.6.2 创建实例并设置代理

```objectivec
@property (nonatomic, strong) GTMAdFullscreenVideoAd *fullscreenVideoAd;

_fullscreenVideoAd = [[GTMAdFullscreenVideoAd alloc] initWithAppId:@"6A90F3261545" placementId:@"SDKFD4783576C59"];
_fullscreenVideoAd.delegate = self;
[_fullscreenVideoAd loadAd];
```

##### 2.6.3 实现代理方法

```objectivec
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

```objectivec
- (void)gtm_fullscreenVideoAdViewRenderSuccess:(GTMAdFullscreenVideoAd *)fullscreenVideoAd {
    
    NSLog(@"----全屏视频广告渲染成功----");
  	// 展示全屏视频广告
    [fullscreenVideoAd showAdFromRootViewController:self];
    [_loadingView stopAnimating];
  	// 可根据业务逻辑选择在之后展示 一般有效期为半小时 展示之前使用 isValid 判断广告是否有效再展示
  	if ([fullscreenVideoAd isValid]) {
      
    }
}
```



## 3. 更新日志

### 1.1.2版本

- 激励视频支持服务端验证。

### 1.1.1版本

- 更新头条SDK。

### 1.1.0版本

- 更新头条SDK。
- 头条SDK添加iOS14广告标识获取支持，请注意需要工程info.plist文件中配置(接入步骤中有说明)。
- 更新广点通SDK。
- 更新SigmobAd平台SDK，SigmobAd平台移除全屏视频支持。

### 1.0.8版本

- 更新第三方SDK版本。
- 开屏广告添加超时设置(只针对广点通上游有效)。
- 激励视频、全屏视频头条上游广告废弃某些字段。

### 1.0.6版本

- 更新第三方SDK版本，需要添加新依赖库libbz2.tbd。
- 调整激励视频回调时机。
- 注意更新1.0.6版本需要更新对应的头条SDK。

### 1.0.5 版本

- 修复全屏视频sigmob平台广告不回调WillVisible方法。

###  1.0.4 版本

- 添加Sigmob广告平台。
- 开屏广告针对广点通添加背景颜色和背景图片设置。
- 信息流模版针对广点通添加非Wi-Fi环境是否自动播放、自动播放时是否静音、视频详情页是否静音设置。

### 1.0.3 版本

- 调整穿山甲开屏广告加载完成和渲染完成的回调时机。

### 1.0.2 版本

- 添加全屏视频和插屏视频广告。

### 1.0.1 版本

- 添加开屏、banner、激励视频广告。



## 4. 常见问题

- 所有类型广告中，需要传入的`ViewController`是用来展示广告详情页的，在广告展示期间，请保持`ViewController`存活。
- 开屏广告中穿山甲上游所返回的广告是展示在传入的容器`window`的`RootViewController`的`view`上，与广点通和其他平台展示在容器`window`有区别。如果有影响到工程内其他业务逻辑，请不要配置穿山甲广告或者只配置穿山甲广告。
- 全屏视频中sigmob平台所展示的广告在点击跳过按钮之后，依然回调播放完成代理方法。所以不能把视频播放完成回调作为用户是否完整观看视频的依据。如果不能满足你的业务逻辑要求，请不要配置sigmob平台的广告，其他平台广告点击跳过按钮不会回调视频播放完成方法。
- 开屏和全屏视频广告中sigmob平台所返回的广告，在被点击展示广告详情页之后，无法回调广告详情页被关闭的回调。
- 更多关于接入方面的问题请参考iOS接入demo或者联系商务同学。