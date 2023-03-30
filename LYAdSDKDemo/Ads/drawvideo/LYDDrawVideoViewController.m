//
//  LYDDrawVideoViewController.m
//  LYAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "LYDDrawVideoViewController.h"
#import <LYAdSDK/LYAdSDK.h>
#import "LYSlotID.h"
#import "LYDDrawVideoDemoViewController.h"

@interface LYDDrawVideoViewController ()
@end

@implementation LYDDrawVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:LYDLocalizedString(@"Draw视频（模版视频）")];
    MMKV *mmkv = [MMKV defaultMMKV];
    NSString *drawvideoId = [mmkv getStringForKey:@"drawvideoId"];
#ifdef DEBUG
    if (!drawvideoId || drawvideoId.length == 0) {
        drawvideoId = ly_drawvideo_id;
    }
#endif
    self.textField.text = drawvideoId;
//    self.navigationController.navigationBar.backItem.title = @"哈哈哈";
//    self.navigationController.navigationItem.backBarButtonItem.title = @"嘿嘿";
}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    NSString *drawvideoId = self.textField.text;
    MMKV *mmkv = [MMKV defaultMMKV];
    [mmkv setString:drawvideoId forKey:@"drawvideoId"];
    LYDDrawVideoDemoViewController * vc = [[LYDDrawVideoDemoViewController alloc] init];
    vc.slotId = drawvideoId;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//}

@end
