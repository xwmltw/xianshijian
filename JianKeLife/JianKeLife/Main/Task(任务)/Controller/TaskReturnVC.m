//
//  TaskReturnVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/4/1.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "TaskReturnVC.h"
#import "XWPhotoCell.h"
#import "XWImagePickerSheet.h"
#import "XPlaceHolderTextView.h"
#import "EMQueueDef.h"
@interface TaskReturnVC ()<UICollectionViewDelegate,UICollectionViewDataSource,XWImagePickerSheetDelegate>
{
    NSInteger _indexChoose;
    NSString *pushImageName;
    //添加图片提示
    UILabel *addImageStrLabel;

    
    
    XPlaceHolderTextView *_txtView;
}
@property (nonatomic, strong) XWImagePickerSheet *imgPickerActionSheet;

@property (nonatomic, strong) UICollectionView *pickerCollectionView;
//选择的图片数据
@property(nonatomic,strong) NSMutableArray *arrSelected;

//方形压缩图image 数组
@property(nonatomic,strong) NSMutableArray * imageArray;

//大图image 数组
@property(nonatomic,strong) NSMutableArray * bigImageArray;

//大图image 二进制
@property(nonatomic,strong) NSMutableArray * bigImgDataArray;

//图片选择器
@property(nonatomic,strong) UIViewController *showActionSheetViewController;

@property(nonatomic,strong) NSMutableArray * dataArray;

//图片总数量限制
@property(nonatomic,assign) NSInteger maxCount;

@property (nonatomic, strong) NSString *cateId;

//获得collectionView 的 Frame
- (CGRect)getPickerViewFrame;

//获取选中的所有图片信息
- (NSArray*)getSmallImageArray;
- (NSArray*)getBigImageArray;
- (NSArray*)getALAssetArray;
@end
const char *localNotificationQueue = "cn.neebel.xwm.localNotificationQueue";

@implementation TaskReturnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"返佣申请";
    _indexChoose = 0;
    
    [self createView];
}
- (void)createView {
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.pickerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, AdaptationWidth(355), ScreenHeight-64) collectionViewLayout:layout];
    [self.view addSubview:self.pickerCollectionView];
    
    self.pickerCollectionView.delegate=self;
    self.pickerCollectionView.dataSource=self;
    self.pickerCollectionView.backgroundColor = [UIColor whiteColor];
    [self.pickerCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    [self.pickerCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    
    if(_imageArray.count == 0)
    {
        _imageArray = [NSMutableArray array];
    }
    if(_bigImageArray.count == 0)
    {
        _bigImageArray = [NSMutableArray array];
    }
    pushImageName = @"plus";
    
    
    
    
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        view = header;
        UILabel *title = [[UILabel alloc] init];
        title.text = @" 上传图片";
        title.font = [UIFont systemFontOfSize:AdaptationWidth(20)];
        title.textColor = LabelMainColor;
        [view addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view).offset(16);
            make.left.mas_equalTo(view).offset(12);
        }];
        
        UILabel *content = [[UILabel alloc] init];
        content.text = @"请至少上传1张图片凭证 最多9张";
        content.font = [UIFont systemFontOfSize:AdaptationWidth(12)];
        content.textColor = LabelAssistantColor;
        content.textAlignment = 0;
        [view addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(title.mas_right).offset(10);
            make.bottom.mas_equalTo(title);
        }];
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        view = footer;
        UILabel *title = [[UILabel alloc] init];
        title.text = @" 上传文本";
        title.font = [UIFont systemFontOfSize:AdaptationWidth(20)];
        title.textColor = LabelMainColor;
        [view addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view).offset(16);
            make.left.mas_equalTo(view).offset(12);
        }];
        
        
        
        _txtView = [[XPlaceHolderTextView alloc]init];
        [_txtView setBorderWidth:AdaptationWidth(1) andColor:BackgroundColor];
        _txtView.placeholder = @"请至少输入3个字";
        _txtView.placeholderColor = LabelAssistantColor;
        _txtView.backgroundColor = [UIColor whiteColor];
        _txtView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:AdaptationWidth(16)];
        [view addSubview:_txtView];
        [_txtView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(15);
            make.right.mas_equalTo(view).offset(-15);
            make.top.mas_equalTo(title.mas_bottom).offset(10);
            make.height.mas_equalTo(215);
        }];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:AdaptationWidth(17)];
        btn.backgroundColor =  blueColor;
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).offset(AdaptationWidth(20));
            make.right.mas_equalTo(view).offset(-AdaptationWidth(20));
            make.top.mas_equalTo(self->_txtView.mas_bottom).offset(AdaptationWidth(30));
            make.height.mas_equalTo(AdaptationWidth(44));
        }];
    }
    return view;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, AdaptationWidth(40));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
 
    return CGSizeMake(ScreenWidth, AdaptationWidth(345));;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_imageArray.count>8) {
        return 9;
    } else {
        if(_indexChoose == 0) {
            return _imageArray.count+1;
        } else {
            return _imageArray.count;
        }
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Register nib file for the cell
    UINib *nib = [UINib nibWithNibName:@"XWPhotoCell" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"XWPhotoCell"];
    // Set up the reuse identifier
    XWPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"XWPhotoCell" forIndexPath:indexPath];
    
    if (indexPath.row == _imageArray.count) {
        [cell.profilePhoto setImage:[UIImage imageNamed:pushImageName]];
        cell.closeButton.hidden = YES;
        
        //没有任何图片
        if (_imageArray.count == 0) {
            addImageStrLabel.hidden = NO;
        }
        else{
            addImageStrLabel.hidden = YES;
        }
    }
    else{
        [cell.profilePhoto setImage:_imageArray[indexPath.item]];
        cell.closeButton.hidden = NO;
    }
    [cell setBigImgViewWithImage:nil];
    cell.profilePhoto.tag = [indexPath item];
    
    //添加图片cell点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.profilePhoto .userInteractionEnabled = YES;
    [cell.profilePhoto  addGestureRecognizer:singleTap];
    cell.closeButton.tag = [indexPath item];
    [cell.closeButton addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
#pragma mark <UICollectionViewDelegate>
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(AdaptationWidth(335)/3 ,AdaptationWidth(335)/3);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(AdaptationWidth(15)/2, AdaptationWidth(15)/2, AdaptationWidth(15)/2, AdaptationWidth(15)/2);//分别为上、左、下、右
}

// 两个cell之间的最小间距，是由API自动计算的，只有当间距小于该值时，cell会进行换行
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return AdaptationWidth(15)/2;
}
#pragma  mark -btn
- (void)btnOnClick:(UIButton *)btn{
    if (self.imageArray.count < 1) {
        [ProgressHUD showProgressHUDInView:nil withText:@"请至少上传1张图片凭证 最多9张" afterDelay:1 ];
        return;
    }
    if (_txtView.text.length < 2) {
        [ProgressHUD showProgressHUDInView:nil withText:@"请至少输入3个字" afterDelay:1 ];
        return;
    }
    self.dataArray  = [NSMutableArray array];
    for (int i = 0; self.imageArray.count > i; i++) {
        WEAKSELF
        [XNetWork UploadPicturesWithUrl:Xupload images:@[self.imageArray[i]] targetWidth:72 andSuccessBlock:^(ResponseModel *model) {
            [weakSelf.dataArray addObject:model.data[@"fileUrl"]];
            if (weakSelf.imageArray.count == weakSelf.dataArray.count) {
                [weakSelf sureBtn];
            }
        } andFailBlock:^(ResponseModel *model) {
            
        }];
    }
    
}
-(void)sureBtn{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.productApplyId forKey:@"productApplyId"];
    [dic setObject:_txtView.text forKey:@"submitContent"];
    [dic setObject:self.dataArray forKey:@"submitPicUrlArr"];
    WEAKSELF
    [XNetWork requestNetWorkWithUrl:Xproduct_apply_submit andModel:dic andSuccessBlock:^(ResponseModel *model) {
        [ProgressHUD showProgressHUDInView:nil withText:@"提交成功" afterDelay:1 ];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } andFailBlock:^(ResponseModel *model) {
        
    }];
}
#pragma mark - 图片cell点击事件
//点击图片看大图
- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
    
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    
    if (index == (_imageArray.count)) {
        [self.view endEditing:YES];
        //添加新图片
        [self addNewImg:gestureRecognizer.view.tag];
    }
    else{
        //点击放大查看
        XWPhotoCell *cell = (XWPhotoCell*)[_pickerCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        if (!cell.BigImgView || !cell.BigImgView.image) {
            
            [cell setBigImgViewWithImage:[self getBigIamgeWithALAsset:_arrSelected[index]]];
        }
        
        JJPhotoManeger *mg = [JJPhotoManeger maneger];
        mg.delegate = self;
        [mg showLocalPhotoViewer:@[cell.BigImgView] selecImageindex:0];
    }
}
- (UIImage*)getBigIamgeWithALAsset:(ALAsset*)set{
    //压缩
    // 需传入方向和缩放比例，否则方向和尺寸都不对
    UIImage *img = [UIImage imageWithCGImage:set.defaultRepresentation.fullResolutionImage
                                       scale:set.defaultRepresentation.scale
                                 orientation:(UIImageOrientation)set.defaultRepresentation.orientation];
    NSData *imageData = UIImageJPEGRepresentation(img, 1);
    [_bigImgDataArray addObject:imageData];
    
    return [UIImage imageWithData:imageData];
}
#pragma mark - 选择图片 - 视频 - 选取照片或者拍照
- (void)addNewImg:(NSInteger)index{
    if (index == 0) {
       
            if (!_imgPickerActionSheet) {
                _imgPickerActionSheet = [[XWImagePickerSheet alloc] init];
                _imgPickerActionSheet.delegate = self;
            }
            if (_arrSelected) {
                _imgPickerActionSheet.arrSelected = _arrSelected;
            }
            _imgPickerActionSheet.maxCount = _maxCount;
            [_imgPickerActionSheet showImgPickerActionSheetInView:self];
        
        
    } else {
        if (!_imgPickerActionSheet) {
            _imgPickerActionSheet = [[XWImagePickerSheet alloc] init];
            _imgPickerActionSheet.delegate = self;
        }
        if (_arrSelected) {
            _imgPickerActionSheet.arrSelected = _arrSelected;
        }
        _imgPickerActionSheet.maxCount = _maxCount;
        [_imgPickerActionSheet showImgPickerActionSheetInView:self];
        
    }
}
//从相册中选取
- (void)choosevideo
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.editing = YES;
    ipc.allowsEditing = YES;
    //    去除毛玻璃效果
    
    ipc.navigationBar.translucent = NO;
    //设置风格
    ipc.modalPresentationStyle = UIModalPresentationCurrentContext;
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    //    视频质量，枚举类型：
    //    UIImagePickerControllerQualityTypeHigh：高清质量
    //    UIImagePickerControllerQualityTypeMedium：中等质量，适合WiFi传输
    //    UIImagePickerControllerQualityTypeLow：低质量，适合蜂窝网传输
    //    UIImagePickerControllerQualityType640x480：640*480
    //    UIImagePickerControllerQualityTypeIFrame1280x720：1280*720
    //    UIImagePickerControllerQualityTypeIFrame960x540：960*540
    ipc.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
    ipc.videoMaximumDuration = 15.0f;
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.delegate = self;//设置委托
}

#pragma mark - 删除照片
- (void)deletePhoto:(UIButton *)sender{
    if (_indexChoose == 0) {
        [_imageArray removeObjectAtIndex:sender.tag];
        [_arrSelected removeObjectAtIndex:sender.tag];
        
        
        [self.pickerCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]]];

        
  
        for (NSInteger item = sender.tag; item <= _imageArray.count; item++) {
            XWPhotoCell *cell = (XWPhotoCell*)[self.pickerCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];
            cell.closeButton.tag--;
            cell.profilePhoto.tag--;
        }
    } else {
        _indexChoose = 0;
        [_imageArray removeAllObjects];
        [_arrSelected removeAllObjects];
        

        
        [self.pickerCollectionView reloadData];
        
        
        
    }
    
    
    
}


/**
 *  相册完成选择得到图片
 */
-(void)getSelectImageWithALAssetArray:(NSArray *)ALAssetArray thumbnailImageArray:(NSArray *)thumbnailImgArray{
    //（ALAsset）类型 Array
    _arrSelected = [NSMutableArray arrayWithArray:ALAssetArray];
    //正方形缩略图 Array
    _imageArray = [NSMutableArray arrayWithArray:thumbnailImgArray] ;
    [self.pickerCollectionView reloadData];

}


#pragma mark - 防止奔溃处理
-(void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex
{
    NSLog(@"最后一张观看的图片的index是:%zd",selecedImageViewIndex);
}

- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}
//获得大图
- (NSArray*)getBigImageArrayWithALAssetArray:(NSArray*)ALAssetArray{
    _bigImgDataArray = [NSMutableArray array];
    NSMutableArray *bigImgArr = [NSMutableArray array];
    for (ALAsset *set in ALAssetArray) {
        [bigImgArr addObject:[self getBigIamgeWithALAsset:set]];
    }
    _bigImageArray = bigImgArr;
    return _bigImgDataArray;
}
#pragma mark - 获得选中图片各个尺寸
- (NSArray*)getALAssetArray{
    return _arrSelected;
}

- (NSArray*)getBigImageArray{
    if (_bigImageArray.count>0) {
        return _bigImageArray;
    }
    
    return [self getBigImageArrayWithALAssetArray:_arrSelected];
}

- (NSArray*)getSmallImageArray{
    return _imageArray;
}
@end
