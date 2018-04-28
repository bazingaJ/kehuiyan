//
//  KHYChatViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/13.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYChatViewController.h"
#import "WSChatMessageInputBar.h"
#import "ODRefreshControl.h"
#import "KHYChatCell.h"
#import "ALView+PureLayout.h"
#import "KHYChatInfoModel.h"
#import "KHYPackgeCell.h"
#import "KHYComboViewController.h"

// 他人信息
static NSString *const cellIdentifier = @"ChatTableCell1";
// 自己信息
static NSString *const cellIdentifier1 = @"ChatTableCell2";

@interface KHYChatViewController ()<JXChatInputBarDelegate,
                                    UITableViewDataSource,
                                    UITableViewDelegate>
{
    dispatch_source_t timer;
}
@property(nonatomic,strong)WSChatMessageInputBar *inputBar;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) ODRefreshControl *refreshControl;

// 计算高度的字典
@property (nonatomic, strong) NSMutableDictionary *heightsDicM;

@end

static NSString *const currentTitle = @"咨询详情";

const CGFloat ChatViewInputViewHeight = 50.f;

@implementation KHYChatViewController

- (NSMutableDictionary*)heightsDicM
{
    if(_heightsDicM==nil)
    {
        _heightsDicM = [NSMutableDictionary dictionary];
    }
    return _heightsDicM;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = currentTitle;
    
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    
    
    if (!self.memberID && [self.isFromInfo isEqualToString:@"2"]) {
        [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeBottom];
        [self.view addSubview:self.inputBar];
        [self.inputBar autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeTop];
        [self.inputBar autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView];
    }else{
        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT);
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadMoreMsg];
        }];
    }

    self.dataArr = [NSMutableArray array];
    [self requestChatData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    if (!self.memberID && [self.isFromInfo isEqualToString:@"2"]) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 15 * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self requestChatData];
            });
            
        });
        dispatch_resume(timer);
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    if (timer) {
        dispatch_source_cancel(timer);
        timer = nil;
    }
    
}

#pragma mark - TableView Delegate

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KHYChatInfoModel *model = self.dataArr[indexPath.row];
    if ([model.content_type isEqualToString:@"1"]) {
        return [self.heightsDicM[indexPath] doubleValue];
    }else{
        return 140;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KHYChatInfoModel *model = self.dataArr[indexPath.row];
    if ([model.content_type isEqualToString:@"1"]) {
        if ([model.is_mine isEqualToString:@"1"]) {
            KHYChatCell *cell = [KHYChatCell cellWithTableView:tableView cellIdentifier:@"TextCellCell2"];
            cell.model = model;
            self.heightsDicM[indexPath] = @([cell getH1]);
            return cell;
            
        }else{
            KHYChatCell *cell = [KHYChatCell cellWithTableView:tableView cellIdentifier:@"TextCellCell1"];
            cell.model = model;
            self.heightsDicM[indexPath] = @([cell getH1]);
            return cell;
        }
    }else{
        KHYPackgeCell *cell = [KHYPackgeCell cellWithTableView:tableView];
        cell.model = model;
        self.heightsDicM[indexPath] = @(140);
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    
}

// 发送按钮点击事件
- (void)getMsgWith:(KHYChatInfoModel *)model
{
    [self sendMsgToServerWithContent:model.content contentType:@"1" completeBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [self.dataArr addObject:model];
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }else{
            [MBProgressHUD showError:@"消息发送失败" toView:self.view];
        }
    }];
    
}

/**
 更多按钮点击事件
 */
- (void)choicePackge
{
    
    KHYComboViewController *vc = [[KHYComboViewController alloc] init];
    vc.isAnswer = @"2";
    vc.choicePackge = ^(KHYComboModel *model) {
        KHYChatInfoModel *chatInfoModel = [KHYChatInfoModel new];
        chatInfoModel.content_type = @"3";
        chatInfoModel.packageID = model.package_num;
        chatInfoModel.packageText = model.name;
        chatInfoModel.chatCellType = JXChatCellType_Pacage;
        chatInfoModel.content = model.package_num;
        chatInfoModel.is_mine = @"1";
        
        NSString *detail = @"";
        for (int i =0; i <model.product_list.count; i++)
        {
            NSDictionary *dict = model.product_list[i];
            NSString *name = [NSString stringWithFormat:@"%@\n",dict[@"name"]];
            detail = [detail stringByAppendingString:name];
            
        }
        chatInfoModel.packgeInfo = detail;
        chatInfoModel.packageImg = model.cover_url;
        
        [self sendMsgToServerWithContent:model.package_num contentType:@"3" completeBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                [self.dataArr addObject:chatInfoModel];
                [self.tableView reloadData];
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            }else{
                [MBProgressHUD showError:@"消息发送失败" toView:self.view];
            }
        }];
        
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 请求聊天信息
 */
- (void)requestChatData
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"getChatInfo";
    param[@"other_user_id"] = _model.user_id;
    if ([JXAppTool isLeader]) {
        param[@"mem_id"] = self.memberID;
    }
    
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSDictionary *dict = [json objectForKey:@"data"];
                               self.dataArr = [KHYChatInfoModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
                               [self.tableView reloadData];
                               if (self.dataArr.count > 0) {
                                   [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                               }
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
    
    
}

/**
 发送咨询回复

 @param content 咨询的内容
 @param block 回调是否成功
 */
- (void)sendMsgToServerWithContent:(NSString *)content contentType:(NSString *)type completeBlock:(void(^)(BOOL isSuccess))block
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"sendChat";
    param[@"content"] = content;
    param[@"other_user_id"] = self.model.user_id;
    param[@"content_type"] = type;
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           NSString *code = [json objectForKey:@"code"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               block(YES);
                           }
                           else
                           {
                               block(NO);
                           }
                       }
                       failure:^(NSError *error) {
                           block(NO);
                       }];
    
}

#pragma mark - Getter Method

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView                      =   [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.separatorStyle       =   UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor      =   BACK_COLOR;
        _tableView.delegate             =   self;
        _tableView.dataSource           =   self;
        _tableView.keyboardDismissMode  =   UIScrollViewKeyboardDismissModeOnDrag;
        
    }
    
    return _tableView;
    
}

- (void)loadMoreMsg{
    
    KHYChatInfoModel *model = self.dataArr[0];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"getChatInfo";
    param[@"msg_id"] = model.msg_id;
    param[@"chat_id"] = model.chat_id;
    param[@"other_user_id"] = _model.user_id;
    if ([JXAppTool isLeader]) {
        param[@"mem_id"] = self.memberID;
    }
    
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [self.tableView.mj_header endRefreshing];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               NSDictionary *dict = [json objectForKey:@"data"];
                               NSMutableArray *Arr = [NSMutableArray array];
                               Arr = [KHYChatInfoModel mj_objectArrayWithKeyValuesArray:dict[@"list"]];
                               NSArray *wholeArr = [Arr arrayByAddingObjectsFromArray:(NSArray *)self.dataArr];
                               [self.dataArr removeAllObjects];
                               [self.dataArr addObjectsFromArray:wholeArr];
                               [self.tableView reloadData];
                           }
                           else
                           {
                               [MBProgressHUD showError:msg toView:self.view];
                           }
                       }
                       failure:^(NSError *error) {
                           [self.tableView.mj_header endRefreshing];
                           [MBProgressHUD showError:@"与服务器连接失败" toView:self.view];
                       }];
}

-(WSChatMessageInputBar *)inputBar
{
    if (_inputBar) {
        return _inputBar;
    }
    
    _inputBar = [[WSChatMessageInputBar alloc]init];
    _inputBar.delegate = self;
    _inputBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    return _inputBar;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
