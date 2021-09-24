//
//  LYBaseViewController.h
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/21.
//

#import <UIKit/UIKit.h>
#import "LYUnionTypeTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYBaseViewController : UIViewController
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableString * logString;
@property (nonatomic, strong) UITextView * logText;
@property (nonatomic, assign) CGFloat y;

- (void)appendLogText:(NSString *) text;
@end

NS_ASSUME_NONNULL_END
