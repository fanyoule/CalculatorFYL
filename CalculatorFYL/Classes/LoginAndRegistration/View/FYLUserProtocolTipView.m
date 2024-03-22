
#import "FYLUserProtocolTipView.h"

 
@implementation FYLUserProtocolTipView
- (instancetype)initWithTitle:(NSString *)title {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        self.backgroundColor = rgba(0, 0, 0, .6);
       
        UIView * V_root_contect = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 150)];
        V_root_contect.center = self.center;
        V_root_contect.backgroundColor = UIColor.whiteColor;
        V_root_contect.layer.cornerRadius = 10.0;
        V_root_contect.layer.masksToBounds = YES;
        [self addSubview:V_root_contect];
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 260, 70)];
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
       
        
        NSString * hexTip = NSLocalizedString(@"Lea atentamente y acepte antes de usar Allbest Home", nil);
        NSString * UserAgreement = NSLocalizedString(@"User Agreement", nil);
        NSString * PrivacyPolicy = NSLocalizedString(@"Privacy Policy", nil);
        NSString * same = NSLocalizedString(@"Gentle", nil);//
        NSString *yl_agreementString =[NSString stringWithFormat:@"%@ %@ %@ %@",hexTip,UserAgreement,same,PrivacyPolicy];
        
        NSMutableAttributedString *attributedString = [NSMutableAttributedString wy_attributeWithStr:yl_agreementString];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0]  range:NSMakeRange(0, yl_agreementString.length)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, yl_agreementString.length)];
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle wy_paragraphStyle];
        style.alignment = NSTextAlignmentLeft;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, yl_agreementString.length)];
        
        NSRange userAgreementRange = [yl_agreementString rangeOfString:UserAgreement];
        NSRange privacyPolicyRange = [yl_agreementString rangeOfString:PrivacyPolicy];
       
        if (userAgreementRange.location != NSNotFound && privacyPolicyRange.location != NSNotFound) {
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0] range:userAgreementRange];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0] range:privacyPolicyRange];
        }
        
        titleLabel.attributedText = attributedString;

        [V_root_contect  addSubview:titleLabel];
        [titleLabel wy_clickRichTextWithStrings:@[UserAgreement, PrivacyPolicy] delegate:self];
        
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setFrame:CGRectMake(30, 100, 100, 40)];
        NSString * disagreeString = NSLocalizedString(@"Disagree", nil);
        [cancelButton setTitle:disagreeString forState:UIControlStateNormal];
        UIFont *buttonFont = [UIFont systemFontOfSize:15.0];
        [cancelButton.titleLabel setFont:buttonFont];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [V_root_contect addSubview:cancelButton];
        UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmButton setFrame:CGRectMake(170, 100, 100, 40)];
        NSString * agreetstring = NSLocalizedString(@"Consent", nil);
        [confirmButton setTitle:agreetstring forState:UIControlStateNormal];
       
        [confirmButton.titleLabel setFont:buttonFont];
        [confirmButton setTitleColor:[UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [confirmButton addTarget:self action:@selector(confirmButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [V_root_contect addSubview:confirmButton];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(149.5, 100,1, 50)];
        line.backgroundColor = LineBackgroundColor;
        [V_root_contect addSubview:line];
        UIView *line_top = [[UIView alloc] init];
        line_top.backgroundColor = LineBackgroundColor;
        [V_root_contect addSubview:line_top];
        [line_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(V_root_contect);
            make.right.mas_equalTo(V_root_contect);
            make.bottom.mas_equalTo(line.mas_top);
            make.height.mas_equalTo(@1);
        }];
        
    }
    return self;
}
#pragma mark 协议点击
- (void)wy_didClickRichText:(NSString *)string range:(NSRange)range index:(NSInteger)index{
    if (index==0) {
       if (self.selectAction) {
            self.selectAction(0);
        }
   } else {
       if (self.selectAction) {
            self.selectAction(1);
        }
    }
}
- (void)cancelButtonTapped {
    if (self.cancelAction) {
        self.cancelAction();
    }
}

- (void)confirmButtonTapped {
    if (self.confirmAction) {
        self.confirmAction();
    }
}
@end
