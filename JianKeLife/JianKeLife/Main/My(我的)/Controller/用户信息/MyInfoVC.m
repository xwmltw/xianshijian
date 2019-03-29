//
//  MyInfoVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/25.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "MyInfoVC.h"
#import "EMSettingActionSheet.h"
#import "FSMediaPicker.h"
#import "MyInfoModel.h"

@interface MyInfoVC ()<EMSettingActionSheetDelegate, FSMediaPickerDelegate>
{
    UIButton *goDetailBtn,*manBtn,*womanbtn,*dateBtn;
    UITextField *userName;
}
@property (nonatomic ,strong) UIDatePicker *datePicker;
@property (nonatomic ,strong) UIView *datePickerView;
@property (nonatomic, strong) EMSettingActionSheet *actionSheet;
@property (nonatomic ,strong) MyInfoModel *infoModel;
@end

@implementation MyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    [self creatUI];
    
    BLOCKSELF
    [XNetWork requestNetWorkWithUrl:Xget_base_info andModel:nil andSuccessBlock:^(ResponseModel *model) {
        blockSelf.infoModel = [MyInfoModel mj_objectWithKeyValues:model.data];
        [blockSelf updateUI:blockSelf.infoModel];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
    
}
- (void)creatUI{
    goDetailBtn = [[UIButton alloc]init];
    goDetailBtn.tag = 4011;
    [goDetailBtn setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    [goDetailBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goDetailBtn];
    [goDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(AdaptationWidth(15));
        make.centerX.mas_equalTo(self.view);
        make.width.height.mas_equalTo(AdaptationWidth(72));
    }];
    
    UILabel *walletLab = [[UILabel alloc]init];
    [walletLab setText:@"更换头像"];
    [walletLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [walletLab setTextColor:LabelMainColor];
    [self.view addSubview:walletLab];
    [walletLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->goDetailBtn.mas_bottom).offset(AdaptationWidth(8));
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *nameLab = [[UILabel alloc]init];
    [nameLab setText:@"姓名"];
    [nameLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [nameLab setTextColor:LabelMainColor];
    [self.view addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(walletLab.mas_bottom).offset(AdaptationWidth(16));
        make.left.mas_equalTo(self.view).offset(16);
    }];
    
    userName = [[UITextField alloc]init];
    userName.backgroundColor = [UIColor whiteColor];
    userName.borderStyle = UITextBorderStyleNone;
    userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入真实姓名" attributes:@{NSForegroundColorAttributeName:LabelAssistantColor}];
    userName.font = [UIFont systemFontOfSize:AdaptationWidth(16)];
    //    [oldPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    userName.keyboardType = UIKeyboardTypeDefault;
    [userName setTextColor:LabelMainColor];
    [self.view addSubview:userName];

    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.top.mas_equalTo(nameLab.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = LineColor;
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.top.mas_equalTo(self->userName.mas_bottom).offset(2);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *sexLab = [[UILabel alloc]init];
    [sexLab setText:@"性别"];
    [sexLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [sexLab setTextColor:LabelMainColor];
    [self.view addSubview:sexLab];
    [sexLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(AdaptationWidth(16));
        make.left.mas_equalTo(self.view).offset(AdaptationWidth(16));
    }];
    
    manBtn = [[UIButton alloc]init];
    manBtn.tag = 4012;
    [manBtn setImage:[UIImage imageNamed:@"icon_unseleted"] forState:UIControlStateNormal];
    [manBtn setImage:[UIImage imageNamed:@"icon_seleted_male"] forState:UIControlStateSelected];
    [manBtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
    [manBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [manBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [manBtn setTitle:@"先生" forState:UIControlStateNormal];

//    manBtn.titleEdgeInsets = UIEdgeInsetsMake(0, AdaptationWidth(20), 0,  0);
    [self.view addSubview:manBtn];
    [manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sexLab.mas_bottom).offset(AdaptationWidth(13));
        make.left.mas_equalTo(self.view).offset(AdaptationWidth(16));
        make.height.mas_equalTo(AdaptationWidth(20));
    }];
    
    womanbtn = [[UIButton alloc]init];
    womanbtn.tag = 4013;
    [womanbtn setTitle:@"女士" forState:UIControlStateNormal];
    [womanbtn setImage:[UIImage imageNamed:@"icon_unseleted"] forState:UIControlStateNormal];
    [womanbtn setImage:[UIImage imageNamed:@"icon_seleted_female"] forState:UIControlStateSelected];
    [womanbtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
    [womanbtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [womanbtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
//    womanbtn.titleEdgeInsets = UIEdgeInsetsMake(0, AdaptationWidth(20), 0,  0);
    [self.view addSubview:womanbtn];
    [womanbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sexLab.mas_bottom).offset(AdaptationWidth(13));
        make.left.mas_equalTo(self->manBtn.mas_right).offset(AdaptationWidth(35));
        make.height.mas_equalTo(AdaptationWidth(20));
    }];
    
    
    
    UILabel *riLab = [[UILabel alloc]init];
    [riLab setText:@"生日"];
    [riLab setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [riLab setTextColor:LabelMainColor];
    [self.view addSubview:riLab];
    [riLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->manBtn.mas_bottom).offset(AdaptationWidth(30));
        make.left.mas_equalTo(self.view).offset(AdaptationWidth(16));
    }];
    
    dateBtn = [[UIButton alloc]init];
    dateBtn.tag = 4014;
    [dateBtn setTitle:@"点击选择" forState:UIControlStateNormal];
    [dateBtn setImage:[UIImage imageNamed:@"icon_userInfo_date"] forState:UIControlStateNormal];
    [dateBtn setTitleColor:LabelAssistantColor forState:UIControlStateNormal];
    [dateBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
    [dateBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
//    dateBtn.titleEdgeInsets = UIEdgeInsetsMake(0, AdaptationWidth(20), 0, 0);
    [self.view addSubview:dateBtn];
    [dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(riLab.mas_bottom).offset(AdaptationWidth(13));
        make.left.mas_equalTo(self.view).offset(AdaptationWidth(16));
        make.height.mas_equalTo(AdaptationWidth(20));
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = LineColor;
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.top.mas_equalTo(self->dateBtn.mas_bottom).offset(2);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *getOutBtn = [[UIButton alloc]init];
    getOutBtn.tag = 4015;
    [getOutBtn setBackgroundColor:blueColor];
    [getOutBtn setCornerValue:4];
    [getOutBtn setTitle:@"保存" forState:UIControlStateNormal];
    [getOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getOutBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(17)]];
    [getOutBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getOutBtn];
    [getOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.bottom.mas_equalTo(self.view).offset(-60);
        make.height.mas_equalTo(44);
    }];
}
- (void)updateUI:(MyInfoModel *)model{
    
    if (model.headLogo.length) {
        [goDetailBtn sd_setImageWithURL:[NSURL URLWithString:model.headLogo] forState:UIControlStateNormal];
    }else{
        [goDetailBtn setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    }
    userName.text = model.trueName;
    [dateBtn setTitle:model.birthDay forState:UIControlStateNormal];
    
    if([model.gender isEqualToString:@"女"]){
        womanbtn.selected = YES;
    }else{
        manBtn.selected = YES;
    }
    
}
- (void)btnOnClock:(UIButton *)btn{
    switch (btn.tag) {
        case 4011:
        {
            [self.actionSheet show];
        }
            break;
        case 4012:
        {
            manBtn.selected = YES;
            womanbtn.selected = NO;
        }
            break;
        case 4013:
        {
            manBtn.selected = NO;
            womanbtn.selected = YES;
        }
            break;
        case 4014:
        {
            
            [self.view addSubview:self.datePickerView];
            [self.datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.mas_equalTo(self.view);
                make.height.mas_equalTo(AdaptationWidth(255));
            }];
            
            [self.datePickerView addSubview:self.datePicker];
            [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.mas_equalTo(self.datePickerView);
                make.height.mas_equalTo(AdaptationWidth(215));
            }];
        
        }
            break;
        case 4015:
        {
            
            if (!userName.text.length) {
                [ProgressHUD showProgressHUDInView:nil withText:@"请填写真实姓名" afterDelay:1];
                return;
            }
            if (!manBtn.isSelected && !womanbtn.isSelected) {
                [ProgressHUD showProgressHUDInView:nil withText:@"请选择性别" afterDelay:1];
                return;
            }
            if (!dateBtn.titleLabel.text.length) {
                [ProgressHUD showProgressHUDInView:nil withText:@"请选择出生日期" afterDelay:1];
                return;
            }
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:userName.text forKey:@"trueName"];
            [dic setObject:manBtn.isSelected ? @"男" :@"女" forKey:@"gender"];
            [dic setObject:dateBtn.titleLabel.text forKey:@"birthday"];
            [XNetWork requestNetWorkWithUrl:Xedit_account_info andModel:dic andSuccessBlock:^(ResponseModel *model) {
                [ProgressHUD showProgressHUDInView:nil withText:@"编辑成功" afterDelay:1];
                [XNotificationCenter postNotificationName:LoginSuccessNotification object:nil];
            } andFailBlock:^(ResponseModel *model) {
                
            }];
        }
            break;
        case 4016:{
            [UIView animateWithDuration:0.3 animations:^{
                self.datePickerView.frame = CGRectMake(0, ScreenHeight , ScreenWidth, 255);
                
            } completion:^(BOOL finished) {
                
                [self.datePickerView removeFromSuperview];
            }];
            
        }
            break;
        default:
            break;
    }
}
- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    [dateBtn setTitle:dateStr forState:UIControlStateNormal];
}
- (UIView *)datePickerView{
    if (!_datePickerView) {
        _datePickerView = [[UIView alloc]init];
        _datePickerView.backgroundColor = XColorWithRGB(247, 247, 249);
        
        UIButton *getOutBtn = [[UIButton alloc]init];
        getOutBtn.tag = 4016;
        [getOutBtn setTitle:@"完成" forState:UIControlStateNormal];
        [getOutBtn setTitleColor:LabelMainColor forState:UIControlStateNormal];
        [getOutBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptationWidth(16)]];
        [getOutBtn addTarget:self action:@selector(btnOnClock:) forControlEvents:UIControlEventTouchUpInside];
        [_datePickerView addSubview:getOutBtn];
        [getOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self->_datePickerView).offset(5);
            make.right.mas_equalTo(self->_datePickerView).offset(-AdaptationWidth(20));
            make.height.mas_equalTo(AdaptationWidth(30));
            make.width.mas_equalTo(AdaptationWidth(40));
        }];
        
    }
    return _datePickerView;
}
- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.backgroundColor = XColorWithRGB(246, 246, 246);
        //设置地区: zh-中国
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        
        //设置日期模式(Displays month, day, and year depending on the locale setting)
        _datePicker.datePickerMode = UIDatePickerModeDate;
        // 设置当前显示时间
        [_datePicker setDate:[NSDate date] animated:YES];
        // 设置显示最大时间（此处为当前时间）
        [_datePicker setMaximumDate:[NSDate date]];
        
        //设置时间格式
        
        //监听DataPicker的滚动
        [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        
        
        
    }
    return _datePicker;
}
#pragma mark - EMSettingActionSheetDelegate

- (void)takePhoto
{
    __weak typeof(self) weakSelf = self;
    [self checkAuthorizationWithType:kEMSettingHeadImageTypeCamera complete:^{
        FSMediaPicker *mediaPicker = [[FSMediaPicker alloc] initWithDelegate:weakSelf];
        mediaPicker.mediaType = FSMediaTypePhoto;
        mediaPicker.editMode = FSEditModeStandard;
        [mediaPicker takePhotoFromCamera];
    }];
}


- (void)searchFromAlbum
{
    __weak typeof(self) weakSelf = self;
    [self checkAuthorizationWithType:kEMSettingHeadImageTypeAlbum complete:^{
        FSMediaPicker *mediaPicker = [[FSMediaPicker alloc] initWithDelegate:weakSelf];
        mediaPicker.mediaType = FSMediaTypePhoto;
        mediaPicker.editMode = FSEditModeStandard;
        [mediaPicker takePhotoFromPhotoLibrary];
    }];
}

#pragma mark - FSMediaPickerDelegate

- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    [goDetailBtn setImage:mediaInfo.editedImage forState:UIControlStateNormal];
    
    BLOCKSELF
    [XNetWork UploadPicturesWithUrl:Xupload images:@[mediaInfo.editedImage] targetWidth:72 andSuccessBlock:^(ResponseModel *model) {
        
        [blockSelf requestHeadUrl:model.data[@"fileUrl"]];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
//    [self refreshHead:mediaInfo.editedImage];
}
- (void)requestHeadUrl:(NSString *)url{
    [XNetWork requestNetWorkWithUrl:Xedit_head_logo andModel:@{@"headLogo":url} andSuccessBlock:^(ResponseModel *model) {
        [ProgressHUD showProgressHUDInView:nil withText:@"更新成功" afterDelay:1];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
- (void)checkAuthorizationWithType:(EMSettingHeadImageType)type complete:(void (^) (void))complete
{
    switch (type) {
        case kEMSettingHeadImageTypeCamera: //检查相机授权
        {
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                switch (authStatus) {
                    case AVAuthorizationStatusAuthorized:
                        if (complete) {
                            complete();
                        }
                        break;
                    case AVAuthorizationStatusNotDetermined:
                    {
                        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//                            dispatch_async_in_main_queue(^{
                                if (granted && complete) {
                                    complete();
                                }
//                            });
                        }];
                    }
                        break;
                    default:
                    {
                    
                        [ProgressHUD showProgressHUDInView:nil withText:@"请在iPhone的\"设置-隐私-相机\"选项中，允许EMark访问你的相机" afterDelay:1];
                    }
                        break;
                }
            } else {
                [ProgressHUD showProgressHUDInView:nil withText:@"您的设备不支持拍照" afterDelay:1];
                
            }
        }
            break;
        case kEMSettingHeadImageTypeAlbum: //检查相册授权
        {
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
            switch (status) {
                case ALAuthorizationStatusNotDetermined:
                case ALAuthorizationStatusAuthorized:
                    if (complete) {
                        complete();
                    }
                    break;
                default:
                {
                    
                    [ProgressHUD showProgressHUDInView:nil withText:@"请在iPhone的\"设置-隐私-照片\"选项中，允许EMark访问你的相册" afterDelay:1];
                }
                    break;
            }
        }
            break;
        default:
            break;
    }
}
- (EMSettingActionSheet *)actionSheet
{
    if (!_actionSheet) {
        _actionSheet = [[EMSettingActionSheet alloc] init];
        _actionSheet.delegate = self;
    }
    
    return _actionSheet;
}
- (MyInfoModel *)infoModel{
    if (!_infoModel) {
        _infoModel = [[MyInfoModel alloc]init];
    }
    return _infoModel;
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
