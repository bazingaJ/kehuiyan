//
//  KHYAskRecordViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/11.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYAskRecordViewController.h"
#import "KHYPatientModel.h"

static NSString *const sickAnalyse = @"病情分析：";

@interface KHYAskRecordViewController ()
@property (nonatomic, strong) KHYPatientModel *model;
@end

@implementation KHYAskRecordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
    self.model = [KHYPatientModel new];
    self.model.descriptionString = @"我胸口正凹处曾七八年前时不时有秒秒钟的不舒服，这种感觉我说不出，不是刺激痛，最近两个月了！每次这样子的不舒服持续时间长，并且次数也频繁了！经过县医院检查B超，胸片，心电图都没有问题，想问问医生到底怎么回事?谢谢";
    self.model.gender = @"2";
    self.model.age = @"44";
    self.model.askDate = @"2018-03-23";
    self.model.answerString = @"您好，根据您所描述的情况，胸口处疼痛经过检查化验没有问题，考虑是否是神经性的。\n指导意见：\n根据你所描述的这种情况，建议注意休息，避免劳累，可以进一步到医院胸外科检查一下。\n以上是对“我胸口正凹处曾七八年前时不时有秒秒钟的不舒服”这个问题的建议，希望对您有帮助，祝您健康！";
    self.model.answerTime = @"2018-03-23";
    
    [self createUI];
    
}

/**
 创建上部的提问视图
 */
- (void)createUI
{
    self.view.backgroundColor = BACK_COLOR;
    UIView *askView = [UIView new];
        askView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:askView];
    
    // 患者病情描述
    UILabel *descripLab = [[UILabel alloc] init];
    descripLab.textColor = COLOR3;
    descripLab.font = FONT15;
    descripLab.numberOfLines = 0;
    // 设置富文本的段落格式
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:_model.descriptionString];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    paragraphStyle.firstLineHeadIndent = 20.0f;//首行缩进
    [attr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, _model.descriptionString.length)];
    descripLab.attributedText = attr;
    [askView addSubview:descripLab];
    [descripLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.view).offset(12);
        make.right.mas_equalTo(self.view).offset(-12);
    }];
    
    // 根据子视图的空间高度 来进行父视图的约束添加
    [askView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(descripLab.mas_bottom).offset(35);;
    }];
    
    // 基本信息label sex | 44岁    2018-03-23
    NSString *genderString = [_model.gender isEqualToString:@"1"] ? @"男" : @"女";
    UILabel *baseInfoLab = [[UILabel alloc] init];
    baseInfoLab.text = [NSString stringWithFormat:@"%@ | %@岁      %@",genderString,_model.age,_model.askDate];
    baseInfoLab.textColor = COLOR6;
    baseInfoLab.font = FONT14;
    [askView addSubview:baseInfoLab];
    [baseInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(descripLab);
        make.top.mas_equalTo(descripLab.mas_bottom).offset(10);
        make.right.mas_equalTo(askView).offset(-12);
        make.height.mas_equalTo(20);
    }];
    
    // 底部回答问题的视图
    UIView *answerView = [UIView new];
    answerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:answerView];
    
    // "答" 小图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"answer"];
    [answerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(15);
        make.left.top.mas_equalTo(answerView).offset(12);
    }];
    
    // 病情分析
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = sickAnalyse;
    titleLab.textColor = COLOR6;
    titleLab.font = FONT15;
    [answerView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(5);
        make.top.mas_equalTo(imageView);
    }];
    
    // 专家回答提问
    UILabel *answerLab = [[UILabel alloc] init];
    answerLab.textColor = COLOR6;
    answerLab.font = FONT14;
    answerLab.numberOfLines = 0;
    // 设置富文本的段落格式
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:_model.answerString];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 10;// 字体的行间距
    paragraph.firstLineHeadIndent = 20.0f;//首行缩进
    [attributeStr addAttribute:NSParagraphStyleAttributeName
                 value:paragraph
                 range:NSMakeRange(0, _model.answerString.length)];
    answerLab.attributedText = attributeStr;
    [answerView addSubview:answerLab];
    [answerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(answerView).offset(12);
        make.top.mas_equalTo(answerView).offset(35);
        make.right.mas_equalTo(answerView).offset(-12);
    }];
    
    // 根据子视图的空间高度 来进行父视图的约束添加
    [answerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(askView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(answerLab.mas_bottom).offset(35);
    }];
    
    // 回答时间 2018-03-23
    UILabel *answerTimeLab = [[UILabel alloc] init];
    answerTimeLab.text = _model.answerTime;
    answerTimeLab.textColor = COLOR6;
    answerTimeLab.font = FONT14;
    answerTimeLab.textAlignment = NSTextAlignmentRight;
    [answerView addSubview:answerTimeLab];
    [answerTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(answerLab.mas_bottom).offset(10);
        make.right.mas_equalTo(answerView).offset(-12);
        make.height.mas_equalTo(20);
    }];
    
    
    
}




- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
