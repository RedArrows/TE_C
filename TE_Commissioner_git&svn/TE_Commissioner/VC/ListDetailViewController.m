//
//  ListDetailViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/25.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ListDetailViewController.h"
#import "ListDetailMidMenu.h"
#import "ListDetailModel.h"
#import "ListContactTableViewCell.h"
#import "ListDetailTableViewCell.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController{
    
    __weak IBOutlet UIView *midBarBackView;
    ListDetailModel *_curModel;
    UITableView *_tableView;
    NSArray *_contactArray;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    
    [self uiConfig];
    
    

    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)uiConfig{
    
    [Tool setLeftBackBarBtn:self];
    ListDetailMidMenu *midMenu = [[ListDetailMidMenu alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    midMenu.menuDelegate = self;
    [midBarBackView addSubview:midMenu];
    
#pragma mark ----- 临时数据-----
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"json" ofType:@"txt"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    ResponseModel *model = [[ResponseModel alloc]initWithJson:jsonStr type:URLTYPE_listDetail];
    NSLog(@"%@",model);
    [midMenu updateWithTabArray:model.data];
    
    [midMenu setSelected:0];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 105, 320, 483) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -----about tableView ----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_curModel.contactArray&&section==0) {
        return _curModel.contactArray.count;
    }else{
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return _curModel.sectionArray.count+((_curModel.contactArray)?1:0);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString* sectionTitle = nil;
    if (_curModel.contactArray && section==0) {
        sectionTitle = @"联系人";
    }else if(_curModel.contactArray && section>0){
        sectionTitle = [_curModel.sectionArray[section-1] objectForKey:@"title"];
    }else{
        sectionTitle = [_curModel.sectionArray[section] objectForKey:@"title"];
    }
    return sectionTitle;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    NSString *contactCellID = @"contactCell";
    
    if (_curModel.contactArray && indexPath.section==0) {
        cell = [tableView dequeueReusableCellWithIdentifier:contactCellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ListContactTableViewCell" owner:self options:nil] lastObject];
            [cell uiConfig];
        }
        ListContactTableViewCell  *contactCell = (ListContactTableViewCell*)cell;
        [contactCell fillDataWithModel:[_curModel.contactArray objectAtIndex:indexPath.row]];
    }else if(_curModel.contactArray && indexPath.section>0){
        if (!cell) {
            cell = [[ListDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        ListDetailTableViewCell  *detailCell = (ListDetailTableViewCell*)cell;
        [detailCell fillDataWithDic:[_curModel.sectionArray objectAtIndex:indexPath.section-1]];
        
    }else{
        if (!cell) {
            cell = [[ListDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        ListDetailTableViewCell  *detailCell = (ListDetailTableViewCell*)cell;
        [detailCell fillDataWithDic:[_curModel.sectionArray objectAtIndex:indexPath.section]];
    }
    

    return cell;
}

#pragma mark -----midMenuDelegate-------
-(void)listDetailMenuDidSelected:(NSInteger)idx model:(ListDetailModel *)model{
    _curModel = model;
    [_tableView reloadData];
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
