//
//  FriendsListVC.m
//  E-Message
//
//  Created by Chan on 2017/6/24.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "FriendsListVC.h"
#import "ChatVC.h"
@interface FriendsListVC () <EMUserListViewControllerDelegate>

@end

@implementation FriendsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.delegate = self;
}

- (void)userListViewController:(EaseUsersListViewController *)userListViewController
            didSelectUserModel:(id<IUserModel>)userModel {
    NSString *easeID = userModel.buddy;
    ChatVC *VC = [[ChatVC alloc] initWithConversationChatter:easeID conversationType:EMConversationTypeChat];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}
@end
