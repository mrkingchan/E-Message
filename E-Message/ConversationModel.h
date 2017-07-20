//
//  ConversationModel.h
//  E-Message
//
//  Created by Chan on 2017/6/23.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConversationModel : NSObject

@property(nonatomic,strong) EMConversation *conversation;

@property(nonatomic,copy)NSString *headerImageURL;


@end
