//
//  FYLHelpFeedbackViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/5/5.
//

#import "FYLHelpFeedbackViewController.h"
#import "UITextView+Placeholder.h"
#import "FYLHelpFeedbackListViewController.h"

@interface FYLHelpFeedbackViewController ()
@property(nonatomic,strong)UITextView *V_text;
@property(nonatomic,strong)UITextField * T_phone;

@end

@implementation FYLHelpFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = [YLUserToolManager getTextTag:24];
    
    [self creatUI];
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(void)rightItemClicked{
    [self.view endEditing:YES];
    FYLHelpFeedbackListViewController * vc = [[FYLHelpFeedbackListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -- 确定
-(void)buttonClickedLogioUserPerson:(UIButton *)btn{
    [self.view endEditing:YES];
    if (!IS_VALID_STRING(self.V_text.text)) {
        return;
    }
    //df095ec35b381c8596563204299bf6fbba91dee8
    NSString * openUUID = [OpenUDID value];
    NSMutableDictionary * parm = [NSMutableDictionary dictionary];
    [parm setObject:openUUID forKey:@"uniqueld"];
    [parm setObject:self.V_text.text forKey:@"content"];
    [[YXHTTPRequst shareInstance]yl_networking:API_feedbackadd parameters:parm method:YXRequstMethodTypePOST showLoadingView:YES showLoadingTitle:@"" showErrorView:YES success:^(NSURLSessionDataTask *task, id responseObject) {
            
    } failsure:^(NSURLSessionDataTask *task, id cacheData, NSError *error) {
        
    }];
    
    
    
}



-(void)creatUI{
    self.yl_rightButton.titleLabel.font = Px30Font;
    [self.yl_rightButton setTitle:[YLUserToolManager getTextTag:39] forState:UIControlStateNormal];
    [self.view addSubview:self.yl_rightButton];
    [self.yl_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.navigationBar.titleLab);
        make.right.mas_equalTo(self.view).mas_offset(-10);
    }];
//    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView * V_topline = [[UIView alloc]init];
    V_topline.backgroundColor = rgba(180, 180, 180, 1);
    [self.view addSubview:V_topline];
    [V_topline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar.mas_bottom).mas_offset(10);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@0.5);
    }];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = UIColor.clearColor;
    textView.placeholderColor = rgba(180, 180, 180, 1);
    self.V_text = textView;
//    textView.frame = CGRectMake(50, 120, 200, 200);
    textView.placeholder = [YLUserToolManager getTextTag:40];
    textView.font = [UIFont systemFontOfSize:15];
    textView.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    textView.textColor = UIColor.whiteColor;
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(V_topline.mas_bottom).mas_offset(4);
        make.left.mas_equalTo(self.view).mas_offset(2);
        make.right.mas_equalTo(self.view).mas_offset(-2);
        make.height.mas_equalTo(@200);
    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [textView becomeFirstResponder];
//    });
    UIView * V_bottomline = [[UIView alloc]init];
    V_bottomline.backgroundColor = rgba(180, 180, 180, 1);
    [self.view addSubview:V_bottomline];
    [V_bottomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textView.mas_bottom).mas_offset(10);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@0.5);
    }];
    
    
    UITextField * T_phone = [[UITextField alloc]init];
    self.T_phone = T_phone;
    NSString *holderText = [YLUserToolManager getTextTag:41];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                            value:rgba(180, 180, 180, 1)
                            range:NSMakeRange(0, holderText.length)];
    T_phone.attributedPlaceholder = placeholder;
    T_phone.textColor = UIColor.whiteColor;
    T_phone.font = Px28Font;
    T_phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:T_phone];
    [T_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textView).mas_offset(7);
        make.right.mas_equalTo(textView).mas_offset(-7);
        make.top.mas_equalTo(V_bottomline.mas_bottom).mas_offset(3);
        make.height.mas_equalTo(25);
    }];
    UIView * V_bottomPhoneline = [[UIView alloc]init];
    V_bottomPhoneline.backgroundColor = rgba(180, 180, 180, 1);
    [self.view addSubview:V_bottomPhoneline];
    [V_bottomPhoneline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(T_phone.mas_bottom).mas_offset(10);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@0.5);
    }];
    
    //确定
    UIButton * B_sure = [UIButton buttonWithType:UIButtonTypeCustom];
    [B_sure setTitle:[YLUserToolManager getTextTag:8] forState:UIControlStateNormal];
    B_sure.titleLabel.font = Px32Font;
    [B_sure setTitleColor:rgba(255, 255, 255, 1) forState:UIControlStateNormal];
    [B_sure addTarget:self action:@selector(buttonClickedLogioUserPerson:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:B_sure];
    [B_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(V_bottomPhoneline.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(T_phone).mas_offset(10);
        make.right.mas_equalTo(T_phone).mas_offset(-10);
        make.height.mas_equalTo(50);
    }];
    B_sure.layer.cornerRadius = 5;
    B_sure.layer.masksToBounds = YES;
    B_sure.backgroundColor = rgba(16, 180, 230, 1);
    
    
    
    
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
