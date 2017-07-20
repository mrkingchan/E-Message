//
//  MessageListVC.m
//  E-Message
//
//  Created by Chan on 2017/6/24.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "MessageListVC.h"
#import "RobotManager.h"
#import "ChatVC.h"
//#import "UserProfileManager.h"

@interface MessageListVC () <EaseConversationListViewControllerDelegate, EaseConversationListViewControllerDataSource>
@property (nonatomic, strong) UIView *networkStateView;

@end

@implementation MessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showRefreshHeader = YES;
    [self networkStateView];
    [self removeEmpryConversationFromDB];
    self.delegate = self;
    self.dataSource = self;
    //加载会话列表
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh];
}
#pragma mark - getter
- (UIView *)networkStateView {
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

//移除空的对话
- (void)removeEmpryConversationFromDB {
    NSMutableArray *temRemoveArray ;
    for (EMConversation *conversation in [[EMClient sharedClient].chatManager getAllConversations]) {
        if (!conversation.latestMessage || conversation.type == EMConversationTypeChatRoom) {
            if (!temRemoveArray) {
                temRemoveArray = [NSMutableArray new];
            }
            [temRemoveArray addObject:conversation];
        }
    }
    if (temRemoveArray && temRemoveArray.count) {
        [[EMClient sharedClient].chatManager deleteConversations:temRemoveArray isDeleteMessages:YES completion:nil];
    }
}

#pragma mark --EaseConversationListViewControllerDataSource
- (id <IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController modelForConversation:(EMConversation *)conversation {
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
    //个人聊天
    if (model.conversation.type == EMConversationTypeChat) {
        //机器人
        if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.conversationId]) {
            model.title = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.conversationId];
        } else {
            //普通用户
            if (conversation.latestMessage.body.type == 1) {
                EMTextMessageBody *textBody = (EMTextMessageBody *) conversation.latestMessage.body;
                model.title = textBody.text;
            }
            /*UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:conversation.conversationId];
            if (profileEntity) {
                model.title = profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
                model.avatarURLPath = profileEntity.imageUrl;
            }*/
        }
    } else if (model.conversation.type == EMConversationTypeGroupChat) {
        //群聊
        NSString *imageName = @"groupPublicHeader";
        if (![conversation.ext objectForKey:@"subject"]) {
            //拿到群成员
            NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.conversationId]) {
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.subject forKey:@"subject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    conversation.ext = ext;
                    break;
                }
            }
        }
        NSDictionary *ext = conversation.ext;
        model.title = [ext objectForKey:@"subject"];
        imageName = [[ext objectForKey:@"isPublic"] boolValue] ? @"groupPublicHeader" : @"groupPrivateHeader";
        model.avatarImage = [UIImage imageNamed:imageName];
    }
    return model;
}

#pragma mark - EaseConversationListViewControllerDelegate
- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel {
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        ChatVC *VC = [[ChatVC alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
        VC.hidesBottomBarWhenPushed = YES;
        VC.timeCellHeight = 30;//时间分割的高度
        [self.navigationController pushViewController:VC animated:YES];
    }
}



-(void)refresh {
    [self refreshAndSortView];
}

-(void)refreshDataSource {
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)isConnect:(BOOL)isConnect {
    if (!isConnect) {
        self.tableView.tableHeaderView = _networkStateView;
    }else{
        self.tableView.tableHeaderView = nil;
    }
}

- (void)networkChanged:(EMConnectionState)connectionState {
    if (connectionState == EMConnectionDisconnected) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
}

- (void)messagesDidReceive:(NSArray *)aMessages {
    [self tableViewDidTriggerHeaderRefresh];
}
@end
