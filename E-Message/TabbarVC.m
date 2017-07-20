//
//  TabbarVC.m
//  E-Message
//
//  Created by Chan on 2017/6/21.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "TabbarVC.h"
#import "MessageListVC.h"
#import "FriendsListVC.h"
#import "SettingVC.h"

@interface TabbarVC () <UITabBarControllerDelegate,EMContactManagerDelegate,EMClientDelegate> {
    NSInteger _unreadMessagesCount;
}

@end

@implementation TabbarVC

+ (TabbarVC *)shareInstance {
    static TabbarVC *_shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [TabbarVC new];
    });
    return _shareInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *classNames = @[[MessageListVC class],
                           [FriendsListVC class],
                           [SettingVC class]];
    NSArray *titles = @[@"消息",@"联系人",@"设置"];
    NSMutableArray *viewControllers = [NSMutableArray new];
    for (int i = 0; i < classNames.count; i ++) {
        UIViewController *VC = [self viewControllerWithClass:classNames[i]
                                                       title:titles[i]
                                                 normalImage:[UIImage imageNamed:@"Tabbar-item"]
                                               selectedImage:[UIImage imageNamed:@"Tabbar-item"]];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:VC];
        [viewControllers addObject:navi];
    }
    self.viewControllers =viewControllers;
    [[EMClient sharedClient].contactManager addDelegate:self];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setBadge:) name:@"unreadMessagesCount" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshBadgeNumber:) name:@"unreadMessagesCount--" object:nil];
}


- (void)refreshBadgeNumber: (NSNotification*)noti {
    NSInteger count = [noti.object integerValue];
    _unreadMessagesCount -= count;
    if (_unreadMessagesCount > 0) {
        [self.viewControllers[0].tabBarItem setBadgeValue:[NSString stringWithFormat:@"%zd",_unreadMessagesCount]];
    } else {
        [self.viewControllers[0].tabBarItem setBadgeValue:[NSString stringWithFormat:@""]];
    }
}

#pragma mark --setBadge
- (void)setBadge:(NSNotification *)noti {
    NSInteger count = [noti.object integerValue];
    _unreadMessagesCount += count;
    if (_unreadMessagesCount > 0) {
        [self.viewControllers[0].tabBarItem setBadgeValue:[NSString stringWithFormat:@"%zd",_unreadMessagesCount]];
    } else {
        [self.viewControllers[0].tabBarItem setBadgeValue:[NSString stringWithFormat:@""]];
    }
}

////viewController
- (UIViewController *)viewControllerWithClass:(Class)class
                                        title:(NSString *)titleStr
                                  normalImage:(UIImage *)normalImage
                                selectedImage:(UIImage *)selectedImage {
    UIViewController *VC = [class new];
    VC.navigationItem.title = titleStr;
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titleStr
                                                       image:normalImage
                                               selectedImage:selectedImage];
    VC.tabBarItem = item;
    return VC;
}

//监听异地登录
-(void)userAccountDidLoginFromOtherDevice {
    iToast(@"异地登录!!!");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userAccountDidRemoveFromServer {
    iToast(@"您的账户被移除!");
}

- (void)dealloc {
    NSLog(@"dealloc");
}

- (void)friendRequestDidApproveByUser:(NSString *)aUsername {
    NSString *approveStr = [NSString stringWithFormat:@"%@同意您的好友申请请求",aUsername];
    iToast(approveStr);
}

#pragma mark --收到被申请者的回调
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"收到%@的好友申请",aUsername] message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                     style:0 handler:^(UIAlertAction * _Nonnull action) {
                                                         //同意添加为好友
                                                         [[EMClient  sharedClient].contactManager approveFriendRequestFromUser:aMessage completion:^(NSString *aUsername, EMError *aError) {
                                                             if (!aError) {
                                                                 iToast(@"同意添加好友成功");
                                                                 [[EMClient sharedClient].contactManager addContact:aUsername message:nil completion:^(NSString *aUsername, EMError *aError) {
                                                                     if (!aError) {
                                                                         iToast(@"添加成功!");
                                                                     } else {
                                                                         iToast(aError.errorDescription);
                                                                     }
                                                                 }];
                                                             }
                                                         }];
                                                     }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
