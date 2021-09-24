//
//  LYDrawVideoViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "LYDrawVideoViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"
#import "LYDrawVideoDemoViewController.h"

@interface LYDrawVideoViewController ()
@end

@implementation LYDrawVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"DrawVideo", nil)];
    
    self.textField.text = ly_drawvideo_id;
    [self appendLogText:self.title];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawvideolog:) name:@"drawvideolog" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    LYDrawVideoDemoViewController * vc = [[LYDrawVideoDemoViewController alloc] init];
    vc.slotId = self.textField.text;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)drawvideolog:(NSNotification*) notification {
    NSString * msg = [notification object];
    [self appendLogText:msg];
}

@end
