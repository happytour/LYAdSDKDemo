//
//  LYDBaseViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/21.
//

#import "LYDBaseViewController.h"

@interface LYDBaseViewController ()<UITextFieldDelegate>

@end

@implementation LYDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = UIColor.systemBackgroundColor;
    } else {
        self.view.backgroundColor = UIColor.whiteColor;
    }
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;

    self.y = navHeight + statusHeight;
    CGFloat w = self.view.bounds.size.width;

    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.y += 10, w - 20, 50)];
    self.textField.placeholder = LYDLocalizedString(@"填入slotId");
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
//    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button.layer setCornerRadius:10.0];
    button.backgroundColor = mainColor;
    button.frame = CGRectMake(10, self.y += 60, self.view.bounds.size.width - 20, 50);
    [button setTitle:LYDLocalizedString(@"点击加载广告") forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
    [button addTarget:self action:@selector(clickBtnLoadAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.y += 60;
}

- (void)clickBtnLoadAd {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}

@end
