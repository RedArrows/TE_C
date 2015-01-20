//
//  ResultForQRCodeViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/10.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ResultForQRCodeViewController.h"

#import "ListItemTableViewCell.h"

@interface ResultForQRCodeViewController ()

@end

@implementation ResultForQRCodeViewController{
    
    __weak IBOutlet UILabel *DocumentNOLabel;
    __weak IBOutlet UIView *mainShowView;
    
    NSArray *_listArray;
    
    UITableView *_tableView;
    AFHTTPRequestOperationManager *_manager;
    BOOL _searchNoResult;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_manager.operationQueue cancelAllOperations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描结果";
    _manager = [AFHTTPRequestOperationManager manager];
    [Tool setLeftMenuBarBtn:self];
    [self uiConfig];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)uiConfig{
    
    UIButton *reScan = [UIButton buttonWithType:UIButtonTypeSystem];
    [reScan setFrame:CGRectMake(0, 0, 65, 20)];
    [reScan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reScan setTitle:@"重新扫描" forState:UIControlStateNormal];
    [reScan addTarget:self action:@selector(popNav) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:reScan];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 105, 320, ScreenHeight-66-21) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    if ([_documentNO integerValue] == 0) {
        DocumentNOLabel.text = @"单号错误";
    }else{
        DocumentNOLabel.text = [NSString stringWithFormat:@"单号：%@",_documentNO];
        [self requestList];
    }
}

-(void)requestList{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInteger:0] forKey:@"start"];
    [params setObject:[NSNumber numberWithInteger:20] forKey:@"num"];
    
    [params setObject:[NSNumber numberWithInt:0] forKey:@"type"];
    [params setObject:_documentNO forKey:@"documentNo"];
    NSLog(@"post参数----》%@",params);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[AFHTTPRequestOperationManager manager] GET:[Tool getURLWithType:URLTYPE_allList] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ResponseModel *model = [[ResponseModel alloc]initWithJson:responseObject type:URLTYPE_allList];
        if (model.isSuccessed) {
            _listArray = model.data;
            [_tableView reloadData];
            
        }
        NSLog(@"成功");
        
        if (_listArray.count == 0) {
            _searchNoResult = YES;
            [_tableView reloadData];
            
        }
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _searchNoResult = YES;
        [_tableView reloadData];
        NSLog(@"失败");
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
}



-(void)popNav{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -----tableView about -----
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return 110;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    NSString *listCellID = @"listCell";
    NSString *noListCellID = @"noList";
    
    if (tableView == _tableView&&_searchNoResult){
        cell = [tableView dequeueReusableCellWithIdentifier:noListCellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noListCellID];
            NSLogRect(cell.textLabel.frame);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"没有找到符合条件的业务单！";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor darkGrayColor];
        }
        _searchNoResult = NO;
        
    }else if (tableView == _tableView){
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

@end
