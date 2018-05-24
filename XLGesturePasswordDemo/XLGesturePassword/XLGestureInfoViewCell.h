//
//  XLGestureInfoViewCell.h
//  XLGesturePasswordDemo
//
//  Created by MengXianLiang on 2018/5/24.
//  Copyright © 2018年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLGestureInfoViewCell : UICollectionViewCell

//item背景色
@property (nonatomic, strong) UIColor *itemBackGoundColor;
//手势选中
@property (nonatomic, assign) BOOL gestureSelected;

@end
