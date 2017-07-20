//
//  MessageVC.m
//  E-Message
//
//  Created by Chan on 2017/6/21.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "CustomMessageVC.h"
#import "MessageCell.h"

@interface CustomMessageVC ()<UITableViewDataSource,UITableViewDelegate,EMChatManagerDelegate> {
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation CustomMessageVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadConversations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray new];
    //监听消息
    [[EMClient sharedClient].chatManager  addDelegate:self
                                        delegateQueue:nil];
    
    [self setUI];
}

#pragma mark --loadConversations
- (void)loadConversations {
  NSArray *conversationArray = [[EMClient sharedClient].chatManager getAllConversations];
    _dataArray = [NSMutableArray arrayWithArray:conversationArray];
    [_tableView reloadData];
}

//初始化UI
- (void)setUI {
    _tableView = InsertTableView(self.view, CGRectMake(0, 0, kScreenWidth, kScreenHeight), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
    _tableView.backgroundColor = [UIColor whiteColor];
}

#pragma mark --UITableViewDataSource&Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kcellID = @"kcellID";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellID];
    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellWithData:_dataArray[indexPath.row]];
    cell.complete = ^(EMConversation *model) {
        [model markAllMessagesAsRead:nil];
        [model updateMessageChange:model.latestMessage error:nil];
        [self loadConversations];
        [_tableView reloadData];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    puts(__func__);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark --收到消息回调
- (void)messagesDidReceive:(NSArray *)aMessages {
    for (EMConversation *conversation in _dataArray) {
        for (EMMessage *message in aMessages) {
            if ([conversation.conversationId isEqualToString:message.conversationId]) {
                [[EMClient sharedClient].chatManager updateMessage:message completion:nil];
                [conversation updateMessageChange:message error:nil];
            }
        }
    }
    [self loadConversations];
}

#pragma mark --内存管理
- (void)dealloc {
    NSLog(@"dealloc");
}

@end
