//
//  ContactVC.m
//  E-Message
//
//  Created by Chan on 2017/6/21.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "ContactVC.h"

@interface ContactVC () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate> {
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation ContactVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadFriends];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(addContact)];
    [self setUI];
}

/*#pragma mark --添加分组
- (void)addGroup {
    EMGroupOptions *setting = [EMGroupOptions new];
    setting.maxUsersCount = 500;
    setting.style = EMGroupStylePublicOpenJoin;
     [[EMClient sharedClient].groupManager createGroupWithSubject:@"朋友"
                                                                      description:@"this is friend"
                                                                         invitees:nil
                                                                          message:@"Friend"
                                                                          setting:setting
                                                                       completion:^(EMGroup *aGroup, EMError *aError) {
                                                                           if (!aError) {
                                                                               iToast(@"创建成功");
                                                                               [_dataArray addObject:aGroup];
                                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                                   [_tableView reloadData];
                                                                               });
                                                                           } else {
                                                                               iToast(aError.errorDescription);
                                                                           }
                                                                       }];
                      }*/

- (void)addContact {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加分组" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //添加
        UITextField *input = [alertView  textFieldAtIndex:0];
        [[EMClient sharedClient].contactManager  addContact:input.text
                                                    message:nil
                                                 completion:^(NSString *aUsername, EMError *aError) {
                                                     if (!aError) {
                                                         iToast(@"添加成功");
                                                     }else {
                                                         iToast(aError.errorDescription);
                                                     }
                                                 }];
    }
}
//加载好友
- (void)loadFriends {
    [[EMClient sharedClient].contactManager getContactsFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
        _dataArray = [NSMutableArray arrayWithArray:aList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }];
}

//初始化UI
- (void)setUI {
    _tableView = InsertTableView(self.view, CGRectMake(0, 0, kScreenWidth, kScreenHeight), self, self, UITableViewStylePlain, UITableViewCellSeparatorStyleSingleLine);
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
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:kcellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =_dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    puts(__func__);
}

@end
