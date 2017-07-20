//
//  MessageListVC.h
//  E-Message
//
//  Created by Chan on 2017/6/24.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "EaseConversationListViewController.h"

@interface MessageListVC : EaseConversationListViewController

@property(nonatomic,strong) NSMutableArray *dataArray;

- (void)refresh;

- (void)refreshDataSource;

- (void)isConnect:(BOOL)isConnect;

- (void)networkChanged:(EMConnectionState)connectionState;

@end
