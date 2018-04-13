//
//  KHYOrderViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/12.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYOrderViewController.h"
#import "KHYOrderListViewController.h"
#import "KBarButtonItem.h"

@interface KHYOrderViewController ()
@property (nonatomic, strong) NSArray *buttonTitleArr;
@end

@implementation KHYOrderViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self prepareData];
    [self createUI];
    [self reloadData];
}

- (void)prepareData
{
    
    self.buttonTitleArr = @[@"全部",@"待支付",@"待发货",@"已取消"];
}

- (void)createUI
{
    
    KBarButtonItem *leftButtonItem = [KBarButtonItem itemWithTitle:@""
                                                             image:@"left_arrow_white"
                                                             Style:SNNavItemStyleLeft
                                                            target:self
                                                            action:@selector(leftButtonItemClick)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
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
    
    KHYOrderListViewController *vc = [[KHYOrderListViewController alloc] init];
    vc.selectIndex = @(index).stringValue;
    return vc;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index
{
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    return CGRectMake(0, 0, self.view.frame.size.width, 50);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - NAVIGATION_BAR_HEIGHT - 50);
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
