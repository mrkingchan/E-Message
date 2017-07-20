//
//  LoginVC.m
//  E-Message
//
//  Created by Chan on 2017/6/21.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "LoginVC.h"
#import "TabbarVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"登录";
}

- (IBAction)registerAction:(id)sender {
    iToastLoding(@"");
    [[EMClient sharedClient] registerWithUsername:_userName.text
                                                          password:_passWord.text
                                                        completion:^(NSString *aUsername, EMError *aError) {
                                                            if (!aError) {
                                                                iToast(@"注册成功!");
                                                            } else {
                                                                iToast(aError.errorDescription);
                                                            }
                                                        }];
}

- (IBAction)loginAction:(id)sender {
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
    iToastLoding(@"");
    [[EMClient sharedClient] loginWithUsername:_userName.text
                                       password:_passWord.text
                                     completion:^(NSString *aUsername, EMError *aError) {
                                         if (!aError) {
                                             iToast(@"登录成功");
                                             [[EMClient sharedClient].options setIsAutoLogin:YES];
                                             TabbarVC *VC = [TabbarVC new];
                                             VC.selectedIndex = 0;
                                             [self.navigationController presentViewController:VC
                                                                                     animated:YES
                                                                                   completion:nil];
                                         } else {
                                             iToast(aError.errorDescription);
                                         }
                                     }];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    NSLog(@"dealloc");
    
}
@end
