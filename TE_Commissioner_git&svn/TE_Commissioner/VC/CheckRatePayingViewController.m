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
#import "CheckBoxSelectedView.h"
#import "JSONKit.h"

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
    
    __weak IBOutlet UIView *_noSuccessReasonShowView;
    
    AFHTTPRequestOperationManager *_manager;
    NSInteger _param_type;
    CheckBoxSelectedView *_checkView;
    CheckBoxSelectedView *_showExamieCheckView;
    CheckBoxSelectedView *_checkBoxView;

    ResultMidMenu *_rmm;
    NSString *_documentType;
    __weak CheckRatePayingViewController *_weakSelf;

    BOOL _checkBoxIsSelected;
    DatePickerView *_datePickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [AFHTTPRequestOperationManager manager];
    _weakSelf = self;
    _checkBoxIsSelected = NO;
    
    [self uiConfig];
    [self requestGetInfo];
    // Do any additional setup after loading the view from its nib.
}

-(void)uiConfig{
    
    self.title = @"登记完税结果";
    [Tool setLeftBackBarBtn:self];
    
        _showExamieCheckView = [[CheckBoxSelectedView alloc]initWithFrame:CGRectMake(0, 30, 320, 70) titleArray:[NSArray arrayWithObjects:@"重新审查",@"等待资料", nil]viewType:SelectedType_TwoSelectOne];
        _showExamieCheckView.callBack = ^(NSInteger index,NSArray* indexArray){
            NSLog(@"index-%@",indexArray);
        };
        [_showExamieCheckView setSelectedView:0];
    _showExamieCheckView.hidden = YES;
    [_noSuccessReasonShowView addSubview:_showExamieCheckView];
    
        _checkBoxView = [[CheckBoxSelectedView alloc]initWithFrame:CGRectMake(0, 30, 320, 70) titleArray:[NSArray arrayWithObjects:@"客户未到场",@"首套变二套",@"备件不齐", nil]viewType:SelectedType_CheckBox];
        _checkBoxView.callBack = ^(NSInteger index,NSArray* indexArray){
            NSLog(@"index-%@",indexArray);
        };
    _checkBoxView.hidden = YES;
    [_noSuccessReasonShowView addSubview:_checkBoxView];

    
    __weak typeof(self) weakSelf = self;
    
    _rmm = [[ResultMidMenu alloc]initWithFrame:CGRectMake(0, 0, 0, 0) titleArray:@[@"办理成功",@"再次办理",@"客户自行办理"]];
    [self.view addSubview:_rmm];
    _rmm.callback = ^(NSInteger index){
        [weakSelf recordTypeDidSelect:index];
    };
    [_rmm setSelected:0];
    
    ResultBottomMenu *rbm = [[ResultBottomMenu alloc]init];
    [self.view addSubview:rbm];
    rbm.submitCallback = ^(void){
        [weakSelf submitOrSaveActionIsSubmit:YES];
    };
    rbm.saveCallback = ^(void){
        [weakSelf submitOrSaveActionIsSubmit:NO];
    };
    
    textView.layer.borderColor = UICOLOR_RGB_Alpha(0xcccccc, 1).CGColor;
    textView.layer.borderWidth = 1;
    
    UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDatePicker)];
    [dateShowLabel addGestureRecognizer:dateTap];
    
    
    __weak typeof(dateShowLabel) weakLabel = dateShowLabel;
    _datePickerView = [[DatePickerView alloc]init];
    _datePickerView.callback = ^(NSDate *date,NSString *str){
        weakLabel.text = str;
    };
    dateShowLabel.text = [_datePickerView getCurrentDateString];

    UITapGestureRecognizer *closeKBTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closekeyBoard)];
    [self.view addGestureRecognizer:closeKBTap];
}

-(void)configCheckView:(BOOL)isShowExamine{
    if (isShowExamine){
        _showExamieCheckView.hidden = NO;
        _checkView = _showExamieCheckView;
    }else{
        _checkBoxView.hidden = NO;
        _checkView = _checkBoxView;
    }
    
}

-(void)requestGetInfo{
    NSDictionary *params = [NSDictionary dictionaryWithObject:_documentNO forKey:@"documentNo"];
    [_manager GET:[Tool getURLWithType:URLTYPE_CheckRatepaying_get] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ResponseModel *model = [[ResponseModel alloc]initWithJson:responseObject type:URLTYPE_listDetail];
        if (model.isSuccessed) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            textView.text = [dic objectForKey:@"comment"];
            if ([dic objectForKey:@"type"]&&[[dic objectForKey:@"type"] isKindOfClass:[NSNumber class]]) {
                switch ([[dic objectForKey:@"type"] integerValue]) {
                    case 0:
                        [_rmm setSelected:2];
                        break;
                    case 1:
                        [_rmm setSelected:0];
                        break;
                    case 2:
                        [_rmm setSelected:1];
                        break;
                }
            }
            if ([dic objectForKey:@"documentType"]&&![[dic objectForKey:@"documentType"] isEqualToString:@""]) {
                _documentType = [dic objectForKey:@"documentType"];
                [_weakSelf configCheckView:[_documentType isEqualToString:@"201500000032"]];
            }else{
                [_weakSelf configCheckView:NO];
            }
            
            if ([dic objectForKey:@"date"]&&![[dic objectForKey:@"date"] isEqualToString:@""]) {
                dateShowLabel.text = [dic objectForKey:@"date"];
            }
            if ([dic objectForKey:@"gotReceipt"]&&[[dic objectForKey:@"type"] isKindOfClass:[NSNumber class]]) {//0未领   1已领
                
                if([[dic objectForKey:@"gotReceipt"] integerValue]&&[[dic objectForKey:@"type"] isKindOfClass:[NSNumber class]]){
                    [self RatepayingTicketClick:nil];//页面初始化时，为no
                }
                
            }
            if ([dic objectForKey:@"failReason"]&&[[dic objectForKey:@"failReason"] isKindOfClass:[NSArray class]]) {
                //偏移-1，因为服务器中以1为开始
                [_checkView setSelectedViewWithArray:[dic objectForKey:@"failReason"] offset:-1];
            }
            if ([dic objectForKey:@"taxableAmount"]&&[[dic objectForKey:@"type"] isKindOfClass:[NSNumber class]]) {
                countRatepaying.text = [[dic objectForKey:@"taxableAmount"] description];
            }
            if ([dic objectForKey:@"paidTaxes"]&&[[dic objectForKey:@"type"] isKindOfClass:[NSNumber class]]) {
                realRatepaying.text = [[dic objectForKey:@"paidTaxes"] description];
            }
            NSLog(@"------>%@",dic);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ErrorPageViewController *wtdVC = [[ErrorPageViewController alloc]init];
        
        UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:wtdVC];
        
        [self presentViewController:mainNav animated:YES completion:^{
            
        }];
    }];
}
-(void)submitOrSaveActionIsSubmit:(BOOL)isSubmit{
    NSString *text;
    if (isSubmit) {
        text = @"是否确认提交登记办理完税结果？";
    }else{
        text = @"是否确认保存登记办理完税结果？";
    }
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:nil contentText:text leftButtonTitle:@"确认" rightButtonTitle:@"取消"];
    [alert show];
    alert.leftBlock = ^() {
        [_weakSelf requestSubmitInfoIsSubmit:isSubmit];
    };
}

-(void)requestSubmitInfoIsSubmit:(BOOL)isSubmit{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInteger:_param_type] forKey:@"type"];
    [params setObject:dateShowLabel.text forKey:@"date"];
    [params setObject:textView.text forKey:@"comment"];
    [params setObject:_documentType forKey:@"documentType"];
    
    [params setObject:[NSNumber numberWithFloat:[countRatepaying.text floatValue]] forKey:@"taxableAmount"];
    [params setObject:[NSNumber numberWithFloat:[realRatepaying.text floatValue]]  forKey:@"paidTaxes"];
    
    NSMutableArray *lsArray = [[NSMutableArray alloc]init];
    for (NSString *num in _checkBoxView.selectedArray) {
        [lsArray addObject:[NSString stringWithFormat:@"%d",num.intValue + 1]];
    }
    [params setObject:[NSNumber numberWithBool:_checkBoxIsSelected] forKey:@"gotReceipt"];
    
    [params setObject:[lsArray JSONString] forKey:@"failReason"];

    if (isSubmit) {
        [params setObject:@"submit" forKey:@"saveType"];
    }else{
        [params setObject:@"save" forKey:@"saveType"];
    }
    [params setObject:_documentNO forKey:@"documentNo"];
    
    NSLog(@"参数----》%@",params);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_manager GET:[Tool getURLWithType:URLTYPE_CheckRatepaying_submit] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ResponseModel *model = [[ResponseModel alloc]initWithJson:responseObject type:URLTYPE_listDetail];
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"------>%@",dic);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (model.isSuccessed) {
            if (isSubmit) {
                [Tool showWarning:self.view text:@"提交成功"];
            }else{
                [Tool showWarning:self.view text:@"保存成功"];
            }
            
        }else if(model.message&&![model.message isEqualToString:@""]){
            [Tool showWarning:self.view text:model.message];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        [Tool showWarning:self.view text:@"失败"];
        ErrorPageViewController *wtdVC = [[ErrorPageViewController alloc]init];
        
        UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:wtdVC];
        
        [self presentViewController:mainNav animated:YES completion:^{
            
        }];
    }];
}


-(void)showDatePicker{
    [_datePickerView show];
}

-(void)recordTypeDidSelect:(NSInteger)index{
    if (index == 0) {
        _param_type = 1;//办理成功
        _noSuccessReasonShowView.hidden = YES;
        dateShowView.hidden = NO;
        ratepayingShowView.hidden = NO;
        ratepayingShowView.frame = CGRectMake(0, 0, ratepayingShowView.frame.size.width, ratepayingShowView.frame.size.height);
        txtViewShowView.frame = CGRectMake(0, 121, txtViewShowView.frame.size.width, txtViewShowView.frame.size.height);
        dateShowView.frame = CGRectMake(0, 292, dateShowView.frame.size.width, dateShowView.frame.size.height);
    }else if(index == 1){
        _param_type = 2;//再次办理

        _noSuccessReasonShowView.hidden = NO;
        dateShowView.hidden = NO;
        ratepayingShowView.hidden = YES;
        txtViewShowView.frame = CGRectMake(0, 100, txtViewShowView.frame.size.width, txtViewShowView.frame.size.height);
        dateShowView.frame = CGRectMake(0, 271, dateShowView.frame.size.width, dateShowView.frame.size.height);
    }else{
        _param_type = 0;//自行办理

        _noSuccessReasonShowView.hidden = YES;
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


-(void)closekeyBoard{
    [textView resignFirstResponder];
    [countRatepaying resignFirstResponder];
    [realRatepaying resignFirstResponder];
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
