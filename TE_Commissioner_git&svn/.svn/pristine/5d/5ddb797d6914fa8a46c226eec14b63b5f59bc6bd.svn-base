//
//  CheckRatePayingViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 15/1/5.
//  Copyright (c) 2015年 shiyao. All rights reserved.
//

#import "CheckRatePayingViewController.h"
#import "ResultBottomMenu.h"
#import "ResultMidMenu.h"
#import "DatePickerView.h"

@interface CheckRatePayingViewController ()

@end

@implementation CheckRatePayingViewController{
    
    __weak IBOutlet UIImageView *checkBoxImage;
    __weak IBOutlet UITextField *countRatepaying;
    
    __weak IBOutlet UITextField *realRatepaying;
    
    __weak IBOutlet UITextView *textView;
    
    __weak IBOutlet UILabel *dateShowLabel;
    
    __weak IBOutlet UIView *ratepayingShowView;
    
    __weak IBOutlet UIView *txtViewShowView;
    
    __weak IBOutlet UIView *dateShowView;
    
    
    BOOL _checkBoxIsSelected;
    DatePickerView *_datePickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _checkBoxIsSelected = NO;
    
    [self uiConfig];
    // Do any additional setup after loading the view from its nib.
}

-(void)uiConfig{
    
    self.title = @"登记完税结果";
    [Tool setLeftBackBarBtn:self];
    
    __weak typeof(self) weakSelf = self;
    ResultMidMenu *rmm = [[ResultMidMenu alloc]initWithFrame:CGRectMake(0, 0, 0, 0) titleArray:@[@"办理成功",@"再次办理",@"客户自行办理"]];
    [self.view addSubview:rmm];
    rmm.callback = ^(NSInteger index){
        [weakSelf recordTypeDidSelect:index];
    };
    [rmm setSelected:0];
    
    ResultBottomMenu *rbm = [[ResultBottomMenu alloc]init];
    [self.view addSubview:rbm];
    
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth = 1;
    
    UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDatePicker)];
    [dateShowLabel addGestureRecognizer:dateTap];
    
    
    __weak typeof(dateShowLabel) weakLabel = dateShowLabel;
    _datePickerView = [[DatePickerView alloc]init];
    _datePickerView.callback = ^(NSDate *date,NSString *str){
        weakLabel.text = str;
    };
    
}

-(void)showDatePicker{
    [_datePickerView show];
}

-(void)recordTypeDidSelect:(NSInteger)index{
    if (index == 0) {
        dateShowView.hidden = NO;
        ratepayingShowView.hidden = NO;
        ratepayingShowView.frame = CGRectMake(0, 0, ratepayingShowView.frame.size.width, ratepayingShowView.frame.size.height);
        txtViewShowView.frame = CGRectMake(0, 121, txtViewShowView.frame.size.width, txtViewShowView.frame.size.height);
        dateShowView.frame = CGRectMake(0, 292, dateShowView.frame.size.width, dateShowView.frame.size.height);
    }else if(index == 1){
        dateShowView.hidden = NO;
        ratepayingShowView.hidden = YES;
        txtViewShowView.frame = CGRectMake(0, 0, txtViewShowView.frame.size.width, txtViewShowView.frame.size.height);
        dateShowView.frame = CGRectMake(0, 171, dateShowView.frame.size.width, dateShowView.frame.size.height);
    }else{
        dateShowView.hidden = YES;
        ratepayingShowView.hidden = YES;
        txtViewShowView.frame = CGRectMake(0, 0, txtViewShowView.frame.size.width, txtViewShowView.frame.size.height);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)RatepayingTicketClick:(id)sender {
    _checkBoxIsSelected = (_checkBoxIsSelected)?NO:YES;
    if (_checkBoxIsSelected) {
        checkBoxImage.image = [UIImage imageNamed:@"checkBox_selected"];
    }else{
        checkBoxImage.image = [UIImage imageNamed:@"checkBox_empty"];
    }
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
