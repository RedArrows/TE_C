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
#import "DatePickerView.h"

@interface OrderRatepayingResultViewController ()

@end

@implementation OrderRatepayingResultViewController{
    
    __weak IBOutlet UILabel *explainLabel;
    __weak IBOutlet UITextView *textView1;
    __weak IBOutlet UILabel *dateShowLabel;
    
    __weak IBOutlet UIView *dateShowView;
    __weak IBOutlet UIView *contentShowView;

    AFHTTPRequestOperationManager *_manager;
    DatePickerView *_datePickerView;
    ResultMidMenu *_rmm;
    __weak OrderRatepayingResultViewController *_weakSelf;
    NSString *_infoText;
    
    NSInteger _param_type;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _weakSelf = self;
    _manager = [AFHTTPRequestOperationManager manager];
    [self uiConfig];
    self.title = @"预约完税过户";
    [Tool setLeftBackBarBtn:self];
    
    [self requestGetInfo];
    // Do any additional setup after loading the view from its nib.
}

-(void)uiConfig{
    
    __weak typeof(self) weakSelf = self;
    _rmm = [[ResultMidMenu alloc]initWithFrame:CGRectMake(0, 0, 0, 0) titleArray:@[@"记录预约结果",@"不做预约直接办理"]];
    [self.view addSubview:_rmm];
    _rmm.callback = ^(NSInteger index){
        [weakSelf recordTypeDidSelect:index];
    };
    [_rmm setSelected:0];
    
    ResultBottomMenu *rbm = [[ResultBottomMenu alloc]init];
    [self.view addSubview:rbm];
    rbm.submitCallback = ^(void){
        [_weakSelf submitOrSaveActionIsSubmit:YES];
    };
    rbm.saveCallback = ^(void){
        [_weakSelf submitOrSaveActionIsSubmit:NO];
    };
    
    textView1.layer.borderColor = UICOLOR_RGB_Alpha(0xcccccc, 1).CGColor;
    textView1.layer.borderWidth = 1;
    
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

-(void)requestGetInfo{
    NSDictionary *params = [NSDictionary dictionaryWithObject:_documentNO forKey:@"documentNo"];
    [_manager GET:[Tool getURLWithType:URLTYPE_OrderRatepaying_get] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ResponseModel *model = [[ResponseModel alloc]initWithJson:responseObject type:URLTYPE_listDetail];
        if (model.isSuccessed) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            textView1.text = [dic objectForKey:@"comment"];
            if ([dic objectForKey:@"type"]&&[[dic objectForKey:@"type"] isKindOfClass:[NSNumber class]]) {
                switch ([[dic objectForKey:@"type"] integerValue]) {
                    case 0:
                        [_rmm setSelected:0];
                        break;
                    case 1:
                        [_rmm setSelected:1];
                        break;
                    
                }
            }
            if ([dic objectForKey:@"date"]) {
                dateShowLabel.text = [dic objectForKey:@"date"];
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
-(void)requestSubmitInfoIsSubmit:(BOOL)isSubmit{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInteger:_param_type] forKey:@"type"];
    [params setObject:dateShowLabel.text forKey:@"date"];
    [params setObject:textView1.text forKey:@"comment"];
    if (isSubmit) {
        [params setObject:@"submit" forKey:@"saveType"];
    }else{
        [params setObject:@"save" forKey:@"saveType"];
    }
    
    [params setObject:_documentNO forKey:@"documentNo"];
    
    NSLog(@"参数----》%@",params);

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_manager GET:[Tool getURLWithType:URLTYPE_OrderRatepaying_submit] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ResponseModel *model = [[ResponseModel alloc]initWithJson:responseObject type:URLTYPE_listDetail];
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"------>%@",dic);
        if (model.isSuccessed) {
            
           

        }
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


-(void)submitOrSaveActionIsSubmit:(BOOL)isSubmit{
    NSString *text;
    if (isSubmit) {
        text = @"是否确认提交登记预约缴税过户结果？";
    }else{
        text = @"是否确认保存登记预约缴税过户结果？";
    }
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:nil contentText:text leftButtonTitle:@"确认" rightButtonTitle:@"取消"];
    [alert show];
    alert.leftBlock = ^() {
        [_weakSelf requestSubmitInfoIsSubmit:isSubmit];
    };
}

-(void)showDatePicker{
    [_datePickerView show];
}
-(void)recordTypeDidSelect:(NSInteger)index{
    if (index == 0) {
        _param_type = 0;//记录预约结果
        dateShowView.hidden = NO;
        contentShowView.frame = CGRectMake(0, 40, contentShowView.frame.size.width, contentShowView.frame.size.height);
        explainLabel.text = @"说明";
    }else{
        _param_type = 1;//不预约直接办理
        dateShowView.hidden = YES;
        contentShowView.frame = CGRectMake(0, 0, contentShowView.frame.size.width, contentShowView.frame.size.height);
        explainLabel.text = @"不预约原因说明";
    }
}

-(void)closekeyBoard{
    [textView1 resignFirstResponder];
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
