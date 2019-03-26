//
//  MyInfoVC.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/25.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseMainVC.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, EMSettingHeadImageType) {
    kEMSettingHeadImageTypeCamera,
    kEMSettingHeadImageTypeAlbum,
};
@interface MyInfoVC : BaseMainVC

@end

NS_ASSUME_NONNULL_END
