//
//  KHYMineInfoViewController.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/24.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYMineInfoViewController.h"
#import "KHYMineInfoCell.h"
#import "KHYBirthdayDatePickerView.h"
#import "AddressPickView.h"

@interface KHYMineInfoViewController ()<UITableViewDelegate,
                                        UITableViewDataSource,
                                        UIImagePickerControllerDelegate,
                                        UINavigationControllerDelegate,
                                        YJXSexButtonDelegate,
                                        JXDatePickerValueChange>
@property (nonatomic, strong) NSArray *originTitleArr;
@property (nonatomic, strong) NSMutableArray *originDetailArr;
@property (nonatomic, strong) NSDictionary *dataDict;

@property (nonatomic, strong) NSString *avatarSring;
@property (nonatomic, strong) NSString *realNameStr;
@property (nonatomic, strong) NSString *sexSelectedStr;
@property (nonatomic, strong) NSString *birthStr;
@property (nonatomic, strong) NSString *contactStr;
@property (nonatomic, strong) NSString *emailStr;
@property (nonatomic, strong) NSString *wechatStr;
@property (nonatomic, strong) NSString *province_idStr;
@property (nonatomic, strong) NSString *city_idStr;
@property (nonatomic, strong) NSString *area_idStr;
@property (nonatomic, strong) NSString *locationNameStr;
@property (nonatomic, strong) NSString *addressStr;

@property (nonatomic, strong) KHYBirthdayDatePickerView *datePickerView;
@property (nonatomic, strong) UIControl *coverView;
@end

@implementation KHYMineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    [self initialized];
    [self setupUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}
- (void)initialized
{
    self.originTitleArr = @[@"头像",@"姓名",@"性别",@"出生年月",@"联系方式",@"邮箱",@"微信",@"联系地址",@"",@"部门",@"职务"];
    self.originDetailArr = [NSMutableArray arrayWithArray:@[@"-",@"-",@"-",@"-",@"-",@"-",@"-",@"-",@"-",@"-",@"-"]];
}
- (void)setupUI
{
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.datePickerView];
}
- (void)requestData
{
    NSLog(@"请求数据");
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"getMyInfo" forKey:@"act"];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUD:self.view];
                           NSString *msg = [json objectForKey:@"msg"];
                           NSString *code = [json objectForKey:@"code"];
                           if([code isEqualToString:SUCCESS]) {
                               self.dataDict = [NSDictionary changeType:[json objectForKey:@"data"]];
                               [self handleWithData];
                               [self.tableView reloadData];
                           }else{
                               [MBProgressHUD showError:msg toView:self.view];
                           }
    }
                       failure:^(NSError *error) {
                           NSLog(@"%@",[error description]);
                           [MBProgressHUD hideHUD:self.view];
    }];
}

- (void)handleWithData
{
    // 头像数据
    self.avatarSring = [NSString getRightStringByCurrentString:self.dataDict[@"avatar"]];
    [self.originDetailArr replaceObjectAtIndex:0 withObject:self.avatarSring];
    // 姓名
    self.realNameStr = [NSString getRightStringByCurrentString:self.dataDict[@"realname"]];
    [self.originDetailArr replaceObjectAtIndex:1 withObject:self.realNameStr];
    // 性别
    self.sexSelectedStr = [NSString getRightStringByCurrentString:self.dataDict[@"gender"]];
    [self.originDetailArr replaceObjectAtIndex:2 withObject:self.sexSelectedStr];
    // 出生年月
    self.birthStr = [NSString getRightStringByCurrentString:self.dataDict[@"birthday"]];
    [self.originDetailArr replaceObjectAtIndex:3 withObject:self.birthStr];
    // 联系方式
    self.contactStr = [NSString getRightStringByCurrentString:self.dataDict[@"mobile"]];
    [self.originDetailArr replaceObjectAtIndex:4 withObject:self.contactStr];
    // 邮箱
    self.emailStr = [NSString getRightStringByCurrentString:self.dataDict[@"email"]];
    [self.originDetailArr replaceObjectAtIndex:5 withObject:self.emailStr];
    // 微信
    self.wechatStr = [NSString getRightStringByCurrentString:self.dataDict[@"weixin"]];
    [self.originDetailArr replaceObjectAtIndex:6 withObject:self.wechatStr];
    // 联系地址
    self.province_idStr = [NSString getRightStringByCurrentString:self.dataDict[@"province_id"]];
    self.city_idStr = [NSString getRightStringByCurrentString:self.dataDict[@"city_id"]];
    self.area_idStr = [NSString getRightStringByCurrentString:self.dataDict[@"area_id"]];
    
    self.locationNameStr = [NSString getRightStringByCurrentString:self.dataDict[@"area_name"]];
    [self.originDetailArr replaceObjectAtIndex:7 withObject:self.locationNameStr];
    // 详细地址
    self.addressStr = [NSString getRightStringByCurrentString:self.dataDict[@"address"]];
    [self.originDetailArr replaceObjectAtIndex:8 withObject:self.addressStr];
    // 部门
    [self.originDetailArr replaceObjectAtIndex:9 withObject:self.dataDict[@"department"]];
    // 职务
    [self.originDetailArr replaceObjectAtIndex:10 withObject:self.dataDict[@"position"]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 11;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        return 100;
    }
    return 45.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier1 = @"infoCell1";
    static NSString *cellIdentifier2 = @"infoCell2";
    static NSString *cellIdentifier3 = @"infoCell3";
    KHYMineInfoCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    KHYMineInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
    KHYMineInfoCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
    
    // 头像cell
    if (indexPath.row == 0)
    {
        if (!cell1)
        {
            cell1 = [[[NSBundle mainBundle] loadNibNamed:@"KHYMineInfoCell" owner:nil options:nil]objectAtIndex:0];
            cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        [cell1.avatarImgView sd_setImageWithURL:[NSURL URLWithString:self.originDetailArr[0]] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
        return cell1;
    }
    //性别cell
    else if (indexPath.row == 2)
    {
        if (!cell3)
        {
            cell3 = [[[NSBundle mainBundle] loadNibNamed:@"KHYMineInfoCell" owner:nil options:nil]objectAtIndex:2];
            cell3.accessoryType = UITableViewCellAccessoryNone;
        }
        cell3.delegate = self;
        NSNumber *genderNum = self.originDetailArr[2];
        NSString *sexStr = [NSString stringWithFormat:@"%@",genderNum];
        if ([sexStr isEqualToString:@"1"])
        {
            self.sexSelectedStr = @"1";
            cell3.manSelectedImgView.image = [UIImage imageNamed:@"sex_ selected"];
            cell3.womanSelectedImgView.image = [UIImage imageNamed:@"sex_ unselected"];
        }
        else
        {
            self.sexSelectedStr = @"2";
            cell3.manSelectedImgView.image = [UIImage imageNamed:@"sex_ unselected"];
            cell3.womanSelectedImgView.image = [UIImage imageNamed:@"sex_ selected"];
        }
        return cell3;
    }
    // 出生年月 || 联系地址
    else if (indexPath.row == 3 || indexPath.row == 7)
    {
        if (!cell2)
        {
            cell2 = [[[NSBundle mainBundle] loadNibNamed:@"KHYMineInfoCell" owner:nil options:nil]objectAtIndex:1];
        }
        cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell2.labelTrailWidth.constant = 0;
        cell2.titleLab.text = self.originTitleArr[indexPath.row];
        cell2.infoTF.enabled = NO;
        cell2.infoTF.text = self.originDetailArr[indexPath.row];
        return cell2;
    }
    else
    {
        if (!cell2)
        {
            cell2 = [[[NSBundle mainBundle] loadNibNamed:@"KHYMineInfoCell" owner:nil options:nil]objectAtIndex:1];
        }
        cell2.accessoryType = UITableViewCellAccessoryNone;
        cell2.delegate = self;
        cell2.labelTrailWidth.constant = 20;
        cell2.titleLab.text = self.originTitleArr[indexPath.row];
        cell2.infoTF.enabled = YES;
        cell2.infoTF.text = self.originDetailArr[indexPath.row];
        if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 9 || indexPath.row == 10)
        {
            cell2.infoTF.enabled = NO;
        }
        return cell2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001f;
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
    // 更换头像
    if (indexPath.row == 0)
    {
        [self headBtnClick];
    }
    if (indexPath.row == 3)
    {
        [UIView animateWithDuration:0.03f animations:^{
            self.coverView.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
        }];
        [UIView animateWithDuration:0.3f animations:^{
            self.datePickerView.transform = CGAffineTransformMakeTranslation(0, -300);
        }];
    }
    if (indexPath.row == 7)
    {
        AddressPickView *addressPickView = [AddressPickView CreateInstance];
        [self.view addSubview:addressPickView];
        
        addressPickView.block = ^(NSString *cityIds,NSString *nameStr){
//            NSLog(@"%@ %@",cityIds,nameStr);
            NSArray *itemArr = [cityIds componentsSeparatedByString:@","];
            self.province_idStr = itemArr[0];
            self.city_idStr = itemArr[1];
            self.area_idStr = itemArr[2];
            self.locationNameStr = nameStr;
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
            KHYMineInfoCell *cell1 = [self.tableView cellForRowAtIndexPath:indexPath];
            cell1.infoTF.text = self.locationNameStr;
        };
    }
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
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        KHYMineInfoCell *cell1 = [self.tableView cellForRowAtIndexPath:indexPath];
        cell1.avatarImgView.image = [self cutImage:image];
        
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

- (void)manButtonClick
{
    self.sexSelectedStr = @"1";
    
}

- (void)womanButtonClick
{
    self.sexSelectedStr = @"2";
    
}
- (IBAction)containBtnClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"ucenter" forKey:@"app"];
    [param setValue:@"editBase" forKey:@"act"];

    // 准备图片数据
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    KHYMineInfoCell *cell1 = [self.tableView cellForRowAtIndexPath:indexPath];
    NSData *imgData = UIImageJPEGRepresentation(cell1.avatarImgView.image, 0.5);
    NSMutableArray *imgArr = [NSMutableArray array];
    [imgArr addObject:@[@"avatar",imgData]];
    
//    [param setValue:@"姓名" forKey:@"realname"]; 不允许更改
    [param setValue:self.sexSelectedStr forKey:@"sex"];
    [param setValue:self.birthStr forKey:@"birthday"];
//    [param setValue:@"联系方式" forKey:@""];   不允许更改
    [param setValue:self.emailStr forKey:@"email"];
    [param setValue:self.wechatStr forKey:@"weixin"];
    [param setValue:self.province_idStr forKey:@"province_id"];
    [param setValue:self.city_idStr forKey:@"city_id"];
    [param setValue:self.area_idStr forKey:@"area_id"];
    [param setValue:self.addressStr forKey:@"address"];
    [MBProgressHUD showMsg:@"保存中" toView:self.view];
    [HttpRequestEx postWithImageURL:SERVICE_URL
                             params:param
                             imgArr:imgArr
                            success:^(id json) {
                                NSString *msg = [json objectForKey:@"msg"];
                                NSString *code = [json objectForKey:@"code"];
                                if([code isEqualToString:SUCCESS]) {
                                    [MBProgressHUD hideHUDForView:self.view];
                                    [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
                                    self.dataDict = [NSDictionary changeType:[json objectForKey:@"data"]];
                                    [self handleWithData];
                                    [self.tableView reloadData];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        [self.navigationController popViewControllerAnimated:YES];
                                    });
                                    
                                }else{
                                    [MBProgressHUD showError:msg toView:self.view];              
                                }
                            }
                            failure:^(NSError *error) {
                                NSLog(@"%@",[error description]);
                                [MBProgressHUD hideHUD:self.view];
                            }];
    
    
    
}

- (void)textAfterEditingWithString:(NSString *)string textFiled:(UITextField *)textFiled
{
    // 找到对应的cell 根据cell映射出对应的indexpath 可以判断是 功能模块
    KHYMineInfoCell *cell = (KHYMineInfoCell *)textFiled.superview.superview;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    if (index.row == 5)
    {
        self.emailStr = string;
    }
    if (index.row == 6)
    {
        self.wechatStr = string;
    }
    if (index.row == 8)
    {
        self.addressStr = string;
    }
    
}


- (void)containBtnClickWithDateString:(NSString *)dateStr
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    KHYMineInfoCell *cell3 = [self.tableView cellForRowAtIndexPath:indexPath];
    cell3.infoTF.text = dateStr;
    self.birthStr = dateStr;
    [self coverViewMiss];
}

- (void)cancelBtnClick
{
    [self coverViewMiss];
}

- (void)coverViewMiss
{
    [UIView animateWithDuration:0.03f animations:^{
        self.coverView.transform = CGAffineTransformIdentity;
    }];
    [UIView animateWithDuration:0.3f animations:^{
        self.datePickerView.transform = CGAffineTransformIdentity;
    }];
}
- (KHYBirthdayDatePickerView *)datePickerView
{
    if (!_datePickerView)
    {
        _datePickerView = [[[NSBundle mainBundle]loadNibNamed:@"KHYBirthdayDatePickerView" owner:nil options:nil]objectAtIndex:0];
        _datePickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 300);
        _datePickerView.delegate = self;
        
    }
    return _datePickerView;
}

- (UIControl *)coverView
{
    if (!_coverView)
    {
        _coverView = [[UIControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = .3f;
        [_coverView addTarget:self action:@selector(coverViewMiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
