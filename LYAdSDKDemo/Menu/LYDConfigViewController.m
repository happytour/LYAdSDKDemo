//
//  LYDConfigViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/24.
//

#import "LYDConfigViewController.h"
#import "LYSlotID.h"
#import <MMKV/MMKV.h>
#import "SVProgressHUD.h"

@interface LYDConfigViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *appIdTextField;
@property (nonatomic, strong) UITextField *userIdTextField;
@property (nonatomic, strong) UITextField *splashIdTextField;
@property (nonatomic, strong) UITextField *fakeBundleId;
@property (nonatomic, strong) UISwitch *iniSwitch;
@property (nonatomic, strong) UISwitch *splashSwitch;
@end

@implementation LYDConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = UIColor.systemBackgroundColor;
    } else {
        self.view.backgroundColor = UIColor.whiteColor;
    }
    [self setTitle:LYDLocalizedString(@"设置")];
    
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *userId = [mmkv getStringForKey:@"userId"];
    NSString *appId = [mmkv getStringForKey:@"appId"];
    NSString *splashId = [mmkv getStringForKey:@"splashId"];
    NSString *fakeBundleId = [mmkv getStringForKey:@"fakeBundleId"];
    BOOL initSwitch = [mmkv getBoolForKey:@"initSwitch"];
    BOOL splashSwitch = [mmkv getBoolForKey:@"splashSwitch"];
    
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;

    CGFloat y = navHeight + statusHeight;
    CGFloat w = self.view.bounds.size.width;
    {
        self.appIdTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, y += 10, w - 20, 50)];
        self.appIdTextField.placeholder = LYDLocalizedString(@"填入appId");
#ifdef DEBUG
        if (!appId || appId.length == 0) {
            appId = ly_app_id;
        }
#endif
        self.appIdTextField.text = appId;
        self.appIdTextField.returnKeyType = UIReturnKeyDone;
        self.appIdTextField.borderStyle = UITextBorderStyleRoundedRect;
    //    self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.appIdTextField.delegate = self;
        [self.view addSubview:self.appIdTextField];
    }
    {
        self.userIdTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, y += 60, w - 20, 50)];
        self.userIdTextField.placeholder = LYDLocalizedString(@"填入userId");
        self.userIdTextField.text = userId;
        self.userIdTextField.returnKeyType = UIReturnKeyDone;
        self.userIdTextField.borderStyle = UITextBorderStyleRoundedRect;
    //    self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.userIdTextField.delegate = self;
        [self.view addSubview:self.userIdTextField];
    }
    {
        self.splashIdTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, y += 60, w - 20, 50)];
        self.splashIdTextField.placeholder = LYDLocalizedString(@"填入开屏slotId");
#ifdef DEBUG
        if (!splashId || splashId.length == 0) {
            splashId = ly_splash_id;
        }
#endif
        self.splashIdTextField.text = splashId;
        self.splashIdTextField.returnKeyType = UIReturnKeyDone;
        self.splashIdTextField.borderStyle = UITextBorderStyleRoundedRect;
    //    self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.splashIdTextField.delegate = self;
        [self.view addSubview:self.splashIdTextField];
    }
    {
        self.fakeBundleId = [[UITextField alloc] initWithFrame:CGRectMake(10, y += 60, w - 20, 50)];
        self.fakeBundleId.placeholder = LYDLocalizedString(@"填入模拟包名");
#ifdef DEBUG
        if (!fakeBundleId || fakeBundleId.length == 0) {
            fakeBundleId = ly_fake_bundle_id;
        }
#endif
        self.fakeBundleId.text = fakeBundleId;
        self.fakeBundleId.returnKeyType = UIReturnKeyDone;
        self.fakeBundleId.borderStyle = UITextBorderStyleRoundedRect;
    //    self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.fakeBundleId.delegate = self;
        [self.view addSubview:self.fakeBundleId];
    }
    {
        CGFloat sy = y += 60;
        UITextField *label = [[UITextField alloc] initWithFrame:CGRectMake(10, sy, w - 20, 50)];
        label.borderStyle = UITextBorderStyleRoundedRect;
        label.text = LYDLocalizedString(@"启动时初始化");
        label.enabled = NO;
        self.iniSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(w - 20 - 51, sy + (50 - 31) / 2, 51, 31)];
        self.iniSwitch.on = initSwitch;
        [self.view addSubview:label];
        [self.view addSubview:self.iniSwitch];
    }
    {
        CGFloat sy = y += 60;
        UITextField *label = [[UITextField alloc] initWithFrame:CGRectMake(10, sy, w - 20, 50)];
        label.borderStyle = UITextBorderStyleRoundedRect;
        label.text = LYDLocalizedString(@"启动时展示开屏广告");
        label.enabled = NO;
        self.splashSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(w - 20 - 51, sy + (50 - 31) / 2, 51, 31)];
        self.splashSwitch.on = splashSwitch;
        [self.splashSwitch addTarget:self action:@selector(onSplashSwitchChange) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:label];
        [self.view addSubview:self.splashSwitch];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = mainColor;
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:LYDLocalizedString(@"保存") forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnSave:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)onSplashSwitchChange {
    if (self.splashSwitch.on) {
        self.iniSwitch.on = YES;
    }
}

- (void)clickBtnSave:(UIButton *)button {
    MMKV *mmkv = [MMKV defaultMMKV];
    [mmkv setString:self.appIdTextField.text forKey:@"appId"];
    [mmkv setString:self.userIdTextField.text forKey:@"userId"];
    [mmkv setString:self.splashIdTextField.text forKey:@"splashId"];
    [mmkv setString:self.fakeBundleId.text forKey:@"fakeBundleId"];
    self.appIdTextField.enabled = NO;
    self.userIdTextField.enabled = NO;
    self.splashIdTextField.enabled = NO;
    self.fakeBundleId.enabled = NO;
    
    [mmkv setBool:self.iniSwitch.on forKey:@"initSwitch"];
    [mmkv setBool:self.splashSwitch.on forKey:@"splashSwitch"];
    
    self.iniSwitch.enabled = NO;
    self.splashSwitch.enabled = NO;
    button.enabled = NO;
    [SVProgressHUD showSuccessWithStatus:LYDLocalizedString(@"保存成功")];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.appIdTextField resignFirstResponder];
    [self.userIdTextField resignFirstResponder];
    [self.splashIdTextField resignFirstResponder];
    [self.fakeBundleId resignFirstResponder];
    return YES;
}

@end
