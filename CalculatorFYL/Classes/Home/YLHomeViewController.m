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
#import "advancedCalculator.h"

#define MaxCount 20
@interface YLHomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
FYLRegularKeyboardViewdelegate
>
@property(nonatomic,strong)ZZLabel * L_contect;
@property(nonatomic,strong)UIView * V_contect;
@property(nonatomic,strong)UIView * V_storehistory;
@property(nonatomic,strong)UIScrollView * V_scroll;
@property(nonatomic,strong)UIView * V_bg_bottom;
@property(nonatomic,strong)FYLRegularKeyboardView * regularKey;
@property(nonatomic,strong)FYLVIPKeyboardView * vipKey;

///方向 0向下 1向上
@property(nonatomic,assign)NSInteger directionType;
@property (strong, nonatomic) advancedCalculator *calculate;
@property int flag;
@end

@implementation YLHomeViewController
{
    NSString * numberBefore;    //前个数字
    NSString * numberCurrent;   //当前数字
    NSString * actionType;      //当前存储的加减乘除动作  + - * /
    double result;
    BOOL  isActionTypeMove;     //加减乘除已经做了移位
    BOOL  isStatusEqual;        //是否按了等号
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    NSLog(@"%@---%@",NSStringFromCGRect(self.view.frame) ,NSStringFromCGRect(self.view.frame));
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
    [self.calculator clearAll];
    _flag=0;
    self.V_scroll.contentSize = CGSizeMake(kScreenWidth, 50);
    [self.V_scroll setContentOffset:CGPointMake(5, 0) animated:NO];
}

-(void)fyl_RegularKeyboardDidSelectedButton:(UIButton *)btn{
    
    [self playSoundEffect:@"click.wav"];
    
    
    if ([btn.titleLabel.text isEqualToString:@"0"]) {
        [self changeNumberGreateBtn:btn];
    }else if ([btn.titleLabel.text isEqualToString:@"1"]){
        [self changeNumberGreateBtn:btn];
//        [self numberGreate:1];
    }else if ([btn.titleLabel.text isEqualToString:@"2"]){
        [self changeNumberGreateBtn:btn];
//        [self numberGreate:2];
    }else if ([btn.titleLabel.text isEqualToString:@"3"]){
        [self changeNumberGreateBtn:btn];
//        [self numberGreate:3];
    }else if ([btn.titleLabel.text isEqualToString:@"4"]){
        [self changeNumberGreateBtn:btn];
//        [self numberGreate:4];
    }else if ([btn.titleLabel.text isEqualToString:@"5"]){
        [self changeNumberGreateBtn:btn];
//        [self numberGreate:5];
    }else if ([btn.titleLabel.text isEqualToString:@"6"]){
        [self changeNumberGreateBtn:btn];
//        [self numberGreate:6];
    }else if ([btn.titleLabel.text isEqualToString:@"7"]){
        [self changeNumberGreateBtn:btn];
//        [self numberGreate:7];
    }else if ([btn.titleLabel.text isEqualToString:@"8"]){
        [self changeNumberGreateBtn:btn];
//        [self numberGreate:8];
    }else if ([btn.titleLabel.text isEqualToString:@"9"]){
        [self changeNumberGreateBtn:btn];
//        [self numberGreate:9];
    }else if ([btn.titleLabel.text isEqualToString:@"."]){
        if ([self stringHasPoint:self.L_contect.text]) {
            return;
        }
        if (!IS_VALID_STRING(self.L_contect.text)) {
            self.L_contect.text = @"0";
            [self.calculator.input appendString:@"0"];
        }
        [self changeNumberGreateBtn:btn];
//        [self actionPoint];
    }else if ([btn.titleLabel.text isEqualToString:@"C"]){
        [self clearDate];
    }else if ([btn.titleLabel.text isEqualToString:@"÷"]){
        [self changeNumberGreateBtn:btn];
//        [self actionTodo:btn type:@"÷"];
    }else if ([btn.titleLabel.text isEqualToString:@"×"]){
        [self changeNumberGreateBtn:btn];
//        [self actionTodo:btn type:@"×"];
    }else if ([btn.titleLabel.text isEqualToString:@"←"]){
        [self clearLastBit];
    }else if ([btn.titleLabel.text isEqualToString:@"-"]){
        [self changeNumberGreateBtn:btn];
//        [self actionTodo:btn type:@"-"];
    }else if ([btn.titleLabel.text isEqualToString:@"+"]){
        [self changeNumberGreateBtn:btn];
//        [self actionTodo:btn type:@"+"];
    }else if ([btn.titleLabel.text isEqualToString:@"="]){
        [self actionEqual];
    }
    
    
}
-(void)changeNumberGreateBtn:(UIButton *)btn{
    if([self.L_contect.text length]!=0&&_flag==1){
        NSString *ch=[[btn titleLabel] text];
        if([ch isEqualToString:@"("]||[ch isEqualToString:@"×"]
           ||[ch isEqualToString:@"÷"]
           ||[ch isEqualToString:@"+"]
           ||[ch isEqualToString:@"-"]
           ||[ch isEqualToString:@")"]){
            self.L_contect.text=@"暂不支持连续运算";
            self.calculator.input=nil;
            _flag=1;
            return;
        }else{
            self.L_contect.text=nil;
            self.calculator.input=nil;
            _flag=0;
        }
    }
    
    //这种处理的原因是对x ÷进行实际运算的替换* /，但显示仍然是x +
    if([[[btn titleLabel] text] isEqualToString:@"×"]){
        [self.calculator.input appendString:@"*"];
    }else if([[[btn titleLabel] text] isEqualToString:@"÷"]){
        [self.calculator.input appendString:@"/"];
    }else{
        [self.calculator.input appendString:[[btn titleLabel] text]];
    }
    
    NSMutableString *originalString=[NSMutableString stringWithString:self.L_contect.text];
    [originalString appendString:[[btn titleLabel] text]];
    self.L_contect.text=originalString;
    self.calculator.screen=originalString;
}


#pragma mark -- 等于
-(void)actionEqual{
    if([self.L_contect.text length]==0){
        self.L_contect.text=@"Error input!";
        return;
    }
    
    NSMutableString *calculateResult=[NSMutableString stringWithString:self.calculator.input];
    [calculateResult appendString:@"="];
    self.L_contect.text=[self.calculator ExpressionCalculate:calculateResult];
    NSMutableString *tempStr=[NSMutableString stringWithString:self.L_contect.text];;
    self.calculator.screen = tempStr;//每次计算之后，将结果也保存在screen中
    self.calculate.input = tempStr;
//    if (!numberBefore) {
//        return;
//    }
//    if (!isStatusEqual) {
//        [self calculationType];
//    }else{
//        numberBefore=[self subString:result];
//        [self calculationType];
//    }
//    NSString *resultStr=[self subString:result];
//    [self setNumberDisplay:resultStr];
//    [savehistoryData historyAdd: [self time] beforeNum:[self setNumber:numberBefore] operationType:actionType CurrentNub:[self setNumber:numberCurrent] result:[self setNumber:resultStr]];
//    [self readHistoryData];
//    isStatusEqual=YES;
}
#pragma mark -- 末尾清除
-(void)clearLastBit{
    
    NSInteger length=[self.calculator.input length];
    if(length>0){
        [self.calculator.input deleteCharactersInRange:NSMakeRange(length-1, 1)];
        //一定也要对输入框中的表达式进行处理，因为input里面的× ÷和显示的* /不同
        NSMutableString *delResultString=[NSMutableString stringWithString:self.L_contect.text];
        [delResultString deleteCharactersInRange:NSMakeRange(length-1, 1)];
        NSLog(@"deleteResult=%@",self.calculator.input);
        self.calculator.screen=delResultString;
        self.L_contect.text=delResultString;
    }
    
}
-(void)actionTodo:(UIButton *)button type:(NSString *)type{
    isActionTypeMove=NO;
    if ([numberCurrent isEqualToString:@"0"]) {
        return;
    }
    if (numberBefore&&![numberCurrent isEqualToString:@""]&&actionType){
        if (isStatusEqual) {
            numberCurrent=[self subString:result];
            isStatusEqual=NO;
        }else{
            [self calculationType];
            numberCurrent=[self subString:result];
            [self setNumberDisplay:numberCurrent];
            NSLog(@"NU%@",numberCurrent);
        }
    }
    actionType=type;
}
#pragma mark -- 算法（+—*÷）
-(void)calculationType{
    if ([actionType isEqualToString:@"+"]) {
        result=[numberBefore doubleValue]+[numberCurrent doubleValue];
    }else if([actionType isEqualToString:@"-"]){
        result=[numberBefore doubleValue]-[numberCurrent doubleValue];
    }else if([actionType isEqualToString:@"×"]){
        result=[numberBefore doubleValue]*[numberCurrent doubleValue];
    }else if([actionType isEqualToString:@"÷"]){
        result=[numberBefore doubleValue]/[numberCurrent doubleValue];
    }

}


-(void)numberGreate:(int)number{//number形式参数
    if (isStatusEqual) {
        [self clearDate];
    }
    if (actionType&&!isActionTypeMove){
        numberBefore=numberCurrent;
        numberCurrent=@"0";
        isActionTypeMove=YES;
    }
    if ([numberCurrent isEqualToString:@"0"]) {
        numberCurrent=[NSString stringWithFormat:@"%d",number];
    }else if([self stringHasPoint:numberCurrent]) {
        if (numberCurrent.length>=MaxCount) {
            return;
        }else{
            numberCurrent=[NSString stringWithFormat:@"%@%d",numberCurrent,number];
        }
    }else if (numberCurrent.length>=MaxCount) {
        return;
    }else{
        if (IS_VALID_STRING(numberCurrent)) {
            numberCurrent=[NSString stringWithFormat:@"%@%d",numberCurrent,number];
        }else{
            numberCurrent=[NSString stringWithFormat:@"%d",number];
        }
        
    }
    [self setNumberDisplay:numberCurrent];

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
//点击小数点
-(void)actionPoint{
    if ([self stringHasPoint:numberCurrent]) {
        return;
    }else{
        numberCurrent=[NSString stringWithFormat:@"%@.",numberCurrent];
        [self setNumberDisplay:numberCurrent];
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
-(BOOL)stringHasPoint:(NSString *)string{
    NSRange rang=[string rangeOfString:@"."];
    if (rang.length>0) {
        return YES;
    }else{
        return NO;
    }
}
-(NSString*)subString:(double)value{   //截取字符串
    NSString *str=[NSString stringWithFormat:@"%lf",value];
    int index=(int) str.length;
    int i;
    for (i=(int)str.length;i>0;i--) {
        NSString *lastChar=[str substringWithRange:NSMakeRange(i-1, 1)];
        if (![lastChar isEqualToString:@"0"]) {
            index=i;
            if ([lastChar isEqualToString:@"."]) {
                index--;
            }break;
        }
    }
    NSString *subString=[str substringWithRange:NSMakeRange(0, index)];
    return subString;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * V_root = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    V_root.backgroundColor = UIColor.yellowColor;
    ZZLabel * L_title = [[ZZLabel alloc]initWithTextColor:UIColor.redColor Font:Px30Font TextString:@"2024.03.11"];
    [V_root addSubview:L_title];
    L_title.frame = V_root.frame;
    [V_root addSubview:L_title];
    return V_root;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYLHistoricalRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYLHistoricalRecordCell" forIndexPath:indexPath];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}




-(void)creatUI{
    self.view.backgroundColor = UIColor.blackColor;
    CGFloat width_cell = kScreenWidth/4;
    CGFloat height_cell = width_cell;
    UIView * V_bg_bottom = [[UIView alloc]init];
    self.V_bg_bottom = V_bg_bottom;
    V_bg_bottom.backgroundColor = UIColor.blueColor;
    [self.view addSubview:V_bg_bottom];
//    V_bg_bottom.frame = CGRectMake(0, kScreenHeight-SBottomSafeHeight-height_cell*5, kScreenWidth, height_cell*5);
    [V_bg_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(height_cell*5);
    }];
    
//    [V_bg_bottom addSubview:self.vipKey];
//    [self.vipKey mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(V_bg_bottom);
//    }];
    
    [self.regularKey initializeData];
    [V_bg_bottom addSubview:self.regularKey];
    [self.regularKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(V_bg_bottom);
    }];
    
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
    
    
    self.table_groupV.backgroundColor = UIColor.clearColor;
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
    }
    return _vipKey;
}

-(advancedCalculator *)calculator{
    if(!_calculate){
        _calculate=[[advancedCalculator alloc]init];
    }
    return _calculate;
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
