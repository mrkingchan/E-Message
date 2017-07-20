//
//  MessageCell.m
//  E-Message
//
//  Created by Chan on 2017/6/22.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "MessageCell.h"
@interface MessageCell(){
    UIImageView *_header;
    UILabel *_contactName;
    UILabel *_latestMessage;
    UILabel *_lastTime;
    NSDateFormatter *_format;
    UIButton *_readCount;
}
@end
@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark --setUI 初始化UI
- (void)setUI {
    _format = [NSDateFormatter new];
    [_format setDateFormat:kDateFormatDefault];
    //头像
    _header = InsertImageView(self, CGRectMake(5, 5, 70, 70), nil);
    _header.clipsToBounds = YES;
    _header.layer.cornerRadius = _header.height/2;
    //联系人名字
    _contactName = InsertLabel(self, CGRectMake(_header.right + 10, 10, kScreenWidth - _header.right - 40, 30), 0, @"", [UIFont systemFontOfSize:15], [UIColor blackColor], NO);
    //内容
    _latestMessage = InsertLabel(self, CGRectMake(_contactName.left, _contactName.bottom + 5, _contactName.width, 25), 0, @"", [UIFont systemFontOfSize:13], [UIColor grayColor], NO);
    //会话时间
    _lastTime = InsertLabel(self, CGRectMake(kScreenWidth - 120, 30, 120, 30), 0, @"", [UIFont systemFontOfSize:13], [UIColor blackColor], NO);
    //发送的badge
    _readCount = InsertButtonWithType(self, CGRectMake(kScreenWidth - 40, 10, 20, 20), 49839, self, @selector(buttonAction:), UIButtonTypeCustom);
    _readCount.clipsToBounds = YES;
    _readCount.backgroundColor = [UIColor redColor];
    _readCount.layer.cornerRadius = 10;
    _readCount.titleLabel.textColor = [UIColor whiteColor];
    _readCount.titleLabel.font = [UIFont systemFontOfSize:10];
    [_readCount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _readCount.hidden = YES;
}

#pragma mark --private Method
- (void)buttonAction:(id)sender {
    if ( [sender isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)sender;
        if (button.tag ==49839 ) {
            _readCount.hidden = YES;
             [[NSNotificationCenter defaultCenter] postNotificationName:@"unreadMessagesCount--" object:@(_model.unreadMessagesCount)];
            if (_complete) {
                _complete(_model);
            }
        }
    }
}

#pragma mark --setCell
- (void)setCellWithData:(EMConversation *)model {
    _model = model;
    _header.image = [UIImage imageNamed:@"Tabbar-item"];
    EMMessage *message = model.latestMessage;
    _contactName.text = message.from;
    NSLog(@"message = %@\n%@\n unreadMessagesCount= %zd", message.ext,model.ext,model.unreadMessagesCount);
    _lastTime.text =  [_format  stringFromDate:[NSDate dateWithTimeIntervalSince1970:(model.latestMessage.timestamp / 1000)]];
    if (model.unreadMessagesCount <1) {
        _readCount.hidden = YES;
    } else {
        _readCount.hidden = NO;
        [_readCount setTitle:[NSString stringWithFormat:@"%d",model.unreadMessagesCount] forState:UIControlStateNormal];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unreadMessagesCount" object:@(model.unreadMessagesCount)];
    EMMessageBodyType cate = model.latestMessage.body.type;
    NSLog(@"latestMessagebodyType == %zd",model.latestMessage.body.type);
    /* EMMessageBodyTypeText   = 1,
    EMMessageBodyTypeImage,         !  Image
    EMMessageBodyTypeVideo,         !  Video
    EMMessageBodyTypeLocation,      !  Location
    EMMessageBodyTypeVoice,         !  Voice
    EMMessageBodyTypeFile,          !  File
    EMMessageBodyTypeCmd,  */
    EMTextMessageBody *body = (EMTextMessageBody *) model.latestMessage.body;
    _latestMessage.text = body.text;
    switch (cate) {
        case EMMessageBodyTypeText:
            break;
        case EMMessageBodyTypeImage:
            break;
        case EMMessageBodyTypeVoice:
            break;
        default:
            break;
    }
}
@end
