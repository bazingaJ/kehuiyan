//
//  KHYAnswerDetailVC.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/17.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYAnswerDetailVC.h"
#import "KHYComboViewController.h"
#import "KHYQuestionListViewController.h"

static NSString *const currentTitle = @"回答提问";

@interface KHYAnswerDetailVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *plusBtnClick;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *holderLab;
@property (nonatomic, strong) UIView *comboView;
@end

@implementation KHYAnswerDetailVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = currentTitle;
    self.plusBtnClick.selected = NO;
    
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    if (self.model)
    {
        [self createComboView];
        self.plusBtnClick.selected = YES;
        [UIView animateWithDuration:0.75f animations:^{
            CGRect rect = self.comboView.frame;
            rect.origin.x = 0;
            self.comboView.frame = rect;
        }];
    }
    
}

- (void)createUI
{
    
    self.view.backgroundColor = BACK_COLOR;
    self.textView.delegate = self;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    if ([textView.text isEqualToString:@""])
    {
        self.holderLab.hidden = NO;
    }
    else
    {
        self.holderLab.hidden = YES;
    }
}

- (IBAction)plusBtnClick:(UIButton *)sender {
    
    if (!sender.isSelected)
    {
        KHYComboViewController *vc = [[KHYComboViewController alloc] init];
        vc.isAnswer = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [UIView animateWithDuration:0.75f animations:^{
            self.plusBtnClick.selected = NO;
            for (UIView *view in self.comboView.subviews) {
                [view removeFromSuperview];
            }
            CGRect rect = self.comboView.frame;
            rect.size.height = 0;
            self.comboView.frame = rect;
        } completion:^(BOOL finished) {
            self.comboView = nil;
        }];
    }
    
}

- (void)createComboView
{
    
    self.comboView = [UIView new];
    self.comboView.frame = CGRectMake(SCREEN_WIDTH, CGRectGetMaxY(self.bottomView.frame)+2, SCREEN_WIDTH, 80);
    self.comboView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.comboView];
    
    UIImageView *img = [[UIImageView alloc] init];
    img.frame = CGRectMake(10, 10, 60, 60);
    img.layer.masksToBounds = YES;
    img.layer.cornerRadius = 5;
    [img sd_setImageWithURL:[NSURL URLWithString:self.model.cover_url] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
    [self.comboView addSubview:img];
    
    UILabel *titleLab = [UILabel new];
    titleLab.frame = CGRectMake(80, 10, SCREEN_WIDTH - 100, 18);
    titleLab.text = self.model.name;
    titleLab.font = FONT15;
    titleLab.textColor = COLOR3;
    [self.comboView addSubview:titleLab];
    
    NSString *detail = @"";
    for (int i =0; i <self.model.product_list.count; i++)
    {
        NSDictionary *dict = self.model.product_list[i];
        NSString *name = [NSString stringWithFormat:@"%@\n",dict[@"name"]];
        detail = [detail stringByAppendingString:name];
        
    }
    UILabel *detailLab = [UILabel new];
    detailLab.frame = CGRectMake(80, 30, SCREEN_WIDTH - 100, 50);
    detailLab.text = detail;
    detailLab.font = FONT13;
    detailLab.textColor = COLOR6;
    [self.comboView addSubview:detailLab];
    
    
    
}

- (IBAction)commitBtnClick:(UIButton *)sender {
    
    if ([self.textView.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入回复" toView:self.view];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"app"] = @"home";
    param[@"act"] = @"answerQuestion";
    param[@"question_id"] = _question_id;
    param[@"content"] = self.textView.text;
    param[@"package_num"] = _model.package_num;
    [MBProgressHUD showSimple:self.view];
    [HttpRequestEx postWithURL:SERVICE_URL
                        params:param
                       success:^(id json) {
                           [MBProgressHUD hideHUDForView:self.view];
                           NSString *code = [json objectForKey:@"code"];
                           NSString *msg  = [json objectForKey:@"msg"];
                           if ([code isEqualToString:SUCCESS])
                           {
                               [MBProgressHUD showMessage:@"回复成功" toView:self.view];
                               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                   NSArray *array = self.navigationController.viewControllers;
                                   KHYQuestionListViewController *first = [array objectAtIndex:array.count - 2];
                                   [self.navigationController popToViewController:first animated:YES];
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
