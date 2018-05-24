# XLGesturePassword

### 显示效果

<img src="https://github.com/mengxianliang/XLGesturePassword/blob/master/GIF/1.gif" width=300 height=534 />

### 使用方法

* 手势密码创建方法
```objc
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
```

* 手势提示创建方法
```objc
_infoView = [[XLGestureInfoView alloc] init];
_infoView.bounds = CGRectMake(0, 0, 80, 80);
_infoView.center = CGPointMake(_passWord.center.x, CGRectGetMinY(_passWord.frame) - 50);
_infoView.itemBackGoundColor = blueColor;
[self.view addSubview:_infoView];
```


### 个人开发过的UI工具集合 [XLUIKit](https://github.com/mengxianliang/XLUIKit)
