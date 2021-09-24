//
//  ConfigViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/24.
//

#import "ConfigViewController.h"
#import "LYSlotID.h"

@interface ConfigViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *appIdTextField;
@property (nonatomic, strong) UITextField *userIdTextField;
@property (nonatomic, strong) UITextField *fakeBundleId;
@end

@implementation ConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Config", nil)];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:@"userId"];
    NSString *appId = [defaults objectForKey:@"appId"];
    NSString *fakeBundleId = [defaults objectForKey:@"fakeBundleId"];
    
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;

    CGFloat y = navHeight + statusHeight;
    CGFloat w = self.view.bounds.size.width;
    {
        self.appIdTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, y += 10, w - 20, 50)];
        self.appIdTextField.placeholder = @"appId";
        if (!appId || appId.length == 0) {
            appId = ly_app_id;
        }
        self.appIdTextField.text = appId;
        self.appIdTextField.returnKeyType = UIReturnKeyDone;
        self.appIdTextField.borderStyle = UITextBorderStyleLine;
    //    self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.appIdTextField.delegate = self;
        [self.view addSubview:self.appIdTextField];
    }
    {
        self.userIdTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, y += 60, w - 20, 50)];
        self.userIdTextField.placeholder = @"userId";
        self.userIdTextField.text = userId;
        self.userIdTextField.returnKeyType = UIReturnKeyDone;
        self.userIdTextField.borderStyle = UITextBorderStyleLine;
    //    self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.userIdTextField.delegate = self;
        [self.view addSubview:self.userIdTextField];
    }
    {
        self.fakeBundleId = [[UITextField alloc] initWithFrame:CGRectMake(10, y += 60, w - 20, 50)];
        self.fakeBundleId.placeholder = NSLocalizedString(@"fakeBundleId", nil);
        if (!fakeBundleId || fakeBundleId.length == 0) {
            fakeBundleId = ly_fake_bundle_id;
        }
        self.fakeBundleId.text = fakeBundleId;
        self.fakeBundleId.returnKeyType = UIReturnKeyDone;
        self.fakeBundleId.borderStyle = UITextBorderStyleLine;
    //    self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.fakeBundleId.delegate = self;
        [self.view addSubview:self.fakeBundleId];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Save and Exit", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnSave) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)clickBtnSave {
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:self.appIdTextField.text forKey:@"appId"];
    [defaults setObject:self.userIdTextField.text forKey:@"userId"];
    [defaults setObject:self.fakeBundleId.text forKey:@"fakeBundleId"];
    self.appIdTextField.enabled = NO;
    self.userIdTextField.enabled = NO;
    self.fakeBundleId.enabled = NO;
    [defaults synchronize];
    exit(0);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.appIdTextField resignFirstResponder];
    [self.userIdTextField resignFirstResponder];
    [self.fakeBundleId resignFirstResponder];
    return YES;
}

@end
