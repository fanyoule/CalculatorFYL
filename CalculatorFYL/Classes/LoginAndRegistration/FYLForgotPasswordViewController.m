//
//  FYLForgotPasswordViewController.m
//  JoyLight
//
//  Created by tianhao on 2024/2/26.
//

#import "FYLForgotPasswordViewController.h"
#import "SHMEmojiMethod.h"
#import "FYLVerificationCodeLoginViewController.h"

@interface FYLForgotPasswordViewController ()
<
UITextFieldDelegate
>
@property(nonatomic,strong)UITextField * T_eamal;

@end

@implementation FYLForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPopBackItem];
    [self yl_creatUI];
    
    // Do any additional setup after loading the view.
}
-(void)getCodeData{
    
    [MBProgressHUD showMessage:@"" toView:YX_Keywindow];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
   
    NSString * url = API_CaptchaEmailRegister;
    if ([self fyl_getLocalAddressType] == 1) {
        url = API_SmsCodeRegister;
        [parameters setObject:self.T_eamal.text forKey:@"userPhoneNumber"];
        if (self.type == ForgotPasswordTypeFromForgot) {
            [parameters setObject:@(2) forKey:@"codeType"];
        }else{
            [parameters setObject:@(1) forKey:@"codeType"];
        }
    }else{
        if (self.type == ForgotPasswordTypeFromForgot) {
            if (ZJ_UserLoginInfomation.getLogin) {
                url = WIFI_CaptchaEmailCode;
            }else{
                url = API_CaptchaEmailPassword;
            }
        }
        [parameters setObject:self.T_eamal.text forKey:@"userEmail"];
    }
   
//    [[YXHTTPRequst shareInstance]networking:url parameters:parameters method:YXRequstMethodTypePOST showErrorView:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//        BaseModel * baseModel = [BaseModel loadModelWithDictionary:responseObject];
//        if(baseModel.code.intValue==1){
//            NSLog(@"忘记密码-----下一步");
//            FYLVerificationCodeLoginViewController * vc = [[FYLVerificationCodeLoginViewController alloc]init];
//            vc.eamal = self.T_eamal.text;
//            if (self.type == ForgotPasswordTypeFromSign) {
//                vc.type = VerificationCodeFromSign;
//            }else if(self.type == ForgotPasswordTypeFromForgot){
//                vc.type = VerificationCodeFromForgotPassword;
//            }
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        
//        
//    } failsure:^(NSURLSessionDataTask *task, id cacheData, NSError * error) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//        
//    }];
     
}
#pragma mark -- 获取验证码
-(void)didSelectedBaseButtonClicked:(UIButton *)btn{
    if (btn.tag == 3) {//返回登录
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self buttonClickedpasswordlogin];
    }
}

-(void)buttonClickedpasswordlogin{
    [self.view endEditing:YES];
    if (!IS_VALID_STRING(self.T_eamal.text)) {
        if([self fyl_getLocalAddressType] == 1){//国内
            [SVProgressHUD showDetailMessage:NSLocalizedString(@"Please enter your phone number", nil) delay:2];
        }else{
            [SVProgressHUD showDetailMessage:NSLocalizedString(@"please input your email", nil) delay:2];
        }
       
        return;
    }
    
    [self getCodeData];
}



#pragma mark -- UITextFieldDelegate
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


-(void)yl_creatUI{
  
    
    [self changeTitle:NSLocalizedString(@"Forget password", nil)];
    
    
    
    NSArray * arr_view = [self creatTextFieldHolderText:NSLocalizedString(@"please input your email", nil) withTextFont:Px28Font withTextColor:UIColor.blackColor withTag:1];
    UIView * V_root_text = arr_view.firstObject;
    UITextField * T_eamal = arr_view.lastObject;
    self.T_eamal = T_eamal;
    T_eamal.delegate = self;
    if (IS_VALID_STRING(self.email)) {
        T_eamal.text = self.email;
        if (self.type == ForgotPasswordTypeFromForgot) {
            T_eamal.userInteractionEnabled = NO;
        }
    }
    [self.V_bg_contect addSubview:V_root_text];
    [V_root_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.V_bg_contect).mas_offset(AdaptedWidthValue(30));
        make.top.mas_equalTo(self.V_bg_contect).mas_offset(AdaptedHeightValue(40));
        make.right.mas_equalTo(self.V_bg_contect).mas_offset(-AdaptedWidthValue(30));
        make.height.mas_equalTo(AdaptedHeightValue(50));
    }];
   
   
    UIButton * B_passwordlogin = [self creatButtonTitle:NSLocalizedString(@"Get verification code", nil) withFont:Px32Font withTitleColor:rgba(255, 255, 255, 1) withImageName:@"SelectedDeviceSureBtn_bg" withBackGroundColor:UIColor.clearColor withTag:2];
    [self.V_bg_contect addSubview:B_passwordlogin];
    [B_passwordlogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(T_eamal.mas_bottom).mas_offset(AdaptedHeightValue(130));
        make.left.mas_equalTo(T_eamal);
        make.right.mas_equalTo(T_eamal);
        make.height.mas_equalTo(AdaptedHeightValue(40));
    }];
    B_passwordlogin.layer.cornerRadius = AdaptedHeightValue(40)/2;
    B_passwordlogin.layer.masksToBounds = YES;
    B_passwordlogin.backgroundColor = rgba(16, 186, 238, 1);
    
    if (self.type == ForgotPasswordTypeFromSign) {
        [self changeTitle:NSLocalizedString(@"Account registration", nil)];
        UIButton * B_backLogin = [self creatButtonTitle:NSLocalizedString(@"Go log in", nil) withFont:Px32Font withTitleColor:rgba(255, 255, 255, 1) withImageName:@"SelectedDeviceSureBtn_bg" withBackGroundColor:UIColor.clearColor withTag:3];
        [self.V_bg_contect addSubview:B_backLogin];
        [B_backLogin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(B_passwordlogin.mas_bottom).mas_offset(AdaptedHeightValue(20));
            make.left.mas_equalTo(T_eamal);
            make.right.mas_equalTo(T_eamal);
            make.height.mas_equalTo(AdaptedHeightValue(40));
        }];
        B_backLogin.layer.cornerRadius = AdaptedHeightValue(40)/2;
        B_backLogin.layer.masksToBounds = YES;
        B_backLogin.backgroundColor = rgba(16, 186, 238, 1);
    }
    if([self fyl_getLocalAddressType] == 1){//国内
        self.T_eamal.placeholder = NSLocalizedString(@"Please enter your phone number", nil);
        [self.T_eamal limitOnlyNumber:YES];
        [self.T_eamal limitTextLength:11];
    }else{
        self.T_eamal.placeholder = NSLocalizedString(@"please input your email", nil);
        [self.T_eamal limitOnlyNumber:NO];
        [self.T_eamal limitTextLength:30];
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
