//
//  ResultForQRCodeViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/10.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "ResultForQRCodeViewController.h"

@interface ResultForQRCodeViewController ()

@end

@implementation ResultForQRCodeViewController{
    
    __weak IBOutlet UILabel *DocumentNOLabel;
    __weak IBOutlet UIView *mainShowView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描结果";
    
    [Tool setLeftMenuBarBtn:self];
    [self uiConfig];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)uiConfig{
    DocumentNOLabel.text = [NSString stringWithFormat:@"单号：%@",_documentNO];
    
    UIButton *reScan = [UIButton buttonWithType:UIButtonTypeSystem];
    [reScan setFrame:CGRectMake(0, 0, 40, 20)];
    [reScan setTitle:@"重新扫描" forState:UIControlStateNormal];
    [reScan addTarget:self action:@selector(popNav) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:reScan];
}

-(void)popNav{
    [self.navigationController popViewControllerAnimated:YES];
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
