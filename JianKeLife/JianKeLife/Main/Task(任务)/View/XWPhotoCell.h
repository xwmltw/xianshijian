//
//  XWPhotoCell.h
//  XWPublishDemo
//
//  Created by mac on 2016/11/25.
//  Copyright © 2016年 com.rongniu.caifuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWPhotoCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

@property(nonatomic,strong) UIImageView *BigImgView;

/** 查看大图 */
- (void)setBigImgViewWithImage:(UIImage *)img;


@end
