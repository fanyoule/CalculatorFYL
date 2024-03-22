//
//  YLWKViewController.m
//  DHMall
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 fanyoule. All rights reserved.
//

#import "YLWKViewController.h"
#import <WebKit/WebKit.h>

@interface YLWKViewController ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, assign) NSUInteger loadCount;

/**wkWebView 对象 在夫类里默认设置的frame（0，0，0，0） 子类需要重新设置*/
@property (nonatomic, strong) WKWebView *wkWebView;
/**configuration配置 对象 子类可以自定义设置*/
@property (nonatomic, strong) WKWebViewConfiguration *configuration;
/** 通过JS与webview内容交互*/
@property (nonatomic, strong) WKUserContentController *wkuserConentVC;
/**! 进度条*/
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation YLWKViewController
-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
     [self clearWebViewCache];
     [self clearWbCache];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPopBackItem];
    self.view.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar.mas_bottom);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
   
    [self addloadingFromObserver];
    if (IS_VALID_STRING(self.url)) {
        NSString * url_str = [self.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:url_str];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.wkWebView loadRequest:request];
    }
       
    [self addScriptMessageHandlerWith:self name:@"main_onItemClick"];
    // Do any additional setup after loading the view.
}
-(void)popBack{
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)dealloc
{
    @try {
    [self removeLodingFromObserver];
     }
    @catch (NSException *exception) {
//        DLog(@"多次删除了");
    }
}
/** 清理缓存 */
- (void)clearWbCache {
    NSMutableArray *types = [@[WKWebsiteDataTypeMemoryCache, WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeOfflineWebApplicationCache, WKWebsiteDataTypeCookies, WKWebsiteDataTypeSessionStorage, WKWebsiteDataTypeLocalStorage, WKWebsiteDataTypeWebSQLDatabases, WKWebsiteDataTypeIndexedDBDatabases] mutableCopy];
     if (@available(iOS 11.3, *)) {
        [types addObject:WKWebsiteDataTypeFetchCache];
        [types addObject:WKWebsiteDataTypeServiceWorkerRegistrations];
     }
    NSSet *websiteDataTypes = [NSSet setWithArray:types];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
    }];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLoadCount:(NSUInteger)loadCount {
    _loadCount = loadCount;
    
    if (loadCount == 0) {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }else {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95) {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
        
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
    }
    if (IS_VALID_STRING(self.nav_Title)) {
        self.navTitle = self.nav_Title;
    }else{
        self.navTitle = self.wkWebView.title;
    }
    
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"message = ===== %@", message);
    if ([message.name isEqualToString:@"main_onItemClick"]) {
            //没有参数
        NSArray *array = message.body;
    }
}


#pragma mark - WKNavigationDelegate  有用到的协议有 这个代理中主要是页面跳转的 ----n 提供了追踪主窗口网页加载过程和判断主窗口和子窗口是否进行页面加载新页面的相关方法。
/**! 这个是决定是否Request --- 在发送请求之前，决定是否跳转*/
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
}

/**! 要获取response，通过WKNavigationResponse对象获取 ---- 在收到响应后，决定是否跳转*/
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/**! 当main frame的导航开始请求时，会调用此方法 --- 页面开始加载时调用*/
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    self.loadCount ++;
}

/**!当main frame接收到服务重定向时，会回调此方法 --- 接收到服务器跳转请求之后调用*/
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

/**! 当main frame开始加载数据失败时，会回调*/
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}

/**! 当main frame的web内容开始到达时，会回调 -----当内容开始返回时调用*/
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    self.loadCount --;
}

/**! 当main frame导航完成时，会回调 -- 页面加载完成之后调用*/
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    //获取内容实际高度（像素）@"document.getElementById(\"content\").offsetHeight;"
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        CGFloat    webViewHeight = [result doubleValue];

        NSLog(@"获取显示高度---%f",webViewHeight);
    }];
    [webView evaluateJavaScript:@"document.body.innerHTML" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSString *resultString = (NSString *)result;
        NSLog(@"加载内容 document.body.innerHTML: %@", resultString);
        if (resultString.length == 0) {
            // 可以做其他操作：刷新或者退出等
            [webView reload];
        }
    }];
}

/**! 当main frame最后下载数据失败时，会回调 --- 加载失败时调用*/
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    self.loadCount --;
}

/**!这与用于授权验证的API，与AFN、UIWebView的授权验证API是一样的*/
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
//{
//
//}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
}
#pragma mark - WKUIDelegate 协议有 这个代理主要是 UI层的 UI->JS之间的交互 ------ 提供用原生控件显示网页的方法回调。
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    completionHandler();
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"弹出框" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
/**!
 * web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    completionHandler(YES);
}

/**!修改web内容*/
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
    
}
#pragma mark-- wk
- (WKWebViewConfiguration *)configuration {
    if (!_configuration) {
//        _configuration = [[WKWebViewConfiguration alloc] init];
//        // 设置偏好设置
//        _configuration.preferences = [[WKPreferences alloc] init];
//        // 默认为YES
//        _configuration.preferences.javaScriptEnabled = YES;
//
//        // 在iOS上默人为NO， 表示不能自动通过窗口打开
//        _configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
//        // 配置userContentControlller
//        _configuration.userContentController = self.wkuserConentVC;
        
        //创建网页配置对象
        _configuration = [[WKWebViewConfiguration alloc] init];
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        _configuration.preferences = preference;

        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        _configuration.allowsInlineMediaPlayback = YES;
        _configuration.mediaTypesRequiringUserActionForPlayback = NO;
        //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
        if (@available(iOS 10.0, *)) {
            _configuration.mediaTypesRequiringUserActionForPlayback = YES;
        } else {
            // Fallback on earlier versions
        }
        //设置是否允许画中画技术 在特定设备上有效
        _configuration.allowsPictureInPictureMediaPlayback = YES;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        _configuration.applicationNameForUserAgent = @"ChinaDailyForiPad";
        //这个类主要用来做native与JavaScript的交互管理
         WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        _configuration.userContentController = wkUController;
        
    }
    return _configuration;
}


#warning wk 配置
- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.configuration];
        _wkWebView.backgroundColor = UIColor.clearColor;
        // 导航代理
        _wkWebView.navigationDelegate = self;
        // 与webView UI交互代理
        _wkWebView.UIDelegate = self;
        
        [_wkWebView addSubview:self.progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_wkWebView.mas_left);
            make.right.mas_equalTo(_wkWebView.mas_right);
            make.top.mas_equalTo(_wkWebView.mas_top);
            make.height.mas_equalTo(2);
        }];
        
    }
    return _wkWebView;
}
- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.progressTintColor =[UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0];
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}
- (WKUserContentController *)wkuserConentVC {
    if (!_wkuserConentVC) {
        _wkuserConentVC = [[WKUserContentController alloc] init];
        
    }
    return _wkuserConentVC;
}



/** 注入JS对象 用户js 与webView内容之间的交互*/
- (void)addScriptMessageHandlerWith:(UIViewController<WKScriptMessageHandler>*)viewController name:(NSString *)nameKey
{
    [self.wkuserConentVC addScriptMessageHandler:viewController name:nameKey];
}


- (void)backAction
{
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    }
}

- (void)forwardAction
{
    if ([self.wkWebView canGoForward]) {
        [self.wkWebView goForward];
    }
}

- (void)back
{
    [self removewScriptAction];
    [self.navigationController popViewControllerAnimated:YES];
}

// 添加观察者为了有一个加载的进度
- (void)addloadingFromObserver
{
    [self.wkWebView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}
/** 移除观察者 --- loding 注意！！！不能随便调用和 addloadingFromObserver 成对出现*/
- (void)removeLodingFromObserver
{
    [self.wkWebView removeObserver:self forKeyPath:@"loading"];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}


/** 根据name 移除注入的scriptMessageHandler*/
- (void)removeScriptMessageHandkerForNameForKey:(nullable NSString *)name
{
    [self.wkuserConentVC removeScriptMessageHandlerForName:name];
}
// 空实现
/** 移除script 方法*/
- (void)removewScriptAction
{
    
}
- (void)clearWebViewCache
{
    if (iOS9) {// 如果是iOS 9的话
        NSSet *tpes = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,
                                            WKWebsiteDataTypeMemoryCache]];
        NSDate *date = [NSDate date];
        
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:tpes modifiedSince:date completionHandler:^{
            NSLog(@"clear webView cache");
        }];
    } else {
        NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString *cookiesFolderPath = [libraryPath stringByAppendingPathComponent:@"Cookies"];
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:nil];
        
    }
    
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
