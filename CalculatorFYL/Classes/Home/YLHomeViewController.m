//
//  YLHomeViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/3/21.
//

#import "YLHomeViewController.h"
#import "FYLHistoricalRecordCell.h"
#import "FYLRegularKeyboardView.h"
#import "FYLVIPKeyboardView.h"
#import "YLShareDeviceOuterModel.h"
#import "FYLHistoryModel.h"
#import "FYLHistoricalRecordNewCell.h"
#import "YLDIYEditBoxListView.h"

#define MaxCount 20
@interface YLHomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
FYLRegularKeyboardViewdelegate,
FYLVIPKeyboardViewdelegate
>
@property(nonatomic,strong)ZZLabel * L_contect;
@property(nonatomic,strong)UIView * V_contect;
@property(nonatomic,strong)UIView * V_storehistory;
@property(nonatomic,strong)UIScrollView * V_scroll;
@property(nonatomic,strong)UIView * V_bg_bottom;
@property(nonatomic,strong)FYLRegularKeyboardView * regularKey;
@property(nonatomic,strong)FYLVIPKeyboardView * vipKey;
@property(nonatomic,strong)NSMutableArray * outDataArr;
///方向 0向下 1向上
@property(nonatomic,assign)NSInteger directionType;
//@property (strong, nonatomic) advancedCalculator *calculate;
//@property int flag;


@end

@implementation YLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    [self readHistoryData];
}
// 记录小数点状态  1已输入小数点 0未输入小数点
int pointFlag = 0;
// 防止连续输入符号  1已输入运算符  0未输入运算符
int secondFlag = 0;
// 记录等于号状态
int equalFlag = 0;
// 记录数字后再输入小数点 0数字 1运算符
int numpoint = 0;
//记录左括号数量
int leftbrackets = 0;

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}
#pragma mark 读取历史记录
-(void)readHistoryData{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray: [FYLHistoryModel obtainTheModelUserHistory:@"123"]];
    [self handleDataIntoModels];
    if (self.dataArray.count>0) {
        YLShareDeviceOuterModel * outModel = self.outDataArr.lastObject;
        [self.table_groupV scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:outModel.detailModelArr.count-1 inSection:self.outDataArr.count-1] atScrollPosition:UITableViewScrollPositionNone animated:NO];

    }
}
-(void)playSoundEffect:(NSString *)name{
    NSString *audioFile=[[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    SystemSoundID soundID=0;//获得系统声音ID
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    AudioServicesPlaySystemSound(soundID);//播放音效
}
#pragma mark -- 清空
-(void)clearDate{
    self.L_contect.text=@"";
    self.V_scroll.contentSize = CGSizeMake(kScreenWidth, 50);
    [self.V_scroll setContentOffset:CGPointMake(5, 0) animated:NO];
}

-(void)fyl_RegularKeyboardDidSelectedButton:(UIButton *)btn{
    NSLog(@"btn.titleLabel.text----:%@",btn.titleLabel.text);
    [self playSoundEffect:@"click.wav"];
    
    
    if ([btn.titleLabel.text isEqualToString:@"0"]) {
        
        secondFlag = 0;
        numpoint = 0;
        
        
        [self changeNumberGreateBtn:btn];
    }else if ([btn.titleLabel.text isEqualToString:@"1"]){
        secondFlag = 0;
        numpoint = 0;
        
        [self changeNumberGreateBtn:btn];

    }else if ([btn.titleLabel.text isEqualToString:@"2"]){
        secondFlag = 0;
        numpoint = 0;
        
        
        [self changeNumberGreateBtn:btn];

    }else if ([btn.titleLabel.text isEqualToString:@"3"]){
        secondFlag = 0;
        numpoint = 0;
        
        
        [self changeNumberGreateBtn:btn];

    }else if ([btn.titleLabel.text isEqualToString:@"4"]){
        secondFlag = 0;
        numpoint = 0;
        
        
        [self changeNumberGreateBtn:btn];

    }else if ([btn.titleLabel.text isEqualToString:@"5"]){
        secondFlag = 0;
        numpoint = 0;
        
        
        [self changeNumberGreateBtn:btn];

    }else if ([btn.titleLabel.text isEqualToString:@"6"]){
        secondFlag = 0;
        numpoint = 0;
        
        
        
        [self changeNumberGreateBtn:btn];

    }else if ([btn.titleLabel.text isEqualToString:@"7"]){
        secondFlag = 0;
        numpoint = 0;
        
        
        
        [self changeNumberGreateBtn:btn];

    }else if ([btn.titleLabel.text isEqualToString:@"8"]){
        secondFlag = 0;
        numpoint = 0;
        
        
        
        
        [self changeNumberGreateBtn:btn];

    }else if ([btn.titleLabel.text isEqualToString:@"9"]){
        secondFlag = 0;
        numpoint = 0;
        
        
        
        [self changeNumberGreateBtn:btn];

    }else if ([btn.titleLabel.text isEqualToString:@"."]){
        if (numpoint == 0 && pointFlag == 0) {
            if (!IS_VALID_STRING(self.L_contect.text)) {
                self.L_contect.text = @"0";
            }
            pointFlag = 1;
            [self changeNumberGreateBtn:btn];
        }
        

    }else if ([btn.titleLabel.text isEqualToString:@"C"]){
        pointFlag = 0;
        secondFlag = 0;
        equalFlag = 0;
        leftbrackets = 0;
        
        
        [self clearDate];
    }else if ([btn.titleLabel.text isEqualToString:@"÷"]){
        if (secondFlag == 0) {
            pointFlag = 0;
            secondFlag = 1;
            numpoint = 1;
            [self changeNumberGreateBtn:btn];
        }

    }else if ([btn.titleLabel.text isEqualToString:@"×"]){
        if (secondFlag == 0) {
            pointFlag = 0;
            secondFlag = 1;
            numpoint = 1;
            [self changeNumberGreateBtn:btn];
        }
        

    }else if ([btn.titleLabel.text isEqualToString:@"←"]){
        
        
        
        [self clearLastBit];
        
        
    }else if ([btn.titleLabel.text isEqualToString:@"-"]){
        if (secondFlag == 0) {
            pointFlag = 0;
            secondFlag = 1;
            numpoint = 1;
            [self changeNumberGreateBtn:btn];
        }
      
    }else if ([btn.titleLabel.text isEqualToString:@"+"]){
        if (secondFlag == 0) {
            pointFlag = 0;
            secondFlag = 1;
            numpoint = 1;
            [self changeNumberGreateBtn:btn];
        }

    }else if ([btn.titleLabel.text isEqualToString:@"="]){
        pointFlag = 0;
        secondFlag = 0;
        equalFlag = 0;
        leftbrackets = 0;
        
        [self actionEqual];
        if ([self.L_contect.text containsString:@"."]) {
            pointFlag = 1;
        }
    }else if ([btn.titleLabel.text isEqualToString:@"()"]){
        secondFlag = 0;
        if (leftbrackets != 0) {
            leftbrackets--;
            NSMutableString *originalString=[NSMutableString stringWithString:self.L_contect.text];
            [originalString appendString:@")"];
            self.L_contect.text=originalString;
            [self refreshWidthContent];
        }else{
            leftbrackets++;
            NSMutableString *originalString=[NSMutableString stringWithString:self.L_contect.text];
            [originalString appendString:@"("];
            self.L_contect.text=originalString;
            [self refreshWidthContent];
        }
        
    }else if ([btn.titleLabel.text isEqualToString:@"%"]){
        if (secondFlag == 0) {
            pointFlag = 0;
            secondFlag = 1;
            numpoint = 1;
            [self changeNumberGreateBtn:btn];
        }

    }
    
    
}
-(void)changeNumberGreateBtn:(UIButton *)btn{
   
    NSMutableString *originalString=[NSMutableString stringWithString:self.L_contect.text];
    [originalString appendString:[[btn titleLabel] text]];
    self.L_contect.text=originalString;
    [self refreshWidthContent];
}


#pragma mark -- 等于
-(void)actionEqual{
    if(!IS_VALID_STRING(self.L_contect.text)){
        return;
    }
    
    NSString* jsExpString = self.L_contect.text;
    NSString* old_str = self.L_contect.text;
    jsExpString = [jsExpString stringByReplacingOccurrencesOfString:@"×" withString:@"*"];
    jsExpString = [jsExpString stringByReplacingOccurrencesOfString:@"÷" withString:@"/"];
    jsExpString = [jsExpString stringByReplacingOccurrencesOfString:@"%" withString:@"*0.01"];
    //表达式预测试
    BOOL allRight = [MSExpressionHelper helperCheckExpression:jsExpString usingBlock:^(NSError *error, NSRange range) {
        NSLog(@"%@",error);
    }];
    
    if(allRight){
        //计算表达式
        NSDecimalNumber* computeResult = [MSParser parserComputeNumberExpression:jsExpString error:nil];
        NSDecimal decimal = computeResult.decimalValue;
        NSDecimal desDecimal;
        NSDecimalRound(&desDecimal, &decimal , 3, NSRoundPlain);
        NSLog(@"保留3位小数计算结果为：%@",[NSDecimalNumber decimalNumberWithDecimal:desDecimal]);
        NSString * jieguo = [NSString stringWithFormat:@"%@",[NSDecimalNumber decimalNumberWithDecimal:desDecimal].stringValue];
        self.L_contect.text= jieguo;
        [self refreshWidthContent];
        NSString * calculateResult_new2 = old_str;
        NSString * currtime = [[PublicHelpers shareManager]getCurrentDate];
        FYLHistoryModel * model = [[FYLHistoryModel alloc]init];
        model.time = [[ToolManagement sharedManager]getTimeStrWithString:currtime];
        model.text = [NSString stringWithFormat:@"%@=%@",calculateResult_new2,jieguo];
        model.userName = @"123";
    
        BOOL success = [model saveToDB];
        if (success) {
            [self readHistoryData];
        }
        
        //表达式转JS表达式
        NSString* jsExpression = [MSParser parserJSExpressionFromExpression:jsExpString error:nil];
        NSLog(@"转JS表达式结果为：%@",jsExpression);
    }
    

    
    
    
    
    

}
-(void)refreshWidthContent{
    CGFloat width_text = [self.L_contect.text jk_widthWithFont:PxM56Font constrainedToHeight:50];
    if (width_text>kScreenWidth) {
        self.L_contect.frame = CGRectMake(0, 15, width_text, 30);
        self.V_scroll.contentSize = CGSizeMake(width_text+30, 50);
        [self.V_scroll setContentOffset:CGPointMake(width_text-kScreenWidth, 0) animated:NO];
    }
}
#pragma mark -- 末尾清除
-(void)clearLastBit{
    NSInteger length=[self.L_contect.text length];
    if(length>0){
        NSString * lastStr_old = [self.L_contect.text substringWithRange:NSMakeRange(self.L_contect.text.length-1, 1)];
        NSMutableString *delResultString=[NSMutableString stringWithString:self.L_contect.text];
        [delResultString deleteCharactersInRange:NSMakeRange(length-1, 1)];
        self.L_contect.text=delResultString;
        NSString * lastStr_new = [self.L_contect.text substringWithRange:NSMakeRange(self.L_contect.text.length-1, 1)];
        if ([lastStr_old isEqualToString:@"÷"]||[lastStr_old isEqualToString:@"×"]||[lastStr_old isEqualToString:@"-"]||[lastStr_old isEqualToString:@"+"]||[lastStr_old isEqualToString:@"%"]) {
            secondFlag = 0;
            
        }else if ([lastStr_old isEqualToString:@"("]){
            
        }else if ([lastStr_old isEqualToString:@")"]){
            
        }else if ([lastStr_old isEqualToString:@"."]){
            pointFlag = 0;
            
        }else{
            
        }
       
    }
    
}

-(void)setNumberDisplay:(NSString *)numberDisplay{
    self.L_contect.text=[self setNumber:numberDisplay];
    CGFloat width_text = [self.L_contect.text jk_widthWithFont:PxM56Font constrainedToHeight:50];
    if (width_text>kScreenWidth) {
        self.L_contect.frame = CGRectMake(0, 15, width_text, 30);
        self.V_scroll.contentSize = CGSizeMake(width_text+30, 50);
        [self.V_scroll setContentOffset:CGPointMake(width_text-kScreenWidth, 0) animated:NO];
    }
}

-(NSString *)setNumber:(NSString *)number{
    NSMutableString *strnumber=[[NSMutableString alloc]init];
    strnumber=[number mutableCopy];
    int length=(int)strnumber.length;
    int index;
    NSRange rang=[strnumber rangeOfString:@"."];
    if (rang.length>0) {
        for ( int j=0; j<=length; j++) {
            NSString *Char=[strnumber substringWithRange:NSMakeRange(j, 1)];
            if ([Char isEqualToString:@"."]) {
                index=j;
                break;
            }
        }if (3<index&&index<=9) {
            for (int i=index; i>3; i=i-3) {//找出小数点为位置i
                if ([[strnumber substringWithRange:NSMakeRange(i-4,1)]isEqualToString:@"-"]) {
                    break;
                }else{
                    [strnumber insertString:@"," atIndex:i-3];
                }
            }
        }
    } else if (3<length) {
        for (int i=length; i>3; i=i-3) {
            if ([[strnumber substringWithRange:NSMakeRange(i-4,1)]isEqualToString:@"-"]) {
                break;
            }else{
                [strnumber insertString:@"," atIndex:i-3];
            }
        }
    }

    number=[strnumber copy];
    return number;
}


#pragma mark -- 向下or向上
-(void)didSelectedxiagxiaClicked:(UIButton *)btn{
    if (self.directionType == 1) {//向上
        self.directionType = 0;
        self.V_storehistory.hidden = YES;
        [UIView animateWithDuration:2 animations:^{
            CGFloat width_cell = kScreenWidth/4;
            CGFloat height_cell = width_cell;
            [self.V_bg_bottom mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height_cell*2);
            }];
        } completion:^(BOOL finished) {
            [btn setTitle:@"下" forState:UIControlStateNormal];
            CGFloat width_cell = kScreenWidth/4;
            CGFloat height_cell = width_cell;
            [self.V_bg_bottom mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height_cell*5);
            }];
        }];
        
    }else{
        self.directionType = 1;
        [UIView animateWithDuration:2 animations:^{
            CGFloat width_cell = kScreenWidth/4;
            CGFloat height_cell = width_cell;
            [self.V_bg_bottom mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height_cell*2);
            }];
        } completion:^(BOOL finished) {
            self.V_storehistory.hidden = NO;
            [btn setTitle:@"上" forState:UIControlStateNormal];
            [self.V_bg_bottom mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@0);
            }];
        }];
    
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.outDataArr.count>section) {
        YLShareDeviceOuterModel * model = self.outDataArr[section];
        return model.detailModelArr.count;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.outDataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * V_root = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    V_root.backgroundColor = UIColor.clearColor;
    ZZLabel * L_title = [[ZZLabel alloc]initWithTextColor:[YLUserToolManager getAppMainColor] Font:[YLUserToolManager getAppTitleFont] TextString:@"Function settings"];
    L_title.frame = CGRectMake(10, 0, kScreenWidth-16*2, 30);
    [V_root addSubview:L_title];
    if (self.outDataArr.count>section) {
        YLShareDeviceOuterModel * model = self.outDataArr[section];
        NSString * timeStr = [[ToolManagement sharedManager]timeWithYearMonthDayCountDown:model.Date];
        L_title.text = timeStr;
    }
    return V_root;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * V_root = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    V_root.backgroundColor = UIColor.clearColor;
    return V_root;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYLHistoricalRecordNewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYLHistoricalRecordNewCell" forIndexPath:indexPath];
    if (self.outDataArr.count>indexPath.section) {
        YLShareDeviceOuterModel * outerModel = self.outDataArr[indexPath.section];
        if (outerModel.detailModelArr.count>indexPath.row) {
            FYLHistoryModel * listModel = outerModel.detailModelArr[indexPath.row];
            cell.L_contect.text = listModel.text;
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.outDataArr.count>indexPath.section) {
        MJWeakSelf
        YLShareDeviceOuterModel * outModel = self.outDataArr[indexPath.section];
        if (outModel.detailModelArr.count>indexPath.row) {
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            FYLHistoryModel * model = outModel.detailModelArr[indexPath.row];
            NSArray * arrTitle = @[NSLocalizedString(@"插入备注", nil),NSLocalizedString(@"编辑", nil),NSLocalizedString(@"复制该行", nil),NSLocalizedString(@"复制全部", nil),NSLocalizedString(@"删除该行", nil),NSLocalizedString(@"清空", nil),NSLocalizedString(@"取消", nil)];
            YLDIYEditBoxListView * view= [[YLDIYEditBoxListView alloc]initWithFrame:CGRectZero withIndexListCount:self.dataArray.count withArrTitle:arrTitle];
            view.didSelectedClickedBtnBlock = ^(NSInteger indexType) {
                NSLog(@"动态图list中某个画板--%ld",indexType);
                if (indexType == 4) {//删除
                   BOOL success = [model deleteToDB];
                    if (success) {
                        [weakSelf readHistoryData];
                    }
                    
                }else if (indexType == 5){//清空
                    [FYLHistoryModel removeUserWifiDevice];
                    [weakSelf readHistoryData];
                }
            };
            [view show];
            
            
        }
    }
    
}

/**
 * 把请求到的数据整理，然后放到数据源中
 */
- (void)handleDataIntoModels {
    //如果请求到的数据为空，则直接返回
    [self.outDataArr removeAllObjects];

//    if (self.dataArray.count == 0) return;
    
    NSMutableArray *timeArr = [NSMutableArray array];
    //首先把原数组中数据的日期取出来放入timeArr
    [self.dataArray enumerateObjectsUsingBlock:^(FYLHistoryModel *model, NSUInteger idx, BOOL *stop) {
        //这里只是根据日期判断，所以去掉时间字符串
        if (IS_VALID_STRING(model.time)) {
            [timeArr addObject:model.time];
        }
    }];
    
    //日期去重
    NSSet *set = [NSSet setWithArray:timeArr];
    NSArray *userArray = [set allObjects];
    
    //重新降序排序
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];//yes升序排列，no,降序排列
    NSArray *descendingDateArr = [userArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
    
    //此时得到的descendingDateArr就是按照时间降序排好的日期数组
    
    //根据日期数组的个数，生成对应数量的外层model，外层model的detailModelArr置为空数组，放置子model（每一行显示的数据model）
    [descendingDateArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YLShareDeviceOuterModel *om = [[YLShareDeviceOuterModel alloc]init];
        NSMutableArray *arr = [NSMutableArray array];
        om.detailModelArr = arr;
        [self.outDataArr addObject:om];
    }];
    
    //遍历未经处理的数组，取其中每个数据的日期，看与降序排列的日期数组相比，若日期匹配就把这个数据装到对应的外层model中
    [self.dataArray enumerateObjectsUsingBlock:^(FYLHistoryModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        for (NSString *str in descendingDateArr) {
            if([str isEqualToString:model.time]) {
                YLShareDeviceOuterModel *om = [self.outDataArr objectAtIndex:[descendingDateArr indexOfObject:str]];
                om.Date = str;
                [om.detailModelArr addObject:model];
            }
        }
    }];
    
    [self.table_groupV reloadData];
}


-(void)creatUI{
    self.view.backgroundColor = UIColor.blackColor;
    CGFloat width_cell = kScreenWidth/4;
    CGFloat height_cell = width_cell;
    UIView * V_bg_bottom = [[UIView alloc]init];
    self.V_bg_bottom = V_bg_bottom;
    V_bg_bottom.backgroundColor = UIColor.blueColor;
    [self.view addSubview:V_bg_bottom];
    [V_bg_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(height_cell*5);
    }];
    BOOL user_one = YES;
    if (user_one) {
        [self.vipKey initializeData];
        [V_bg_bottom addSubview:self.vipKey];
        [self.vipKey mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.mas_equalTo(V_bg_bottom);
        }];
    }else{
        [self.regularKey initializeData];
        [V_bg_bottom addSubview:self.regularKey];
        [self.regularKey mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(V_bg_bottom);
        }];
    }
    
    UIView * V_contect = [[UIView alloc]init];
    V_contect.backgroundColor = UIColor.blackColor;
    [self.view addSubview:V_contect];
    [V_contect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(V_bg_bottom.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(20+50);
    }];
    UIButton * B_top = [UIButton buttonWithType:0];
    [B_top setTitle:NSLocalizedString(@"下", nil) forState:UIControlStateNormal];
    [B_top addTarget:self action:@selector(didSelectedxiagxiaClicked:) forControlEvents:UIControlEventTouchUpInside];
    [V_contect addSubview:B_top];
    [B_top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(V_contect);
        make.left.mas_equalTo(V_contect).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    UIScrollView * V_scroll = [[UIScrollView alloc]init];
    self.V_scroll = V_scroll;
//    V_scroll.backgroundColor = UIColor.blueColor;
    V_scroll.contentSize = CGSizeMake(kScreenWidth, 50);
    V_scroll.scrollEnabled = YES;
    V_scroll.showsHorizontalScrollIndicator = YES;
    [V_contect addSubview:V_scroll];
    [V_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(B_top.mas_bottom);
        make.left.bottom.right.mas_equalTo(V_contect);
    }];
    
    ZZLabel * L_contect = [[ZZLabel alloc]initWithTextColor:UIColor.whiteColor Font:PxM56Font TextString:@""];
    L_contect.userInteractionEnabled = YES;
    L_contect.textAlignment = NSTextAlignmentRight;
    self.L_contect = L_contect;
    L_contect.frame = CGRectMake(0, 15, kScreenWidth, 30);
    [V_scroll addSubview:L_contect];

    UIView * V_bg_storehistory = [[UIView alloc]init];
    V_bg_storehistory.hidden = YES;
    self.V_storehistory = V_bg_storehistory;
    V_bg_storehistory.backgroundColor = UIColor.redColor;
    [V_contect addSubview:V_bg_storehistory];
    [V_bg_storehistory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(B_top.mas_bottom);
        make.left.bottom.right.mas_equalTo(V_contect);
    }];
    
    [self.table_groupV registerClass:[FYLHistoricalRecordNewCell class] forCellReuseIdentifier:@"FYLHistoricalRecordNewCell"];
    self.table_groupV.backgroundColor = UIColor.clearColor;
    self.table_groupV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    self.table_groupV.rowHeight = UITableViewAutomaticDimension;
    self.table_groupV.estimatedRowHeight = 30;
    [self.view addSubview:self.table_groupV];
    self.table_groupV.delegate = self;
    self.table_groupV.dataSource = self;
    [self.table_groupV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar).mas_offset(20);
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(V_contect.mas_top);
        
    }];
    
    [self.table_groupV registerNib:[UINib nibWithNibName:@"FYLHistoricalRecordCell" bundle:nil] forCellReuseIdentifier:@"FYLHistoricalRecordCell"];
    [self.view layoutIfNeeded];
    
}

-(FYLRegularKeyboardView *)regularKey{
    if (!_regularKey) {
        _regularKey = [[[NSBundle mainBundle]loadNibNamed:@"FYLRegularKeyboardView" owner:self options:nil]lastObject];
        _regularKey.delegate = self;
    }
    return _regularKey;
}
-(FYLVIPKeyboardView *)vipKey{
    if (!_vipKey) {
        _vipKey = [[[NSBundle mainBundle]loadNibNamed:@"FYLVIPKeyboardView" owner:self options:nil]lastObject];
        _vipKey.delegate = self;
    }
    return _vipKey;
}

-(NSMutableArray *)outDataArr{
    if (!_outDataArr) {
        _outDataArr = [NSMutableArray array];
    }
    return _outDataArr;
}

/**
 将string每隔三位添加一个逗号
 */
- (NSString *)getCommaTextWithString:(NSString *)string {
    if ([string containsString:@"e"]) {
        return string;
    }
    BOOL sign = [string hasPrefix:@"-"];
    NSString *str = sign ? [string substringFromIndex:1] : string;
    BOOL FLOAT = [string containsString:@"."];
    NSString *str1 = FLOAT ? [str componentsSeparatedByString:@"."][0] : str;
    NSString *str2 = FLOAT ? [NSString stringWithFormat:@".%@", [str componentsSeparatedByString:@"."][1]] : @"";
    NSMutableString *mutableStr = [NSMutableString stringWithString:str1];
    for (int i = 3; i < 300; i += 3) {
        if (str1.length > i) {
            [mutableStr insertString:@"," atIndex:str1.length - i];
        } else {
            break;
        }
    }
    if (sign) [mutableStr insertString:@"-" atIndex:0];
    [mutableStr appendString:str2];
    return [NSString stringWithString:mutableStr];
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
