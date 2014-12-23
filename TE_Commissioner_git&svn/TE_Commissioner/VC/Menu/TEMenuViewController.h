//
//  TEMenuViewController.h
//  TE_Commissioner
//
//  Created by liuyunda on 14/12/18.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end
