//
//  LYBaseViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/21.
//

#import "LYBaseViewController.h"

@interface LYBaseViewController ()<UITextFieldDelegate>

@end

@implementation LYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;

    self.y = navHeight + statusHeight;
    CGFloat w = self.view.bounds.size.width;

    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.y += 10, w - 20, 50)];
    self.textField.placeholder = @"slostId";
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.borderStyle = UITextBorderStyleLine;
//    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button.layer setCornerRadius:10.0];
    button.backgroundColor = [UIColor whiteColor];
    button.frame = CGRectMake(10, self.y += 60, self.view.bounds.size.width - 20, 50);
    [button setTitle:NSLocalizedString(@"loadAd", nil) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
    [button addTarget:self action:@selector(clickBtnLoadAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.logString = [NSMutableString new];
    self.logText = [[UITextView alloc] initWithFrame:CGRectMake(10, self.y += 60, w - 20, 100)];
    self.logText.textColor = UIColor.whiteColor;
    self.logText.backgroundColor = UIColor.blackColor;
    self.logText.editable = NO;
    self.logText.layoutManager.allowsNonContiguousLayout = NO;
    [self.view addSubview:self.logText];
    self.y += 100;
}

- (void)appendLogText:(NSString *) text {
    [self.logString appendString:[NSString stringWithFormat:@"%@\n", text]];
    self.logText.text = self.logString;
    [self.logText scrollRangeToVisible:NSMakeRange(self.logText.text.length, 1)];
}

- (void)clickBtnLoadAd {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}

@end
