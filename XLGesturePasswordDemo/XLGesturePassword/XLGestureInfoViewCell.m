//
//  XLGestureInfoViewCell.m
//  XLGesturePasswordDemo
//
//  Created by MengXianLiang on 2018/5/24.
//  Copyright © 2018年 jwzt. All rights reserved.
//

#import "XLGestureInfoViewCell.h"

@implementation XLGestureInfoViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.layer.cornerRadius = self.bounds.size.height/2.0f;
    self.layer.masksToBounds = true;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor colorWithRed:129/255.0f green:129/255.0f blue:129/255.0f alpha:1].CGColor;
}

- (void)setGestureSelected:(BOOL)gestureSelected {
    if (gestureSelected) {//选中
        self.layer.borderWidth = 0;
        self.backgroundColor = _itemBackGoundColor;
    }else{//未选中
        self.layer.borderWidth = 1;
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setItemBackGoundColor:(UIColor *)itemBackGoundColor {
    _itemBackGoundColor = itemBackGoundColor;
}

@end
