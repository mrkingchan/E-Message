//
//  ChatVC.m
//  E-Message
//
//  Created by Chan on 2017/6/26.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "ChatVC.h"

@interface ChatVC () <EaseMessageViewControllerDataSource,EaseMessageViewControllerDelegate>

@end

@implementation ChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.navigationItem.title = self.conversation.conversationId;
}

///点击头像处理
- (void)messageViewController:(EaseMessageViewController *)viewController
  didSelectAvatarMessageModel:(id<IMessageModel>)messageModel {
    NSString *nickName = messageModel.nickname;
    iToast(nickName);
    //跳转到个人资料页面
}

//录音view点击
- (void)messageViewController:(EaseMessageViewController *)viewController
          didSelectRecordView:(UIView *)recordView
                 withEvenType:(EaseRecordViewType)type{
    /*if (type == EaseRecordViewTypeTouchUpInside) {
        //一直按下的状态 开始录音
        EaseRecordView *view = (EaseRecordView *)recordView;
        [view  recordButtonTouchUpInside];
    }*/
}
@end
