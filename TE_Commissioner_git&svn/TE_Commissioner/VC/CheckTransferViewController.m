//
//  CheckTransferViewController.m
//  TE_Commissioner
//
//  Created by 时瑶 on 15/1/5.
//  Copyright (c) 2015年 shiyao. All rights reserved.
//

#import "CheckTransferViewController.h"
#import "ResultMidMenu.h"
#import "DatePickerView.h"
#import "ResultBottomMenu.h"

@interface CheckTransferViewController ()

@end

@implementation CheckTransferViewController{
    
    __weak IBOutlet UILabel *noLandCer;
    __weak IBOutlet UIImageView *noCerIcon;
    
//    __weak IBOutlet UILabel *hadLandCer;
    
    __weak IBOutlet UILabel *hadLandCer;
    __weak IBOutlet UIImageView *haveCerIcon;
    
    
    __weak IBOutlet UIImageView *checkBoxImage;
    __weak IBOutlet UITextView *textView;
    __weak IBOutlet UILabel *dateShowLabel;
    
    __weak IBOutlet UIView *landCerSelectView;
    __weak IBOutlet UIView *textShowView;
    __weak IBOutlet UIView *dateShowView;
    
    DatePickerView *_datePickerView;
    
    BOOL _isShowSelectLandCer;
    BOOL _isHasLandCer;
    
    UIColor *_selectedColor;
    UIColor *_normalColor;
    
    __weak CheckTransferViewController *_weakSelf;
    NSInteger _param_type;
    AFHTTPRequestOperationManager *_manager;
    ResultMidMenu *_rmm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isShowSelectLandCer = NO;
    _isHasLandCer = NO;
    _manager = [AFHTTPRequestOperationManager manager];
    [self uiConfig];
    [self requestGetInfo];
    // Do any additional setup after loading the view from its nib.
}

-(void)uiConfig{
    
    self.title = @"登记过户结果";
    
    _weakSelf = self;
    [Tool setLeftBackBarBtn:self];
    
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
        [_weakSelf submitOrSaveActionIsSubmit:YES];
    };
    rbm.saveCallback = ^(void){
        [_weakSelf submitOrSaveActionIsSubmit:NO];
    };
    
    textView.layer.borderColor = UICOLOR_RGB_Alpha(0xcccccc, 1).CGColor;
    textView.layer.borderWidth = 1;
    
    _selectedColor = UICOLOR_RGB_Alpha(0x39ac6a, 1);
    _normalColor = UICOLOR_RGB_Alpha(0x969696, 1);
    
    noLandCer.tag = 1001;
    noLandCer.layer.borderColor = _normalColor.CGColor;
    noLandCer.layer.borderWidth = 2.0;
    noLandCer.layer.cornerRadius = 5;
    noLandCer.textColor = _normalColor;
    noLandCer.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setLandCerSelectedWithGes:)];
    [noLandCer addGestureRecognizer:tap1];
    
    hadLandCer.tag = 1002;
    hadLandCer.layer.borderColor = _normalColor.CGColor;
    hadLandCer.layer.borderWidth = 2.0;
    hadLandCer.layer.cornerRadius = 5;
    hadLandCer.textColor = _normalColor;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setLandCerSelectedWithGes:)];
    [hadLandCer addGestureRecognizer:tap2];
    
    [self setLandCerSelected:noLandCer];
    
    UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDatePicker)];
    dateShowLabel.userInteractionEnabled = YES;
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

-(void)submitOrSaveActionIsSubmit:(BOOL)isSubmit{
    NSString *text;
    if (isSubmit) {
        text = @"是否确认提交登记办理过户结果？";
    }else{
        text = @"是否确认保存登记办理过户结果？";
    }
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:nil contentText:text leftButtonTitle:@"确认" rightButtonTitle:@"取消"];
    [alert show];
    alert.leftBlock = ^() {
        [self requestSubmitInfoIsSubmit:isSubmit];
    };
}

-(void)requestGetInfo{
    NSDictionary *params = [NSDictionary dictionaryWithObject:_documentNO forKey:@"documentNo"];
    [_manager GET:[Tool getURLWithType:URLTYPE_CheckTransfer_get] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            
            
            if ([dic objectForKey:@"date"]&&![[dic objectForKey:@"date"] isEqualToString:@""]) {
                dateShowLabel.text = [dic objectForKey:@"date"];
            }
            if ([dic objectForKey:@"needLandTransfer"]&&[[dic objectForKey:@"needLandTransfer"] isKindOfClass:[NSNumber class]]) {
                
                if ([[dic objectForKey:@"needLandTransfer"] integerValue]==1) {
                    [self todoTransferLandClick:nil];
                    if ([dic objectForKey:@"hasLandCertificate"]&&[[dic objectForKey:@"hasLandCertificate"] isKindOfClass:[NSNumber class]]) {
                        if ([[dic objectForKey:@"hasLandCertificate"] integerValue]==1) {
                            [self setLandCerSelected:hadLandCer];
                        }
                    }
                }
                
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
    [params setObject:textView.text forKey:@"comment"];
    if (_isShowSelectLandCer) {
        [params setObject:[NSNumber numberWithInt:1] forKey:@"needLandTransfer"];
    }else{
        [params setObject:[NSNumber numberWithInt:0] forKey:@"needLandTransfer"];
    }
    if (_isHasLandCer) {
        [params setObject:[NSNumber numberWithInt:1] forKey:@"hasLandCertificate"];
    }else{
        [params setObject:[NSNumber numberWithInt:0] forKey:@"hasLandCertificate"];
    }

    
    if (isSubmit) {
        [params setObject:@"submit" forKey:@"saveType"];
    }else{
        [params setObject:@"save" forKey:@"saveType"];
    }
    [params setObject:_documentNO forKey:@"documentNo"];
    
    NSLog(@"参数----》%@",params);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_manager GET:[Tool getURLWithType:URLTYPE_CheckTransfer_submit] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
-(void)setLandCerSelectedWithGes:(UITapGestureRecognizer *)tap{
    [self setLandCerSelected:(UILabel *)(tap.view)];
}

-(void)setLandCerSelected:(UILabel *)label{
    
    label.layer.borderColor = _selectedColor.CGColor;
    label.textColor = _selectedColor;
    
    if (label.tag == 1001) {//选择无土地证
        _isHasLandCer = NO;
        hadLandCer.layer.borderColor = _normalColor.CGColor;
        hadLandCer.textColor = _normalColor;
        haveCerIcon.hidden = YES;
        noCerIcon.hidden = NO;
    }else{
        _isHasLandCer = YES;
        noLandCer.layer.borderColor = _normalColor.CGColor;
        noLandCer.textColor = _normalColor;
        noCerIcon.hidden = YES;
        haveCerIcon.hidden = NO;
    }
}


-(void)recordTypeDidSelect:(NSInteger)index{
    if (index == 0) {
        dateShowView.hidden = NO;
        _param_type = 1;

    }else if(index == 1){
        dateShowView.hidden = NO;
        _param_type = 2;
//        dateShowView.frame = CGRectMake(0, 171, dateShowView.frame.size.width, dateShowView.frame.size.height);
    }else{
        _param_type = 0;
        dateShowView.hidden = YES;
        
    }
}


- (IBAction)todoTransferLandClick:(id)sender {
    _isShowSelectLandCer = (_isShowSelectLandCer)?NO:YES;
    
    if (_isShowSelectLandCer) {
        checkBoxImage.image = [UIImage imageNamed:@"checkBox_selected"];
        [UIView animateWithDuration:0.3 animations:^{
            textShowView.frame = CGRectMake(textShowView.frame.origin.x, textShowView.frame.origin.y+landCerSelectView.frame.size.height, textShowView.frame.size.width, textShowView.frame.size.height);
            dateShowView.frame = CGRectMake(dateShowView.frame.origin.x, dateShowView.frame.origin.y+landCerSelectView.frame.size.height, dateShowView.frame.size.width, dateShowView.frame.size.height);
        } completion:^(BOOL finished) {
            [self.view bringSubviewToFront:landCerSelectView];
        }];
    }else{
        [self.view sendSubviewToBack:landCerSelectView];
        checkBoxImage.image = [UIImage imageNamed:@"checkBox_empty"];
        [UIView animateWithDuration:0.3 animations:^{
            textShowView.frame = CGRectMake(textShowView.frame.origin.x, textShowView.frame.origin.y-landCerSelectView.frame.size.height, textShowView.frame.size.width, textShowView.frame.size.height);
            dateShowView.frame = CGRectMake(dateShowView.frame.origin.x, dateShowView.frame.origin.y-landCerSelectView.frame.size.height, dateShowView.frame.size.width, dateShowView.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)closekeyBoard{
    [textView resignFirstResponder];
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
