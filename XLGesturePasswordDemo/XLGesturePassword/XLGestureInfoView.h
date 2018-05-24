//
//  XLGestureInfoView.h
//  手势密码Demo
//
//  Created by MengXianLiang on 2018/5/23.
//  Copyright © 2018年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLGestureInfoView : UIView
//选中颜色
@property (nonatomic, strong) UIColor *itemBackGoundColor;
//要显示的密码
@property (nonatomic, copy) NSString *passWord;
//重新输入
- (void)refresh;

@end
