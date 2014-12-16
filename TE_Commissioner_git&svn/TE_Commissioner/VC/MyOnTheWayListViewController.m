//
//  MyOnTheWayListViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/16.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "MyOnTheWayListViewController.h"

@interface MyOnTheWayListViewController ()

@end

@implementation MyOnTheWayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的在途单";
    [Tool setLeftMenuBarBtn:self];
    
    // Do any additional setup after loading the view from its nib.
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
