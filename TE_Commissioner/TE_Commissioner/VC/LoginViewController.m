//
//  LoginViewController.m
//  TE_Commissioner
//
//  Created by shiyao on 14-12-4.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "LoginViewController.h"
#import "PAImageView.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    PAImageView *_saber;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    self.navigationController.navigationBar.hidden = YES;
    _saber = [[PAImageView alloc]initWithFrame:CGRectMake(40, 40, 90, 90)
                       backgroundProgressColor:[UIColor grayColor] progressColor:[UIColor greenColor]];
    [self.view addSubview:_saber];
    [_saber updateWithImage:[UIImage imageNamed:@"saberheader.png"] animated:YES];

    
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
