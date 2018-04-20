//
//  KHYAnnounceViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/11.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYAnnounceViewController.h"
#import "KHYAnnounceCell.h"
#import "KHYAnnounceModel.h"
#import "MHDatePicker.h"
#import "AddressPickView.h"

static NSString *const cellIdentifier1 = @"KHYAnnounceCell1";
static NSString *const cellIdentifier2 = @"KHYAnnounceCell2";
static NSString *const cellIdentifier3 = @"KHYAnnounceCell3";
static NSString *const cellIdentifier4 = @"KHYAnnounceCell4";
static NSString *const cellIdentifier5 = @"KHYAnnounceCell5";

@interface KHYAnnounceViewController ()<JXAnnounceDelegate,
                                        UIImagePickerControllerDelegate,
                                        UINavigationControllerDelegate>
@property (nonatomic, strong) NSArray *originArr;
@property (nonatomic, strong) NSMutableArray *buttonArr;
@property (nonatomic, strong) NSMutableArray *buttonTitleArr;

@property (nonatomic, strong) UIView *filterView;

@property (nonatomic, strong) UIControl *controlView;
@property (nonatomic, strong) KHYAnnounceModel *model;


@end

@implementation KHYAnnounceViewController

- (void)viewDidLoad {
    
    [self setHiddenHeaderRefresh:YES];
    self.bottomH = 50;
    [super viewDidLoad];
    self.title = @"发布活动";
    [self prepareForData];
    [self createUI];
}

- (void)prepareForData
{
    self.model = [KHYAnnounceModel new];
    
    self.originArr = @[@[@"活动分类",@"请选择活动分类"],
                       @[@"活动名称",@"请输入活动名称"],
                       @[@"主办机构",@"请输入主办机构名称"],
                       @[@"承办单位",@"请输入承办单位名称"],
                       @[@"活动时间",@""],
                       @[@"报名时间",@""],
                       @[@"报名人数",@"请输入报名人数"],
                       @[@"活动地址",@"请选择活动地址"],
                       @[@"",@"请输入详细地址"]];
    self.buttonArr = [NSMutableArray array];
    self.buttonTitleArr = [NSMutableArray array];
    for (int i = 0; i<_btnArr.count; i++)
    {
        NSDictionary *smallDic = self.btnArr[i];
        [self.buttonTitleArr addObject:smallDic[@"name"]];
    }
}

- (void)createUI
{
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [publishBtn setBackgroundColor:kRGB(89, 189, 237)];
    [publishBtn addTarget:self action:@selector(publishActivity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publishBtn];
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.controlView];
    [self.view addSubview:self.filterView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return self.originArr.count;
    }
    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        return 120.f;
    }
    else if (indexPath.section == 2 && indexPath.row == 1)
    {
        return 130.f;
    }
    return 45.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 4 || indexPath.row == 5)
        {
            KHYAnnounceCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
            if (!cell1)
            {
                cell1 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAnnounceCell class]) owner:nil options:nil]objectAtIndex:1];
            }
            cell1.delegate = self;
            cell1.titleLab1.text = self.originArr[indexPath.row][0];
            return cell1;
        }
        else
        {
            KHYAnnounceCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (!cell2)
            {
                cell2 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAnnounceCell class]) owner:nil options:nil]objectAtIndex:0];
                cell2.accessoryType = UITableViewCellAccessoryNone;
            }
            cell2.delegate = self;
            cell2.titleLab.text = self.originArr[indexPath.row][0];
            cell2.contentTF.placeholder = self.originArr[indexPath.row][1];
            if (indexPath.row == 0)
            {
                cell2.contentTF.text = _model.cate_name;
                cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell2.width.constant = 0;
                cell2.contentTF.userInteractionEnabled = NO;
            }
            if (indexPath.row == 6)
            {
                cell2.contentTF.keyboardType = UIKeyboardTypeNumberPad;
            }
            if (indexPath.row == 7)
            {
                cell2.contentTF.text =_model.area;
                cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell2.width.constant = 0;
                cell2.contentTF.userInteractionEnabled = NO;
            }
            if (indexPath.row == 8)
            {
                cell2.titleLab.hidden = YES;
            }
            
            return cell2;
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 1)
        {
            KHYAnnounceCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
            if (!cell3)
            {
                cell3 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAnnounceCell class]) owner:nil options:nil]objectAtIndex:2];
            }
            cell3.delegate =self;
            return cell3;
        }
        else
        {
            KHYAnnounceCell *cell4 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (!cell4)
            {
                cell4 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAnnounceCell class]) owner:nil options:nil]objectAtIndex:0];
                cell4.accessoryType = UITableViewCellAccessoryNone;
            }
            cell4.titleLab.text = @"活动简介";
            cell4.contentTF.hidden = YES;
            return cell4;
        }
        
    }
    else
    {
        if (indexPath.row == 1)
        {
            KHYAnnounceCell *cell5 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
            if (!cell5)
            {
                cell5 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAnnounceCell class]) owner:nil options:nil]objectAtIndex:3];
            }
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage)];
            [cell5.activityImage addGestureRecognizer:tap];
            return cell5;
        }
        else
        {
            KHYAnnounceCell *cell6 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier5];
            if (!cell6)
            {
                cell6 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([KHYAnnounceCell class]) owner:nil options:nil]objectAtIndex:4];
            }
            
            return cell6;
        }
    }
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self showActivityView];
        }
        if (indexPath.row == 7) {
            [self showAddressView];
        }
    }
}

- (void)publishActivity
{
    
    if ([JXAppTool verifyIsNullString:_model.cate_id] || [JXAppTool verifyIsNullString:_model.cate_name])
    {
        [MBProgressHUD showMessage:@"请选择活动分类" toView:self.view];
        return;
    }
    if ([JXAppTool verifyIsNullString:_model.title])
    {
        [MBProgressHUD showMessage:@"请输入活动名称" toView:self.view];
        return;
    }
    if ([JXAppTool verifyIsNullString:_model.zhuzhi_mech])
    {
        [MBProgressHUD showMessage:@"请输入主办机构名称" toView:self.view];
        return;
    }
    if ([JXAppTool verifyIsNullString:_model.chengban_mech])
    {
        [MBProgressHUD showMessage:@"请输入承办单位名称" toView:self.view];
        return;
    }
    if ([JXAppTool verifyIsNullString:_model.start_time])
    {
        [MBProgressHUD showMessage:@"请选择活动开始时间" toView:self.view];
        return;
    }
    if ([JXAppTool verifyIsNullString:_model.end_time])
    {
        [MBProgressHUD showMessage:@"请选择活动结束时间" toView:self.view];
        return;
    }
    if ([JXAppTool verifyIsNullString:_model.sign_start_time])
    {
        [MBProgressHUD showMessage:@"请选择报名开始时间" toView:self.view];
        return;
    }
    if ([JXAppTool verifyIsNullString:_model.sign_end_time])
    {
        [MBProgressHUD showMessage:@"请选择报名结束时间" toView:self.view];
        return;
    }
    if ([JXAppTool verifyIsNullString:_model.limit_num])
    {
        [MBProgressHUD showMessage:@"请输入报名人数" toView:self.view];
        return;
    }
    if ([JXAppTool verifyIsNullString:_model.province_id] || [JXAppTool verifyIsNullString:_model.city_id] || [JXAppTool verifyIsNullString:_model.district_id])
    {
        [MBProgressHUD showMessage:@"请选择活动地址" toView:self.view];
        return;
    }
    if ([JXAppTool verifyIsNullString:_model.address])
    {
        [MBProgressHUD showMessage:@"请输入详细地址" toView:self.view];
        return;
    }
    if ([JXAppTool verifyIsNullString:_model.intro])
    {
        [MBProgressHUD showMessage:@"请输入活动简介" toView:self.view];
        return;
    }
    if (!_model.img)
    {
        [MBProgressHUD showMessage:@"请选择封面图片" toView:self.view];
        return;
    }
    NSData *imgData = UIImageJPEGRepresentation(_model.img, 0.5);
    NSMutableArray *imgArr = [NSMutableArray array];
    [imgArr addObject:@[@"cover",imgData]];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"publishActivity";
    param[@"title"] = _model.title;
    param[@"zhuzhi_mech"] = _model.zhuzhi_mech;
    param[@"chengban_mech"] = _model.chengban_mech;
    param[@"start_time"] = _model.start_time;
    param[@"end_time"] = _model.end_time;
    param[@"sign_start_time"] = _model.sign_start_time;
    param[@"sign_end_time"] = _model.sign_end_time;
    param[@"cate_id"] = _model.cate_id;
    param[@"limit_num"] = _model.limit_num;
    param[@"province_id"] = _model.province_id;
    param[@"city_id"] = _model.city_id;
    param[@"district_id"] = _model.district_id;
    param[@"address"] = _model.address;
    param[@"intro"] = _model.intro;
    
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithImageURL:SERVICE_URL
                             params:param
                             imgArr:imgArr
                            success:^(id json) {
                                [MBProgressHUD hideHUDForView:self.view];
                                NSString *code = [json objectForKey:@"code"];
                                NSString *msg  = [json objectForKey:@"msg"];
                                if ([code isEqualToString:SUCCESS])
                                {
                                    [MBProgressHUD showMessage:@"发布成功" toView:self.view];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        [self.navigationController popViewControllerAnimated:YES];
                                    });
                                    
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

- (void)showAddressView
{
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:7 inSection:0];
    KHYAnnounceCell *cell = [self.tableView cellForRowAtIndexPath:index];
    AddressPickView *addressPickView = [AddressPickView CreateInstance];
    [self.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *cityIds,NSString *nameStr){
        NSLog(@"%@ %@",cityIds,nameStr);
        //省市区名称
        cell.contentTF.text = nameStr;
        self.model.area = nameStr;

        //值存储
        NSArray *itemArr = [cityIds componentsSeparatedByString:@","];
        self.model.province_id = itemArr[0];
        self.model.city_id = itemArr[1];
        self.model.district_id = itemArr[2];
        self.model.area = nameStr;
        [self.tableView reloadData];
    };
}

#pragma mark - KHYAnnounceCell delegate
- (void)cellTFEditing:(UITextField *)textFiled
{
    
    KHYAnnounceCell *cell = (KHYAnnounceCell *)textFiled.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    switch (index.row) {
        case 1:
        {
            // 活动名称
//            cell.contentTF.text = textFiled.text;
            self.model.title = textFiled.text;
        }
            break;
        case 2:
        {
            // 主办机构
//            cell.contentTF.text = textFiled.text;
            self.model.zhuzhi_mech = textFiled.text;
        }
            break;
        case 3:
        {
            // 承办单位
//            cell.contentTF.text = textFiled.text;
            self.model.chengban_mech = textFiled.text;
        }
            break;
        case 6:
        {
            // 报名人数
//            cell.contentTF.text = textFiled.text;
            self.model.limit_num = textFiled.text;
        }
            break;
        case 8:
        {
            // 详细地址
//            cell.contentTF.text = textFiled.text;
            self.model.address = textFiled.text;
        }
            break;
            
    }
}

// 单元格 第一个时间选择
- (void)firstBtnClick:(UIButton *)button
{
    
    KHYAnnounceCell *cell = (KHYAnnounceCell *)button.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    MHDatePicker *selectDatePicker = [[MHDatePicker alloc] init];
    selectDatePicker.isBeforeTime = NO;
    selectDatePicker.datePickerMode = UIDatePickerModeDate;
    [selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        
            if (index.row == 4) {
                NSString *beginDate = [NSString dateStringWithDate:selectedDate DateFormat:@"yyyyMMdd"];
                NSString *nowDate = [NSString dateStringWithDate:[NSDate date] DateFormat:@"yyyyMMdd"];
                if ([beginDate integerValue] < [nowDate integerValue]) {
                    [MBProgressHUD showMessage:@"活动开始时间不能小于当前时间" toView:self.view];
                    return ;
                }else{
                NSString *beginTime = [NSString dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
                [cell.firstBtn setTitle:beginTime forState:UIControlStateNormal];
                [cell.secondBtn setTitle:@"" forState:UIControlStateNormal];
                self.model.start_time = beginTime;
                self.model.end_time = @"";
                }
            }else{
                NSString *beginDate = [NSString dateStringWithDate:selectedDate DateFormat:@"yyyyMMdd"];
                NSString *nowDate = [NSString dateStringWithDate:[NSDate date] DateFormat:@"yyyyMMdd"];
                if ([beginDate integerValue] < [nowDate integerValue]) {
                    [MBProgressHUD showMessage:@"报名开始时间不能小于当前时间" toView:self.view];
                    return ;
                }else{
                NSString *beginTime = [NSString dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
                [cell.firstBtn setTitle:beginTime forState:UIControlStateNormal];
                [cell.secondBtn setTitle:@"" forState:UIControlStateNormal];
                self.model.sign_start_time = beginTime;
                self.model.sign_end_time = @"";
                }
            }
            
        
    }];
}

// 单元格 第二个时间选择
- (void)secondBtnClick:(UIButton *)button
{
    
    KHYAnnounceCell *cell = (KHYAnnounceCell *)button.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    MHDatePicker *selectDatePicker = [[MHDatePicker alloc] init];
    selectDatePicker.isBeforeTime = NO;
    selectDatePicker.datePickerMode = UIDatePickerModeDate;
    [selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        
            if (index.row == 4) {
                NSString *beginDate = self.model.start_time;
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                [format setDateFormat:@"yyyy-MM-dd"];
                NSDate *beforedate = [format dateFromString:beginDate];
                if ([selectedDate timeIntervalSince1970] < [beforedate timeIntervalSince1970]) {
                    [MBProgressHUD showMessage:@"活动结束时间不能小于活动开始时间" toView:self.view];
                    return ;
                }else{
                NSString *beginTime = [NSString dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
                [cell.secondBtn setTitle:beginTime forState:UIControlStateNormal];
                self.model.end_time = beginTime;
                }
            }else{
                NSString *beginDate = self.model.sign_start_time;
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                [format setDateFormat:@"yyyy-MM-dd"];
                NSDate *beforedate = [format dateFromString:beginDate];
                if ([selectedDate timeIntervalSince1970] < [beforedate timeIntervalSince1970]) {
                    [MBProgressHUD showMessage:@"报名结束时间不能小于报名开始时间" toView:self.view];
                    return ;
                }else{
                NSString *beginTime = [NSString dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
                [cell.secondBtn setTitle:beginTime forState:UIControlStateNormal];
                self.model.sign_end_time = beginTime;
                }
            }
            
        
    }];
}

// 活动简介
- (void)textViewDidEditing:(UITextView *)textView
{
    
//    KHYAnnounceCell *cell = (KHYAnnounceCell *)textView.superview.superview;
//    cell.textView.text = textView.text;
    self.model.intro = textView.text;
}

/**
 筛选列表
 */
- (void)showActivityView
{
    
    [UIView animateWithDuration:0.03 animations:^{
        self.controlView.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.filterView.transform = CGAffineTransformMakeTranslation(0, -220-HOME_INDICATOR_HEIGHT);
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
    self.model.cate_name = self.buttonTitleArr[button.tag];
    NSDictionary *dic = self.btnArr[button.tag];
    self.model.cate_id = dic[@"cate_id"];
    [self dismissControlViewAndUpperView];
    [self.tableView reloadData];
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
// tap手势添加图片
- (void)addImage
{
    
    [self headBtnClick];
}
- (void)headBtnClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self photoAlbum];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - 去相册选择图片
- (void)photoAlbum
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.navigationBar.tintColor = [UIColor blackColor];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:2];
        KHYAnnounceCell *cell1 = [self.tableView cellForRowAtIndexPath:indexPath];
        cell1.activityImage.image = [self cutImage:image];
        self.model.img = [self cutImage:image];
        
    }];
}
- (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < 1)
    {
        newSize.width = image.size.width;
        newSize.height = image.size.width * 1;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    }
    else
    {
        newSize.height = image.size.height;
        newSize.width = image.size.height * 1;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}
// 拍照
- (void)takePhoto
{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备不支持拍照功能" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}
- (UIControl *)controlView
{
    if (!_controlView)
    {
        _controlView = [[UIControl alloc] init];
        _controlView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
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
        _filterView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 220);
        _filterView.backgroundColor = BACK_COLOR;
        
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
            activityBtn.frame = CGRectMake(15 + (buttonWidth +15)*(i%4), 15 + (buttonHeight + 20) * (i/4), buttonWidth, buttonHeight);
            activityBtn.tag = i;
            [_filterView addSubview:activityBtn];
            [self.buttonArr addObject:activityBtn];
        }
    }
    return _filterView;
}


- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
}



@end
