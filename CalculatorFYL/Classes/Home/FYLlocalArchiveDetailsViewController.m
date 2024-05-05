//
//  FYLlocalArchiveDetailsViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/22.
//

#import "FYLlocalArchiveDetailsViewController.h"
#import "FYLOnFileModel.h"
#import "FYLRecycleBinModel.h"
#import "FYLHistoricalRecordNewCell.h"
#import "YLShareDeviceOuterModel.h"
#import "FYLlocalArchiveDetailsBottomView.h"

#import "ZXDataHandle.h"
#import "ZXDecimalNumberTool.h"
@interface FYLlocalArchiveDetailsViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
FYLlocalArchiveDetailsBottomViewdelegate
>
@property(nonatomic,strong)NSMutableArray * outDataArr;

@end

@implementation FYLlocalArchiveDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 1) {
        self.navTitle = self.binModle.title;
    }else{
        self.navTitle = self.fileModle.title;
    }
    
    [self creatUI];
    [self readHistoryData];
    
    // Do any additional setup after loading the view.
}
-(void)readHistoryData{
    [self.dataArray removeAllObjects];
    if (self.type == 1) {
        if (IS_VALID_STRING(self.binModle.resArrJson)) {
            NSLog(@"%@",self.binModle.resArrJson);
           NSArray * dic_arr = (NSArray *)[self.binModle.resArrJson jk_dictionaryValue];
            if ([dic_arr isKindOfClass:[NSArray class]]) {
                [dic_arr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    FYLHistoryModel * histM = [[FYLHistoryModel alloc]init];
                    histM.resultStr = obj[@"resultStr"];
                    histM.userName = obj[@"userName"];
                    histM.IDs =[[NSString stringWithFormat:@"%@",obj[@"IDs"]] doubleValue] ;
                    histM.time =[NSString stringWithFormat:@"%@",obj[@"time"]];
                    histM.contect = obj[@"contect"];
                    histM.textDirectionType = [[NSString stringWithFormat:@"%@",obj[@"textDirectionType"]] doubleValue];
                    histM.state = [[NSString stringWithFormat:@"%@",obj[@"state"]] doubleValue];
                    [self.dataArray addObject:histM];
                }];
                [self handleDataIntoModels];
            }
        }
    }else{
        if (IS_VALID_STRING(self.fileModle.resArrJson)) {
            NSLog(@"%@",self.fileModle.resArrJson);
           NSArray * dic_arr = (NSArray *)[self.fileModle.resArrJson jk_dictionaryValue];
            if ([dic_arr isKindOfClass:[NSArray class]]) {
                [dic_arr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    FYLHistoryModel * histM = [[FYLHistoryModel alloc]init];
                    histM.resultStr = obj[@"resultStr"];
                    histM.userName = obj[@"userName"];
                    histM.IDs =[[NSString stringWithFormat:@"%@",obj[@"IDs"]] doubleValue] ;
                    histM.time =[NSString stringWithFormat:@"%@",obj[@"time"]];
                    histM.contect = obj[@"contect"];
                    histM.textDirectionType = [[NSString stringWithFormat:@"%@",obj[@"textDirectionType"]] doubleValue];
                    histM.state = [[NSString stringWithFormat:@"%@",obj[@"state"]] doubleValue];
                    [self.dataArray addObject:histM];
                }];
                [self handleDataIntoModels];
            }
        }
        
    }
    

    
}

#pragma mark -- 恢复 or  删除
-(void)fyl_didSelectedlocalArchiveDetailsBottomViewButtonTag:(NSInteger)tag{
    if (tag == 0) {//恢复
        BOOL success = [FYLHistoryModel zx_dbDropTable];
        if (success) {
            BOOL res = [self.dataArray zx_dbSave];
            if (res) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
    }else if (tag == 1){//删除
        if (self.type == 1) {
            [self deleteCurrentBinModel:self.binModle];
        }else{
            [self deleteCurrentModel:self.fileModle];
        }
        
    }
}
#pragma mark -- 删除
-(void)deleteCurrentBinModel:(FYLRecycleBinModel *)model{
    NSString * sqStr = [NSString stringWithFormat:@"IDs=%.f",model.IDs];
    BOOL success = [FYLRecycleBinModel zx_dbDropWhere:sqStr];
    if (success) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)deleteCurrentModel:(FYLOnFileModel *)model{
    NSString * sqStr = [NSString stringWithFormat:@"IDs=%.f",model.IDs];
    BOOL success = [FYLOnFileModel zx_dbDropWhere:sqStr];
    if (success) {
        [self.navigationController popViewControllerAnimated:YES];
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
    if (self.model.dataState.intValue == 0) {
        L_title.hidden = YES;
        V_root.frame = CGRectMake(0, 0, kScreenWidth, 0.1);
    }else{
        V_root.frame = CGRectMake(0, 0, kScreenWidth, 35);
        L_title.hidden = NO;
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
            cell.L_contect.text =[NSString stringWithFormat:@"%@%@",listModel.contect,[self getUnitsContect:listModel.resultStr]];
            cell.L_contect.font = [YLUserToolManager getAppTitleFont];
            if (listModel.textDirectionType == 0) {
                cell.L_contect.textAlignment = NSTextAlignmentLeft;
            }else{
                cell.L_contect.textAlignment = NSTextAlignmentRight;
            }
            if (listModel.state == HistoryTypeStatus_beizhu) {
                cell.L_contect.textColor = [YLUserToolManager getAppMainColor];
            }else{
                cell.L_contect.textColor = UIColor.blackColor;
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
    UIView * V_bg_bottom = [[UIView alloc]init];
    V_bg_bottom.backgroundColor = UIColor.blueColor;
    [self.view addSubview:V_bg_bottom];
    [V_bg_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-YX_TabbarSafetyZone);
        make.height.mas_equalTo(@60);
    }];
    FYLlocalArchiveDetailsBottomView * V_bottom = [[[NSBundle mainBundle]loadNibNamed:@"FYLlocalArchiveDetailsBottomView" owner:self options:nil]lastObject];
    [V_bottom.B_huifu setTitle:[YLUserToolManager getTextTag:10] forState:UIControlStateNormal];
    [V_bottom.B_shanchu setTitle:[YLUserToolManager getTextTag:11] forState:UIControlStateNormal];
    
    V_bottom.delegate = self;
    [V_bg_bottom addSubview:V_bottom];
    [V_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(V_bg_bottom);
    }];
    [self.table_groupV registerClass:[FYLHistoricalRecordNewCell class] forCellReuseIdentifier:@"FYLHistoricalRecordNewCell"];
    self.table_groupV.backgroundColor = UIColor.whiteColor;
    self.table_groupV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    self.table_groupV.rowHeight = UITableViewAutomaticDimension;
    self.table_groupV.estimatedRowHeight = 30;
    [self.view addSubview:self.table_groupV];
    self.table_groupV.delegate = self;
    self.table_groupV.dataSource = self;
    [self.table_groupV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar.mas_bottom).mas_offset(0);
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(V_bg_bottom.mas_top);
        
    }];
    
}
-(NSMutableArray *)outDataArr{
    if (!_outDataArr) {
        _outDataArr = [NSMutableArray array];
    }
    return _outDataArr;
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
