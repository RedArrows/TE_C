//
//  TEMenuViewController.m
//  TE_Commissioner
//
//  Created by liuyunda on 14/12/18.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "TEMenuViewController.h"
#import "TEMenuCell.h"
#import "TETitleCell.h"
#import "TEMenuNoPicCell.h"

@interface TEMenuViewController ()

@end

@implementation TEMenuViewController


-(void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    self.dataArray = [NSMutableArray arrayWithArray:@[@"我的待办",@"我的在途单",@"扫描二维码",@"业务办理",@"登记预约完税过户结果",@"登记办理完税结果",@"登记办理过户结果",@"登记办理土地过户结果"]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        return 20;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        TETitleCell *titleCell = (TETitleCell *)[tableView dequeueReusableCellWithIdentifier:@"TitleIdentifier"];
        if (!titleCell) {
            titleCell = (TETitleCell *)[[[UINib nibWithNibName:@"TETitleCell" bundle:nil] instantiateWithOwner:self options:nil]objectAtIndex:0];
        }
        titleCell.cellTitle.text = [self.dataArray objectAtIndex:indexPath.row];
        return titleCell;
    }else if(indexPath.row<3){
        TEMenuCell *menuCell = (TEMenuCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuIdentifier"];
        if (!menuCell) {
            menuCell = (TEMenuCell *)[[[UINib nibWithNibName:@"TEMenuCell" bundle:nil] instantiateWithOwner:self options:nil]objectAtIndex:0];
        }
        if (indexPath.row==0) {
            menuCell.titleImageView.image = [UIImage imageNamed:@"mark_myWait_green"];
        }else if (indexPath.row==1){
            menuCell.titleImageView.image = [UIImage imageNamed:@"mark_onWayList_green"];
        }else{
            menuCell.titleImageView.image = [UIImage imageNamed:@"mark_QRCode_green"];
        }
        menuCell.cellTitle.text = [self.dataArray objectAtIndex:indexPath.row];
        return menuCell;
    }else{
        TEMenuNoPicCell *noPicCell = (TEMenuNoPicCell *)[tableView dequeueReusableCellWithIdentifier:@"NoPicIdentifier"];
        if (!noPicCell) {
            noPicCell = (TEMenuNoPicCell *)[[[UINib nibWithNibName:@"TEMenuNoPicCell" bundle:nil] instantiateWithOwner:self options:nil]objectAtIndex:0];
        }
        noPicCell.cellTitle.text = [self.dataArray objectAtIndex:indexPath.row];
        return noPicCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [Tool hidenMenu:indexPath.row];
}


@end
