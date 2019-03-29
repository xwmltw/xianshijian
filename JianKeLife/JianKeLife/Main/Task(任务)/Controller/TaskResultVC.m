//
//  TaskResultVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/28.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "TaskResultVC.h"

@interface TaskResultVC ()

@end

@implementation TaskResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    self.title = @"返佣审核结果";
    
}
- (void)creatUI{
    if (self.resultModel.prodTradeAuditStatus.integerValue != 3) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(10);
            make.right.mas_equalTo(self.view).offset(-10);
            make.top.mas_equalTo(self.view).offset(10);
            make.height.mas_equalTo(AdaptationWidth(320));
        }];
        
        UIImageView *bhimageView = [[UIImageView alloc]init];
        bhimageView.image = [UIImage imageNamed:@"image_failed"];
        
        [view addSubview:bhimageView];
        [bhimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view);
            make.top.mas_equalTo(view).offset(AdaptationWidth(20));
            make.width.mas_equalTo(AdaptationWidth(200));
            make.height.mas_equalTo(AdaptationWidth(238));
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = LabelAssistantColor;
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.top.mas_equalTo(view).offset(AdaptationWidth(16));
            make.height.mas_equalTo(AdaptationWidth(1));
        }];
        
        UILabel *timeLab = [[UILabel alloc]init];
        [timeLab setText:[NSString stringWithFormat:@"提交时间 %@",self.resultModel.prodTradeFinishTime]];
        [timeLab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
        [timeLab setTextColor:LabelAssistantColor];
        [view addSubview:timeLab];
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
            make.top.mas_equalTo(line.mas_bottom).offset(AdaptationWidth(9));
        }];
    }
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.view).offset(10);
        make.height.mas_equalTo(AdaptationWidth(410));
    }];
    
    UIImageView *bhimageView = [[UIImageView alloc]init];
    bhimageView.image = [UIImage imageNamed:@"image_pass"];
    
    [view addSubview:bhimageView];
    [bhimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(view).offset(AdaptationWidth(20));
        make.width.mas_equalTo(AdaptationWidth(200));
        make.height.mas_equalTo(AdaptationWidth(238));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = LabelAssistantColor;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(view).offset(AdaptationWidth(16));
        make.height.mas_equalTo(AdaptationWidth(1));
    }];
    
    UILabel *timeLab = [[UILabel alloc]init];
    [timeLab setText:[NSString stringWithFormat:@"提交时间 %@",self.resultModel.prodTradeFinishTime]];
    [timeLab setFont:[UIFont systemFontOfSize:AdaptationWidth(14)]];
    [timeLab setTextColor:LabelAssistantColor];
    [view addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
        make.top.mas_equalTo(line.mas_bottom).offset(AdaptationWidth(9));
    }];
    
    UILabel *notiLab = [[UILabel alloc]init];
    [notiLab setText:[NSString stringWithFormat:@"未通过理由"]];
    [notiLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [notiLab setTextColor:LabelMainColor];
    [view addSubview:notiLab];
    [notiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(16));
        make.top.mas_equalTo(timeLab.mas_bottom).offset(AdaptationWidth(8));
    }];
    
    UILabel *detailLab = [[UILabel alloc]init];
    detailLab.numberOfLines = 0;
    [detailLab setText:self.resultModel.prodTradeAuditRemark];
    [detailLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [detailLab setTextColor:LabelMainColor];
    [view addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).offset(AdaptationWidth(16));
        make.right.mas_equalTo(view).offset(AdaptationWidth(-16));
        make.top.mas_equalTo(notiLab.mas_bottom).offset(AdaptationWidth(9));
        make.bottom.mas_equalTo(view).offset(AdaptationWidth(9));
    }];
    
    
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
