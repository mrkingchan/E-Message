//
//  SettingVC.m
//  E-Message
//
//  Created by Chsan on 2017/6/21.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "SettingVC.h"

#import "TabbarVC.h"

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"LoginOut"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(loginOut)];
}

#pragma mark -- loginOut
- (void)loginOut {
    iToastLoding(@"");
    [[EMClient sharedClient] logout:NO
                         completion:^(EMError *aError) {
                             if (!aError) {
                                 iToastHide;
                                 UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                 UINavigationController *loginVC = (UINavigationController*)[mainSB instantiateViewControllerWithIdentifier:@"LoginNavi"];
                                 [ self.navigationController.tabBarController presentViewController:loginVC animated:YES completion:nil];
                             } else {
                                 iToast(aError.errorDescription);
                             }
                         }];
}

@end
