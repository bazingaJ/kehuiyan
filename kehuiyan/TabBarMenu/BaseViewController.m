//
//  BaseViewController.m
//  YiJiaMao_S
//
//  Created by 相约在冬季 on 2016/12/16.
//  Copyright © 2016年 e-yoga. All rights reserved.
//

#import "BaseViewController.h"
#import "KBarButtonItem.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *stateView = [[UIView alloc] initWithFrame:CGRectMake(0, -STATUS_BAR_HEIGHT, SCREEN_WIDTH, STATUS_BAR_HEIGHT)];
    stateView.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar addSubview:stateView];

    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    if(!self.leftButtonItemHidden) {
        KBarButtonItem *leftButtonItem = [KBarButtonItem itemWithTitle:_leftButtonItemTitle
                                                                   image:_leftButtonItemImageName
                                                                   Style:SNNavItemStyleLeft
                                                                  target:self
                                                                  action:@selector(leftButtonItemClick)];
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    }
    
    if(self.rightButtonItemShow || _rightButtonItemTitle || _rightButtonItemImageName) {
        KBarButtonItem *rightButtonItem = [KBarButtonItem itemWithTitle:_rightButtonItemTitle
                                                                    image:_rightButtonItemImageName
                                                                    Style:SNNavItemStyleRight
                                                                   target:self
                                                                   action:@selector(rightButtonItemClick)];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
    }

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(IOS_VERSION>=7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.navigationController.navigationBar.translucent = NO;
        [UIApplication sharedApplication].statusBarHidden = NO;
    }

}

/**
 *  点击左侧按钮
 */
- (void)leftButtonItemClick {
    NSLog(@"您点击了左侧按钮");
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  点击右侧按钮
 */
- (void)rightButtonItemClick {
    NSLog(@"您点击了右侧按钮");
}

/**
 *  存储本地用户信息
 */
- (void)setUserDefaultInfo:(NSDictionary *)userDic {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setValue:[userDic objectForKey:@"user_id"] forKey:@"user_id"];//用户编号
    [userInfo setValue:[userDic objectForKey:@"token"] forKey:@"token"];//登录唯一凭证
    [userInfo setValue:[userDic objectForKey:@"mobile"] forKey:@"mobile"];//手机号
    [userInfo setValue:[userDic objectForKey:@"realname"] forKey:@"realname"];//真实姓名
    [userInfo setValue:[userDic objectForKey:@"avatar"] forKey:@"avatar"];//头像
    [userInfo setValue:[userDic objectForKey:@"province_id"] forKey:@"province_id"];//省编号
    [userInfo setValue:[userDic objectForKey:@"city_id"] forKey:@"city_id"];//市编号
    [userInfo setValue:[userDic objectForKey:@"area_id"] forKey:@"area_id"];//区编号
    [userInfo setValue:[userDic objectForKey:@"area_name"] forKey:@"area_name"];//区域名称
    [userInfo setValue:[userDic objectForKey:@"address"] forKey:@"address"];//详细地址
    [userInfo setValue:[userDic objectForKey:@"email"] forKey:@"email"];//邮件
    [userInfo setValue:[userDic objectForKey:@"gender"] forKey:@"gender"];//性别
    [userInfo setValue:[userDic objectForKey:@"weixin"] forKey:@"weixin"];//微信
    [userInfo setValue:[userDic objectForKey:@"qq"] forKey:@"qq"];//QQ
    [userInfo setValue:[userDic objectForKey:@"org_one"] forKey:@"org_one"];
    [userInfo setValue:[userDic objectForKey:@"org_two"] forKey:@"org_two"];
    [userInfo setValue:[userDic objectForKey:@"org_name"] forKey:@"org_name"];
    [userInfo setValue:[userDic objectForKey:@"department"] forKey:@"department"];//部门名称
    [userInfo setValue:[userDic objectForKey:@"status"] forKey:@"status"];
    [userInfo setValue:[userDic objectForKey:@"position"] forKey:@"position"];
    [userInfo setValue:[userDic objectForKey:@"position_id"] forKey:@"position_id"];
    [userDefault setObject:userInfo forKey:@"userInfo"];
    [userDefault synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
