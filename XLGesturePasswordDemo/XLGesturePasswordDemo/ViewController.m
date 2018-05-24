//
//  ViewController.m
//  XLGesturePasswordDemo
//
//  Created by MengXianLiang on 2018/5/23.
//  Copyright © 2018年 jwzt. All rights reserved.
//

#import "ViewController.h"
#import "XLGesturePassword.h"
#import "XLGestureInfoView.h"

@interface ViewController () {
    XLGesturePassword *_passWord;
    XLGestureInfoView *_infoView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *blueColor = [UIColor colorWithRed:0/255.0f green:160/255.0f blue:229/255.0f alpha:1];
    UIColor *ligntBlueColor = [UIColor colorWithRed:181/255.0f green:224/255.0f blue:244/255.0f alpha:1];
    UIColor *redColor = [UIColor colorWithRed:253/255.0f green:106/255.0f blue:95/255.0f alpha:1];
    
    //密码输入
    _passWord = [[XLGesturePassword alloc] init];
    _passWord.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width);
    _passWord.center = self.view.center;
    _passWord.itemBackGoundColor = ligntBlueColor;
    _passWord.itemCenterBallColor = blueColor;
    _passWord.lineNormalColor = blueColor;
    _passWord.lineErrorColor = redColor;
    [self.view addSubview:_passWord];
    __weak typeof (self)weekSelf = self;
    [_passWord addPasswordBlock:^(NSString *password) {
        [weekSelf showPassword:password];
    }];
    
    //密码提示
    _infoView = [[XLGestureInfoView alloc] init];
    _infoView.bounds = CGRectMake(0, 0, 80, 80);
    _infoView.center = CGPointMake(_passWord.center.x, CGRectGetMinY(_passWord.frame) - 50);
    _infoView.itemBackGoundColor = blueColor;
    [self.view addSubview:_infoView];
}

- (void)showPassword:(NSString *)password {
    _infoView.passWord = password;
    NSLog(@"密码是：%@",password);
}

- (IBAction)Reenter:(id)sender {
    [_passWord refresh];
    [_infoView refresh];
}

- (IBAction)ShowError:(id)sender {
    [_passWord showError];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
