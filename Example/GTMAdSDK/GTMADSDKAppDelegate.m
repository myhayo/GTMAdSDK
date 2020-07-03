//
//  GTMADSDKAppDelegate.m
//  GTMAdSDK
//
//  Created by Aaslte on 06/09/2020.
//  Copyright (c) 2020 Aaslte. All rights reserved.
//

#import "GTMADSDKAppDelegate.h"
#import "GTMAdSDK/GTMAdSplashAd.h"

@interface GTMADSDKAppDelegate () <GTMAdSplashAdDelegate>

@property (nonatomic, strong) GTMAdSplashAd *splashAd;
@property (nonatomic, strong) UILabel *launchView;

@end

@implementation GTMADSDKAppDelegate

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

#pragma - mark 开屏广告

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

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
