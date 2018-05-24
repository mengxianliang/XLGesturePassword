//
//  XLGestureCell.m
//  手势密码Demo
//
//  Created by MengXianLiang on 2018/5/23.
//  Copyright © 2018年 jwzt. All rights reserved.
//

#import "XLGesturePasswordCell.h"

@interface XLGesturePasswordCell () {
    UIView *_centerBall;
}
@end

@implementation XLGesturePasswordCell

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
    
    CGFloat dotW = self.bounds.size.width*0.45;
    _centerBall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dotW, dotW)];
    _centerBall.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    _centerBall.layer.cornerRadius = _centerBall.bounds.size.height/2.0f;
    _centerBall.layer.masksToBounds = true;
    [self addSubview:_centerBall];
}

- (void)setGestureSelected:(BOOL)gestureSelected {
    if (gestureSelected) {//选中
        self.layer.borderWidth = 0;
        _centerBall.hidden = false;
        self.backgroundColor = _itemBackGoundColor;
    }else{//未选中
        self.layer.borderWidth = 1;
        _centerBall.hidden = true;
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setItemBackGoundColor:(UIColor *)itemBackGoundColor {
    _itemBackGoundColor = itemBackGoundColor;
}

- (void)setItemCenterBallColor:(UIColor *)itemCenterBallColor {
    _centerBall.backgroundColor = itemCenterBallColor;
}

@end
