//
//  XLGesturePassword.m
//  手势密码Demo
//
//  Created by MengXianLiang on 2018/5/23.
//  Copyright © 2018年 jwzt. All rights reserved.
//

#import "XLGesturePassword.h"
#import "XLGesturePasswordCell.h"

@interface XLGesturePassword ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    //集合视图
    UICollectionView *_collectionView;
    //手势路径
    UIBezierPath *_path;
    //连线
    CAShapeLayer *_layer;
    //存放每次手势路径上的indexPath
    NSMutableArray <NSIndexPath *>*_passwordIndexPathArr;
    //密码block
    PasswordBlock _passwordBlock;
}
@end

@implementation XLGesturePassword

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
        [self setDefaultColor];
    }
    return self;
}

- (void)buildUI {
    
    self.layer.masksToBounds = true;
    
    //初始化collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[XLGesturePasswordCell class] forCellWithReuseIdentifier:@"XLGesturePasswordCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    
    //初始化手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMethod:)];
    [_collectionView addGestureRecognizer:pan];
    
    //创建运动路径
    _path = [UIBezierPath bezierPath];
    
    //创建中间连线
    _layer = [CAShapeLayer layer];
    _layer.fillColor = [UIColor clearColor].CGColor;
    _layer.lineWidth = 3;
    _layer.lineCap = kCALineCapRound;
    _layer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_layer];
    
    //初始选中化数组
    _passwordIndexPathArr = [[NSMutableArray alloc] init];
}

//设置默认颜色
- (void)setDefaultColor {
    self.itemBackGoundColor = [UIColor lightGrayColor];
    self.itemCenterBallColor = [UIColor grayColor];
    self.lineNormalColor = [UIColor grayColor];
    self.lineErrorColor = [UIColor redColor];
}

//自动布局
- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
}


#pragma mark -
#pragma mark CollectonViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [self itemSpacing];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [self itemSpacing];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([self itemWidth], [self itemWidth]);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake([self itemSpacing], [self itemSpacing], [self itemSpacing], [self itemSpacing]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellId = @"XLGesturePasswordCell";
    XLGesturePasswordCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.gestureSelected = [_passwordIndexPathArr containsObject:indexPath];
    cell.itemBackGoundColor = self.itemBackGoundColor;
    cell.itemCenterBallColor = self.itemCenterBallColor;
    return cell;
}

#pragma mark -
#pragma mark CollectionView辅助方法
- (CGFloat)itemSpacing {
    return self.bounds.size.width/10.0f;
}

- (CGFloat)itemWidth {
    return (self.bounds.size.width - 4*[self itemSpacing])/3.0f;
}

#pragma mark -
#pragma mark 手势相关方法
- (void)panMethod:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:_collectionView];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            [self gestureBegan];
            break;
        case UIGestureRecognizerStateChanged:
            [self gestureChanged:point];
            break;
        case UIGestureRecognizerStateEnded:
            [self gestureEnded];
            break;
        default:
            break;
    }
}

//手势开始
- (void)gestureBegan {
    [self refresh];
}

//手势变化
- (void)gestureChanged:(CGPoint)point {
    [self updatePasswordIndexPathArr:point];
    [self updateGesturePath:point];
}

//更新路径上的indexPath
- (void)updatePasswordIndexPathArr:(CGPoint)point {
    for (NSIndexPath *indexPath in _collectionView.indexPathsForVisibleItems) {
        XLGesturePasswordCell *cell = (XLGesturePasswordCell *)[_collectionView cellForItemAtIndexPath:indexPath];
        if (CGRectContainsPoint(cell.frame, point)) {
            if (![_passwordIndexPathArr containsObject:indexPath]) {
                [_passwordIndexPathArr addObject:indexPath];
                cell.gestureSelected = true;
            }
        }
    }
}

//绘制手势路径
- (void)configGesturePath {
    [_path removeAllPoints];
    for (NSInteger i = 0; i < _passwordIndexPathArr.count; i++) {
        NSIndexPath *indexPath  = _passwordIndexPathArr[i];
        UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
        if (i == 0) {
            [_path moveToPoint:cell.center];
        }else {
            [_path addLineToPoint:cell.center];
        }
    }
    _layer.path = _path.CGPath;
}

//更新手势路径
- (void)updateGesturePath:(CGPoint)point {
    [self configGesturePath];
    [_path addLineToPoint:point];
    _layer.path = _path.CGPath;
}

//手势结束
- (void)gestureEnded {
    //显示手势路径
    [self configGesturePath];
    NSString *password = @"";
    for (NSIndexPath *indexPath in _passwordIndexPathArr) {
        password = [NSString stringWithFormat:@"%@%zd",password,indexPath.row];
    }
    if (_passwordBlock) {
        _passwordBlock(password);
    }
}

#pragma mark -
#pragma mark Setter
//设置线条正常颜色
- (void)setLineNormalColor:(UIColor *)lineNormalColor {
    _lineNormalColor = lineNormalColor;
    _layer.strokeColor = lineNormalColor.CGColor;
}

//设置线条错误颜色
- (void)setLineErrorColor:(UIColor *)lineErrorColor {
    _lineErrorColor = lineErrorColor;
}

#pragma mark -
#pragma mark 功能方法
//报错
- (void)showError {
    _layer.strokeColor = _lineErrorColor.CGColor;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self refresh];
    });
}
//重置
- (void)refresh {
    //刷新列表
    [_passwordIndexPathArr removeAllObjects];
    [_collectionView reloadData];
    //更新路径
    [_path removeAllPoints];
    _layer.path = _path.CGPath;
    _layer.strokeColor = _lineNormalColor.CGColor;
    
}

//添加密码输入回调
- (void)addPasswordBlock:(PasswordBlock)passwordBlock {
    _passwordBlock = passwordBlock;
}
@end
