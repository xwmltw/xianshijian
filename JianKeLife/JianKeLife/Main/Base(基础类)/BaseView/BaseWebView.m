//
//  BaseWebView.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/6.
//  Copyright © 2019年 xwm. All rights reserved.
//
#define kProgressViewHeight 2.0f
#define kMinimumFontSize    10.0f
#import "WXApi.h"
#import <ShareSDK/ShareSDK.h>
#import "BaseWebView.h"
@interface BaseWebView ()<WKUIDelegate,WKScriptMessageHandler>

@property(nonatomic, strong)UIProgressView *progressView;
@property(nonatomic,assign)CGFloat progress;

@end

@implementation BaseWebView
-(instancetype)initWithFrame:(CGRect)frame canCopy:(BOOL)canCopy canZoom:(BOOL)canZoom
{
    self = [super initWithFrame:frame];
    if (self) {
        
        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:[self javascriptOfCSS:canCopy canZoom:canZoom] injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addUserScript:noneSelectScript];
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        //添加注入js方法, oc与js端对应实现
        [configuration.userContentController addScriptMessageHandler:self name:@"triggerAppMethod_laxin_XCX"];
        [configuration.userContentController addScriptMessageHandler:self name:@"triggerAppMethod_laxin_Auth"];
        [configuration.userContentController addScriptMessageHandler:self name:@"triggerAppMethod_laxin_Hot"];
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = kMinimumFontSize;
        configuration.preferences = preferences;
        
        self.webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
        
        self.webView.UIDelegate = self;
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, kProgressViewHeight);
        progressView.progressTintColor = [UIColor grayColor];
        progressView.trackTintColor = [UIColor clearColor];
        
        self.progressView = progressView;
        
        [self addSubview:self.webView];
        
        [self insertSubview:progressView aboveSubview:self.webView];
        
        [self.webView addObserver:self
                       forKeyPath:@"estimatedProgress"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
        [self createButtomView];
    }
    return self;
}
-(void)createButtomView{
    UIView *buttomView = [[UIView alloc]init];
    buttomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:buttomView];
    
    UIButton *leftBTN = [[UIButton alloc]init];
    [leftBTN setBackgroundColor:[UIColor clearColor]];
    leftBTN.tag = 6666;
    [leftBTN addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [buttomView addSubview:leftBTN];
    
    UIImageView *buttonImage = [[UIImageView alloc]init];
    buttonImage.image = [UIImage imageNamed:@"icon_entre2"];
    [leftBTN addSubview:buttonImage];
    
    UIView *lineView  = [[UIView alloc]init];
    lineView.backgroundColor = XColorWithRGB(233, 233, 235);
    [buttomView addSubview:lineView];
    
    UIButton *rightBTN = [[UIButton alloc]init];
    [rightBTN setBackgroundColor:[UIColor clearColor]];
    rightBTN.tag = 7777;
    [rightBTN addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [buttomView addSubview:rightBTN];
    
    UIImageView *buttonImage2 = [[UIImageView alloc]init];
    buttonImage2.image = [UIImage imageNamed:@"icon_entre"];
    [rightBTN addSubview:buttonImage2];
    
    [leftBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(buttomView);
        make.width.mas_equalTo(ScreenWidth / 2);
    }];
    [buttonImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(leftBTN);
        make.height.mas_equalTo(AdaptationWidth(28));
        make.width.mas_equalTo(AdaptationWidth(28));
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(buttomView);
        make.height.mas_equalTo(AdaptationWidth(28));
        make.width.mas_equalTo(0.5);
    }];
    [rightBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(buttomView);
        make.width.mas_equalTo(ScreenWidth / 2);
    }];
    [buttonImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(rightBTN);
        make.height.mas_equalTo(AdaptationWidth(28));
        make.width.mas_equalTo(AdaptationWidth(28));
    }];
    [buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self);
        make.height.mas_equalTo(AdaptationWidth(50));
    }];
}

-(void)btnOnClick:(UIButton *)button{
    switch (button.tag) {
        case 6666:{
            [self.webView goBack];
        }
            break;
        case 7777:{
            [self.webView goForward];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - WKScriptMessageHandler
//实现js注入方法的协议方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //找到对应js端的方法名,获取messge.body
    MyLog(@"111111%@",message.name);
    MyLog(@"222222%@",message.body);
    MyLog(@"333333%@",message.frameInfo.request.URL);
    
//    XBlockExec(self.scriptBlock ,message);
    
    
    if ([message.name isEqualToString:@"triggerAppMethod_laxin_XCX"]) {
        if (![WXApi isWXAppInstalled]) {
            [ProgressHUD showProgressHUDInView:nil withText:@"未安装微信" afterDelay:1 ];
            return ;
        }
        //        小程序分享
        
        
        NSDictionary *dic = [message.body mj_JSONObject];
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"hdThumbImage"]]];
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        
        
        NSNumber *row = dic[@"type"] ;
        if (row.integerValue == 0) {
            
            [shareParams SSDKSetupWeChatMiniProgramShareParamsByTitle:dic[@"title"]
                                                          description:dic[@"title"]
                                                           webpageUrl:[NSURL URLWithString:@"https://www.baidu.com/"]
                                                                 path:dic[@"page"]
                                                           thumbImage:nil
                                                         hdThumbImage:[UIImage imageWithData:imgData]
                                                             userName:dic[@"userName"]
                                                      withShareTicket:YES
                                                      miniProgramType:[dic[@"type"] integerValue]
                                                   forPlatformSubType:SSDKPlatformSubTypeWechatSession];
            [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                [UserInfo sharedInstance].isAlertShare = YES;
                [[UserInfo sharedInstance]saveUserInfo:[UserInfo sharedInstance]];
                
            }];
        }else{
            
            [shareParams SSDKSetupShareParamsByText:dic[@"title"]
                                             images:[UIImage imageWithData:imgData]
                                                url:dic[@"url"]
                                              title:dic[@"title"]
                                               type:SSDKContentTypeAuto];
            [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                [UserInfo sharedInstance].isAlertShare = YES;
                [[UserInfo sharedInstance]saveUserInfo:[UserInfo sharedInstance]];
                
            }];
        }
        
       
    }
    if ([message.name isEqualToString:@"triggerAppMethod_laxin_Hot"]) {
        [self viewController].tabBarController.selectedIndex = 0;
        [[self viewController].navigationController popToRootViewControllerAnimated:YES];
    }
    
    if ([message.name isEqualToString:@"triggerAppMethod_laxin_Auth"]) {
        
        NSString * jsStr  =[NSString stringWithFormat:@"getToken('%@')",[UserInfo sharedInstance].token];
        [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error){
            NSNumber *rsdCode = result[@"rspCode"];
            if (rsdCode.integerValue > 0) {
                [ProgressHUD showProgressHUDInView:nil withText:result[@"rspMsg"] afterDelay:1 ];
            }else{
                [[self viewController].navigationController popViewControllerAnimated:YES];
                MyLog(@"%@",result);
            }
//            NSLog(@"%@====%@",result,error);
        }];
    }
    
}
#pragma mark - <WKUIDelegate>
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [[self viewController] presentViewController:alert animated:YES completion:NULL];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [[self viewController] presentViewController:alert animated:YES completion:NULL];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:prompt message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blackColor];
        textField.placeholder = defaultText;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [[self viewController] presentViewController:alert animated:YES completion:NULL];
}
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    //"webViewDidCreateWebView"
    if (!navigationAction.targetFrame.isMainFrame) {
        
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
- (NSString *)javascriptOfCSS:(BOOL)canCopy canZoom:(BOOL)canZoom
{
    NSString *css = canCopy ? @"" : @"body{-webkit-user-select:none;-webkit-user-drag:none;}";
    NSMutableString *javascript = [NSMutableString string];
    [javascript appendString:@"var style = document.createElement('style');"];
    [javascript appendString:@"style.type = 'text/css';"];
    [javascript appendFormat:@"var cssContent = document.createTextNode('%@');", css];
    [javascript appendString:@"style.appendChild(cssContent);"];
    [javascript appendString:@"document.body.appendChild(style);"];
    [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [javascript appendString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%';"];
    [javascript appendString:canZoom ? @"" : @"var script = document.createElement('meta');""script.name = 'viewport';""script.content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\";""document.getElementsByTagName('head')[0].appendChild(script);"];
    return javascript;
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    if (self.progressView.alpha == 0) {self.progressView.alpha = 1;}
    [self.progressView setProgress:progress animated:YES];
    if (progress >= 1) {
        
        [UIView animateWithDuration:0.8 animations:^{
            
            self.progressView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            self.progressView.progress = 0;
        }];
    }
}
//kvo观察者方法
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        self.progress = self.webView.estimatedProgress;
        
    }else{
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
//移除观察者
-(void)dealloc{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


@end
