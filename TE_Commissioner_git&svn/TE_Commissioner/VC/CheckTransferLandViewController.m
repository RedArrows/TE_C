//
//  CheckTransferLandViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 15/1/6.
//  Copyright (c) 2015年 shiyao. All rights reserved.
//

#import "CheckTransferLandViewController.h"
#import "ResultMidMenu.h"
#import "ResultBottomMenu.h"
#import "DatePickerView.h"

@interface CheckTransferLandViewController ()

@end

@implementation CheckTransferLandViewController{
    
    __weak IBOutlet UIImageView *checkBox;
    __weak IBOutlet UITextView *textView;
    
    __weak IBOutlet UILabel *dateLabel;
    
    __weak IBOutlet UIView *landCerBtnShowView;
    __weak IBOutlet UIView *textShowView;
    __weak IBOutlet UIView *dateShowView;
    
    DatePickerView *_datePickerView;
    
    BOOL _checkBoxIsSelected;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)uiConfig{
    
    self.title = @"登记土地过户结果";
    [Tool setLeftBackBarBtn:self];
    
    __weak typeof(self) weakSelf = self;
    ResultMidMenu *rmm = [[ResultMidMenu alloc]initWithFrame:CGRectMake(0, 0, 0, 0) titleArray:@[@"办理成功",@"再次办理"]];
    [self.view addSubview:rmm];
    rmm.callback = ^(NSInteger index){
        [weakSelf recordTypeDidSelect:index];
    };
    [rmm setSelected:0];
    
    ResultBottomMenu *rbm = [[ResultBottomMenu alloc]init];
    [self.view addSubview:rbm];
    
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth = 1;
    
    dateShowView.frame = CGRectMake(0, 171, dateShowView.frame.size.width, dateShowView.frame.size.height);

    
    UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDatePicker)];
    [dateLabel addGestureRecognizer:dateTap];
    
    
    __weak typeof(dateLabel) weakLabel = dateLabel;
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
        dateShowView.hidden = YES;
        landCerBtnShowView.hidden = NO;
        
        textShowView.frame = CGRectMake(0, 40, textShowView.frame.size.width, textShowView.frame.size.height);

    }else if(index == 1){
        dateShowView.hidden = NO;
        landCerBtnShowView.hidden = NO;

        textShowView.frame = CGRectMake(0, 0, textShowView.frame.size.width, textShowView.frame.size.height);
    }
}


- (IBAction)landCerClick:(id)sender {
    _checkBoxIsSelected = (_checkBoxIsSelected)?NO:YES;
    if (_checkBoxIsSelected) {
        checkBox.image = [UIImage imageNamed:@"checkBox_selected"];
    }else{
        checkBox.image = [UIImage imageNamed:@"checkBox_empty"];
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
