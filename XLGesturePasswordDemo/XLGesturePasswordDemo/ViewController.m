//
//  ViewController.m
//  XLGesturePasswordDemo
//
//  Created by MengXianLiang on 2018/5/23.
//  Copyright © 2018年 jwzt. All rights reserved.
//

#import "ViewController.h"
#import "XLGesturePassword.h"
@interface ViewController () {
    XLGesturePassword *_passWord;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *blueColor = [UIColor colorWithRed:0/255.0f green:160/255.0f blue:229/255.0f alpha:1];
    UIColor *ligntBlueColor = [UIColor colorWithRed:181/255.0f green:224/255.0f blue:244/255.0f alpha:1];
    
    _passWord = [[XLGesturePassword alloc] init];
    _passWord.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width);
    _passWord.center = self.view.center;
    _passWord.itemBackGoundColor = ligntBlueColor;
    _passWord.itemCenterBallColor = blueColor;
    _passWord.lineColor = blueColor;
    [self.view addSubview:_passWord];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
