//
//  PageView.h
//  TE_Commissioner
//
//  Created by liuyunda on 14/12/29.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray * configPage;
@property (nonatomic,assign) id delegate;

-(id)initWithFrame:(CGRect)frame;

@end
