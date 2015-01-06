//
//  WellcomePageViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 15/1/5.
//  Copyright (c) 2015年 shiyao. All rights reserved.
//

#import "WellcomePageViewController.h"
#import "LoginViewController.h"

@interface WellcomePageViewController ()

@end

@implementation WellcomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)iknowClick:(id)sender {
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:YES completion:^{
        
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
