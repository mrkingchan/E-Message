//
//  MessageCell.h
//  E-Message
//
//  Created by Chan on 2017/6/22.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property(nonatomic,strong) EMConversation *model;

- (void)setCellWithData:(id)model;

@property(nonatomic,copy)void (^complete)(EMConversation  *model);

@end
