//
//  LogoViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/5/11.
//

#import "LogoViewController.h"

@interface LogoViewController ()

@end

@implementation LogoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = self.view.bounds;
    label.text = @"TEST LOGO";
    label.font = [UIFont boldSystemFontOfSize:36.0f];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
}

@end
