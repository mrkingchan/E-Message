//
//  CommonDefine.h
//  E-Message
//
//  Created by Chan on 2017/6/22.
//  Copyright © 2017年 Chan. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

#define kAppKey @"1196170324115502#e-message"
#define kCertiName @"E-MessageDeveP12"

#define iToast(X)         [LCProgressHUD showMessage:X]
#define iToastHide        [LCProgressHUD hide]
#define iToastLoding(X)   [LCProgressHUD showLoading:X]

#define kDateFormatDefault     @"yyyy-MM-dd HH:mm:ss"
#define kDateFormat_yyMdHm     @"yy-MM-dd HH:mm"
#define kDateFormat_yyyyMdHm   @"yyyy-MM-dd HH:mm"
#define kDateFormat_yMd        @"yyyy-MM-dd"
#define kDateFormat_MdHms      @"MM-dd HH:mm:ss"
#define kDateFormat_MdHm       @"MM-dd HH:mm"
#define kDateFormat_MdHm1      @"MM/dd HH:mm"
#define kDateFormatTime        @"HH:mm:ss"
#define kDateFormat_MSS        @"mm:ss:SSS"
#define kDateFormat_Hm         @"HH:mm"
#define kDateFormat_Md         @"MM-dd"
#define kDateFormat_yyMd       @"yy-MM-dd"
#define kDateFormat_YYMMdd     @"yyyyMMdd"
#define kDateFormat_yyyyMdHms  @"yyyyMMddHHmmss"
#define kDateFormat_yyyyMMddHHmmssSSS   @"yyyy-MM-dd HH:mm:ss:SSS"
#define kDateFormat_yyyyMdHm_ForPoint   @"yyyy.MM.dd HH:mm"
#define kDateFormat_yyyyMMddHHmm        @"yyyy/MM/dd HH:mm"
#define KDateFormat_yyyy @"yyyy"
#define kDateFormat_yyyyMM @"yyyy-MM"
#define kDateFormat_yyyMMddWeek @"yyyy-MM-dd EEE"

#define kScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight   [[UIScreen mainScreen] bounds].size.height
#define kBodyHeight     (kScreenHeight - 44 - 20)
#define kMiddleHeight   (kBodyHeight - 49)

#define kFontSize9 [UIFont systemFontOfSize:9.0]

/// 10号字体
#define kFontSize10 [UIFont systemFontOfSize:10.0]

/// 11号字体
#define kFontSize11 [UIFont systemFontOfSize:11.0]

/// 12号字体
#define kFontSize12 [UIFont systemFontOfSize:12.0]

/// 13号字体
#define kFontSize13 [UIFont systemFontOfSize:13.0]

/// 14号字体
#define kFontSize14 [UIFont systemFontOfSize:14.0]

/// 15号字体
#define kFontSize15 [UIFont systemFontOfSize:15.0]

/// 16号字体
#define kFontSize16 [UIFont systemFontOfSize:16.0]




#pragma mark - CommonColor
// 导航栏背景颜色
#define kColorNavBground UIColorHex(0xf3ee64)
// 深灰色
#define kColorDarkgray UIColorHex(0x666666)
// 淡灰色-如普通界面的背景颜色
#define kColorLightgray UIColorHex(0xeeeeee)
// 灰色—如内容字体颜色
#define kColorgrayContent UIColorHex(0x969696)
// 搜索焦点颜色
#define kTintColorSearch UIColorRGB(2, 162, 253)
// 主题背景色
#define kBackgroundColor UIColorHex(0xf2f2f2)
// cell高亮颜色
#define kCellHightedColor UIColorHex(0xe6e6e9)
// 通用的红色文字颜色
#define kColorFontRed UIColorHex(0xe12228)
// 透明色
#define kColorClear [UIColor clearColor]
// 白色-如导航栏字体颜色
#define kColorWhite UIColorHex(0xffffff)
#define kColorLightWhite UIColorHex(0xf9f9f9)
#define kColorBgWhite UIColorHex(0xfbfbfb)
// 黑色-如输入框输入字体颜色或标题颜色
#define kColorBlack UIColorHex(0x333333)
// 黑色-细黑
#define kColorLightBlack UIColorHex(0x999999)
// 黑色-纯黑
#define kColorDeepBlack UIColorHex(0x000000)
// 灰色—如列表cell分割线颜色样式
#define kColorSeparatorline UIColorHex(0xdddddd)
// 灰色-边框线颜色
#define kColorBorderline UIColorHex(0xb8b8b8)
// 按钮不可用背景色
#define kColorGrayButtonDisable UIColorHex(0xdcdcdc)
// 绿色-如导航栏背景颜色
#define kColorGreenNavBground UIColorHex(0x38ad7a)
// 绿色
#define kColorGreen UIColorHex(0x349c6f)
// 深绿色
#define kColorDarkGreen UIColorHex(0x188d5a)
// 橙色
#define kColorOrange UIColorHex(0xf39700)
// 深橙色
#define kColorDarkOrange UIColorHex(0xe48437)
// 淡紫色
#define kColorLightPurple UIColorHex(0x909af8)
// 红色
#define kColorRed UIColorHex(0xfd492e)
#define kColorLightRed UIColorHex(0xe4393c)
// 蓝色
#define kColorBlue UIColorHex(0x00a0e9)
#define kColorLightBlue UIColorHex(0x3985ff)
#endif /* CommonDefine_h */
