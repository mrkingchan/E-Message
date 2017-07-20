//
//  LoginVC.h
//  E-Message
//
//  Created by Chan on 2017/6/21.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *passWord;
- (IBAction)registerAction:(id)sender;
- (IBAction)loginAction:(id)sender;

@end
