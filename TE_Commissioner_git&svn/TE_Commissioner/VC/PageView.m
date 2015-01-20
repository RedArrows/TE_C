//
//  PageView.m
//  TE_Commissioner
//
//  Created by liuyunda on 14/12/29.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "PageView.h"
#import "MyOnTheWayListViewController.h"
#import "PageViewCell.h"


@implementation PageView
{
    UILabel *label;
}


-(id)initWithFrame:(CGRect)frame withPageNum:(NSInteger)num
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame :CGRectMake(0, 30, 100,num<5?num*36:5*35+30)];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.tableView.layer setMasksToBounds:YES];
        [self.tableView.layer setCornerRadius:8.0];
        [self.tableView.layer setBorderWidth:4.0];
        [self.tableView.layer setBorderColor:UICOLOR_RGB_Alpha(0x5a5a5a, 1.0).CGColor];
        self.backgroundColor = UICOLOR_RGB_Alpha(0x5a5a5a, 1.0);
        
        UIView *aview = [[UIView alloc]init];
        aview.frame = CGRectMake(0, 0, 100, 30);
        UILabel *alabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, 60, 30)];
        alabel.text = @"选择页码";
        alabel.font = [UIFont systemFontOfSize:15];
        alabel.textColor = [UIColor whiteColor];
        [aview addSubview:alabel];
        aview.backgroundColor = UICOLOR_RGB_Alpha(0x5a5a5a, 1.0);

        [self addSubview:aview];
        [self addSubview:self.tableView];
    }
    self.configPage = [NSMutableArray array];
    for (int i; i<num; i++) {
        [self.configPage addObject:[NSString stringWithFormat:@"第%d页",i+1]];
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.configPage count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIdentifier = @"PageIdentifier";
    PageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = (PageViewCell *)[[[UINib nibWithNibName:@"PageViewCell" bundle:nil] instantiateWithOwner:self options:nil]objectAtIndex:0];
    }
    cell.pageLable.text = self.configPage[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate currentPageWithTitle:self.configPage[indexPath.row] atIndex:indexPath.row+1];
}

@end