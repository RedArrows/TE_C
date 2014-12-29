//
//  MyOnTheWayListViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/16.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "MyOnTheWayListViewController.h"
#import "YDListMenuView.h"
#import "OptionDetailModel.h"
#import "OptionsTableViewCell.h"
#import "DateOrderSelect.h"
#import "ListItemTableViewCell.h"
#import "MJRefresh.h"
#import "ListDetailViewController.h"
#import "DXPopover.h"
#import "PageView.h"



@interface MyOnTheWayListViewController ()<ListViewChooseDelegate>

@property (weak, nonatomic) IBOutlet UIButton *selectedMunu;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *upPage;
@property (weak, nonatomic) IBOutlet UIButton *nextPage;
@property (weak, nonatomic) IBOutlet UIButton *currentPage;

@property (strong,nonatomic) PageView *selectedPageView;

@property (nonatomic, strong) DXPopover *popover;

@property (assign,nonatomic) NSInteger currentPageNum;
@property (assign,nonatomic) NSInteger TotalPageNum;



- (IBAction)selectedMenuPressed:(UIButton *)sender;
- (IBAction)upPagePressed:(id)sender;
- (IBAction)currentPagePressed:(id)sender;
- (IBAction)nextPagePressed:(id)sender;

@end



@implementation MyOnTheWayListViewController{
    
    IBOutlet UIView *searchBackView;
    __weak IBOutlet UITextField *inputTextField;
    __weak IBOutlet UIView *inputBackView;
    __weak IBOutlet UIView *midBarBackView;
    
    __weak IBOutlet UILabel *totalCountLabel;
    __weak IBOutlet UIView *mainShowView;
    
    UITableView *_optionsTableView;
    NSMutableArray *_optionsArray;
    
    UITableView *_listShowTableView;
    NSArray *_listArray;
    
    CGSize showSize;
    OptionDetailModel *_curOption;
    AFHTTPRequestOperationManager *manager;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [manager.operationQueue cancelAllOperations];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Tool setLeftMenuBarBtn:self];
    [self uiConfig];
    searchBackView.hidden = YES;
    [self.view addSubview:searchBackView];
    
    manager = [AFHTTPRequestOperationManager manager];
    [self requestList];
    
    self.popover = [DXPopover new];
    self.upPage.enabled = NO;
    self.upPage.backgroundColor = [UIColor lightGrayColor];
    self.currentPageNum = 1;
    
    // Do any additional setup after loading the view from its nib.
}

-(void)requestList{
    
#pragma mark ----- 临时数据-----
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jsonList" ofType:@"txt"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    ResponseModel *model = [[ResponseModel alloc]initWithJson:jsonStr type:URLTYPE_myOnThewayList];
    _listArray = model.data;
    [totalCountLabel setText:[NSString stringWithFormat:@"共%li条",_listArray.count]];
    
    [_listShowTableView reloadData];
    
    [manager POST:[Tool getURLWithType:URLTYPE_myOnThewayList] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ResponseModel *model = [[ResponseModel alloc]initWithJson:responseObject type:URLTYPE_myOnThewayList];
        if (model.isSuccessed) {
            _listArray = model.data;
            [totalCountLabel setText:[NSString stringWithFormat:@"共%li条",_listArray.count]];
            [_listShowTableView reloadData];
        }
        [_listShowTableView headerEndRefreshing];
        NSLog(@"成功");

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_listShowTableView reloadData];
        [_listShowTableView headerEndRefreshing];
        NSLog(@"失败");
    }];
    
}


-(void)uiConfig{
    
    //配置日期排序选项
    DateOrderSelect *orderView = [[DateOrderSelect alloc]initWithFrame:CGRectMake(10, 7+midBarBackView.frame.origin.y, 110, 30)];
    [self.view addSubview:orderView];

    
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    leftView.image = [UIImage imageNamed:@"mark_Magnifier_gray"];
    
    inputTextField.leftViewMode = UITextFieldViewModeAlways;
    inputTextField.leftView = leftView;
    
    inputBackView.layer.cornerRadius = 15;
    inputBackView.layer.borderColor = [UIColor grayColor].CGColor;
    inputBackView.layer.borderWidth = 1;
    
    showSize = mainShowView.frame.size;
    
    _optionsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
    _optionsTableView.delegate = self;
    _optionsTableView.dataSource = self;
    _optionsTableView.scrollEnabled = NO;
    _optionsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mainShowView addSubview:_optionsTableView];
    
    _optionsArray = [[NSMutableArray alloc]init];
    
    _listShowTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,showSize.height-50)];
    _listShowTableView.delegate = self;
    _listShowTableView.dataSource = self;
    _listShowTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_listShowTableView addHeaderWithTarget:self action:@selector(requestList)];
    [mainShowView addSubview:_listShowTableView];
    
    
    
}
-(void)resetFrameWithdelete:(BOOL)isDel{
    for (int i = 0; i < _optionsArray.count; i++) {
        OptionDetailModel *m = [_optionsArray objectAtIndex:i];
        if (m.optionType == _curOption.optionType) {
            [_optionsArray removeObject:m];
        }
    }
    if (!isDel) {
        [_optionsArray addObject:_curOption];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [_optionsTableView setFrame:CGRectMake(0, 0, 320, 36*_optionsArray.count)];
        [_listShowTableView setFrame:CGRectMake(0, 36*_optionsArray.count, 320, showSize.height - 36*_optionsArray.count-50)];

    }];
    
    [_optionsTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -----tableView about-----

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _optionsTableView) {
        return 36;
    }else{
        return 110;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _optionsTableView) {
        return _optionsArray.count;
    }else{
        return (_listArray.count==0)?1:_listArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    NSString *opCellID = @"opCell";
    NSString *listCellID = @"listCell";
    NSString *noListCellID = @"noList";
    
    if (tableView == _optionsTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:opCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OptionsTableViewCell" owner:self options:nil] lastObject];
            [cell uiConfig];
        }
        OptionsTableViewCell *opCell = (OptionsTableViewCell*)cell;
        opCell.delDelegate = self;
        [opCell fillDataWithModel:[_optionsArray objectAtIndex:indexPath.row]];
    }else if (tableView == _listShowTableView&&_listArray.count == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:noListCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noListCellID];
            NSLogRect(cell.textLabel.frame);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"没有找到符合条件的业务单！";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor darkGrayColor];
        }
        
    }else if (tableView == _listShowTableView){
        cell = [tableView dequeueReusableCellWithIdentifier:listCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ListItemTableViewCell" owner:self options:nil] lastObject];
            [cell uiConfig];
        }
        ListItemTableViewCell *listCell = (ListItemTableViewCell*)cell;
        [listCell fillDataWithModel:[_listArray objectAtIndex:indexPath.row] isShowToDo:YES];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _optionsTableView) {
        return;
    }
    ListDetailViewController *vc = [[ListDetailViewController alloc]initWithNibName:@"ListDetailViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----option delete------

-(void)deleteOptionForType:(OptionType)type{
    _curOption = [[OptionDetailModel alloc]init];
    _curOption.optionType = type;
    [self resetFrameWithdelete:YES];
    
}


#pragma mark -----click event-----

- (IBAction)selectedMenuPressed:(UIButton *)sender
{
    YDListMenuView *listView = [[YDListMenuView alloc] initBackViewFrame:CGRectMake(0,64,320,568) withListViewPoint:CGPointMake(160, 40) withDelegate:self];
    
    switch (self.VCType) {
        case VC_MyOnTheWayList:{
            listView.dataArray = [NSMutableArray arrayWithArray:@[@"搜索经纪人/主办",@"搜索买方/卖方",@"搜索交易编号",@"报单日期：全部",@{@"特殊业务单":@[@"挂起",@"连环单",@"失效单"]},@{@"交易产品:全部":@[@"全款业务",@"全款赎楼",@"商业贷款",@"商贷.赎楼",@"商贷.垫资",@"补按揭.商贷",@"公积金.市属",@"补按揭.市属",@"公积金.市属.垫资",@"公积金.市属.赎楼",@"公积金.市属.垫资",@"公积金.国管",@"补按揭.国管"]}]];
        }
            break;
        case VC_OrderRatepaying:{
            listView.dataArray = [NSMutableArray arrayWithArray:@[@"搜索经纪人/主办",@"搜索买方/卖方",@"搜索交易编号"]];
        }
            break;
        case VC_CheckRatePaying:{
            listView.dataArray = [NSMutableArray arrayWithArray:@[@"搜索经纪人/主办",@"搜索买方/卖方",@"搜索交易编号",@{@"特殊业务单":@[@"挂起",@"连环单",@"失效单"]}]];
        }
            break;
        case VC_CheckTransfer:{
            listView.dataArray = [NSMutableArray arrayWithArray:@[@"搜索经纪人/主办",@"搜索买方/卖方",@"搜索交易编号",@{@"特殊业务单":@[@"挂起",@"连环单",@"失效单"]}]];
        }
            break;
        case VC_CheckTransferLand:{
            listView.dataArray = [NSMutableArray arrayWithArray:@[@"搜索经纪人/主办",@"搜索买方/卖方",@"搜索交易编号",@{@"特殊业务单":@[@"挂起",@"连环单",@"失效单"]}]];
        }
            break;
        default:
            break;
    }
    
//    listView.dataArray = [NSMutableArray arrayWithArray:@[@"搜索经纪人/主办",@"搜索买方/卖方",@"搜索交易编号",@"报单日期：全部",@{@"特殊业务单":@[@"挂起",@"连环单",@"失效单"]},@{@"交易产品:全部":@[@"全款业务",@"全款赎楼",@"商业贷款",@"商贷.赎楼",@"商贷.垫资",@"补按揭.商贷",@"公积金.市属",@"补按揭.市属",@"公积金.市属.垫资",@"公积金.市属.赎楼",@"公积金.市属.垫资",@"公积金.国管",@"补按揭.国管"]}]];
    
    [self.view addSubview:listView];
}

- (IBAction)upPagePressed:(id)sender
{
    self.upPage.backgroundColor = UICOLOR_RGB_Alpha(0x39AC6A, 1.0);
    self.nextPage.backgroundColor = UICOLOR_RGB_Alpha(0x39AC6A, 1.0);
    self.nextPage.enabled = YES;
    self.upPage.enabled = YES;
    self.currentPageNum-=1;
    [self.currentPage setTitle:[NSString stringWithFormat:@"第%ld页",self.currentPageNum] forState:UIControlStateNormal];
    if (self.currentPageNum==1) {
        self.upPage.backgroundColor = [UIColor lightGrayColor];
        self.upPage.enabled = NO;
    }
}

- (IBAction)currentPagePressed:(id)sender
{
    self.selectedPageView = [[PageView alloc]initWithFrame:CGRectMake(0, 0, 100,250)];
    self.selectedPageView.delegate =self;
    
    [self.popover showAtPoint:CGPointMake(160, 510) popoverPostion:DXPopoverPositionUp withContentView:self.selectedPageView inView:self.view];
}

- (IBAction)nextPagePressed:(id)sender
{
    self.upPage.backgroundColor = UICOLOR_RGB_Alpha(0x39AC6A, 1.0);
    self.nextPage.backgroundColor = UICOLOR_RGB_Alpha(0x39AC6A, 1.0);
    self.nextPage.enabled = YES;
    self.upPage.enabled = YES;
    self.currentPageNum+=1;
    [self.currentPage setTitle:[NSString stringWithFormat:@"第%ld页",self.currentPageNum] forState:UIControlStateNormal];
    if (self.currentPageNum==5) {
        self.nextPage.backgroundColor = [UIColor lightGrayColor];
        self.nextPage.enabled = NO;
    }
}

-(void)currentPageWithTitle:(NSString *)title atIndex:(NSInteger)index
{
    self.currentPageNum = index;
    if (self.currentPageNum==1) {
        self.upPage.backgroundColor = [UIColor lightGrayColor];
        self.upPage.enabled = NO;
    }else if (self.currentPageNum==5){
        self.nextPage.backgroundColor = [UIColor lightGrayColor];
        self.upPage.backgroundColor = UICOLOR_RGB_Alpha(0x39AC6A, 1.0);
        self.nextPage.enabled = NO;
        self.upPage.enabled = YES;
    }else{
        self.upPage.backgroundColor = UICOLOR_RGB_Alpha(0x39AC6A, 1.0);
        self.nextPage.backgroundColor = UICOLOR_RGB_Alpha(0x39AC6A, 1.0);
        self.upPage.enabled = YES;
        self.nextPage.enabled = YES;
    }
    [self.currentPage setTitle:title forState:UIControlStateNormal];
    [self.popover dismiss];
}

- (IBAction)searchClick:(id)sender {
    [inputTextField resignFirstResponder];
    _curOption.mainText = [NSString stringWithFormat:@"%@：%@",_curOption.mainText,inputTextField.text];
    [self resetFrameWithdelete:NO];
    searchBackView.hidden = YES;
}
- (IBAction)searchCancelClick:(id)sender {
    searchBackView.hidden = YES;
}

-(void) chooseAtTitle:(NSString *)title index:(NSInteger)index
{
    NSLog(@"%@--------",title);
    
    NSArray *searchArray = @[@"搜索经纪人/主办",@"搜索买方/卖方",@"搜索交易编号"];
    if ([searchArray containsObject:title]) {
        searchBackView.hidden = NO;
        inputTextField.text = @"";
        inputTextField.placeholder = [NSString stringWithFormat:@"请输入%@",[title substringFromIndex:2]];
        [self.view bringSubviewToFront:searchBackView];
    _curOption = [[OptionDetailModel alloc]init];
    _curOption.mainText = [title substringFromIndex:2];
    _curOption.optionType = index;
    }
    
    
}




@end
