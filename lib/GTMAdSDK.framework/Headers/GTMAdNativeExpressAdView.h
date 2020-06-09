//
//  GTMAdNativeExpressAdView.h
//  GTMAdSDK
//
//  Created by Aaslte on 2020/5/27.
//  Copyright © 2020 tredian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTMAdNativeExpressAdView : UIView

/// 渲染模版
/// @param controller 点击模版广告时用来present广告视图的vc
- (void)rednerWithController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
