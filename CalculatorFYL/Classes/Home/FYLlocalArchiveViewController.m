//
//  FYLlocalArchiveViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/20.
//

#import "FYLlocalArchiveViewController.h"
#import "FYLlocalArchiveTableViewCell.h"
#import "FYLOnFileModel.h"
#import "ZXDataHandle.h"
#import "ZXDecimalNumberTool.h"
#import "FYLlocalArchiveDetailsViewController.h"

@interface FYLlocalArchiveViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>



@end

@implementation FYLlocalArchiveViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self downLoadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = NSLocalizedString(@"On file", nil);
    
    [self creatUI];
    
    // Do any additional setup after loading the view.
}

-(void)downLoadData{
    
    NSMutableArray * arr_model = [NSMutableArray arrayWithArray:[FYLOnFileModel zx_dbQuaryAll]];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:arr_model.count];
    NSEnumerator *enumerator = [arr_model reverseObjectEnumerator];
    for (id element in enumerator) {
      [array addObject:element];

    }
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    
    [self.tableV reloadData];

}

#pragma mark -- 清空
-(void)rightItemClicked{

    [[ZZAlertViewTools alloc]showSheet:@"" message:@"" cancelTitle:@"Cancel" titleArray:@[NSLocalizedString(@"Make sure", nil)] confirm:^(NSInteger buttonTag) {
        if (buttonTag == 0) {
            BOOL success = [FYLOnFileModel zx_dbDropTable];
            if (success) {
                [self downLoadData];
            }
        }
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYLlocalArchiveTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYLlocalArchiveTableViewCell" forIndexPath:indexPath];
    if (self.dataArray.count>indexPath.row) {
        FYLOnFileModel * outerModel = self.dataArray[indexPath.row];
        cell.L_contect.text = outerModel.title;
        cell.L_number.text =[NSString stringWithFormat:@"%@",outerModel.listCount];
        if (self.dataArray.count == indexPath.row+1) {
            cell.V_line.hidden = YES;
        }else{
            cell.V_line.hidden = NO;
        }
      }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count>indexPath.row) {
        FYLlocalArchiveDetailsViewController * vc = [[FYLlocalArchiveDetailsViewController alloc]init];
        vc.fileModle = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}




-(void)creatUI{
    [self setNavRightItem:NSLocalizedString(@"Clear", nil) withImage:nil];
    
    self.tableV.backgroundColor = UIColor.blackColor;
    [self.tableV registerClass:[FYLlocalArchiveTableViewCell class] forCellReuseIdentifier:@"FYLlocalArchiveTableViewCell"];
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
