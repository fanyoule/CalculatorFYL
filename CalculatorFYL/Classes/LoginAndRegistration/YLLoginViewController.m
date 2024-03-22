//
//  YLLoginViewController.m
//  DayBetter
//
//  Created by tianhao on 2022/11/30.
//

#import "YLLoginViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SHMEmojiMethod.h"

#import "NSMutableAttributedString+WY_Extension.h"
#import "NSMutableParagraphStyle+WY_Extension.h"
#import "UILabel+WY_RichText.h"

#import "YLWKViewController.h"
#import "FYLUserProtocolTipView.h"


#import "FYLPasswordLoginViewController.h"
#import "FYLVerificationCodeLoginViewController.h"
#import "FYLForgotPasswordViewController.h"

#define CodeTime 60
@interface YLLoginViewController ()
<
CLLocationManagerDelegate,
UITextFieldDelegate,
WY_RichTextDelegate,
UIGestureRecognizerDelegate
>
@property(nonatomic,strong)CLLocationManager * locationManager;
@property(nonatomic,strong)CLGeocoder *geocoder;;
/// 手机号输入框
@property(nonatomic,strong)UITextField * T_phone;
/// 协议同意 按钮
@property(nonatomic, strong) UIButton *selectButton;
@property(nonatomic,strong)UIButton *  B_sure;//密码登录
/// 验证码按钮
@property(nonatomic,strong)UIButton * B_VerificationCode;
@property(nonatomic,copy)NSString * uuid;//验证码uuid
@end

@implementation YLLoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pop_gesture = NO;
    [self yl_creatUI];

   
}
#pragma mark - 网络请求
#pragma mark -- 验证账号是否注册
-(void)getUserVerifyEmail{
    [MBProgressHUD showMessage:@"" toView:YX_Keywindow];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:self.T_phone.text forKey:@"account"];
    [parameters setObject:@(0) forKey:@"type"];
//    [[YXHTTPRequst shareInstance]networking:API_UserIsUserAccount parameters:parameters method:YXRequstMethodTypePOST showErrorView:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//        BaseModel * baseModel = [BaseModel loadModelWithDictionary:responseObject];
//        if(baseModel.code.intValue==1){
//            FYLPasswordLoginViewController * vc = [[FYLPasswordLoginViewController alloc]init];
//            vc.eamal = self.T_phone.text;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        
//    } failsure:^(NSURLSessionDataTask *task, id cacheData, NSError * error) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//        
//    }];
    
}
#pragma mark 获取验证码
-(void)getCodeData{
    [MBProgressHUD showMessage:@"" toView:YX_Keywindow];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:self.T_phone.text forKey:@"userEmail"];
//    [[YXHTTPRequst shareInstance]networking:API_CaptchaEmailNewCode parameters:parameters method:YXRequstMethodTypePOST showErrorView:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//        BaseModel * baseModel = [BaseModel loadModelWithDictionary:responseObject];
//        if(baseModel.code.intValue==1){
//            FYLVerificationCodeLoginViewController * vc = [[FYLVerificationCodeLoginViewController alloc]init];
//            vc.type = VerificationCodeTypeFromLogin;
//            vc.eamal = self.T_phone.text;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        //事件统计
//        [YLFlurryManagerTool flurry_selectedButtonClickedType:0 withTitle:@"登录-发送验证码" withDic:@{@"事件结果":@"发送成功"}];
//        
//    } failsure:^(NSURLSessionDataTask *task, id cacheData, NSError * error) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//        //事件统计
//        [YLFlurryManagerTool flurry_selectedButtonClickedType:0 withTitle:@"登录-发送验证码" withDic:@{@"事件结果":@"发送失败",@"事件内容":error.debugDescription}];
//        
//    }];
     
}
#pragma mark - 点击事件
#pragma mark - 点击密码 or 验证码登录
-(void)didSelectedBaseButtonClicked:(UIButton *)btn{
    if (btn.tag == 2) {//密码
        if ([self VerifyThatYouAgreeToTheAgreement]) {
            if (!IS_VALID_STRING(self.T_phone.text)) {
                if ([self fyl_getLocalAddressType] == 1) {
                    [SVProgressHUD showDetailMessage:NSLocalizedString(@"Please enter your phone number", nil) delay:2];
                }else{
                    [SVProgressHUD showDetailMessage:NSLocalizedString(@"please input your email", nil) delay:2];
                }
                return;
            }
            [self getUserVerifyEmail];
            
        }
    }else if (btn.tag == 3){//验证码
        
        if ([self VerifyThatYouAgreeToTheAgreement]) {
            if (!IS_VALID_STRING(self.T_phone.text)) {
                if ([self fyl_getLocalAddressType] == 1) {
                    [SVProgressHUD showDetailMessage:NSLocalizedString(@"Please enter your phone number", nil) delay:2];
                }else{
                    [SVProgressHUD showDetailMessage:NSLocalizedString(@"please input your email", nil) delay:2];
                }
                return;
            }
            [self getCodeData];
            
            
        }
    }
    
}
#pragma mark --- 创建账号
-(void)buttonClickedCreatUserPerson:(UIButton *)btn{
    
    if ([self VerifyThatYouAgreeToTheAgreement]) {
        FYLForgotPasswordViewController * vc = [[FYLForgotPasswordViewController alloc]init];
        vc.type = ForgotPasswordTypeFromSign;
        if (IS_VALID_STRING(self.T_phone.text)) {
            vc.email = self.T_phone.text;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(BOOL)VerifyThatYouAgreeToTheAgreement{
    [self.view endEditing:YES];
    //在这里判断是否同意了协议
    if (self.agreementBtn.selected == NO) {
        FYLUserProtocolTipView * alertView = [[FYLUserProtocolTipView alloc] initWithTitle:@""];
       
        __weak YLLoginViewController * weakSelf = self;
        __weak FYLUserProtocolTipView *weakAlertView = alertView; // 使用弱引用
        // 处理不同意按钮点击事件
        alertView.cancelAction = ^{
           [weakAlertView removeFromSuperview];
        };
        // 处理同意按钮点击事件
        alertView.confirmAction = ^{
            [weakAlertView removeFromSuperview];
            // 改变按钮的状态
            [weakSelf agreementBtnClicked];
        };
        //用户协议 和 隐私协议 点击事件
        alertView.selectAction = ^(NSInteger index) {
            [weakSelf jumbToWeb:index];
        };
     
        alertView.center = self.view.center;
        [self.view addSubview:alertView];
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([SHMEmojiMethod iosCurrentKeyType]) {
        //   限制苹果系统输入法  禁止输入表情
        if ([SHMEmojiMethod iosStringContainsEmoji]) {
            return NO;
        }
        //判断是否输入了emoji 表情
        if ([SHMEmojiMethod yl_stringContainsEmoji:string]) {
            return NO;
        }
    }else{
        //判断是否输入了emoji 表情
        if ([SHMEmojiMethod yl_stringContainsEmoji:string]) {
            return NO;
        }
    }
    
    //禁止输入空格
    NSString *blank = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if(![string isEqualToString:blank]) {
        return NO;
    }

    return YES;
}

//结束输入
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.T_phone) { //只统计账号  不统计密码
        if (textField.text.length!=0) {
            
        }
    }
    
}


#pragma mark - UI
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败--%@",error.localizedDescription);
    NSString * language = [ToolManagement getsTheCurrentPhoneLanguage];
    if (IS_VALID_STRING(language)&&[language isEqualToString:@"ZH"]) {
        [self getLoacaAddressChangeUIType:1];
    }else{
        [self getLoacaAddressChangeUIType:0];
    }
    
}
//-(void)loca
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *loctaion = [locations firstObject];
    [self.geocoder reverseGeocodeLocation:loctaion completionHandler:^(NSArray *placemarks, NSError *error) {
        if(!error&&placemarks.count>0){
            CLPlacemark *placemark=[placemarks firstObject];
            NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
            if([ISOcountryCode isEqualToString:@"CN"]){//中国
                [self getLoacaAddressChangeUIType:1];
            }else{//国外
                [self getLoacaAddressChangeUIType:0];
            }
        }
        
     }];
    [manager stopUpdatingLocation];
    
}
#pragma mark 协议点击
- (void)wy_didClickRichText:(NSString *)string range:(NSRange)range index:(NSInteger)index{
    NSLog(@"协议点击--%@--:%ld",string,index);
    [self jumbToWeb:index];
}
//点击协议跳转到web
- (void)jumbToWeb:(NSInteger)index{
    if (index==0) {
        
        YLWKViewController *webVC = [YLWKViewController new];
        webVC.url = NSLocalizedString(@"UserAgreementUrlString", nil);
        [self.navigationController pushViewController:webVC animated:YES];
        
    } else {
        
        YLWKViewController *webVC = [YLWKViewController new];
        webVC.url = NSLocalizedString(@"PrivacyPolicyUrlString", nil);
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
#pragma mark -- 获取定位
-(void)setLocaAdress{
    //    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    //    CGFloat version = [phoneVersion floatValue];
    //    // 如果是iOS13 未开启地理位置权限 需要提示一下
    //    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined && version >= 13) {}
    //如果没有授权则请求用户授权
    self.locationManager = [[CLLocationManager alloc]init];
    self.geocoder = [[CLGeocoder alloc] init];
    
//       if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
//           [self.locationManager requestWhenInUseAuthorization];
//       }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
//           [self.locationManager requestAlwaysAuthorization];
           [self.locationManager  requestWhenInUseAuthorization];
           self.locationManager.delegate = self;
           self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;//精准度
           [self.locationManager startUpdatingLocation];
          
//       }
    
}

//同意协议按钮点击事件
- (void)agreementBtnClicked{
    self.agreementBtn.selected = !self.agreementBtn.selected;
    if (self.agreementBtn.selected){
        self.protocolImgView.image = [UIImage imageNamed:@"loginProtocolSelectedIcon_1"];
    }
    else {
       self.protocolImgView.image = [UIImage imageNamed:@"loginProtocolNotSelectedIcon_1"];
    }
}

-(void)getLoacaAddressChangeUIType:(NSInteger)type{
//    type = 0;
    [UIView animateWithDuration:0.5 animations:^{
        if (type == 1) {//国内
            [[NSUserDefaults standardUserDefaults]setObject:@"CN" forKey:CountriesAddress];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            self.T_phone.placeholder = NSLocalizedString(@"Please enter your phone number", nil);
            [self.T_phone limitOnlyNumber:YES];
            [self.T_phone limitTextLength:11];
            self.B_VerificationCode.hidden = YES;
        }else{//国外
            [[NSUserDefaults standardUserDefaults]setObject:@"YY" forKey:CountriesAddress];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            self.B_VerificationCode.hidden = NO;
            self.T_phone.placeholder = NSLocalizedString(@"please input your email", nil);
            [self.T_phone limitOnlyNumber:NO];
            [self.T_phone limitTextLength:30];
        }
    }];
   
}


    



-(void)yl_creatUI{
    [self setLocaAdress];//获取定位
    [self changeTitle:@""];
    
    NSArray * arr_view = [self creatTextFieldHolderText:NSLocalizedString(@"please input your email", nil) withTextFont:Px26Font withTextColor:rgba(61, 61, 61, 1) withTag:1];
    UITextField * T_phone = arr_view.lastObject;
    UIView * V_root_text = arr_view.firstObject;
    self.T_phone = T_phone;
    NSString * userPhone = [[NSUserDefaults standardUserDefaults]objectForKey:@"userPhone"];
    if (IS_VALID_STRING(userPhone)) {
        T_phone.text = userPhone;
    }
    T_phone.delegate = self;
    [self.V_bg_contect addSubview:V_root_text];
    [V_root_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.V_bg_contect).mas_offset(AdaptedHeightValue(40));
        make.left.mas_equalTo(self.V_bg_contect).mas_offset(AdaptedWidthValue(30));
        make.right.mas_equalTo(self.V_bg_contect).mas_offset(-AdaptedWidthValue(30));
        make.height.mas_equalTo(AdaptedHeightValue(50));
    }];
    //选中未选中标签
    [self.V_bg_contect addSubview:self.protocolImgView];
    [self.protocolImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(V_root_text).mas_offset(15);
        make.top.mas_equalTo(V_root_text.mas_bottom).mas_offset(AdaptedHeightValue(15));
        make.width.height.mas_equalTo(@(10.5));
    }];
    //登录即同意《用户协议》、《隐私政策》
    NSString * UserAgreement = NSLocalizedString(@"User Agreement", nil);
    NSString * PrivacyPolicy = NSLocalizedString(@"Privacy Policy", nil);
    NSString * Loginmeansconsent = NSLocalizedString(@"Consent", nil);
    NSString *yl_agreementString =[NSString stringWithFormat:@"%@%@、%@",Loginmeansconsent,UserAgreement,PrivacyPolicy];
    
    NSMutableAttributedString *attributedString = [NSMutableAttributedString wy_attributeWithStr:yl_agreementString];
    [attributedString addAttribute:NSFontAttributeName value:Px28Font range:NSMakeRange(0, yl_agreementString.length)];

    NSMutableParagraphStyle *style = [NSMutableParagraphStyle wy_paragraphStyle];
    style.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, yl_agreementString.length)];
    
    UILabel *L_protocolLabel = [[UILabel alloc] init];
    L_protocolLabel.numberOfLines = 2;
    L_protocolLabel.textAlignment = NSTextAlignmentLeft;
    L_protocolLabel.textColor =rgba(61, 61, 61, 1);
    L_protocolLabel.wy_clickEffectColor = UIColor.clearColor;
    L_protocolLabel.attributedText = attributedString;

    [self.V_bg_contect addSubview:L_protocolLabel];
    [L_protocolLabel wy_clickRichTextWithStrings:@[UserAgreement, PrivacyPolicy] delegate:self];
    [L_protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.protocolImgView.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.protocolImgView).mas_offset(0);
        make.right.mas_equalTo(self.V_bg_contect);
    }];
    //协议按钮
    [self.view addSubview:self.agreementBtn];
    [self.agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.protocolImgView).mas_offset(0);
        make.height.mas_equalTo(@(35));
    }];
    //密码登录
    UIButton * B_sure = [self creatButtonTitle:NSLocalizedString(@"Password login", nil) withFont:Px32Font withTitleColor:rgba(255, 255, 255, 1) withImageName:@"SelectedDeviceSureBtn_bg" withBackGroundColor:nil withTag:2];
    [self.V_bg_contect addSubview:B_sure];
    self.B_sure = B_sure;
    [self.B_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.protocolImgView.mas_bottom).mas_offset(AdaptedHeightValue(36));
        make.left.mas_equalTo(self.V_bg_contect).mas_offset(AdaptedWidthValue(50));
        make.right.mas_equalTo(self.V_bg_contect).mas_offset(-AdaptedWidthValue(50));
        make.height.mas_equalTo(AdaptedHeightValue(40));
    }];
    self.B_sure.layer.cornerRadius = AdaptedHeightValue(40)/2;
    self.B_sure.layer.masksToBounds = YES;
    self.B_sure.backgroundColor = rgba(16, 186, 238, 1);
    
    //验证码登录
    UIButton * B_VerificationCode = [self creatButtonTitle:NSLocalizedString(@"Verification code login", nil) withFont:Px32Font withTitleColor:rgba(255, 255, 255, 1) withImageName:@"SelectedDeviceSureBtn_bg" withBackGroundColor:UIColor.clearColor withTag:3];
    self.B_VerificationCode = B_VerificationCode;
    [self.V_bg_contect addSubview:B_VerificationCode];
    [B_VerificationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(B_sure.mas_bottom).mas_offset(AdaptedHeightValue(20));
        make.left.mas_equalTo(B_sure);
        make.right.mas_equalTo(B_sure);
        make.height.mas_equalTo(B_sure);
    }];
    B_VerificationCode.layer.cornerRadius = AdaptedHeightValue(40)/2;
    B_VerificationCode.layer.masksToBounds = YES;
    B_VerificationCode.backgroundColor = rgba(16, 186, 238, 1);
    
    ZZLabel * L_newPerson = [[ZZLabel alloc]initWithTextColor:rgba(216, 216, 216, 1) Font:Px20Font TextString:@"Don't have an account yet?"];
    [self.V_bg_contect addSubview:L_newPerson];
    [L_newPerson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.V_bg_contect).mas_offset(-AdaptedHeightValue(100));
        make.centerX.mas_equalTo(self.V_bg_contect);
    }];
    UIView * V_line_left = [[UIView alloc]init];
    V_line_left.backgroundColor = rgba(216, 216, 216, 1);
    [self.V_bg_contect addSubview:V_line_left];
    [V_line_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(V_root_text);
        make.height.mas_equalTo(@1);
        make.centerY.mas_equalTo(L_newPerson);
        make.right.mas_equalTo(L_newPerson.mas_left).mas_offset(-AdaptedWidthValue(20));
    }];
    UIView * V_line_right = [[UIView alloc]init];
    V_line_right.backgroundColor = rgba(216, 216, 216, 1);
    [self.V_bg_contect addSubview:V_line_right];
    [V_line_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(L_newPerson.mas_right).mas_offset(AdaptedWidthValue(20));
        make.height.mas_equalTo(@1);
        make.centerY.mas_equalTo(L_newPerson);
        make.right.mas_equalTo(V_root_text);
    }];
    CGFloat width_creatPeraon = [NSLocalizedString(@"Don't have an account yet?", nil) jk_widthWithFont:Px24Font constrainedToHeight:30]+AdaptedWidthValue(60);
    if (width_creatPeraon>kScreenWidth-AdaptedWidthValue(60)) {
        width_creatPeraon = kScreenWidth - AdaptedWidthValue(60);
    }
    //创建一个账号
    UIButton * B_creatPeraon = [UIButton buttonWithType:UIButtonTypeCustom];
    [B_creatPeraon setTitle:NSLocalizedString(@"Create an account", nil) forState:UIControlStateNormal];
    B_creatPeraon.titleLabel.font = Px24Font;
    [B_creatPeraon setTitleColor:rgba(16, 186, 238, 1) forState:UIControlStateNormal];
    [B_creatPeraon addTarget:self action:@selector(buttonClickedCreatUserPerson:) forControlEvents:UIControlEventTouchUpInside];
    [self.V_bg_contect addSubview:B_creatPeraon];
    [B_creatPeraon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(L_newPerson.mas_bottom).mas_offset(AdaptedHeightValue(20));
        make.centerX.mas_equalTo(L_newPerson);
        make.size.mas_equalTo(CGSizeMake(width_creatPeraon, AdaptedHeightValue(30)));
    }];

    [self getLoacaAddressChangeUIType:[self fyl_getLocalAddressType]];

    
    
    
    
}
//协议图标
-(UIImageView *)protocolImgView{
    if (!_protocolImgView) {
        _protocolImgView = [[UIImageView alloc] init];
        _protocolImgView.image = [UIImage imageNamed:@"loginProtocolSelectedIcon_1"];
    }
    return _protocolImgView;
}

-(UIButton *)agreementBtn{
    if (!_agreementBtn) {
        _agreementBtn = [[UIButton alloc] init];
        [_agreementBtn addTarget:self action:@selector(agreementBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _agreementBtn.backgroundColor = UIColor.clearColor;
        _agreementBtn.selected = YES;
    }
    return _agreementBtn;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
