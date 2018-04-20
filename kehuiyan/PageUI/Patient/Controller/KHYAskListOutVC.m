//
//  KHYAskListVC.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/17.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYAskListOutVC.h"
#import "KHYAskRecordListVC.h"
#import "KBarButtonItem.h"

@interface KHYAskListOutVC ()
@property (nonatomic, strong) NSMutableArray *buttonArr;
@property (nonatomic, strong) NSMutableArray *buttonTitleArr;

@property (nonatomic, strong) UIView *filterView;

@property (nonatomic, strong) UIControl *controlView;
// 源数据
@property (nonatomic, strong) NSArray *originData;
@end

@implementation KHYAskListOutVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self prepareData];
    [self createUI];
    [self requestCateList];
    
}

- (void)prepareData
{
    
    self.buttonArr = [NSMutableArray array];
    self.buttonTitleArr = [NSMutableArray array];
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
    
    
}

- (void)leftButtonItemClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return _buttonTitleArr.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return _buttonTitleArr[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    KHYAskRecordListVC *vc = [[KHYAskRecordListVC alloc] init];
    NSDictionary *smallDic = self.originData[index];
    vc.selectIndex = smallDic[@"cate_id"];
    vc.patient_id = self.patient_id;
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
    return CGRectMake(0, originY, self.view.frame.size.width, SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - NAVIGATION_BAR_HEIGHT - 50);
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
    self.selectIndex = (int)button.tag;
    [self dismissControlViewAndUpperView];
    
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

#pragma mark - 获取类型列表
- (void)requestCateList
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"default";
    param[@"act"] = @"getCateList";
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               self.originData = [json objectForKey:@"data"];
                               for (int i = 0; i < self.originData.count; i++)
                               {
                                   NSDictionary *smallDic = self.originData[i];
                                   [self.buttonTitleArr addObject:smallDic[@"name"]];
                               }
                               
                               [self reloadData];
                               [self.view addSubview:self.controlView];
                               [self.view addSubview:self.filterView];
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           [MBProgressHUD hideHUDForView:self.view];
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
