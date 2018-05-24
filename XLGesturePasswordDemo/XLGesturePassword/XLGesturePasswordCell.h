//
//  XLGestureCell.h
//  手势密码Demo
//
//  Created by MengXianLiang on 2018/5/23.
//  Copyright © 2018年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLGesturePasswordCell : UICollectionViewCell

//item背景色
@property (nonatomic, strong) UIColor *itemBackGoundColor;
//item中间圆球的颜色
@property (nonatomic, strong) UIColor *itemCenterBallColor;
//手势选中
@property (nonatomic, assign) BOOL gestureSelected;

@end
