//
//  BaseWebVC.m
//  JianKeLife
//
//  Created by yanqb on 2019/3/5.
//  Copyright © 2019年 xwm. All rights reserved.
//

#import "BaseWebVC.h"
#import "BaseWebView.h"
#import "XDeviceHelper.h"
@interface BaseWebVC ()<WKNavigationDelegate>
@property(nonatomic,strong)BaseWebView *webParentView;
@end

@implementation BaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!CGRectIsEmpty(self.viewFrame)) self.view.frame = self.viewFrame;
}

- (void)reloadForGetWebView:(NSString *)htmlStr
{
    NSString *version = [XDeviceHelper getAppBundleVersion];
    htmlStr = [htmlStr stringByAppendingFormat:@"?clientType=1&appVersionCode=%@",version];
    [self.webParentView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:htmlStr]]];
}

- (void)reloadForPostWebView:(NSString *)htmlStr parameters:(NSDictionary *)parameters
{
    htmlStr = [NSString stringWithFormat:@"%@",htmlStr];
    NSMutableURLRequest * requestShare = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:htmlStr]];
    [requestShare addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestShare setHTTPMethod:@"POST"];
    [requestShare setHTTPBody: [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil]];
    [self.webParentView.webView loadRequest:requestShare];
}
#pragma mark - <WKNavigationDelegate>
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    //"webViewDidStartLoad"
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.title = self.webParentView.webView.title;//标题
    //"webViewDidFinishLoad"
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    //"webViewDidFailLoad"
//    [ProgressHUD showProgressHUDInView:kWindow withText:Request_Failure afterDelay:HUD_DismisTime];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    //"webViewWillLoadData"
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    //"webViewWillAuthentication"
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling , nil);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    WKNavigationActionPolicy policy =WKNavigationActionPolicyAllow;
    NSString *str = [NSString stringWithFormat:@"%@",navigationAction.request.URL];
    if ([str rangeOfString:@"tel://"].location !=NSNotFound && [[UIApplication sharedApplication] openURL:navigationAction.request.URL]) {
        
        policy =WKNavigationActionPolicyCancel;
    }
    if ([[navigationAction.request.URL host] isEqualToString:@"itunes.apple.com"] &&[[UIApplication sharedApplication] openURL:navigationAction.request.URL]){
        policy =WKNavigationActionPolicyCancel;
    }
    if([[navigationAction.request.URL scheme] isEqualToString:@"itms-services"] &&[[UIApplication sharedApplication] openURL:navigationAction.request.URL]){
        policy =WKNavigationActionPolicyCancel;
        
    }

    decisionHandler(policy);
}

#pragma mark - lazy
-(BaseWebView *)webParentView
{
    if (!_webParentView) {
        _webParentView = [[BaseWebView alloc] initWithFrame:self.view.bounds canCopy:YES canZoom:NO];
        _webParentView.webView.navigationDelegate = self;
        
        [self.view addSubview:self.webParentView];
    }
    return _webParentView;
}

@end
