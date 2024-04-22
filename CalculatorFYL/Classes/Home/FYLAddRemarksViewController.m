//
//  FYLAddRemarksViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/10.
//

#import "FYLAddRemarksViewController.h"
#import "UITextView+Placeholder.h"
#import "ZXDataHandle.h"
#import "ZXDecimalNumberTool.h"
#import "FYLOnFileModel.h"

@interface FYLAddRemarksViewController ()
@property(nonatomic,strong)UITextView * V_text;
@property(nonatomic,strong)UIView * V_bg_bottom;
@property(nonatomic,assign)NSInteger textDirectionType;

@end

@implementation FYLAddRemarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = NSLocalizedString(@"Remarks", nil);
    
    [self creatUI];
    
    // Do any additional setup after loading the view.
}
#pragma mark -- 键盘将要显示
-(void)boardWillShow:(NSNotification *)notification{
    //获取键盘高度，
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
  //键盘弹出的时间
    [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:[[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.V_bg_bottom.hidden = NO;
        [self.V_bg_bottom mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view).mas_offset(-kbHeight);
        }];
        [self.V_text mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view).mas_offset(-(kbHeight+50));
        }];
        
        
    }];

}
#pragma mark 将多条记录存储到数据库
-(void)rightItemClicked{
    if (!IS_VALID_STRING(self.V_text.text)) {
        return;
    }
    if (self.type == AddRemarksType_OnFile) {
        FYLOnFileModel *cat = [[FYLOnFileModel alloc]init];
        cat.title = self.V_text.text;
        cat.listCount =[NSString stringWithFormat:@"%ld",self.dataArray.count];
        NSString * ids_time = [NSString stringWithFormat:@"%@%u",[[ToolManagement sharedManager]currentTimeStr],arc4random_uniform(1000)];
        cat.IDs = ids_time.doubleValue;
        cat.resArrJson = [self.dataArray zx_toJsonStr];
        BOOL success = [cat zx_dbSave];
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
       
    }else{
        __block NSUInteger index;
        [self.dataArray enumerateObjectsUsingBlock:^(FYLHistoryModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqual:self.Model]) {
                index = idx;
                *stop = YES;
                NSLog(@"需要插入的位置====：%ld",idx);
            }
        }];
        if (self.fyl_edit == 1) {
            self.Model.contect = self.V_text.text;
            self.Model.textDirectionType = self.textDirectionType;
            NSString * sqStr = [NSString stringWithFormat:@"IDs=%.f",self.Model.IDs];
            BOOL res = [self.Model zx_dbUpdateWhere:sqStr];
            NSLog(@"修改结果--%i",res);
            if (res) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }else{
            FYLHistoryModel * remarksModel = [[FYLHistoryModel alloc]init];
            remarksModel.time = self.Model.time;
            remarksModel.state = HistoryTypeStatus_beizhu;
            remarksModel.contect = self.V_text.text;
            remarksModel.userName = @"123";
            remarksModel.textDirectionType = self.textDirectionType;
            NSString * ids_time = [NSString stringWithFormat:@"%@%u",[[ToolManagement sharedManager]currentTimeStr],arc4random_uniform(1000)];
            remarksModel.IDs = ids_time.doubleValue;
            [self.dataArray insertObject:remarksModel atIndex:index+1];
            [FYLHistoryModel zx_dbDropTable];
            BOOL res = [self.dataArray zx_dbSave];
            NSLog(@"添加结果--%i",res);
            if (res) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
        
    }
    
    
    
    
    
   
}
-(void)didSelectedLeftTextClicked:(UIButton *)btn{
    if (btn.tag == 0) {
        NSString * time_one = [[ToolManagement sharedManager]currentTimeStr];
        NSString * time =  [[ToolManagement sharedManager]yl_getDateStringWithTimeStr:time_one];
        self.V_text.text = [NSString stringWithFormat:@"%@ %@ ",self.V_text.text,time];
    }else if (btn.tag == 1){
        UIPasteboard * paste = [UIPasteboard generalPasteboard];
        if (IS_VALID_STRING(paste.string) ) {
            self.V_text.text = [NSString stringWithFormat:@"%@ %@ ",self.V_text.text,paste.string];
        }
    }else if (btn.tag == 2){
        self.textDirectionType = 0;
        self.V_text.textAlignment = NSTextAlignmentLeft;
        self.V_text.placeholderTextView.textAlignment = NSTextAlignmentLeft;
        self.V_text.selectedRange = NSMakeRange(self.V_text.text.length, 1);

    }else if (btn.tag == 3){
        self.textDirectionType = 1;
        self.V_text.textAlignment = NSTextAlignmentRight;
        self.V_text.placeholderTextView.textAlignment = NSTextAlignmentRight;
        self.V_text.selectedRange = NSMakeRange(self.V_text.text.length, 1);
    }
    
    
}















-(void)creatUI{
    [self setNavRightItem:NSLocalizedString(@"Done", nil) withImage:nil];

    self.view.backgroundColor = UIColor.whiteColor;
    
    UITextView *textView = [[UITextView alloc] init];
   
    self.V_text = textView;
//    textView.frame = CGRectMake(50, 120, 200, 200);
    textView.placeholder = NSLocalizedString(@"Remarks", nil);
    textView.font = [UIFont systemFontOfSize:15];
    textView.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.view).mas_offset(2);
        make.right.mas_equalTo(self.view).mas_offset(-2);
        make.bottom.mas_equalTo(self.view).mas_offset(-400);
    }];
    
    UIView * V_bg_bottom = [[UIView alloc]init];
    self.V_bg_bottom = V_bg_bottom;
    V_bg_bottom.hidden = YES;
    V_bg_bottom.backgroundColor = UIColor.purpleColor;
    [self.view addSubview:V_bg_bottom];
    [V_bg_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-SBottomSafeHeight);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@50);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [textView becomeFirstResponder];
    });
    //键盘将要显示时候的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boardWillShow:) name:UIKeyboardWillShowNotification object:nil];
   
    UIButton * B_time = [UIButton buttonWithType:0];
    B_time.tag = 0;
    [B_time addTarget:self action:@selector(didSelectedLeftTextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [B_time setTitle:@"时间" forState:UIControlStateNormal];
    [V_bg_bottom addSubview:B_time];
    [B_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(V_bg_bottom).mas_offset(5);
        make.centerY.mas_equalTo(V_bg_bottom);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    UIButton * B_NT = [UIButton buttonWithType:0];
    B_NT.tag = 1;
    [B_NT addTarget:self action:@selector(didSelectedLeftTextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [B_NT setTitle:@"粘贴" forState:UIControlStateNormal];
    [V_bg_bottom addSubview:B_NT];
    [B_NT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(B_time.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(V_bg_bottom);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    UIButton * B_left_text = [UIButton buttonWithType:0];
    B_left_text.tag = 2;
    [B_left_text addTarget:self action:@selector(didSelectedLeftTextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [B_left_text setTitle:@"左对齐" forState:UIControlStateNormal];
    [V_bg_bottom addSubview:B_left_text];
    [B_left_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(B_NT.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(V_bg_bottom);
        make.size.mas_equalTo(CGSizeMake(70, 50));
    }];
    UIButton * B_right_text = [UIButton buttonWithType:0];
    B_right_text.tag = 3;
    [B_right_text addTarget:self action:@selector(didSelectedLeftTextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [B_right_text setTitle:@"右对齐" forState:UIControlStateNormal];
    [V_bg_bottom addSubview:B_right_text];
    [B_right_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(B_left_text.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(V_bg_bottom);
        make.size.mas_equalTo(CGSizeMake(70, 50));
    }];
    
    if (self.fyl_edit == 1) {
        if (IS_VALID_STRING(self.Model.contect)) {
            self.V_text.text = self.Model.contect;
        }
    }
    if (self.type == AddRemarksType_OnFile) {
        B_left_text.hidden = YES;
        B_right_text.hidden = YES;
        self.navTitle = NSLocalizedString(@"Save current record", nil);
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
