//
//  FYLHelpFeedbackListViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/5/6.
//

#import "FYLHelpFeedbackListViewController.h"
#import "FYLHelpFeedbackListTableViewCell.h"
#import "FYLHelpFeedbackListModel.h"
#import "NSDate+JKExtension.h"
@interface FYLHelpFeedbackListViewController ()

@end

@implementation FYLHelpFeedbackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = [YLUserToolManager getTextTag:39];
    
    [self creatUI];
    [self downLoad];
    
    
    // Do any additional setup after loading the view.
}

-(void)downLoad{
    [[YXHTTPRequst shareInstance]yl_networking:API_feedbacklist parameters:@{} method:YXRequstMethodTypeGET showLoadingView:YES showLoadingTitle:@"" showErrorView:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        BaseModel * modelzz = [BaseModel loadModelWithDictionary:responseObject];
        if (modelzz.code.intValue == 200) {
            NSArray * arr = (NSArray *)responseObject[@"data"];
            [arr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FYLHelpFeedbackListModel * model = [FYLHelpFeedbackListModel loadModelWithDictionary:obj];
                [self.dataArray addObject:model];
            }];
            [self.tableV reloadData];
        }
    } failsure:^(NSURLSessionDataTask *task, id cacheData, NSError *error) {
        
    }];
    NSDictionary * dic = @{@"content":@"asdasdas啊实打实大师大师大师啊实打实大师大师啊实打实大师大师大师啊撒大声地阿萨德阿萨德阿萨德阿萨德",@"create_time":@"1714025828"};
    FYLHelpFeedbackListModel * model = [FYLHelpFeedbackListModel loadModelWithDictionary:dic];
    [self.dataArray addObject:model];
    
    NSDictionary * dic1 = @{@"content":@"asdasdas啊实打实大师大师大师啊实大师大师大师啊实打实大师大师啊实打实大师大师大师大师大师啊实打实大师大师啊实打实大师大师大师大师大师啊实打实大师大师啊实打实大师大师打实大师大师啊实打实大师大师大师啊撒大声地阿萨德阿萨德阿萨德阿萨德",@"create_time":@"1714994013"};
    FYLHelpFeedbackListModel * model1 = [FYLHelpFeedbackListModel loadModelWithDictionary:dic1];
    [self.dataArray addObject:model1];
    [self.tableV reloadData];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYLHelpFeedbackListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYLHelpFeedbackListTableViewCell" forIndexPath:indexPath];
    if (self.dataArray.count>indexPath.row) {
        FYLHelpFeedbackListModel * outerModel = self.dataArray[indexPath.row];
        cell.L_contect.text = outerModel.content;
        NSDate * timeDate = [self changeSpToTime:outerModel.create_time];
        cell.L_time.text =[NSString stringWithFormat:@"%@",[NSDate jk_timeInfoWithDate:timeDate]];
        
      }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
}
-(NSDate *)changeSpToTime:(NSString*)spString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    return confromTimesp;
}


-(void)creatUI{
    self.tableV.backgroundColor = UIColor.blackColor;
    [self.tableV registerClass:[FYLHelpFeedbackListTableViewCell class] forCellReuseIdentifier:@"FYLHelpFeedbackListTableViewCell"];
    self.tableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    self.tableV.rowHeight = UITableViewAutomaticDimension;
    self.tableV.estimatedRowHeight = 30;
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar.mas_bottom);
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-YX_TabbarSafetyZone);
    }];
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
