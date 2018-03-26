//
//  KHYHomeTopView.m
//  kehuiyan
//
//  Created by 相约在冬季 on 2018/2/10.
//  Copyright © 2018年 印特. All rights reserved.
//

#import "KHYHomeTopView.h"

@implementation KHYHomeTopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        //设置背景色
        self.backgroundColor = MAIN_COLOR;
        
        //创建“头像”
        NSString *imgURL = [HelperManager CreateInstance].avatar;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-70)/2, 15, 70, 70)];
        [imgView setContentMode:UIViewContentModeScaleAspectFill];
        [imgView setClipsToBounds:YES];
        [imgView.layer setCornerRadius:35];
        [imgView.layer setMasksToBounds:YES];
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
        [self addSubview:imgView];
        
        //创建“名称”
        UILabel *lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, frame.size.width-20, 20)];
        [lbMsg setText:[HelperManager CreateInstance].realname];
        [lbMsg setTextColor:[UIColor whiteColor]];
        [lbMsg setTextAlignment:NSTextAlignmentCenter];
        [lbMsg setFont:FONT17];
        [self addSubview:lbMsg];
        
        //创建“部门-角色”
        UILabel *lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, frame.size.width-20, 30)];
        [lbMsg2 setText:[HelperManager CreateInstance].org_departmentName];
        [lbMsg2 setTextColor:[UIColor whiteColor]];
        [lbMsg2 setTextAlignment:NSTextAlignmentCenter];
        [lbMsg2 setFont:FONT14];
        [self addSubview:lbMsg2];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
