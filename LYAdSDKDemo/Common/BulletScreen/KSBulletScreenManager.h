//
//  KSBulletScreenManager.h
//  KSAdSDKGitDemo
//
//  Created by xuzhijun on 2019/12/27.
//  Copyright © 2019 xuzhijun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSBulletScreenManager : NSObject

- (void)showWithText:(NSString *)text;

- (void)beginScene:(NSString *)scene;
- (void)endScene:(NSString *)scene;

#pragma mark - Singleton
+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
