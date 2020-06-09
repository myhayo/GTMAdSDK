//
//  GTMAdSDKConfig.h
//  GTMAdSDK
//
//  Created by Aaslte on 2020/5/25.
//  Copyright © 2020 tredian. All rights reserved.
//

#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface GTMAdSDKConfig : NSObject

/**
 聚合SDK版本
 */
@property (nonatomic, copy, class, readonly) NSString *sdkVersion;

/// 穿山甲SDK版本
@property (nonatomic, copy, class, readonly) NSString *ttSdkVersion;

/// 广点通SDK版本
@property (nonatomic, copy, class, readonly) NSString *gdtSdkVersion;

@end

NS_ASSUME_NONNULL_END
