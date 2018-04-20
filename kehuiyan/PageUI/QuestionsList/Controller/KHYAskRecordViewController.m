//
//  KHYAskRecordViewController.m
//  kehuiyan
//
//  Created by yunduopu-ios-2 on 2018/4/11.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYAskRecordViewController.h"
#import "KHYPatientModel.h"
#import "KHYAnswerDetailVC.h"

static NSString *const sickAnalyse = @"病情分析：";

@interface KHYAskRecordViewController ()<MWPhotoBrowserDelegate>
@property (nonatomic, strong) NSString *selectImgIndex;
@property (nonatomic, strong) NSMutableArray *photos;
@end

@implementation KHYAskRecordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self prepareForData];
    [self createUI];
    
}
// 数据准备
- (void)prepareForData
{
    
    self.photos = [NSMutableArray array];
    
    for (int i = 0; i <_model.img_list.count; i++) {
        // Add photos
        [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:_model.img_list[i]]]];
    }
    
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
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:_model.ask_content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    paragraphStyle.firstLineHeadIndent = 20.0f;//首行缩进
    [attr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, _model.ask_content.length)];
    descripLab.attributedText = attr;
    [askView addSubview:descripLab];
    [descripLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.view).offset(12);
        make.right.mas_equalTo(self.view).offset(-12);
    }];
    
    
    CGFloat maxY = CGRectGetMaxY(descripLab.frame);
    CGFloat space = (SCREEN_WIDTH - 300) / 4;
    UIImageView *last = nil;   //上一个按钮
    if (_model.img_list.count > 0) {
        for (int i = 0; i < _model.img_list.count; i ++)
        {
            UIImageView *img = [[UIImageView alloc] init];
            img.userInteractionEnabled = YES;
            [img sd_setImageWithURL:[NSURL URLWithString:_model.img_list[i]] placeholderImage:nil];
            
            [askView addSubview:img];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapClick:)];
            
            [img addGestureRecognizer:tap];
            
            
            //布局
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                //宽高是固定的，前面已经算好了
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(100);
                make.top.mas_equalTo(descripLab.mas_bottom).mas_offset(10 + (i/3)*(100+10));
                
                if (!last || (i%3) == 0) {
                    //last为nil  或者(i%col) == 0 说明换行了 每行的第一个确定它距离左边边缘的距离
                    make.left.mas_offset(space);
                }else{
                    //第二个或者后面的按钮 距离前一个按钮右边的距离都是gap个单位
                    make.left.mas_equalTo(last.mas_right).mas_offset(space);
                }
            }];
            last = img;

            if (_model.img_list.count == i +1)
            {
                maxY = CGRectGetMaxY(img.frame);
            }
        }
    }
    
    // 根据子视图的空间高度 来进行父视图的约束添加
    [askView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        if (_model.img_list.count > 0) {
            make.bottom.mas_equalTo(last.mas_bottom).offset(35);
        }else{
            make.bottom.mas_equalTo(descripLab.mas_bottom).offset(35);
        }
    }];
    
    // 基本信息label sex | 44岁    2018-03-23
    NSString *genderString = [_model.sex isEqualToString:@"1"] ? @"男" : @"女";
    UILabel *baseInfoLab = [[UILabel alloc] init];
    baseInfoLab.text = [NSString stringWithFormat:@"%@ | %@岁      %@",genderString,_model.age,_model.ask_date];
    baseInfoLab.textColor = COLOR6;
    baseInfoLab.font = FONT14;
    [askView addSubview:baseInfoLab];
    [baseInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_model.img_list.count > 0) {
            make.left.mas_equalTo(last);
            make.top.mas_equalTo(last.mas_bottom).offset(10);
        }else{
            make.left.mas_equalTo(descripLab);
            make.top.mas_equalTo(descripLab.mas_bottom).offset(10);
        }
        make.right.mas_equalTo(askView).offset(-12);
        make.height.mas_equalTo(20);
    }];
    
    if ([_model.status isEqualToString:@"1"])
    {
        if ([self.isPatient isEqualToString:@"1"]) {
            return;
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"回答" forState:UIControlStateNormal];
        [btn setBackgroundColor:BLUE_COLOR];
        [btn addTarget:self action:@selector(answerQuestion) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.view);
            make.height.mas_equalTo(45);
        }];
        return;
    }
    else if ([_model.status isEqualToString:@"2"]||[_model.status isEqualToString:@"3"])
    {
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
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:_model.reply_content];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 10;// 字体的行间距
        paragraph.firstLineHeadIndent = 20.0f;//首行缩进
        [attributeStr addAttribute:NSParagraphStyleAttributeName
                             value:paragraph
                             range:NSMakeRange(0, _model.reply_content.length)];
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
        answerTimeLab.text = _model.reply_date;
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
    
}

// 去回答问题
- (void)answerQuestion
{
    
    KHYAnswerDetailVC *vc = [[KHYAnswerDetailVC alloc] init];
    vc.question_id = _model.question_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)imgTapClick:(UIGestureRecognizer *)recognizer
{
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.zoomPhotosToFill = YES;
    browser.alwaysShowControls = NO;
    [browser setCurrentPhotoIndex:0];
    [self.navigationController pushViewController:browser animated:YES];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count) {
        return _photos[index];
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



@end
