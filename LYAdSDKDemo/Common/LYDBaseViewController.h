//
//  LYDBaseViewController.h
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/21.
//

#import <UIKit/UIKit.h>
#import "LYDUnionTypeTool.h"
#import "KSBulletScreenManager.h"
#import <MMKV/MMKV.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYDBaseViewController : UIViewController
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) CGFloat y;
@end

NS_ASSUME_NONNULL_END
