//
//  OrderRatepayingResultViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 14/12/29.
//  Copyright (c) 2014年 shiyao. All rights reserved.
//

#import "OrderRatepayingResultViewController.h"
#import "ResultMidMenu.h"
#import "ResultBottomMenu.h"

@interface OrderRatepayingResultViewController ()

@end

@implementation OrderRatepayingResultViewController{
    
    __weak IBOutlet UILabel *explainLabel;
    __weak IBOutlet UITextView *textView1;
    __weak IBOutlet UILabel *dateShowLabel;
    
    __weak IBOutlet UIView *dateShowView;
    __weak IBOutlet UIView *contentShowView;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiConfig];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)uiConfig{
    
    __weak typeof(self) weakSelf = self;
    ResultMidMenu *rmm = [[ResultMidMenu alloc]initWithFrame:CGRectMake(0, 0, 0, 0) titleArray:@[@"记录预约结果",@"不做预约直接办理"]];
    [self.view addSubview:rmm];
    rmm.callback = ^(NSInteger index){
        [weakSelf recordTypeDidSelect:index];
    };
    [rmm setSelected:0];
    
    ResultBottomMenu *rbm = [[ResultBottomMenu alloc]init];
    [self.view addSubview:rbm];
    
    textView1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView1.layer.borderWidth = 1;
    
}

-(void)recordTypeDidSelect:(NSInteger)index{
    if (index == 0) {
        dateShowView.hidden = NO;
        contentShowView.frame = CGRectMake(0, 40, contentShowView.frame.size.width, contentShowView.frame.size.height);
        explainLabel.text = @"说明";
        textView1.text = @"";
    }else{
        dateShowView.hidden = YES;
        contentShowView.frame = CGRectMake(0, 0, contentShowView.frame.size.width, contentShowView.frame.size.height);
        explainLabel.text = @"不预约原因说明";
        textView1.text = @"";
    }
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
