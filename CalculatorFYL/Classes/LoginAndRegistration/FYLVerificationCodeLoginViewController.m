//
//  FYLVerificationCodeLoginViewController.m
//  JoyLight
//
//  Created by tianhao on 2024/2/26.
//

#import "FYLVerificationCodeLoginViewController.h"
#import "HWTFCodeBView.h"
#import "SMSCodeInputView.h"
#import "FYLCreatePasswordViewController.h"
#define CodeTime 60
@interface FYLVerificationCodeLoginViewController ()
<
SMSCodeInputViewDelegate
>
///验证码
@property(nonatomic,copy)NSString * codeStr;
//跑秒
@property(nonatomic,strong)dispatch_source_t timer;
/// 验证码按钮
@property(nonatomic,strong)UIButton * B_getCode;
@property(nonatomic,strong)SMSCodeInputView * V_codes;

@end

@implementation FYLVerificationCodeLoginViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self cancelData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPopBackItem];
    [self yl_creatUI];
    [self starteTime];
    
    // Do any additional setup after loading the view.
}

-(void)cancelData{
    self.codeStr = @"";
    [self.B_getCode setTitle:NSLocalizedString(@"Get verification code", nil) forState:UIControlStateNormal];
    self.B_getCode.userInteractionEnabled = YES;
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    [self.V_codes cancelText];
}
#pragma mark --  SMSCodeInputViewDelegate
-(void)HWTFCodeBView_endTextStr:(NSString *)text{
    NSLog(@"输入结束：%@",text);
//    if (IS_VALID_STRING(text)) {
    self.codeStr = text;
//    }
}
#pragma mark -- 登录 or 下一步
-(void)didSelectedBaseButtonClicked:(UIButton *)btn{
    [self buttonClickedpasswordlogin];
}
-(void)buttonClickedpasswordlogin{
    NSLog(@"登录 or 下一步------");
    [self.view endEditing:YES];
    if (!IS_VALID_STRING(self.eamal)) {
        return;
    }

    if (!IS_VALID_STRING(self.codeStr)) {
        [SVProgressHUD showDetailMessage:NSLocalizedString(@"please enter verification code", nil) delay:2];
        return;
    }
    
    if (self.type == VerificationCodeFromSign || self.type == VerificationCodeFromForgotPassword) {
        [self VerificationCode];

    }else if (self.type == VerificationCodeTypeFromLogin){
        //登录
        [self VerificationCodeLogin];
    }
    
    
}
#pragma mark -- 校验验证码
-(void)VerificationCode{
    
    if (!IS_VALID_STRING(self.codeStr)) {
        [SVProgressHUD showDetailMessage:NSLocalizedString(@"please enter verification code", nil) delay:2];
        return;
    }
    [MBProgressHUD showMessage:@"" toView:YX_Keywindow];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString * url = API_CaptchaValidateRegisterEmail;
    if ([self fyl_getLocalAddressType] == 1) {
        url = API_ValidateSmsCode;
        [parameters setObject:self.eamal forKey:@"phoneNumber"];
        [parameters setObject:self.codeStr forKey:@"code"];

    }else{
        if (self.type == VerificationCodeFromForgotPassword) {
            if (ZJ_UserLoginInfomation.getLogin) {
                url = WIFI_IsEmailPassword;
                [parameters setObject:self.eamal forKey:@"email"];
                [parameters setObject:self.codeStr forKey:@"code"];
            }else{
                url = API_CaptchaValidateEmailPassword;
                [parameters setObject:self.eamal forKey:@"userEmail"];
                [parameters setObject:self.codeStr forKey:@"captchaCode"];
            }
            
        }else{
            [parameters setObject:self.eamal forKey:@"userEmail"];
            [parameters setObject:self.codeStr forKey:@"captchaCode"];
        }
    }
    
//    [[YXHTTPRequst shareInstance]networking:url parameters:parameters method:YXRequstMethodTypePOST showErrorView:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//        BaseModel * baseModel = [BaseModel loadModelWithDictionary:responseObject];
//        if(baseModel.code.intValue==1){
//            NSString * uuid = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"uuid"]];
//            FYLCreatePasswordViewController * vc = [[FYLCreatePasswordViewController alloc]init];
//            vc.uuid = uuid;
//            vc.email = self.eamal;
//            if (self.type == VerificationCodeFromSign) {
//                vc.type = 1;
//            }else if (self.type == VerificationCodeFromForgotPassword){
//                vc.type = 2;
//            }
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        
//    } failsure:^(NSURLSessionDataTask *task, id cacheData, NSError * error) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//
//    }];
    
    
    
}
#pragma mark -- 验证码登录
-(void)VerificationCodeLogin{
    [self.view endEditing:YES];
    if (!IS_VALID_STRING(self.codeStr)) {
        [SVProgressHUD showDetailMessage:NSLocalizedString(@"please enter verification code", nil) delay:2];
        return;
    }
    NSString *emailStr = [self.eamal stringByReplacingOccurrencesOfString:@" " withString:@""]; //去空格
    [MBProgressHUD showMessage:@"" toView:YX_Keywindow];
    NSMutableDictionary * parm = [NSMutableDictionary dictionary];
    [parm setObject:emailStr forKey:@"account"];
    [parm setObject:self.codeStr forKey:@"code"];
    
    
//    [[YXHTTPRequst shareInstance]networking:API_LoginNewEmail parameters:parm method:YXRequstMethodTypePOST showErrorView:YES  success:^(NSURLSessionDataTask *task, id responseObject) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//
//        BaseModel * BModel = [BaseModel loadModelWithDictionary:responseObject];
//        
//        [FlurryUserProperties set:@"UserEmail" value:emailStr]; //设置用户属性
//        if(BModel.code.intValue==1){
//            [[NSUserDefaults standardUserDefaults] setObject:emailStr forKey:@"userPhone"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            
//            //登录成功，保存信息
//            NSDictionary *infoDic =(NSDictionary *) responseObject[@"data"];
//            [ZJ_UserLoginInfomation userInfoWithDict:infoDic];
//            //返回到根视图
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [[NSNotificationCenter defaultCenter]postNotificationName:FYL_LoginSeccessRefreshData object:self];
//                [self.navigationController dismissViewControllerAnimated:YES completion:^{
//                }];
//            });
//           
//   
//        }
//    } failsure:^(NSURLSessionDataTask *task, id cacheData, NSError * error) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//
//    }];
}

#pragma mark 获取验证码按钮点击 开始跑秒
-(void)starteTime{
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    MJWeakSelf
    if (self.timer==nil) {
        __block NSInteger timeOut = CodeTime;
        if (timeOut!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);//每秒执行
            dispatch_source_set_event_handler(self.timer, ^{
                if (timeOut<=0) {//当倒计时结束时
                    dispatch_source_cancel(weakSelf.timer);
                    weakSelf.timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.B_getCode setTitle:NSLocalizedString(@"Get verification code", nil) forState:UIControlStateNormal];
                        weakSelf.B_getCode.userInteractionEnabled = YES;
                    });

                }else{//倒计时计算
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.B_getCode setTitle:[NSString stringWithFormat:NSLocalizedString(@"You can resend it after %ld seconds", nil),timeOut] forState:UIControlStateNormal];
                        weakSelf.B_getCode.userInteractionEnabled = NO;
                    });
                    timeOut--;//递减
                }
            });
            dispatch_resume(self.timer);

        }
    }
}
#pragma mark  获取验证码
-(void)buttonClcikedSelectedCode:(UIButton *)btn{
    [self.view endEditing:YES];

    [self getCodeData];
    
}
#pragma mark 获取验证码
-(void)getCodeData{
    [MBProgressHUD showMessage:@"" toView:YX_Keywindow];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString * url = API_CaptchaEmailRegister;
    if ([self fyl_getLocalAddressType] == 1) {
        url = API_SmsCodeRegister;
        [parameters setObject:self.eamal forKey:@"userPhoneNumber"];
        if (self.type == VerificationCodeFromSign) {
            [parameters setObject:@(1) forKey:@"codeType"];
        }else if (self.type == VerificationCodeFromForgotPassword){
            [parameters setObject:@(2) forKey:@"codeType"];
        }
    }else{
        if (self.type == VerificationCodeFromForgotPassword) {
            if (ZJ_UserLoginInfomation.getLogin) {
                url = WIFI_CaptchaEmailCode;
            }else{
                url = API_CaptchaEmailPassword;
            }
            
        }else if (self.type == VerificationCodeTypeFromLogin){
            url = API_CaptchaEmailNewCode;
        }
        [parameters setObject:self.eamal forKey:@"userEmail"];

    }
    
//    [[YXHTTPRequst shareInstance]networking:url parameters:parameters method:YXRequstMethodTypePOST showErrorView:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//        BaseModel * baseModel = [BaseModel loadModelWithDictionary:responseObject];
//        if(baseModel.code.intValue==1){
//            [self.V_codes becomeFirstResponder];
//            [self starteTime];
//        }
//        
//    } failsure:^(NSURLSessionDataTask *task, id cacheData, NSError * error) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//    }];
     
}



-(void)yl_creatUI{
    [self changeTitle:NSLocalizedString(@"Verification code login", nil)];
    
    
    
    UILabel * L_top_contect = [[UILabel alloc]init];
    if ([self fyl_getLocalAddressType] == 1) {
        L_top_contect.text = [NSString stringWithFormat:NSLocalizedString(@"Please enter the verification code we sent to %@.", nil),self.eamal];

    }else{
        L_top_contect.text = [NSString stringWithFormat:NSLocalizedString(@"Please enter the verification code we sent to %@. If you did not receive it, please check your spam.", nil),self.eamal];

    }
    L_top_contect.textColor = rgba(61, 61, 61, 1);
    L_top_contect.font = Px22Font;
    L_top_contect.numberOfLines = 0;
    [self.V_bg_contect addSubview:L_top_contect];
    [L_top_contect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.V_bg_contect).mas_offset(AdaptedHeightValue(40));
        make.left.mas_equalTo(self.V_bg_contect).mas_offset(AdaptedWidthValue(30));
        make.right.mas_equalTo(self.V_bg_contect).mas_offset(-AdaptedWidthValue(30));
    }];
    
    SMSCodeInputView * codeView = [[SMSCodeInputView alloc]initWithFrame:CGRectMake(AdaptedWidthValue(40), 0, kScreenWidth-AdaptedWidthValue(80), 50)];
    codeView.delegate = self;
    codeView.codeSpace = 5;
    codeView.codeCount = 6;
    self.V_codes = codeView;
    [self.V_bg_contect addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(L_top_contect.mas_bottom).mas_offset(AdaptedHeightValue(10));
        make.left.mas_equalTo(L_top_contect);
        make.right.mas_equalTo(L_top_contect);
        make.height.mas_equalTo(50);
    }];
    
//    HWTFCodeBView *code2View = [[HWTFCodeBView alloc] initWithCount:6 margin:8];
//    self.V_code = code2View;
//    code2View.delegate = self;
//    [code2View EvocativeKeyboard];
//    [self.V_bg_contect addSubview:code2View];
//    [code2View mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(L_top_contect.mas_bottom).mas_offset(AdaptedHeightValue(5));
//        make.left.mas_equalTo(L_top_contect);
//        make.right.mas_equalTo(L_top_contect);
//        make.height.mas_equalTo(43);
//    }];
    UIButton * B_getCode = [UIButton buttonWithType:UIButtonTypeCustom];
    self.B_getCode = B_getCode;
    [B_getCode setTitle:NSLocalizedString(@"Get verification code", nil) forState:UIControlStateNormal];
    B_getCode.titleLabel.font = Px22Font;
    [B_getCode setTitleColor:rgba(16, 186, 238, 1) forState:UIControlStateNormal];
    [B_getCode addTarget:self action:@selector(buttonClcikedSelectedCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.V_bg_contect addSubview:B_getCode];
    [B_getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeView.mas_bottom).mas_offset(AdaptedHeightValue(50));
        make.left.mas_equalTo(L_top_contect);
    }];
    
    ZZLabel * L_bottom_contect = [[ZZLabel alloc]initWithTextColor:rgba(61, 61, 61, 1) Font:Px22Font TextString:@"The verification code is valid for 30 minutes"];
    L_bottom_contect.numberOfLines = 0;
    [self.V_bg_contect addSubview:L_bottom_contect];
    [L_bottom_contect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(B_getCode.mas_bottom).mas_offset(-AdaptedHeightValue(4));
        make.left.mas_equalTo(B_getCode);
        make.right.mas_equalTo(L_top_contect);
    }];
    
    
    UIButton * B_bottom = [self creatButtonTitle:NSLocalizedString(@"Verification code login", nil) withFont:Px32Font withTitleColor:rgba(255, 255, 255, 1) withImageName:@"SelectedDeviceSureBtn_bg" withBackGroundColor:UIColor.clearColor withTag:2];
    [self.V_bg_contect addSubview:B_bottom];
    [B_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(L_bottom_contect.mas_bottom).mas_offset(AdaptedHeightValue(80));
        make.left.mas_equalTo(L_top_contect);
        make.right.mas_equalTo(L_top_contect);
        make.height.mas_equalTo(AdaptedHeightValue(40));
    }];
    B_bottom.layer.cornerRadius = AdaptedHeightValue(40)/2;
    B_bottom.layer.masksToBounds = YES;
    B_bottom.backgroundColor = rgba(16, 186, 238, 1);
    
    
    if (self.type == VerificationCodeFromSign || self.type == VerificationCodeFromForgotPassword) {
        [B_bottom setTitle:NSLocalizedString(@"Next step", nil) forState:UIControlStateNormal];
        if ([self fyl_getLocalAddressType] == 1) {
            [self changeTitle:NSLocalizedString(@"Mobile phone verification", nil)];
        }else{
            [self changeTitle:NSLocalizedString(@"Email verification", nil)];
        }
       
        
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.V_codes becomeFirstResponder];
    });
    
    
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
