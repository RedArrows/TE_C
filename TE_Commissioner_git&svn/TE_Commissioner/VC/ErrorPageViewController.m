//
//  ErrorPageViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/11.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ErrorPageViewController.h"

@interface ErrorPageViewController ()

@end

@implementation ErrorPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)refreshPage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
