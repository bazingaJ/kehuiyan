//
//  KHYActivityViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYActivityViewController.h"
#import "KHYActivityListViewController.h"
#import "KBarButtonItem.h"
#import "KHYAnnounceViewController.h"

@interface KHYActivityViewController ()
@property (nonatomic, strong) NSMutableArray *buttonArr;
@property (nonatomic, strong) NSArray *buttonTitleArr;

@property (nonatomic, strong) UIView *filterView;

@property (nonatomic, strong) UIControl *controlView;

@end

@implementation KHYActivityViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self prepareData];
    [self createUI];
}

- (void)prepareData
{
    
    self.buttonTitleArr = @[@"产后恢复",@"术后康复",@"病后修养",@"产后恢复",@"产后恢复",@"术后康复",@"病后修养",@"产后恢复",@"产后恢复",@"术后康复",@"病后修养"];
    self.buttonArr = [NSMutableArray array];
}

- (void)createUI
{
    
    KBarButtonItem *leftButtonItem = [KBarButtonItem itemWithTitle:@""
                                                             image:@"left_arrow_white"
                                                             Style:SNNavItemStyleLeft
                                                            target:self
                                                            action:@selector(leftButtonItemClick)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 50, 50);
    [selectBtn setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(showChoiceList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
    
    UIImageView *view = [UIImageView new];
    view.frame = CGRectMake(SCREEN_WIDTH - 48, 4, 4, 42);
    view.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:view];
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - NAVIGATION_BAR_HEIGHT - 50, SCREEN_WIDTH, 50);
    [bottomBtn setBackgroundColor:kRGB(89, 189, 237)];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn setTitle:@"发布活动" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(announce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
    [self.view addSubview:self.controlView];
    [self.view addSubview:self.filterView];
    
}

- (void)leftButtonItemClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return 5;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    switch (index % 4)
    {
        case 0: return @"术后康复";
        case 1: return @"产后康复";
        case 2: return @"病后修养";
        case 3: return @"营养保健";
    }
    return @"NULL";
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    KHYActivityListViewController *vc = [[KHYActivityListViewController alloc] init];
    vc.selectIndex = @(index).stringValue;
    return vc;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index
{
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    return CGRectMake(0, 0, self.view.frame.size.width - 50, 50);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - NAVIGATION_BAR_HEIGHT - 50 - 50);
}



/**
 筛选列表
 */
- (void)showChoiceList
{
    
    [UIView animateWithDuration:0.03 animations:^{
        self.controlView.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.filterView.transform = CGAffineTransformMakeTranslation(0, 210);
    }];
}

- (void)upperBtnClick
{
    
    [self dismissControlViewAndUpperView];
}

/**
 筛选按钮选择

 @param button 选中的按钮
 */
- (void)activityBtnClick:(UIButton *)button
{
    
    for (UIButton *btn in _buttonArr)
    {
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 12.5;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = COLOR9.CGColor;
    }
    button.selected = YES;
    [button setBackgroundColor:kRGB(89, 189, 237)];
    button.layer.borderColor = kRGB(89, 189, 237).CGColor;
    
}

- (void)dismissControlViewAndUpperView
{
    
    [UIView animateWithDuration:0.03 animations:^{
        self.controlView.transform = CGAffineTransformIdentity;
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.filterView.transform = CGAffineTransformIdentity;
    }];
}

- (UIControl *)controlView
{
    if (!_controlView)
    {
        _controlView = [[UIControl alloc] init];
        _controlView.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        [_controlView addTarget:self action:@selector(dismissControlViewAndUpperView) forControlEvents:UIControlEventTouchUpInside];
        _controlView.backgroundColor = [UIColor blackColor];
        _controlView.alpha = 0.4f;
    }
    return _controlView;
}

- (UIView *)filterView
{
    if (!_filterView)
    {
        _filterView = [[UIView alloc] init];
        _filterView.frame = CGRectMake(0, -210, SCREEN_WIDTH, 210);
        _filterView.backgroundColor = BACK_COLOR;
        
        UIView *upperView = [[UIView alloc] init];
        upperView.backgroundColor = kRGB(240, 240, 240);
        [_filterView addSubview:upperView];
        [upperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(_filterView);
            make.height.mas_equalTo(40);
        }];
        
        UILabel *selectLab = [[UILabel alloc] init];
        selectLab.text = @"请选择";
        selectLab.textColor = COLOR6;
        selectLab.font = FONT15;
        [upperView addSubview:selectLab];
        [selectLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(upperView.mas_centerY);
            make.height.mas_equalTo(20);
        }];
        
        UIButton *upperBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [upperBtn setImage:[UIImage imageNamed:@"upper_arrow"] forState:UIControlStateNormal];
        [upperBtn addTarget:self action:@selector(upperBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [upperView addSubview:upperBtn];
        [upperBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(upperView).offset(-15);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(upperView.mas_centerY);
        }];
        
        // 按钮宽度
        CGFloat buttonWidth = (SCREEN_WIDTH - 15 * 5) / 4;
        CGFloat buttonHeight = 25;
        
        for (int i = 0; i < _buttonTitleArr.count; i ++)
        {
            UIButton *activityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [activityBtn setTitle:_buttonTitleArr[i] forState:UIControlStateNormal];
            [activityBtn setTitleColor:COLOR9 forState:UIControlStateNormal];
            [activityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [activityBtn setBackgroundColor:[UIColor whiteColor]];
            [activityBtn addTarget:self action:@selector(activityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            activityBtn.titleLabel.font = FONT12;
            activityBtn.layer.masksToBounds = YES;
            activityBtn.layer.cornerRadius = 12.5;
            activityBtn.layer.borderWidth = 0.5;
            activityBtn.layer.borderColor = COLOR9.CGColor;
            activityBtn.frame = CGRectMake(15 + (buttonWidth +15)*(i%4), 60 + (buttonHeight + 20) * (i/4), buttonWidth, buttonHeight);
            activityBtn.tag = i;
            [_filterView addSubview:activityBtn];
            [self.buttonArr addObject:activityBtn];
        }
    }
    return _filterView;
}

/**
 发布活动
 */
- (void)announce
{
    
    KHYAnnounceViewController *vc = [[KHYAnnounceViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
