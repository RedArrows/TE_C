//
//  PageView.m
//  TE_Commissioner
//
//  Created by liuyunda on 14/12/29.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "PageView.h"
#import "MyOnTheWayListViewController.h"


@implementation PageView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame :CGRectMake(0, 0, 160, 250)];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
    }
    self.configPage = @[@"第1页", @"第2页", @"第3页", @"第4页", @"第5页"];
    return self;
}

- (void)drawRect:(CGRect)rect
{

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.configPage[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate currentPageWithTitle:self.configPage[indexPath.row] atIndex:indexPath.row+1];
}


@end
