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
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-70)/2, 15, 70, 70)];
        [self.imgView setContentMode:UIViewContentModeScaleAspectFill];
        [self.imgView setClipsToBounds:YES];
        [self.imgView.layer setCornerRadius:35];
        [self.imgView.layer setMasksToBounds:YES];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_img_round_list"]];
        [self addSubview:self.imgView];
        
        //创建“名称”
        self.lbMsg = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, frame.size.width-20, 20)];
        [self.lbMsg setText:[HelperManager CreateInstance].realname];
        [self.lbMsg setTextColor:[UIColor whiteColor]];
        [self.lbMsg setTextAlignment:NSTextAlignmentCenter];
        [self.lbMsg setFont:FONT17];
        [self addSubview:self.lbMsg];
        
        //创建“部门-角色”
        self.lbMsg2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, frame.size.width-20, 30)];
        [self.lbMsg2 setText:[HelperManager CreateInstance].org_departmentName];
        [self.lbMsg2 setTextColor:[UIColor whiteColor]];
        [self.lbMsg2 setTextAlignment:NSTextAlignmentCenter];
        [self.lbMsg2 setFont:FONT14];
        [self addSubview:self.lbMsg2];
        
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
