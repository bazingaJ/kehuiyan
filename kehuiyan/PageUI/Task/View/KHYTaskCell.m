//
//  KHYTaskCell.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYTaskCell.h"

@implementation KHYTaskCell

- (void)setTaskModel:(KHYTaskModel *)model {
    if(!model) return;
    
    //设置数据源
    NSMutableArray *titleArr = [NSMutableArray array];
    [titleArr addObject:@[@"task_icon_type",@"任务类型"]];
    [titleArr addObject:@[@"task_icon_cycle",@"任务周期"]];
    [titleArr addObject:@[@"task_icon_time",@"时间"]];
    [titleArr addObject:@[@"task_icon_ren",@"任务参与人"]];
    [titleArr addObject:@[@"task_icon_matter",@"任务创建人"]];
    
    for (int i=0; i<5; i++) {
        NSArray *itemArr = [titleArr objectAtIndex:i];
        
        //创建“图标”
        UIImage *img = [UIImage imageNamed:itemArr[0]];
        CGFloat tW = img.size.width;
        CGFloat tH = img.size.height;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10+25*i+(25-tH)/2, tW, tH)];
        [imgView setImage:img];
        [self.contentView addSubview:imgView];
        
        //创建“标题”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(35, 10+25*i, SCREEN_WIDTH-105, 25)];
        [lbMsg setTextColor:COLOR3];
        [lbMsg setTextAlignment:NSTextAlignmentLeft];
        [lbMsg setFont:FONT15];
        [self.contentView addSubview:lbMsg];
        
        NSString *titleStr = itemArr[1];
        switch (i) {
            case 0: {
                //任务类型
                titleStr = [NSString stringWithFormat:@"%@：%@",itemArr[1],model.task_type_text];
                break;
            }
            case 1: {
                //任务周期
                titleStr = [NSString stringWithFormat:@"%@：%@",itemArr[1],model.task_cycle_text];
                break;
            }
            case 2: {
                //时间
                titleStr = [NSString stringWithFormat:@"%@：%@至%@",itemArr[1],model.start_date,model.end_date];
                break;
            }
            case 3: {
                //任务参与人
                titleStr = [NSString stringWithFormat:@"%@：%@",itemArr[1],model.takeIner_name];
                break;
            }
            case 4: {
                //事项
                titleStr = [NSString stringWithFormat:@"%@：%@",itemArr[1],model.user_name];
                break;
            }
                
            default:
                break;
        }
        [lbMsg setText:titleStr];
        
    }
    //创建“任务状态”
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-69, 0, 69, 69)];
    NSLog(@"---%@",model.status_text);
    [self.contentView addSubview:imgView];
    if (model.status == 1)
    {
        // 待完成
        [imgView setImage:[UIImage imageNamed:@"task_icon_wait"]];
    }
    else if (model.status == 2)
    {
        // 按时完成
        [imgView setImage:[UIImage imageNamed:@"task_icon_ontime"]];
    }
    else if (model.status == 3)
    {
        // 逾期完成
        [imgView setImage:[UIImage imageNamed:@"task_icon_overcomplete"]];
    }
    else if (model.status == 4)
    {
        // 已过期
        [imgView setImage:[UIImage imageNamed:@"task_icon_overtime"]];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
