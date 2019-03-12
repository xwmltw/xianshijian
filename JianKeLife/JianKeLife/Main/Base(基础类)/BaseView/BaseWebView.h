//
//  BaseWebView.h
//  JianKeLife
//
//  Created by yanqb on 2019/3/6.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseWebView : UIView
-(instancetype)initWithFrame:(CGRect)frame canCopy:(BOOL)canCopy canZoom:(BOOL)canZoom;
@property(nonatomic,strong)WKWebView *webView;
@end

NS_ASSUME_NONNULL_END
